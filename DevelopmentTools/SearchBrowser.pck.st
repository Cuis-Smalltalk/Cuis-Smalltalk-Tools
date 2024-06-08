'From Cuis7.1 [latest update: #6456] on 8 June 2024 at 3:46:10 pm'!
'Description Browser tool for searching Cuis source code.'!
!provides: 'SearchBrowser' 1 34!
SystemOrganization addCategory: #SearchBrowser!


!classDefinition: #SearchBrowser category: #SearchBrowser!
MethodSet subclass: #SearchBrowser
	instanceVariableNames: 'searchString source domain matcher caseSensitive'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'SearchBrowser class' category: #SearchBrowser!
SearchBrowser class
	instanceVariableNames: ''!

!classDefinition: #SearchBrowserWindow category: #SearchBrowser!
MethodSetWindow subclass: #SearchBrowserWindow
	instanceVariableNames: 'matcherSelectionButton sourceSelectionButton contextSelectionButton searchStringInput'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'SearchBrowserWindow class' category: #SearchBrowser!
SearchBrowserWindow class
	instanceVariableNames: ''!

!classDefinition: #SearchContext category: #SearchBrowser!
Object subclass: #SearchContext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'SearchContext class' category: #SearchBrowser!
SearchContext class
	instanceVariableNames: ''!

!classDefinition: #ClassHierarchySearchContext category: #SearchBrowser!
SearchContext subclass: #ClassHierarchySearchContext
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'ClassHierarchySearchContext class' category: #SearchBrowser!
ClassHierarchySearchContext class
	instanceVariableNames: ''!

!classDefinition: #ClassProtocolSearchContext category: #SearchBrowser!
SearchContext subclass: #ClassProtocolSearchContext
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'ClassProtocolSearchContext class' category: #SearchBrowser!
ClassProtocolSearchContext class
	instanceVariableNames: ''!

!classDefinition: #ClassSearchContext category: #SearchBrowser!
SearchContext subclass: #ClassSearchContext
	instanceVariableNames: 'class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'ClassSearchContext class' category: #SearchBrowser!
ClassSearchContext class
	instanceVariableNames: ''!

!classDefinition: #SystemCategorySearchContext category: #SearchBrowser!
SearchContext subclass: #SystemCategorySearchContext
	instanceVariableNames: 'systemCategory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'SystemCategorySearchContext class' category: #SearchBrowser!
SystemCategorySearchContext class
	instanceVariableNames: ''!

!classDefinition: #SystemSearchContext category: #SearchBrowser!
SearchContext subclass: #SystemSearchContext
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'SearchBrowser'!
!classDefinition: 'SystemSearchContext class' category: #SearchBrowser!
SystemSearchContext class
	instanceVariableNames: ''!


!SearchBrowserWindow commentStamp: '<historical>' prior: 0!
SearchBrowserWindow open.!

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 14:27:21'!
caseSensitive: aBoolean
	
	caseSensitive := aBoolean! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:45:06'!
context 

	^ domain! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:47:01'!
context: aSearchContext

	domain := aSearchContext! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:18:06'!
getMessageNameOf: aMethodReference

	^ aMethodReference selector asString! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:09:10'!
getSourceOf: aMethodReference

	^ aMethodReference sourceCode! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 15:47:49'!
getStringLiteralsOf: aMethod

	| sources |
	
	sources := ''.

	aMethod compiledMethod literalsDo: [ :aLiteral |
		(aLiteral isMemberOf: String) ifTrue: [
			sources := sources, ' ', aLiteral]].
	
	^ sources! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:51:10'!
initialize

	super initialize.
	
	searchString := ''.
	caseSensitive := false.
	messageList := Array new.
	domain := SystemSearchContext new.
	matcher := self matcherNames first.
	source := self sourceNames first.! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 14:31:07'!
isCaseSensitive
	^ caseSensitive ! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:48:48'!
