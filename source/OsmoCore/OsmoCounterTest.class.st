"
An OsmoCounterTest is a test class for testing the behavior of OsmoCounter
"
Class {
	#name : #OsmoCounterTest,
	#superclass : #TestCase,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
OsmoCounterTest >> testSimple [
	| ctr |
	ctr := OsmoCounter initWithName: 'Test'.
	self assert: ctr counterName equals: 'Test'.

	self assert: ctr count equals: 0.
	ctr increment.
	self assert: ctr count equals: 1.
	ctr increment.
	self assert:  ctr count equals: 2.

	self assert: ctr readReset equals: 2.
	self assert: ctr count equals: 0.
	self assert: ctr readReset equals: 0.
]
