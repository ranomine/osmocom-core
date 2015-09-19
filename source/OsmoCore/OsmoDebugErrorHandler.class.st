"
I can be used during development like

 OsmoDebugErrorHandler install
"
Class {
	#name : #OsmoDebugErrorHandler,
	#superclass : #Object,
	#category : #'OsmoCore-Core'
}

{ #category : #'as yet unclassified' }
OsmoDebugErrorHandler class >> install [
	| handler |
	handler := self new.
	ModuleBoundary addErrorHandler: handler.
]

{ #category : #'as yet unclassified' }
OsmoDebugErrorHandler >> handleError: anError on: block [ 
	UIManager default unhandledErrorDefaultAction: anError.
]

{ #category : #'as yet unclassified' }
OsmoDebugErrorHandler >> handleTimerError: anError on: block [
	UIManager default unhandledErrorDefaultAction: anError.
]
