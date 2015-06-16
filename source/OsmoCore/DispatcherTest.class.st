Class {
	#name : #DispatcherTest,
	#superclass : #TestCase,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
DispatcherTest >> testDispatcher [
	| sem |
	sem := Semaphore new.
	self assert: sem signals = 0.
	"Force a debugger or some abortion? And a log message"
	OsmoDispatcher dispatchBlock: [123 unknownMessageForSmallInteger].
	OsmoDispatcher dispatchBlock: [Processor activeProcess terminate].
	OsmoDispatcher dispatchBlock: [sem signal].
	self assert: sem signals = 1

]

{ #category : #'as yet unclassified' }
DispatcherTest >> testSameDispatcher [
	self assert: Dispatcher instance == Dispatcher instance

]
