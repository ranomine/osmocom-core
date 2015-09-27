"
I help you to invoke another module/boundary and not care about the fall-out (exceptions/etc).

Currently I keep on holding all the locks the current process holds but in the future this might change (and new processed will be used/spawned).

One can install error handlers on my singleton that can be used for logging and debugging in the fure
"
Class {
	#name : #ModuleBoundary,
	#superclass : #Object,
	#classInstVars : [
		'errorHandlers'
	],
	#category : #'OsmoCore-Core'
}

{ #category : #'as yet unclassified' }
ModuleBoundary class >> addErrorHandler: anErrorHandler [ 
	errorHandlers add: anErrorHandler
]

{ #category : #'as yet unclassified' }
ModuleBoundary class >> initialize [
	errorHandlers := OrderedCollection with: OsmoLogErrorHandler new.
]

{ #category : #'as yet unclassified' }
ModuleBoundary class >> runSynchronous: aBlock [

	"Execute aBlock, catch _all_ Errors and invoke the error handlers"
	"Ignore Notifications, IllegalResumeAttempt, SimulationExceptionWrapper,
	MockExceptionWithPassAction, TestSkip, MCNoChangesException. We should
	not care about notifications so we can not catch Exception"
	aBlock on: Error, Abort, UnhandledError, TestFailure, Halt, Exit do:  [:error |
		errorHandlers do: [:each | each handleError: error on: aBlock]].
]
