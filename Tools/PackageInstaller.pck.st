'From Cuis7.1 [latest update: #6378] on 18 May 2024 at 4:49:02 pm'!
'Description '!
!provides: 'PackageInstaller' 1 3!
SystemOrganization addCategory: #PackageInstaller!


!classDefinition: #PackageInstallerWindow category: #PackageInstaller!
SystemWindow subclass: #PackageInstallerWindow
	instanceVariableNames: 'filterString filterInput currentIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PackageInstaller'!
!classDefinition: 'PackageInstallerWindow class' category: #PackageInstaller!
PackageInstallerWindow class
	instanceVariableNames: ''!

!classDefinition: #PackageInstaller category: #PackageInstaller!
Object subclass: #PackageInstaller
	instanceVariableNames: 'packageList'
	classVariableNames: 'PackageList'
	poolDictionaries: ''
	category: 'PackageInstaller'!
!classDefinition: 'PackageInstaller class' category: #PackageInstaller!
PackageInstaller class
	instanceVariableNames: ''!


!PackageInstallerWindow commentStamp: '<historical>' prior: 0!
I'm a tool for listing locally available Cuis packages and installing them.!

!PackageInstaller commentStamp: '<historical>' prior: 0!
I'm the model of PackageInstallerWindow.!

!PackageInstallerWindow methodsFor: 'GUI building' stamp: 'MM 11/25/2021 15:21:52'!
buildActionsBar

	| actionsBar | 
	
	actionsBar := LayoutMorph newRow.
	
	actionsBar addMorph:
		(PluggableButtonMorph 
				model: self 
				action: #installPackage
				label: 'Install package').
	actionsBar addMorph:
		(PluggableButtonMorph
				model: self
				action: #updatePackageList
				label: 'Update package list').
	
	actionsBar addMorph: (LabelMorph contents: 'Search: ').
	
	filterInput := TextModelMorph textProvider: self textGetter: #filterString textSetter: #filterString:.
	filterInput acceptOnCR: true;
		askBeforeDiscardingEdits: false.
	actionsBar addMorph: filterInput layoutSpec: (LayoutSpec fixedHeight: 30).
	
	^ actionsBar! !

!PackageInstallerWindow methodsFor: 'GUI building' stamp: 'MM 11/25/2021 13:56:23'!
buildDetailPane
	^ TextModelMorph textProvider:  self textGetter: #packageDescription! !

!PackageInstallerWindow methodsFor: 'GUI building' stamp: 'MM 11/25/2021 15:23:37'!
buildMorphicWindow

	|layout|
		
	layout := LayoutMorph newRow.
	layout addMorph: self buildPackageListMorph layoutSpec: (LayoutSpec proportionalWidth: 0.5).
	layout addAdjusterAndMorph: self buildDetailPane layoutSpec: (LayoutSpec proportionalWidth: 0.5).
	self addMorph: layout layoutSpec: (LayoutSpec proportionalWidth: 1).
	self addMorph: self buildActionsBar layoutSpec: (LayoutSpec new fixedHeight: 30; proportionalWidth: 1; yourself). 
	! !

!PackageInstallerWindow methodsFor: 'GUI building' stamp: 'jmv 5/17/2024 18:07:47'!
buildPackageListMorph
	
	^ PluggableListMorph withModel: self listGetter: #packageListNames indexGetter: #currentIndex indexSetter: #currentIndex:.! !

!PackageInstallerWindow methodsFor: 'GUI building' stamp: 'MM 1/3/2022 22:30:37'!
windowColor
	^ Theme current packageInstaller! !

!PackageInstallerWindow methodsFor: 'initialization' stamp: 'MM 11/25/2021 15:18:18'!
initialize
	super initialize.
	filterString := ''.! !

!PackageInstallerWindow methodsFor: 'actions' stamp: 'MM 11/25/2021 19:26:26'!
installPackage
	self selectedPackage ifNotNil: [:package | 
		(FeatureRequirement name: package packageName)
		pathName: package fullName;
		satisfyRequirementsAndInstall]! !

!PackageInstallerWindow methodsFor: 'actions' stamp: 'MM 11/25/2021 14:04:10'!
open
	self buildMorphicWindow.
	labelString := 'Package Installer'.
	self openInWorld! !

!PackageInstallerWindow methodsFor: 'actions' stamp: 'MM 11/25/2021 15:30:07'!
updatePackageList

	model updatePackageList.
	self changed: #packageListNames! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 15:17:00'!
currentIndex
	^ currentIndex ifNil: [0]! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 15:17:08'!
currentIndex: index
	currentIndex := index.
	self changed: #acceptedContents! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 13:43:45'!
filterInput
	"Answer the value of filterInput"

	^ filterInput! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 13:43:45'!
filterInput: anObject
	"Set the value of filterInput"

	filterInput := anObject! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 13:43:45'!
filterString
	"Answer the value of filterString"

	^ filterString! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 16:53:16'!
filterString: aString
	"Set the value of filterString"

	filterString := aString.
	filterInput hasUnacceptedEdits: false.
	self currentIndex: nil.
	self changed: #packageListNames! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 9/19/2022 21:50:32'!
filteredPackageList

	| packageList |
	
	packageList := model packageList.
	
	^ filterString isEmpty
		ifTrue: [packageList]
		ifFalse: [packageList select: [:package | package packageName includesSubstring: filterString asString caseSensitive: false]]! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 14:18:16'!
getFilter
	^ [:str :el | el printString includesSubstring: str caseSensitive: false]! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 13:43:45'!
