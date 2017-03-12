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

	"Dump a payload if there is one. Be very careful here as we can't have this cascade"
	(LogDataPayload value) ifNotNil: [:payload |
		payload class = ByteArray ifTrue: [
			anError logError: 'Payload hex: ', payload hex area: #core]].
	(LogDataJSON value) ifNotNil: [:json |
		(json isKindOf: String) ifTrue: [
			anError logError: 'Json string ', json  area: #core]].

	"Legacy... remove in the future"
	(self logManager contextValue: 'payload') ifNotNil: [:payload |
		payload class = ByteArray ifTrue: [
			anError logError: 'Payload hex: ', payload hex area: #core]].
	(self logManager contextValue: 'json') ifNotNil: [:json |
		(json isKindOf: String) ifTrue: [
			anError logError: 'Json string ', json  area: #core]].
]
