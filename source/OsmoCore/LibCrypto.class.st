Class {
	#name : #LibCrypto,
	#superclass : #FFILibrary,
	#category : #'OsmoCore-Random'
}

{ #category : #'accessing platform' }
LibCrypto >> macModuleName [

	^ 'libcrypto.1.1.dylib'
]

{ #category : #'accessing platform' }
LibCrypto >> unixModuleName [
	^ 'libcrypto.so'
]
