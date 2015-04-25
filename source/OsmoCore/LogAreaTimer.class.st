"
I am the debug area for the timer code.
"
Class {
	#name : #LogAreaTimer,
	#superclass : #LogArea,
	#category : #'OsmoCore-Logging'
}

{ #category : #'as yet unclassified' }
LogAreaTimer class >> areaDescription [
	^'Timer related'

]

{ #category : #'as yet unclassified' }
LogAreaTimer class >> areaName [
	^#timer

]

{ #category : #'as yet unclassified' }
LogAreaTimer class >> default [
	^(self new)
	    enabled: true;
	    minLevel: LogLevel debug;
	    yourself

]
