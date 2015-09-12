"
I am a blocking work queue. A >>#nextPut: will block until someone has consumed the data.

This is not optimal but the easiest to implement. E.g. if a counter is maintained only the next insert would block allowing a higher level of parallelism.
"
Class {
	#name : #OsmoBlockingQueue,
	#superclass : #SharedQueue,
	#category : #'OsmoCore-Core'
}

{ #category : #'as yet unclassified' }
OsmoBlockingQueue >> next [
	| res |
	res := super next.
	res key signal.
	^res value
]

{ #category : #'as yet unclassified' }
OsmoBlockingQueue >> nextPut: anObject [
	| res sem |
	sem := Semaphore new.
	res := super nextPut: sem -> anObject.
	sem wait.
	^anObject.
	
]
