Class {
	#name : #DispatcherTest,
	#superclass : #TestCase,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
DispatcherTest >> testDispatcher [
	| sem dispatcher |

	dispatcher := Dispatcher new.
	dispatcher startDispatching.

	sem := Semaphore new.
	self assert: sem signals equals: 0.
	"Force a debugger or some abortion? And a log message"
	dispatcher dispatchBlock: [123 unknownMessageForSmallInteger].
	dispatcher dispatchBlock: [Processor activeProcess terminate].
	dispatcher dispatchBlock: [sem signal].
	self assert: sem signals equals: 1.
	dispatcher quit.
]

{ #category : #'as yet unclassified' }
DispatcherTest >> testPendingBlocks [
	| sem dispatcher |
	dispatcher := Dispatcher new.
	dispatcher startDispatching.

	sem := Semaphore new.
	self assert: sem signals equals: 0.
	self assert: dispatcher pendingBlocks equals: 0.
	dispatcher dispatchBlock: [sem wait].
	dispatcher dispatchBlock: [ ].

	"Verify that one block is pending"
	self assert: dispatcher pendingBlocks equals: 1.
	sem signal.
	dispatcher quit.

]

{ #category : #'as yet unclassified' }
DispatcherTest >> testSameDispatcher [
	self assert: Dispatcher instance == Dispatcher instance

]
