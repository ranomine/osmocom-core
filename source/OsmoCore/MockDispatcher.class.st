Class {
	#name : #MockDispatcher,
	#superclass : #Dispatcher,
	#category : #'OsmoCore-Tests'
}

{ #category : #'as yet unclassified' }
MockDispatcher >> dispatchBlock: aBlock [
	aBlock value
]

{ #category : #'as yet unclassified' }
MockDispatcher >> startDispatching [
	
]

{ #category : #'as yet unclassified' }
MockDispatcher >> terminate [
]