model
	"Answer the value of model"

	^ model! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 13:43:45'!
model: anObject
	"Set the value of model"

	model := anObject! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 6/19/2023 20:16:07'!
packageDescription

	| package |
	
	package := self selectedPackage.
	
	package ifNil: [^''].
	
	^ Text streamContents: [:s | 
		s nextPutAll: (Text string: package packageName attribute: TextEmphasis bold).
		s newLine; newLine.
		package packageDescription ifNotEmpty: [:description |
			s nextPutAll: description.
			s  newLine;		newLine].
		
		s nextPutAll: (self descriptionOfPackage: package)]! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 16:12:17'!
packageListNames

	^ self filteredPackageList collect: [:package | package packageName].
	
	! !

!PackageInstallerWindow methodsFor: 'accessing' stamp: 'MM 11/25/2021 16:10:59'!
selectedPackage
	currentIndex ifNil: [^nil].
	currentIndex isZero ifTrue: [^nil].
	^ self filteredPackageList at: currentIndex.! !

!PackageInstallerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/19/2023 20:19:15'!
descriptionOfPackage: aPackage

	^ Text streamContents: [ :s |
		s nextPutAll: (Text string: 'Code Package File: ' attribute: TextEmphasis bold).
		s nextPutAll: aPackage fullName; newLine; newLine.
		s nextPutAll: (Text string: 'Provides: ' attribute: TextEmphasis bold).
		aPackage provides printDetailsOn: s.
		s newLine; newLine.
		aPackage requires ifNotEmpty: [ :requirements | 
			s nextPutAll: (Text string: 'Requires: ' attribute: TextEmphasis bold).
			(requirements sorted: [:a :b | a name < b name]) do: [ :req |
				s newLine; space.
				req printDetailsOn: s ].
			s newLine ].
		s newLine.
		aPackage sourceSystem ifNotEmpty: [:sourceSystem | 
			s nextPutAll: sourceSystem; newLine; newLine ]]! !

!PackageInstallerWindow class methodsFor: 'as yet unclassified' stamp: 'MM 11/25/2021 15:11:25'!
open

	^ self open: PackageInstaller new label: 'Package Installer'! !

!PackageInstallerWindow class methodsFor: 'as yet unclassified' stamp: 'jmv 3/4/2024 17:31:45'!
worldMenuOptions
	^ `{{
			#submenuOf -> 				TheWorldMenu openLabel.
			#itemGroup 			-> 	20.
			#itemOrder 			-> 	30.
			#label 			->	'Package Installer'.
			#object 			-> 	PackageInstallerWindow.
			#selector 			-> 	#open.
			#icon 			-> 	#packageIcon.
			#balloonText 	-> 			'A tool for installing local Cuis packages.'.
		} asDictionary}`! !

!PackageInstaller methodsFor: 'accessing' stamp: 'MM 11/25/2021 15:12:28'!
addPackage: aPackageSpec

	packageList add: aPackageSpec! !

!PackageInstaller methodsFor: 'accessing' stamp: 'MM 11/25/2021 14:24:04'!
packageList
	"Answer the value of packageList"

	^ packageList! !

!PackageInstaller methodsFor: 'actions' stamp: 'MM 9/19/2022 16:16:07'!
collectPackagesFromDirectory: aDirectory

	"Create a collection of PackageSpec with package files found in aDirectory."
	
	|packageFiles|
	
	packageFiles := aDirectory fileNamesMatching: '*.pck.st'.
		
	packageFiles do: [:packageFile | | codePackage |
		[codePackage := CodePackageFile onFileEntry: (aDirectory // packageFile).
			self addPackage: codePackage] 
		on: Error
		do: [:e | Transcript nextPutAll: 'Warning: Error scanning the package ', packageFile, '. Ignoring ...'; newLine]]! !

!PackageInstaller methodsFor: 'actions' stamp: 'jmv 3/4/2024 17:03:26'!
collectPackagesFromDisk

	"Collect PackageSpec with package files found in Cuis packages directories."

	| alreadyVisited |
	alreadyVisited := Set new.
	self placesToLookForPackagesDo: [ :aDirectory |
		(alreadyVisited includes: aDirectory) ifFalse: [
			alreadyVisited add: aDirectory.
			self collectPackagesFromDirectory: aDirectory ]
		ifTrue: [aDirectory print]]! !

!PackageInstaller methodsFor: 'actions' stamp: 'jmv 12/15/2023 16:17:42'!
placesToLookForPackagesDo: aBlock

	"Packages that come included with Cuis"
	aBlock value: DirectoryEntry packagesDirectory.
	DirectoryEntry packagesDirectory allRegularDirectoriesDo: aBlock.

	"Packages in other folders or repos in the project directory"
	aBlock value: DirectoryEntry projectBaseDirectory.
	DirectoryEntry projectBaseDirectory allRegularDirectoriesDo: aBlock.! !

!PackageInstaller methodsFor: 'actions' stamp: 'MM 1/1/2022 18:39:02'!
updatePackageList
	
	(PopUpMenu confirm: 'I need to scan for packages. This takes some time. Continue?')
		ifFalse: [^ OrderedCollection new].
	packageList := OrderedCollection new.
	self collectPackagesFromDisk.
	packageList sort: [:p1 :p2 | p1 packageName < p2 packageName].
	PackageList := packageList.
	self changed: #packageList.
	^ packageList! !

!PackageInstaller methodsFor: 'initialization' stamp: 'MM 11/25/2021 16:15:28'!
initialize
	packageList := PackageList ifNil: [self updatePackageList]! !
