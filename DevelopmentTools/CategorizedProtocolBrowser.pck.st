'From Cuis7.1 [latest update: #6387] on 20 May 2024 at 10:34:37 pm'!
'Description A ProtocolBrowser tool with an additional list pane for navigating messages by category.'!
!provides: 'CategorizedProtocolBrowser' 1 9!
SystemOrganization addCategory: #CategorizedProtocolBrowser!


!classDefinition: #CategorizedProtocolBrowser category: #CategorizedProtocolBrowser!
MethodSet subclass: #CategorizedProtocolBrowser
	instanceVariableNames: 'baseClass selectiveClassList selectiveClassListIndex selectedName exclude categoriesList categoriesListIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CategorizedProtocolBrowser'!
!classDefinition: 'CategorizedProtocolBrowser class' category: #CategorizedProtocolBrowser!
CategorizedProtocolBrowser class
	instanceVariableNames: ''!

!classDefinition: #CategorizedProtocolBrowserWindow category: #CategorizedProtocolBrowser!
MethodSetWindow subclass: #CategorizedProtocolBrowserWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CategorizedProtocolBrowser'!
!classDefinition: 'CategorizedProtocolBrowserWindow class' category: #CategorizedProtocolBrowser!
CategorizedProtocolBrowserWindow class
	instanceVariableNames: ''!


!CategorizedProtocolBrowser commentStamp: '<historical>' prior: 0!
An instance of CategorizedProtocolBrowser shows the methods a class understands--inherited or implemented at this level--as a "flattened" list.!

!CategorizedProtocolBrowserWindow commentStamp: 'MM 5/20/2024 22:29:50' prior: 0!
A view of the messages available to a class from itself upward through the class hierarchy. The viewed protocol can be pruned by selecting a superclass in the class hierarchy pane.

CategorizedProtocolBrowserWindow openFullProtocolForClass: Number.!

!CategorizedProtocolBrowser methodsFor: 'accessing' stamp: 'MM 5/20/2024 21:16:37'!
growable
	"Answer whether the receiver is subject to manual additions and deletions"

	^ false! !

!CategorizedProtocolBrowser methodsFor: 'accessing' stamp: 'MM 5/20/2024 21:16:37'!
labelString
	"Answer the string for the window title"
	
	^ 'Protocol for: ', baseClass name, ' up to: ', (selectedName ifNil: [ ProtoObject name asPlainString ])! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:18:44'!
categoriesList
	
	^ categoriesList! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 22:06:52'!
categoriesListIndex
	"Answer the value of categoriesListIndex"

	^ categoriesListIndex ifNil: [0] ifNotNil: [categoriesListIndex]! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 22:26:34'!
categoriesListIndex: anIndex
	"Set the value of categoriesListIndex"

	categoriesListIndex := anIndex isZero ifTrue:  [nil] ifFalse: [anIndex].
	self changed: #messageList! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:16:37'!
hierarchyForClass: aClass
	"Set the class hierarchy for the list pane"
	| tab |

	selectiveClassList := OrderedCollection new.
	tab := ''.
	aClass withAllSuperclasses reverse do: [:ea | 
		selectiveClassList add: tab , ea name.
		tab := tab , '  '].
! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:16:37'!
initListFrom: selectorCollection highlighting: aClass 
	"Make up the messageList with items from aClass in boldface."
	| defClass item |

	messageList := OrderedCollection new.
	selectorCollection do: [ :selector |  
		defClass := aClass whichClassIncludesSelector: selector.
		item := selector, '     (' , defClass name , ')'.
		defClass == aClass ifTrue: [item := item asText allBold].
		messageList add: (
			MethodReference new
				setClass: defClass 
				methodSymbol: selector 
				stringVersion: item)].
	self hierarchyForClass: (baseClass := aClass)! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 22:04:08'!
messageList

	^ self selectedCategory ifNil: [ super messageList]
		ifNotNil: [:category |
			messageList select: [:methodRef | methodRef category == category]]! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:45:15'!
on: aClass
	"Initialize the protocol for the class, aClass."
	"Optionally, the upper part of the protocol is excluded."
	| selectors |
	
	selectors := Set new.
	aClass withAllSuperclasses do: [ :each |
		(exclude includes: each name) ifFalse: [selectors addAll: each selectors]].
	self
		initListFrom: selectors asArray sort
		highlighting: aClass.
	self updateCategoriesList.! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:16:37'!
protocolFor: anIndex
	"Change the listed protocol"

	exclude := OrderedCollection new.
	anIndex > 0
		ifTrue: [
			selectedName := (selectiveClassList at: anIndex) withBlanksTrimmed.
			(1 to: anIndex - 1) do: [:ix |
				exclude addLast: (selectiveClassList at: ix) withBlanksTrimmed]]
		ifFalse: [
			selectedName := nil.
			].
	self on: baseClass.
	self changed: #messageList.
	self changed: #relabel.
	self acceptedContentsChanged! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:59:06'!
selectedCategory

	^ categoriesListIndex ifNotNil: [categoriesList at: categoriesListIndex]! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:16:37'!
selectiveClassList
	"Answer the value of selectiveClassList"

	^ selectiveClassList! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:16:37'!
