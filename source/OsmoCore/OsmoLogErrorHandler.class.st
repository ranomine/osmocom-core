"
I log exceptions using the OsmoLogging framework
"
Class {
	#name : #OsmoLogErrorHandler,
	#superclass : #Object,
	#category : #'OsmoCore-Core'
}

{ #category : #'as yet unclassified' }
OsmoLogErrorHandler >> handleError: anError on: block [ 
	anError logException: 'dispatch failed on "' , block printString , '".' area: #core.
]

{ #category : #'as yet unclassified' }
OsmoLogErrorHandler >> handleTimerError: anError on: block [ 
	anError logException: 'Execution of timer failed: ' , anError messageText area: #timer
]