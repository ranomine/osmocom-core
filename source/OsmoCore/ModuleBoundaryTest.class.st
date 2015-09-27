Class {
	#name : #ModuleBoundaryTest,
	#superclass : #TestCase,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
ModuleBoundaryTest >> testNotificationDoesNotAbort [
	| called |

	ModuleBoundary runSynchronous: [
		Notification new signal.
		called := 1.
	].
	self assert: called equals: 1.
]
