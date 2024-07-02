'From Cuis7.1 [latest update: #6493] on 2 July 2024 at 1:53:32 pm'!
'Description World Menu for requiring features.'!
!provides: 'FeatureRequirer' 1 3!
SystemOrganization addCategory: #FeatureRequirer!


!classDefinition: #FeatureRequirer category: #FeatureRequirer!
Object subclass: #FeatureRequirer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FeatureRequirer'!
!classDefinition: 'FeatureRequirer class' category: #FeatureRequirer!
FeatureRequirer class
	instanceVariableNames: ''!


!FeatureRequirer methodsFor: 'as yet unclassified' stamp: 'MM 7/2/2024 13:46:45'!
collectPackagesFromDisk

	"Collect PackageSpec with package files found in Cuis packages directories."

	| alreadyVisited files |
	
	alreadyVisited := Set new.
	files := Set new.
	self placesToLookForPackagesDo: [ :aDirectory |
		(alreadyVisited includes: aDirectory) 
			ifFalse: [
				alreadyVisited add: aDirectory.
				files addAll: (aDirectory fileNamesMatching: '*.pck.st')]].
	^ files collect: [:fileName | fileName asFileEntry baseName].
	! !

!FeatureRequirer methodsFor: 'as yet unclassified' stamp: 'MM 7/2/2024 13:30:54'!
placesToLookForPackagesDo: aBlock

	"Packages that come included with Cuis"
	aBlock value: DirectoryEntry packagesDirectory.
	DirectoryEntry packagesDirectory allRegularDirectoriesDo: aBlock.

	"Packages in other folders or repos in the project directory"
	aBlock value: DirectoryEntry projectBaseDirectory.
	DirectoryEntry projectBaseDirectory allRegularDirectoriesDo: aBlock.! !

!FeatureRequirer methodsFor: 'as yet unclassified' stamp: 'MM 7/2/2024 13:51:45'!
requireFeature

	self request: 'Require Feature: (accept empty to select from menu)' do: [:featureName |
		featureName 
			ifEmpty: [ | menu packages selectedFeature |
				packages := self collectPackagesFromDisk asSortedCollection .
				menu := SelectionMenu labels: packages selections: packages.
				selectedFeature := menu startUpWithCaption: 'Require feature: '.
				selectedFeature ifNotNil: [Feature require: selectedFeature]]
			ifNotEmpty: [Feature require: featureName]]! !

!FeatureRequirer class methodsFor: 'as yet unclassified' stamp: 'MM 7/2/2024 13:38:18'!
requireFeature

	^ self new requireFeature! !

!FeatureRequirer class methodsFor: 'as yet unclassified' stamp: 'MM 7/2/2024 13:51:17'!
worldMenuOptions
	^ `{{
			#itemGroup -> 20.
			#itemOrder 			-> 	30.
			#label 			-> 	'Require feature'.
			#object 			-> 	FeatureRequirer.
			#selector 			-> 	#requireFeature.
			#icon 			-> 	#developmentIcon.
			#balloonText 			-> 	'Require a Feature'.
		} asDictionary}`! !
