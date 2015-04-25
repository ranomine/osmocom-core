"
I am the debug area for OsmoCore.
"
Class {
	#name : #LogAreaCore,
	#superclass : #LogArea,
	#category : #'OsmoCore-Logging'
}

{ #category : #'as yet unclassified' }
LogAreaCore class >> areaDescription [
	^'Core related things'

]

{ #category : #'as yet unclassified' }
LogAreaCore class >> areaName [
	^#core

]

{ #category : #'as yet unclassified' }
LogAreaCore class >> default [
	^(self new)
	    enabled: true;
	    minLevel: LogLevel debug;
	    yourself

]
