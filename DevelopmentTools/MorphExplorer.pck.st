'From Cuis7.1 [latest update: #6578] on 10 August 2024 at 6:05:46 pm'!
'Description Tool that combines an explorer and an inspector specialized for Morphs.

Open from the Morphs Halo menu: Debug -> Explore.

Pickup morph to explore from the Window menu.'!
!provides: 'MorphExplorer' 1 20!
SystemOrganization addCategory: #MorphExplorer!


!classDefinition: #MorphExplorer category: #MorphExplorer!
AbstractHierarchicalList subclass: #MorphExplorer
	instanceVariableNames: 'rootMorph previousSelection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MorphExplorer'!
!classDefinition: 'MorphExplorer class' category: #MorphExplorer!
MorphExplorer class
	instanceVariableNames: ''!

!classDefinition: #MorphExplorerWindow category: #MorphExplorer!
SystemWindow subclass: #MorphExplorerWindow
	instanceVariableNames: 'listMorph inspectorMorph activateWindows inspector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MorphExplorer'!
!classDefinition: 'MorphExplorerWindow class' category: #MorphExplorer!
MorphExplorerWindow class
	instanceVariableNames: ''!

!classDefinition: #MorphExplorerWrapper category: #MorphExplorer!
ListItemWrapper subclass: #MorphExplorerWrapper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MorphExplorer'!
!classDefinition: 'MorphExplorerWrapper class' category: #MorphExplorer!
MorphExplorerWrapper class
	instanceVariableNames: ''!


!MorphExplorer commentStamp: 'MM 6/5/2023 16:43:21' prior: 0!
MorphExplorerWindow 
		open: (MorphExplorer new rootMorph: self runningWorld)!

!MorphExplorerWindow commentStamp: 'MM 6/5/2023 16:43:30' prior: 0!
MorphExplorerWindow 
		open: (MorphExplorer new rootMorph: self runningWorld)!

!MorphExplorer methodsFor: 'accessing' stamp: 'MM 6/13/2023 12:47:01'!
getList

	^Array with: (MorphExplorerWrapper with: rootMorph)! !

!MorphExplorer methodsFor: 'accessing' stamp: 'MM 6/5/2023 15:46:03'!
rootMorph
	"Answer the value of rootMorph"

	^ rootMorph! !

!MorphExplorer methodsFor: 'accessing' stamp: 'MM 6/5/2023 15:46:03'!
rootMorph: anObject
	"Set the value of rootMorph"

	rootMorph := anObject! !

!MorphExplorer methodsFor: 'accessing' stamp: 'jmv 8/10/2024 17:39:28'!
selectedMorph
	^ currentSelection item! !

!MorphExplorer methodsFor: 'as yet unclassified' stamp: 'jmv 8/10/2024 17:55:33'!
exploreSelectedMorph

	currentSelection item ifNotNil: [:aMorph | aMorph explore]! !

!MorphExplorer methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2023 16:33:04'!
getPreviousSelection

	^ previousSelection! !

!MorphExplorer methodsFor: 'as yet unclassified' stamp: 'MM 6/6/2023 10:22:01'!
inspectSelectedMorph

	currentSelection item ifNotNil: [:aMorph | aMorph inspect]! !

!MorphExplorer methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2023 16:32:45'!
noteNewSelection: anItemWrapper

	previousSelection := currentSelection.
	
	^ super noteNewSelection: anItemWrapper! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'jmv 8/10/2024 18:01:07'!
