Class {
	#name : #BaselineOfOsmoCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfOsmoCore
}

{ #category : #baselines }
BaselineOfOsmoCore >> baseline: spec [
	<baseline>
	

	spec baseline: 'OsmoLogging' with: [
		spec
			repository: 'github://ranomine/osmocom-logging:v8/source'].
	spec baseline: 'OsmoCrashReportClient' with: [
		spec
			repository: 'github://moiji-mobile/osmocom-crashreport:v7/source'].

	spec package: #OsmoCore with: [
		spec requires: #('OsmoLogging' 'OsmoCrashReportClient')].
]
