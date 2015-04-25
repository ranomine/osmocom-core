"
This is a receipt for an active timer
"
Class {
	#name : #Timer,
	#superclass : #Object,
	#instVars : [
		'schedule',
		'timeout',
		'block'
	],
	#category : #'OsmoCore-Timer'
}

{ #category : #creation }
Timer class >> on: aSchedule [
	^(self new)
	    schedule: aSchedule;
	    yourself

]

{ #category : #creation }
Timer >> block: aBlock [
	block := aBlock

]

{ #category : #management }
Timer >> cancel [
	"Remember that the timer is gone."
	schedule := nil.
	block := nil

]

{ #category : #execution }
Timer >> fire [
	block value

]

{ #category : #management }
Timer >> isCanceled [
	^schedule == nil

]

{ #category : #accessing }
Timer >> remainingTime [
	^timeout - DateAndTime now

]

{ #category : #creation }
Timer >> schedule: aSchedule [
	schedule := aSchedule

]

{ #category : #accessing }
Timer >> timeout [
	^timeout

]

{ #category : #creation }
Timer >> timeout: aTimeout [
	timeout := aTimeout

]
