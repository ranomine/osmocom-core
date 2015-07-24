"
Use libcrypto to provide a secure random number
"
Class {
	#name : #OsmoSecureRandom,
	#superclass : #Object,
	#category : #'OsmoCore-Random'
}

{ #category : #'as yet unclassified' }
OsmoSecureRandom class >> intRand: aByteArray size: aSize [
	<primitive: 'primitiveNativeCall' module: 'NativeBoostPlugin'>

	^self nbCall: #(int RAND_bytes(byte* aByteArray, int aSize)) module: 'crypto'.
]

{ #category : #'as yet unclassified' }
OsmoSecureRandom class >> rand: numberOfBytes [
	| rand |
	rand := ByteArray new: numberOfBytes.
	^(self intRand: rand size: rand size) = 1
		ifTrue: [ rand ]
		ifFalse: [ nil ]
]