buildMorphicWindow

	|leftCol|
	
	leftCol := LayoutMorph newColumn.

	listMorph := (HierarchicalListMorph
				withModel: model
				listGetter: #getList
				indexGetter: #getCurrentSelection
				indexSetter: #noteNewSelection:)
					menuNshortcutsKey: #morphTreeMenuSpec.
	listMorph autoDeselect: false.
	listMorph doubleClickSelector: #inspectSelectedMorph.
	
	self createInspectorMorphOn: model rootMorph.
	
	leftCol addMorph: listMorph layoutSpec: LayoutSpec useAll.
	leftCol addMorph: (PluggableButtonMorph model: self action: #pickMorph label: 'Pick morph')
			fixedHeight: 30.
		
	self layoutMorph
		addMorph: leftCol proportionalWidth: 0.4;
		addAdjusterAndMorph: inspectorMorph layoutSpec: LayoutSpec useAll.
	
	self setLabel: model rootMorph shortPrintString.! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 11:46:56'!
buildWindowMenu

	|menu|
	
	menu := super buildWindowMenu.
	
	menu addLine.
	menu add: 'pick morph ...' action: #pickMorph icon: #worldIcon.
	
	^ menu! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'jmv 8/10/2024 18:01:42'!
createInspectorMorphOn: aMorph

	|window|
	inspector := Inspector inspect: aMorph.
	window := InspectorWindow new.
	window
		model: inspector;
		buildMorphicWindow.
	inspectorMorph := window layoutMorph! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 11:48:41'!
deeperMorphFrom: aMorph that: aBlock

	| found |
	
	aMorph submorphs do: [ :submorph |
		found := self
			deeperMorphFrom: submorph
			that: aBlock.
		found ifNotNil: [ ^ found ]].
	(aBlock value: aMorph) ifTrue: [ ^ aMorph ].

	^ nil.! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 12:00:59'!
delete

	model getCurrentSelection ifNotNil: [:aWrapper | aWrapper withoutListWrapper highlighted: false].
	
	super delete.! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 12:45:18'!
initialExtent

	^`500@400` * (Preferences at: #standardCodeFont) lineSpacing // 14! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/6/2023 10:45:16'!
initialize

	super initialize.
	self beRow.
	activateWindows := false.! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'jmv 10/11/2023 14:25:53'!
pickMorph

	| morph prevMorph delay world |
	
	morph := nil.
	prevMorph := nil.
	delay := Delay forMilliseconds: 50.
	world := self runningWorld.
	
	[Sensor isAnyButtonPressed] whileFalse: [
		prevMorph := morph.
		morph := self deeperMorphFrom: model rootMorph
					that: [:m | m displayBounds ifNotNil: [:bounds | bounds containsPoint: Sensor mousePoint] ifNil: [false]].
		prevMorph == morph ifFalse: [
			Transcript show: morph printString; newLine.
			prevMorph ifNotNil: [prevMorph highlighted: false].
			morph ifNotNil: [morph highlighted: true.
						model noteNewSelection: (MorphExplorerWrapper with: morph)]].
		world doOneCycleNowOn: world mainCanvas.
		delay wait].
	
	prevMorph ifNotNil: [prevMorph highlighted: false].
	morph ifNotNil: [
		morph highlighted: false.
		model noteNewSelection: (MorphExplorerWrapper with: morph)]
		! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'jmv 8/10/2024 18:01:18'!
replaceInspector

	self layoutMorph removeMorph: inspectorMorph.
	
	self createInspectorMorphOn:model getCurrentSelection withoutListWrapper .
	
	self layoutMorph addMorph: inspectorMorph layoutSpec: LayoutSpec useAll.
	self layoutMorph adoptWidgetsColor: self windowColor.! !

!MorphExplorerWindow methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 12:50:36'!
update: aSymbol

	aSymbol == #getCurrentSelection ifTrue: [ | selectedMorph |
		model getPreviousSelection ifNotNil: [:wrapper | wrapper item highlighted: false].
		selectedMorph := model getCurrentSelection ifNotNil: [:selection | selection item ].
		selectedMorph ifNotNil: [
			selectedMorph highlighted: true.
			activateWindows ifTrue: [selectedMorph isKindOf: SystemWindow :: ifTrue: [selectedMorph activate]].
			self replaceInspector]].! !

!MorphExplorerWindow methodsFor: 'menu & kbd shortcuts' stamp: 'jmv 8/10/2024 17:44:54'!
fieldListMenuSpec
	"Spec for the menu and shortcut keys for the list of variables in our object.
	See coment at Morph >> #getMenu
	"
	| answer |
	answer := #(
		#(10		'inspect (i)' 					$i 	window 			inspectSelectedVar 								inspectIcon)
		#(20		'explore (I)' 					$I 	window 			exploreSelectedVar 								exploreIcon)
		#(210 		'-----')
		#(220		'browser full (b)' 					$b 	window 			browseSelectedVarFull 								editFindReplaceIcon)
		#(230		'browser hierarch (h)' 					$h 	window 			browseSelectedVarHierarchy 								goTopIcon)
		#(240		'browser protocol (p)' 					$p 	window 			browseSelectedVarProtocol 								spreadsheetIcon)
	).
	^answer! !

!MorphExplorerWindow methodsFor: 'menu & kbd shortcuts' stamp: 'jmv 8/10/2024 17:55:12'!
morphTreeMenuSpec
	"Spec for the menu and shortcut keys for the list of variables in our object.
	See coment at Morph >> #getMenu
	"
	| answer |
	answer := #(
		#(10		'inspect (i)' 					$i 	window 			inspectSelectedMorph 									inspectIcon)
		#(20		'explore (I)' 					$I 	window 			exploreSelectedMorph 									exploreIcon)
		#(30		'copy to clipboard (c)' 					$c 	window 			copySelectionToClipboard 									copyIcon)
		#(210 		'-----')
		#(220		'browser full (b)' 					$b 	window 			browseSelectedMorphFull 									editFindReplaceIcon)
		#(230		'browser hierarch (h)' 					$h 	window 			browseSelectedMorphHierarchy 									goTopIcon)
		#(240		'browser protocol (p)' 					$p 	window 			browseSelectedMorphProtocol 									spreadsheetIcon)
	).
	^answer! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 17:58:51'!
