Class {
	#name : #TimerSchedulerTest,
	#superclass : #TestCase,
	#instVars : [
		'timerScheduler'
	],
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
TimerSchedulerTest >> setUp [
	timerScheduler := TimerScheduler new

]

{ #category : #'as yet unclassified' }
TimerSchedulerTest >> tearDown [
	timerScheduler doShutDown

]

{ #category : #'as yet unclassified' }
TimerSchedulerTest >> testCancel [
	| timer1 timer2 fire1 sem block |
	sem := Semaphore new.
	block := [sem signal].
	fire1 := timerScheduler scheduleInSeconds: 5 block: block.
	timer1 := timerScheduler scheduleInSeconds: 3 block: block.
	timer2 := timerScheduler scheduleInSeconds: 2 block: block.
	timer2 cancel.
	timer1 cancel.
	sem wait.
	self assert: sem signals equals: 0

]

{ #category : #'as yet unclassified' }
TimerSchedulerTest >> testOnlyOneProcessIsRunning [
	timerScheduler doShutDown.
	self assert: (
		Process allInstances 
			select: [:each | each isTerminated not & each name =  TimerScheduler processName ]) size  equals: 1
]

{ #category : #'as yet unclassified' }
TimerSchedulerTest >> testTimer [
	| sem now |
	now := DateAndTime now.
	sem := Semaphore new.
	timerScheduler scheduleInSeconds: 2 block: [sem signal].
	sem wait.
	self assert: (DateAndTime now - now) asSeconds >= 2

]
