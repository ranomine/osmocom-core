"
A WorkManagerTest is a test class for testing the behavior of WorkManager
"
Class {
	#name : #WorkManagerTest,
	#superclass : #TestCase,
	#instVars : [
		'workManager'
	],
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
WorkManagerTest >> setUp [
	workManager := WorkManager new.
]

{ #category : #'as yet unclassified' }
WorkManagerTest >> testStartStop [
	workManager namePrefix: 'RH'.
	workManager start: 5.
	self assert: workManager runningProcesses equals: 5.
	workManager stop.

]
