Class {
	#name : #ConfigurationOfOsmoCore,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfOsmoCore
}

{ #category : #'development support' }
ConfigurationOfOsmoCore class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfOsmoCore class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfOsmoCore class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfOsmoCore class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfOsmoCore class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfOsmoCore class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfOsmoCore class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfOsmoCore class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfOsmoCore class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfOsmoCore class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfOsmoCore >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/osmocom/Core/main/'.
		spec 
			project: 'OsmoLogging' with: [
				spec
					className: #ConfigurationOfOsmoLogging;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Logging/main/' ];
			project: 'OsmoCrashReportClient' with: [
				spec
					className: #ConfigurationOfOsmoCrashReportClient;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/OsmoCrashReport/main/' ];
			project: 'RFB' with: [
				spec
					className: #ConfigurationOfRFB;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/RFB/main/' ].
		spec package: #OsmoCore with: [
				spec requires: #('OsmoLogging' 'OsmoCrashReportClient' ). ].
		spec group: 'default' with: #(#OsmoCore #RFB 'OsmoCrashReportClient' ). ].

]

{ #category : #baselines }
ConfigurationOfOsmoCore >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/osmocom/Core/main/'.
		spec 
			project: 'OsmoLogging' with: [
				spec
					className: #ConfigurationOfOsmoLogging;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/Logging/main/' ];
			project: 'OsmoCrashReportClient' with: [
				spec
					className: #ConfigurationOfOsmoCrashReportClient;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/osmocom/OsmoCrashReport/main/' ];
			project: 'RFB' with: [
				spec
					className: #ConfigurationOfRFB;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/RFB/main/' ].
		spec package: #OsmoCore with: [
				spec requires: #('OsmoLogging' 'OsmoCrashReportClient' ). ].
		spec group: 'default' with: #(#OsmoCore #RFB 'OsmoCrashReportClient' ). ].

]

{ #category : #accessing }
ConfigurationOfOsmoCore >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfOsmoCore >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfOsmoCore >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfOsmoCore >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '5'.

]

{ #category : #versions }
ConfigurationOfOsmoCore >> version1: spec [
	<version: '1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '2/8/2016 11:50'.
		spec 
			project: 'OsmoLogging' with: '1';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.63'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.40'. ].

]

{ #category : #versions }
ConfigurationOfOsmoCore >> version2: spec [
	<version: '2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '10/20/2016 23:11'.
		spec 
			project: 'OsmoLogging' with: '3';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.63'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.40'. ].

]

{ #category : #'as yet unclassified' }
ConfigurationOfOsmoCore >> version3: spec [
	<version: '3' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '03/12/2017 12:22'.
		spec 
			project: 'OsmoLogging' with: '4';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.63'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.43'. ].

]

{ #category : #'as yet unclassified' }
ConfigurationOfOsmoCore >> version4: spec [
	<version: '4' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 4'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '06/05/2017 18:25'.
		spec 
			project: 'OsmoLogging' with: '5';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.63'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.43'. ].

]

{ #category : #versions }
ConfigurationOfOsmoCore >> version5: spec [
	<version: '5' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 5'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '07/21/2017 09:23'.
		spec 
			project: 'OsmoLogging' with: '5';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.65'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.43'. ].
]

{ #category : #versions }
ConfigurationOfOsmoCore >> version6: spec [
	<version: '6' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 6'.
		spec author: 'HolgerHansPeterFreyther'.
		spec timestamp: '04/27/2018 22:12'.
		spec 
			project: 'OsmoLogging' with: '5';
			project: 'OsmoCrashReportClient' with: '4';
			project: 'RFB' with: '0.65'.
		spec package: #OsmoCore with: 'OsmoCore-HolgerHansPeterFreyther.46'. ].
]