browseSelectedMorphFull
	"Create and schedule a full Browser and then select the current class and message."

	|  myClass |
	(myClass := model selectedMorph class) ifNotNil: [
		BrowserWindow fullOnClass: myClass selector: nil]! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 17:57:48'!
browseSelectedMorphHierarchy
	"Create and schedule a class list browser on the receiver's hierarchy."

	HierarchyBrowserWindow
		onClass: model selectedMorph class
		selector: nil! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 17:59:05'!
browseSelectedMorphProtocol
	"Spawn a window showing full protocol for the receiver's selection"

	ProtocolBrowserWindow openFullProtocolForClass: model selectedMorph class! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 18:04:23'!
browseSelectedVarFull
	"Create and schedule a full Browser and then select the current class and message."

	|  myClass |
	(myClass := inspector selection class) ifNotNil: [
		BrowserWindow fullOnClass: myClass selector: nil]! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 18:04:40'!
browseSelectedVarHierarchy
	"Create and schedule a class list browser on the receiver's hierarchy."

	HierarchyBrowserWindow
		onClass: inspector selection class
		selector: nil! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 18:05:08'!
browseSelectedVarProtocol
	"Spawn a window showing full protocol for the receiver's selection"

	ProtocolBrowserWindow openFullProtocolForClass: inspector selection class! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 17:40:46'!
copySelectionToClipboard
	self model selectedMorph copyToClipboard! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 17:55:28'!
exploreSelectedMorph
	self model exploreSelectedMorph! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 18:03:23'!
exploreSelectedVar
	inspector selection explore! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 6/16/2024 17:08:40'!
inspectSelectedMorph
	self model inspectSelectedMorph! !

!MorphExplorerWindow methodsFor: 'menu commands' stamp: 'jmv 8/10/2024 18:03:38'!
inspectSelectedVar
	inspector selection inspect! !

!MorphExplorerWrapper methodsFor: 'as yet unclassified' stamp: 'MM 6/5/2023 16:13:08'!
contents

	^ item submorphs collect: [:submorph | self class with: submorph]! !

!MorphExplorerWrapper methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 12:23:24'!
isAncestorOf: anObject

	self item allSubmorphsDo: [:submorph |
		submorph == anObject ifTrue: [^true]].
	
	^ false! !

!Morph methodsFor: '*MorphExplorer' stamp: 'MM 6/6/2023 10:46:39'!
explore

	MorphExplorerWindow 
		open: (MorphExplorer new rootMorph: self)! !
