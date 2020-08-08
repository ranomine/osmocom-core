Class {
	#name : #LibCrypto,
	#superclass : #FFILibrary,
	#category : #'OsmoCore-Random'
}

{ #category : #'accessing platform' }
LibCrypto >> macModuleName [
	^'/usr/lib/libcrypto.dylib'
]

{ #category : #'accessing platform' }
LibCrypto >> unixModuleName [
	^ 'libcrypto.so'
]
