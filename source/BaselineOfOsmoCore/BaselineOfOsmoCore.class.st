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
			repository: 'github://ranomine/osmocom-logging:pharo10-migration/source'].
	spec baseline: 'OsmoCrashReportClient' with: [
		spec
			repository: 'github://ranomine/osmocom-crashreport:pharo10-migration/source'].

	spec package: #OsmoCore with: [
		spec requires: #('OsmoLogging' 'OsmoCrashReportClient')].
]