matcherNames

	^ self matchers collect: [:m | m key]! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:05:42'!
matcherSelector

	^ self matchers asDictionary at: matcher! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:00:32'!
matchers

	^ {#'substring matcher' -> #substringMatchIn:.
	     #'wild matcher' -> #wildMatchIn:
	    }! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:08:19'!
performSearch

	| classes classCount |
	
	classes := domain getClasses.
	messageList := Set new.
	
	'Searching source code...'
		displayProgressAt: Sensor mousePoint
		from: 0
		to: classes size
		during: [ :barBlock |
			classCount := 0.
			classes do: [ :class |
				barBlock value: (classCount := classCount + 1).
				(Array
					with: class
					with: class class) do: [ :cl |
					cl selectorsDo: [ :sel | |sourceString method|
						method := MethodReference class: cl selector: sel.
						sourceString := self perform: self sourceSelector with: method.
						(self perform: self matcherSelector with: sourceString)		 ifTrue: [
							messageList add: method ]]		]]].
	messageList := messageList asArray sort.
	self changed: #messageList! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:13:53'!
searchContexts

	^ SearchContext subclasses! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:49:13'!
sourceNames

	^ self sources collect: [:src | src key]! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:05:25'!
sourceSelector

	^ self sources asDictionary at: source! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:52:59'!
