"
I implement distributing work to several worker threads.

I have the queue and I managed the worker processes. I work by being subclassed to implement doing the actual work.

TODO: I should respawn broken processes that even the ModuleBoundary fails or somebody is executing >>#terminate on the process
"
Class {
	#name : #WorkManager,
	#superclass : #Object,
	#instVars : [
		'queue',
		'processes',
		'namePrefix'
	],
	#category : #'OsmoCore-Core'
}

{ #category : #api }
WorkManager >> doWork: aMsg [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
WorkManager >> initialize [
	super initialize.
	queue := OsmoBlockingQueue new.
	namePrefix := ''.
]

{ #category : #api }
WorkManager >> namePrefix: aPrefix [
	namePrefix := aPrefix
]

{ #category : #'as yet unclassified' }
WorkManager >> newWork: aMsg [
	"This will block until one of the workers has picked it up"
	queue nextPut: aMsg.
]

{ #category : #api }
WorkManager >> queue: aQueue [
	queue := aQueue
]

{ #category : #'as yet unclassified' }
WorkManager >> runOnce [
	| msg |
	msg := queue next.
	msg ifNil: [^true].
	self doWork: msg.
	^false
]

{ #category : #'as yet unclassified' }
WorkManager >> runWorker [
	[
		ModuleBoundary runSynchronous: [
			| res |
			res := self runOnce.
			res ifTrue: [^self]]
	] repeat.
]

{ #category : #api }
WorkManager >> runningProcesses [
	^(processes select: [ :each | each isTerminated not ]) size.
]

{ #category : #'as yet unclassified' }
WorkManager >> start: numberOfJobs [
	| worker |

	worker := [self runWorker].
	processes := Array new: numberOfJobs.

	1 to: numberOfJobs do: [:each |
		| proc |
		proc := worker newProcess.
		proc name: namePrefix, 'Work Manager Job #', each asString.
		processes at: each put: proc].

	1 to: numberOfJobs do: [:each |
		(processes at: each) resume].
]

{ #category : #'as yet unclassified' }
WorkManager >> stop [
	| running |
	running := self runningProcesses.
	1 to: running do: [:each |
		self newWork: nil].

	"Each process can only process the pill of death once. So unless a
	process is stuck.. everybody should terimate now."
]
