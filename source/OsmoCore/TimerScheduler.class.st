"
I can help to fire things at the right time. Right now I
only work on seconds granularity because Time has no direct access to
milliseconds. Also I run a loop every second. I should use a Semaphore to
signal the process about a change of the closest time but it might be a
bit difficult to do this race free.
"
Class {
	#name : #TimerScheduler,
	#superclass : #Object,
	#instVars : [
		'queue',
		'sem',
		'loop',
		'quit',
		'processExited',
		'delay',
		'loopSem'
	],
	#category : #'OsmoCore-Timer'
}

{ #category : #loading }
TimerScheduler class >> initialize [
	"Pharo requires us to do some post-processing"
	Smalltalk addToStartUpList: self.
	^self instance

]

{ #category : #singleton }
TimerScheduler class >> instance [
	^Smalltalk at: #OsmoTimeScheduler ifAbsentPut: [TimerScheduler new]

]

{ #category : #private }
TimerScheduler class >> new [
	^(self basicNew)
	    initialize;
	    addToBeFinalized;
	    yourself

]

{ #category : #accessing }
TimerScheduler class >> processName [
	^'Osmo Timers'

]

{ #category : #'as yet unclassified' }
TimerScheduler class >> startUp [
	"This is for up-to Pharo6.0"
	Smalltalk at: #OsmoTimeScheduler ifPresent: [:timer | timer doStartUp]

]

{ #category : #'as yet unclassified' }
TimerScheduler class >> startUp: resuming [
	"This is for Pharo7.0 and beyond"
	Smalltalk at: #OsmoTimeScheduler ifPresent: [:timer |
		timer doStartUp].

]

{ #category : #'delay_loop' }
TimerScheduler >> dispatchTimers [
	| timers |
	timers := self expiredTimers: DateAndTime now.
	OsmoDispatcher dispatchBlock: [
		timers do: [:timer |
			ModuleBoundary runSynchronous: [timer fire]]].


]

{ #category : #PharoHacks }
TimerScheduler >> doShutDown [
	loop ifNil: [^self].
	quit := true.
	sem critical: [loopSem ifNotNil: [loopSem signal]].
	self signalDelay.
	processExited wait.
	Transcript
	    nextPutAll: 'Stopped the TimerScheduler process';
	    cr

]

{ #category : #PharoHacks }
TimerScheduler >> doStartUp [
	self signalDelay
]

{ #category : #'as yet unclassified' }
TimerScheduler >> expiredTimers: now [
	| res |
	"Now execute the timers. One way or another this is crazy. If we have
	 a long blocking application or a deadlock the timer queue will get
	 stuck. But if we run this in a new process a later process might be run
	 before this process, changing the order of the timers."

	"Only this process will remove items, this is why we can check isEmpty
	 without having the lock"
	res := OrderedCollection new.
		
	[queue isEmpty or: [queue first timeout > now]] whileFalse:  [| timer |
		timer := sem critical: [queue removeFirst].
		timer isCanceled ifFalse: [
			res add: timer]].
	^res
]

{ #category : #private }
TimerScheduler >> finalize [
	quit := true

]

{ #category : #private }
TimerScheduler >> initialize [
	queue := SortedCollection sortBlock: [:a :b | a timeout < b timeout].
	sem := Semaphore forMutualExclusion.
	quit := false.
	self startLoop

]

{ #category : #'delay_loop' }
TimerScheduler >> runTimers [
	[quit] whileFalse: 
		[| timer |
		sem critical: 
			[queue isEmpty ifFalse: [timer := queue first].
			loopSem := Semaphore new.
			delay := nil.].
		timer isNil 
		    ifTrue: 
			["nothing to do. No need to poll an empty queue. Remove delay to get rid of
			 a false resumptionTime. Suspend the process. The process will be resumed
			 when an item is added. Please note that Processor activeProcess == loop will
			 hold here."
			loopSem wait]
		    ifFalse: 
			["either a timer has expired and we process it or we wait for the first item in
			 the queue to expire"

			| offset |
			(offset := timer remainingTime) asMilliSeconds > 0 
			    ifTrue: [(delay := offset asDelay) wait]
			    ifFalse: [self dispatchTimers]]]

]

{ #category : #schedule }
TimerScheduler >> scheduleIn: aDuration block: aBlock [
	| timer currentFirst |
	timer := (Timer on: self)
		    block: aBlock;
		    timeout: DateAndTime now + aDuration;
		    yourself.
	sem critical: 
		[currentFirst := queue isEmpty ifFalse: [queue first].
		queue add: timer.

		"Make sure the loopSem is waking up at least once."
		loopSem ifNotNil: [loopSem signal].
		"if the first item in the queue has changed we need to readjust the delay
		 to wait for. Signalling the waiting delay will enter the recalculation of
		 a new expire time"
		currentFirst == queue first ifFalse: [self signalDelay]].
	^timer

]

{ #category : #schedule }
TimerScheduler >> scheduleInSeconds: aNumber block: aBlock [
	^self scheduleIn: aNumber seconds block: aBlock

]

{ #category : #'as yet unclassified' }
TimerScheduler >> signalDelay [
	delay ifNotNil: [:aDelay | aDelay delaySemaphore signal ].
]

{ #category : #creation }
TimerScheduler >> startLoop [
	processExited := Semaphore new.
	loop := [[self runTimers] ensure: 
			[processExited signal.
			loop := nil]] 
		    newProcess.
	loop name: self class processName.
	loop resume

]
