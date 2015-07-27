"
I represent something that can be counted
"
Class {
	#name : #OsmoCounter,
	#superclass : #Object,
	#instVars : [
		'counterName',
		'count'
	],
	#category : #'OsmoCore-Core'
}

{ #category : #'as yet unclassified' }
OsmoCounter class >> initWithName: aString [ 
	^self new
		counterName: aString;
		yourself
]

{ #category : #'as yet unclassified' }
OsmoCounter >> count [
	^count
]

{ #category : #'as yet unclassified' }
OsmoCounter >> counterName [
	^ counterName
]

{ #category : #'as yet unclassified' }
OsmoCounter >> counterName: aName [
	counterName := aName
]

{ #category : #'as yet unclassified' }
OsmoCounter >> increment [
	count := count + 1.
]

{ #category : #'as yet unclassified' }
OsmoCounter >> initialize [
	super initialize.
	count := 0.
]

{ #category : #'as yet unclassified' }
OsmoCounter >> readReset [
	| res |
	res := count.
	count := 0.
	^res
]