sources

	^ {#'source' -> #getSourceOf: .
	     #'message name' -> #getMessageNameOf: .
	     #'string literal'     -> #getStringLiteralsOf: }! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:09:39'!
substringMatchIn: aString

	^ (aString findString: self searchString
		startingAt: 1
		caseSensitive: caseSensitive) > 0! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 14:31:44'!
toggleCaseSensitive

	caseSensitive  := caseSensitive not! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/3/2024 16:06:33'!
updateIfNeeded! !

!SearchBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 15:42:59'!
wildMatchIn: aString

	^ self searchString match: aString! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
domain
	"Answer the value of domain"

	^ domain! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
domain: anObject
	"Set the value of domain"

	domain := anObject! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
matcher
	"Answer the value of matcher"

	^ matcher! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
matcher: anObject
	"Set the value of matcher"

	matcher := anObject! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 20:35:13'!
searchString
	"Answer the value of searchString"

	^ searchString asString! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/4/2024 12:52:14'!
searchString: anObject
	"Set the value of searchString"

	searchString := anObject.
	self autoHighlightString: anObject asString allOccurrences: true! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
source
	"Answer the value of source"

	^ source! !

!SearchBrowser methodsFor: 'accessing' stamp: 'MM 6/3/2024 18:22:58'!
source: anObject
	"Set the value of source"

	source := anObject! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 15:31:01'!
buildMorphicWindow

	| searchBar listPane |
	
	listPane := self buildMorphicMessageList.
	
	self layoutMorph
		addMorph: listPane proportionalHeight: 0.3;
		addAdjusterAndMorph: self buildLowerPanes proportionalHeight: 0.7.
			
	searchBar := LayoutMorph newRow.
	
	matcherSelectionButton := (PluggableButtonMorph model: self action: #selectMatcher label: self model matcher asString) 
		setBalloonText: 'Select the matcher';
		yourself.
	sourceSelectionButton := (PluggableButtonMorph model: self action: #selectSource label: self model source asString)
		setBalloonText: 'Select the source';
		yourself.
	contextSelectionButton := (PluggableButtonMorph model: self action: #selectContext label: self model context asString)
		setBalloonText: 'Select the search context';
		yourself.
	searchBar addMorph: (PluggableButtonMorph model: self action: #performSearch label: 'Search').
	searchStringInput := (TextModelMorph textProvider: self textGetter: #searchString  textSetter: #searchString: )
							acceptOnCR: true;
							askBeforeDiscardingEdits: false;
							hideScrollBarsIndefinitely;
							morphHeight: 30; 
							yourself.
	searchBar addMorph: searchStringInput.
	searchBar addMorph:  (LabelMorph contents: ' in: ' );
			addMorph: sourceSelectionButton;
			addMorph: (LabelMorph contents: ' of: ');
			addMorph: contextSelectionButton;
			addMorph: (LabelMorph contents: ' using: ');
			addMorph:  matcherSelectionButton;
			addMorph: ((PluggableButtonMorph model: self model stateGetter: #isCaseSensitive action: #toggleCaseSensitive) label: 'Case sensitive').
	
	layoutMorph addAdjusterAndMorph: searchBar fixedHeight: 40.
	model changed: #editSelection.
	self setLabel: 'Search browser'! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:15:13'!
context
	^ self model context! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 15:45:09'!
performSearch

	| innerTextMorph |
	
	innerTextMorph := searchStringInput submorphsSatisfying: [:m | m isKindOf: InnerTextMorph ] :: first.
	innerTextMorph hasUnacceptedEdits 
		ifFalse: [self model performSearch]
		ifTrue: [innerTextMorph acceptContents].! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/3/2024 20:23:10'!
searchString
	^ model searchString! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 15:35:35'!
searchString: aString

	model searchString: aString.
	searchStringInput hasUnacceptedEdits: false.
	self model performSearch.! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:46:40'!
selectContext

	| menu selection contexts |
	
	
	contexts := self model searchContexts.
	menu := SelectionMenu labels: (contexts collect: [:ctx | ctx contextName])
							selections: contexts.
		
	selection := menu startUpMenu.
	selection ifNotNil: [ 
		selection createInstanceDo: [:ctx |
			self model context: ctx.
			contextSelectionButton label: ctx asString.
			contextSelectionButton owner someSubmorphPositionOrExtentChanged]]! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:48:22'!
selectMatcher

	| menu selection matchers |
	
	matchers := self model matcherNames.
	menu := SelectionMenu labels: (matchers collect: [:m | m asString]) 
							selections: matchers.
	selection := menu startUpMenu.
	
	selection ifNotNil: [
		self model matcher: selection.
		matcherSelectionButton label: selection asString.
		matcherSelectionButton owner someSubmorphPositionOrExtentChanged]! !

!SearchBrowserWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 10:52:36'!
selectSource

	| menu selection sources|
	
	sources := self model sourceNames.
	
	menu := SelectionMenu labels: (sources collect: [:m | m asString]) 
							selections: sources.
	selection := menu startUpMenu.
	selection ifNotNil: [
		self model source: selection.
		sourceSelectionButton label: selection asString.
		sourceSelectionButton owner someSubmorphPositionOrExtentChanged]! !

!SearchBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 07:57:56'!
open

	^ self open: SearchBrowser new label: 'Search Browser'.! !

!SearchBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 10:20:49'!
searchCategory: aSystemCategory

	"SearchBrowserWindow searchCategory: 'Morphic'"

	| model |
	
	model := SearchBrowser new
				context: (SystemCategorySearchContext on: aSystemCategory);
				yourself.
	self open: model.! !

!SearchBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 10:20:34'!
searchClass: aClassName

	"SearchBrowserWindow searchClass: #Morph."

	| model |
	
	model := SearchBrowser new
				context: (ClassSearchContext on: (Smalltalk at: aClassName));
				yourself.
	self open: model.! !

!SearchBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 16:55:39'!
systemCategoryMenuOptions

	^ {
			{
				#itemGroup 			-> 		10.
				#itemOrder 			-> 		15.
				#label 			-> 		'search...'.
				#selector 			-> 		#performSearch.
				#icon 			-> 		#findIcon
			} asDictionary.
		}! !

!SearchBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 07:57:06'!
worldMenuOptions
	^ `{{
			#submenuOf 			-> 		TheWorldMenu openLabel.
			#itemGroup 			-> 		10.
			#itemOrder 			-> 		40.
			#label 			-> 		'Search Browser'.
			#object 			-> 		SearchBrowserWindow.
			#selector 			-> 		#open.
			#icon 			-> 		#inspectIcon.
			#balloonText 			-> 		'A tool for searching source code.'.
		} asDictionary}`! !

!SearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:03:08'!
getClasses

	^ self subclassResponsibility ! !

!SearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:14:17'!
contextName

	^ self subclassResponsibility ! !

!SearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:34:26'!
createInstanceDo: aBlock

	^ self subclassResponsibility ! !

!ClassHierarchySearchContext methodsFor: 'as yet unclassified'!
getClasses
	^ {class} , class allSubclasses.! !

!ClassHierarchySearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:39:37'!
initialize: aClass
	class := aClass! !

!ClassHierarchySearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:39:46'!
printOn: aStream
	aStream
		nextPutAll: class name;
		nextPutAll: ' hierarchy'.! !

!ClassHierarchySearchContext class methodsFor: 'as yet unclassified'!
contextName
	^ 'class hierarchy'.! !

!ClassHierarchySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:42:30'!
createInstanceDo: aBlock

	^ ClassNameRequestMorph request: 'Class: ' 
		initialAnswer: '' 
		do: [ :pattern | ClassSearchContext findClassFrom: (Smalltalk classNames asOrderedCollection) ifFound: [:aClass | aBlock value: (self on: aClass)] with: pattern ]! !

!ClassHierarchySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:40:21'!
on: aClass
	^ self new initialize: aClass! !

!ClassProtocolSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:43:08'!
getClasses

	^ {class}, class allSuperclasses ! !

!ClassProtocolSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:40:01'!
initialize: aClass
	class := aClass! !

!ClassProtocolSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:39:54'!
printOn: aStream
	aStream
		nextPutAll: class name;
		nextPutAll: ' protocol'.! !

!ClassProtocolSearchContext class methodsFor: 'as yet unclassified'!
contextName
	^ 'class protocol'.! !

!ClassProtocolSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:42:20'!
createInstanceDo: aBlock

	^ ClassNameRequestMorph request: 'Class: ' 
		initialAnswer: '' 
		do: [ :pattern | ClassSearchContext findClassFrom: (Smalltalk classNames asOrderedCollection) ifFound: [:aClass | aBlock value: (self on: aClass)] with: pattern ]! !

!ClassProtocolSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/8/2024 11:40:12'!
on: aClass
	^ self new initialize: aClass! !

!ClassSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:04:23'!
getClasses

	^ {class}! !

!ClassSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:04:45'!
initialize: aClass

	class := aClass! !

!ClassSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:06:03'!
printOn: aStream

	aStream nextPutAll: 'Class: '.
	aStream nextPutAll: class name.! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:30:11'!
classNamesFrom: potentialClassNames with: pattern matching: toMatch 

	^ (pattern last = $. or: [pattern last = $ ])
		ifTrue: [potentialClassNames select: [:className | className asLowercase = toMatch]]
		ifFalse: [potentialClassNames select: [:className | className includesSubstring: toMatch caseSensitive: false]]! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:14:25'!
contextName

	^ #'class'! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:34:05'!
createInstanceDo: aBlock

	^ ClassNameRequestMorph request: 'Class: ' 
		initialAnswer: '' 
		do: [ :pattern | self findClassFrom: (Smalltalk classNames asOrderedCollection) ifFound: [:aClass | aBlock value: (self on: aClass)] with: pattern ]! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:26:35'!
findClassFrom: potentialClassNames ifFound: aBlock with: pattern

	| exactMatch foundClass index  classNames toMatch |

	pattern isEmpty ifTrue: [^self flash].
	
	toMatch := (pattern copyWithout: $.) asLowercase withBlanksTrimmed.
	classNames := self classNamesFrom: potentialClassNames with: pattern matching: toMatch.
	classNames isEmpty ifTrue: [^self flash].

	exactMatch := classNames detect: [ :each | each asLowercase = toMatch] ifNone: [ nil ].
	index := self indexOfClassFrom: classNames exactMatch: exactMatch.
	index = 0 ifTrue: [^self flash].
	
	foundClass := Smalltalk at: (classNames at: index) asSymbol.
	aBlock value: foundClass! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:30:45'!
indexOfClassFrom: classNames exactMatch: exactMatch

	| options |
	
	classNames size = 1 ifTrue: [ ^1 ].
	
	options := exactMatch
		ifNil: [ PopUpMenu labelArray: classNames lines: #()]
		ifNotNil: [
			classNames remove: exactMatch ifAbsent: [].
			classNames addFirst: exactMatch.
			PopUpMenu labelArray: classNames lines: #(1)].
		
	^options startUpMenu! !

!ClassSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:04:57'!
on: aClass

	^ self new initialize: aClass! !

!SystemCategorySearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 11:12:11'!
getClasses

	^ (SystemOrganization fullListAtCategoryNamed: systemCategory)
		collect: [:clsName | Smalltalk at: clsName]! !

!SystemCategorySearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:08:34'!
initialize: aSystemCategory

	systemCategory := aSystemCategory! !

!SystemCategorySearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:09:26'!
printOn: aStream

	aStream nextPutAll: 'System Category: '.
	aStream nextPutAll: systemCategory asString
! !

!SystemCategorySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:14:31'!
contextName

	^ #'system category'! !

!SystemCategorySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 14:19:52'!
createInstanceDo: aBlock

	| menu categories  |
	
	categories := (self systemCategoryRoots, SystemOrganization categories) asSet
					asSortedCollection.
	menu := SelectionMenu labels: (categories collect: [:cat | cat asString])
							selections: categories.
	menu startUpMenu ifNotNil: [:category |
		aBlock value: (self on: category)]! !

!SystemCategorySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:08:20'!
on: aSystemCategory

	^ self new initialize: aSystemCategory! !

!SystemCategorySearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2024 10:07:17'!
systemCategoryRoots
	"Answer the roots of the forest of system categories."
	| categories subcategories roots categoryName |
	categories := SystemOrganization categories.
	subcategories := Dictionary new.
	categories do: [:each|
		categoryName := (each findTokens: '-') first.
		(subcategories at: categoryName ifAbsentPut: [OrderedCollection new]) add: each].
	roots := OrderedCollection new.
	categories do: [:each|
		categoryName := (each findTokens: '-') first.
		(roots includes: categoryName) ifFalse:
			[(subcategories at: categoryName) size > 1 ifTrue: [roots add: categoryName asSymbol] ifFalse: [roots add: (subcategories at: categoryName) first asSymbol]]].
	^ roots! !

!SystemSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:10:50'!
getClasses

	^ Smalltalk allClasses! !

!SystemSearchContext methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:11:09'!
printOn: aStream

	aStream nextPutAll: 'every class'! !

!SystemSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:14:38'!
contextName

	^#'every class'! !

!SystemSearchContext class methodsFor: 'as yet unclassified' stamp: 'MM 6/4/2024 08:35:22'!
createInstanceDo: aBlock

	aBlock value: self new! !

!BrowserWindow methodsFor: '*SearchBrowser-menu commands' stamp: 'MM 6/4/2024 16:56:51'!
performSearch

	| searchBrowser |
	
	searchBrowser := SearchBrowser new.
	
	self model selectedClassOrMetaClass ifNotNil: [:class |
		searchBrowser context: (ClassSearchContext on: class)]
		ifNil: [
			self model selectedSystemCategory ifNotNil: [:category |
				searchBrowser context: (SystemCategorySearchContext on: category									)]].
						
	SearchBrowserWindow open: searchBrowser label: 'Search'! !
