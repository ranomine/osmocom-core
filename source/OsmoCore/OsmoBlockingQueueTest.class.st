"
An OsmoBlockingQueueTest is a test class for testing the behavior of OsmoBlockingQueue
"
Class {
	#name : #OsmoBlockingQueueTest,
	#superclass : #TestCase,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
OsmoBlockingQueueTest >> testNextNextPut [
	| queue proc res sem |

	sem := Semaphore new.
	queue := OsmoBlockingQueue new.
	proc := [ res := queue next. sem signal ] fork.

	self assert: (queue nextPut: 10) equals: 10.
	sem wait.
	self assert: res equals: 10.


]