selectiveClassListIndex
	"Answer the value of selectiveClassListIndex"

	selectiveClassListIndex ifNil: [selectiveClassListIndex := 0].
	^ selectiveClassListIndex! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 22:24:41'!
selectiveClassListIndex: anObject
	"Set the value of selectiveClassListIndex"

	selectiveClassListIndex := anObject.
	categoriesListIndex := nil.
	self protocolFor: selectiveClassListIndex
! !

!CategorizedProtocolBrowser methodsFor: 'private' stamp: 'MM 5/20/2024 21:55:31'!
updateCategoriesList

	"Update the list of categories"
	
	| categories |
	
	categories := Set new.
	messageList do: [:methodRef | categories add: methodRef category].
	
	categoriesList := categories asSortedCollection.
	
	self changed: #categoriesList! !

!CategorizedProtocolBrowser methodsFor: 'initialization' stamp: 'MM 5/20/2024 21:16:37'!
initialize
	super initialize.
	exclude := OrderedCollection new! !

!CategorizedProtocolBrowserWindow methodsFor: 'GUI building' stamp: 'MM 5/20/2024 21:23:58'!
buildCategoriesList
	"Define the message categories list pane"

	^(PluggableListMorph
		withModel: model
		listGetter: #categoriesList
		indexGetter: #categoriesListIndex
		indexSetter: #categoriesListIndex:)
			mainView: self 
			menuGetter: #categoriesListMenu 
			keystrokeAction: #categoriesListKey:from:! !

!CategorizedProtocolBrowserWindow methodsFor: 'GUI building' stamp: 'MM 5/20/2024 21:22:51'!
buildMorphicWindow
	"Answer a morphic window that can display the receiver with a class hierarchy"
	| topRow |

	topRow := LayoutMorph newRow.
	topRow 
		addMorph: self buildSelectiveClassList proportionalWidth: 0.25;
		addAdjusterMorph;
		addMorph: self buildCategoriesList proportionalWidth: 0.25;
		addAdjusterMorph;
		addMorph: self buildMorphicMessageList proportionalWidth: 0.5.
	self layoutMorph
		addMorph: topRow proportionalHeight: 0.2;
		addAdjusterAndMorph: self buildLowerPanes proportionalHeight: 0.8.
	model changed: #editSelection! !

!CategorizedProtocolBrowserWindow methodsFor: 'GUI building' stamp: 'MM 5/20/2024 21:17:15'!
buildSelectiveClassList
	"Define the class hierarchy list pane"

	^(PluggableListMorph
		withModel: model
		listGetter: #selectiveClassList
		indexGetter: #selectiveClassListIndex
		indexSetter: #selectiveClassListIndex:)
			mainView: self 
			menuGetter: #protocolClassListMenu 
			keystrokeAction: #protocolClassListKey:from:! !

!CategorizedProtocolBrowserWindow methodsFor: 'menu building' stamp: 'MM 5/20/2024 21:17:15'!
protocolClassListMenu
	"Fill aMenu with items appropriate for the class list"

	| aMenu |
	self flag: #assumesKeyboardShortcuts.
	aMenu := MenuMorph new defaultTarget: self.
	aMenu addTitle: 'Class List'.
	aMenu 
		addItemsFromDictionaries: `{
			{
				#label 			-> 		'browse full (b)'.
				#selector 			-> 		#browseMethodFull.
				#icon 			-> 		#editFindReplaceIcon
			} asDictionary.
			{
				#label 			-> 		'browse hierarchy (h)'.
				#selector 			-> 		#browseHierarchy.
				#icon 			-> 		#goTopIcon
			} asDictionary.

		}`.
	^ aMenu! !

!CategorizedProtocolBrowserWindow methodsFor: 'keyboard shortcuts' stamp: 'MM 5/20/2024 21:17:15'!
protocolClassListKey: aChar from: view 
	"Respond to a Command key.  I am a model with a list of 
	classes and a list of methods.  The 
	view knows how to get the list and selection."

	self flag: #definesKeyboardShortcuts.
	aChar = $b ifTrue: [^ self browseMethodFull ].
	aChar = $h ifTrue: [^ self browseHierarchy].
	
	^ nil! !

!CategorizedProtocolBrowserWindow class methodsFor: 'as yet unclassified' stamp: 'MM 5/20/2024 21:27:09'!
openFullProtocolForClass: aClass
	"Create and schedule a browser for the entire protocol of the class."
	"
	CategorizedProtocolBrowserWindow openFullProtocolForClass: Number.
	"

	| aPBrowser label |

	aPBrowser := CategorizedProtocolBrowser new on: aClass.
	label := 'Entire protocol of: ', aClass name.

	^self open: aPBrowser label: label! !

!CodeWindow methodsFor: '*CategorizedProtocolBrowser' stamp: 'MM 5/20/2024 22:33:15'!
browseFullProtocol
	"Create and schedule a new protocol browser on the currently selected class or meta."

	| aPBrowser label |
	model selectedClassOrMetaClass ifNotNil: [ :classOrMetaclass |
		aPBrowser := CategorizedProtocolBrowser new on: classOrMetaclass.
		label := 'Entire protocol of: ', classOrMetaclass name.
		CategorizedProtocolBrowserWindow open: aPBrowser label: label ]! !
