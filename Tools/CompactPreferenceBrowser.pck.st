'From Cuis7.1 [latest update: #6727] on 18 September 2024 at 11:54:53 am'!
'Description Tool for browsing and editing Cuis preferences.'!
!provides: 'CompactPreferenceBrowser' 1 13!
SystemOrganization addCategory: #CompactPreferenceBrowser!


!classDefinition: #PreferenceToggleButtonMorph category: #CompactPreferenceBrowser!
BorderedBoxMorph subclass: #PreferenceToggleButtonMorph
	instanceVariableNames: 'model getStateSelector isPressed actWhen actionSelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'PreferenceToggleButtonMorph class' category: #CompactPreferenceBrowser!
PreferenceToggleButtonMorph class
	instanceVariableNames: ''!

!classDefinition: #PreferenceEditorMorph category: #CompactPreferenceBrowser!
LinearLayoutMorph subclass: #PreferenceEditorMorph
	instanceVariableNames: 'preference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'PreferenceEditorMorph class' category: #CompactPreferenceBrowser!
PreferenceEditorMorph class
	instanceVariableNames: ''!

!classDefinition: #PreferencesPanel category: #CompactPreferenceBrowser!
LinearLayoutMorph subclass: #PreferencesPanel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'PreferencesPanel class' category: #CompactPreferenceBrowser!
PreferencesPanel class
	instanceVariableNames: ''!

!classDefinition: #PreferenceButtonMorph category: #CompactPreferenceBrowser!
PluggableButtonMorph subclass: #PreferenceButtonMorph
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'PreferenceButtonMorph class' category: #CompactPreferenceBrowser!
PreferenceButtonMorph class
	instanceVariableNames: ''!

!classDefinition: #PreferenceSelectionButtonMorph category: #CompactPreferenceBrowser!
PreferenceButtonMorph subclass: #PreferenceSelectionButtonMorph
	instanceVariableNames: 'printer placeHolder elems getter setter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'PreferenceSelectionButtonMorph class' category: #CompactPreferenceBrowser!
PreferenceSelectionButtonMorph class
	instanceVariableNames: ''!

!classDefinition: #CompactPreferenceBrowser category: #CompactPreferenceBrowser!
SystemWindow subclass: #CompactPreferenceBrowser
	instanceVariableNames: 'categoriesList selectedCategory selectedPreference preferencesPane scroller categories filter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CompactPreferenceBrowser'!
!classDefinition: 'CompactPreferenceBrowser class' category: #CompactPreferenceBrowser!
CompactPreferenceBrowser class
	instanceVariableNames: ''!


!PreferenceEditorMorph commentStamp: '<historical>' prior: 0!
The editor row for a single preference!

!CompactPreferenceBrowser commentStamp: '<historical>' prior: 0!
Cuis Smalltalk preferences editor.

CompactPreferenceBrowser open.

Or open from WorldMenu.!

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
actWhen
	"Answer the value of actWhen"

	^ actWhen! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
actWhen: anObject
	"Set the value of actWhen"

	actWhen _ anObject! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
actionSelector
	"Answer the value of actionSelector"

	^ actionSelector! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
actionSelector: anObject
	"Set the value of actionSelector"

	actionSelector _ anObject! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
getStateSelector
	"Answer the value of getStateSelector"

	^ getStateSelector! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
getStateSelector: anObject
	"Set the value of getStateSelector"

	getStateSelector _ anObject! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/15/2023 12:22:43'!
initialize
	super initialize.
	
	getStateSelector := #value.
	self morphExtent: 34@20.
	color := Color veryVeryLightGray .
	actWhen := #buttonDown.
	extent := nil! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
isPressed
	"Answer the value of isPressed"

	^ isPressed! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
isPressed: anObject
	"Set the value of isPressed"

	isPressed _ anObject! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
model
	"Answer the value of model"

	^ model! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
model: anObject
	"Set the value of model"

	model ifNotNil: [model removeDependent: self].
	getStateSelector ifNotNil: [
		anObject ifNotNil: [anObject addDependent: self]].
	model _ anObject! !

!PreferenceToggleButtonMorph methodsFor: 'accessing' stamp: 'MM 6/14/2023 20:45:06'!
update: aSymbol

	super update: aSymbol.
	aSymbol = getStateSelector ifTrue: [
		self redrawNeeded ]! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
defaultExtent

	^ 30@16! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/15/2023 12:21:10'!
drawOn: aCanvas

	|rx ry statusColor |
	
	"Calculate the radius of toggles."
	ry := self morphHeight // 2.
	rx := ry.
	
	"Draw the background."
	
	statusColor := self value ifTrue: [Color green] ifFalse: [Color gray].
	
	aCanvas ellipseCenter: rx@ry  
				radius: rx@ry  
				borderWidth: 1  
				borderColor: statusColor
				fillColor: statusColor.
	
	aCanvas ellipseCenter:  ((self morphExtent x - rx)@ry)
			radius: rx@ry  
			borderWidth: 1
			borderColor: statusColor
			fillColor: statusColor.
			
	aCanvas fillRectangle: ((rx@0) corner: ((self morphExtent x - rx)@self morphExtent y)) color: statusColor.
	
	"Draw either the On or Off toggle." 
	
	self value ifFalse: [
			aCanvas ellipseCenter: rx@ry  
				radius: ((rx@ry) - 2)  
				borderWidth: 0  
				borderColor: color
				fillColor: color]
		ifTrue: [
			aCanvas ellipseCenter:  ((self morphExtent x - rx)@ry)
				radius: ((rx@ry) - 2)  
				borderWidth: 0
				borderColor: color
				fillColor: color] ! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
handlesMouseDown: aMouseButtonEvent
	"Do I want to receive mouseDown events (mouseDown:, mouseMove:, mouseUp:)?"
	^true! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/2/2024 19:51:26'!
localBounds

	^`0@0` extent: self morphExtent.! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
morphExtent

	^ extent ifNil: [extent := self defaultExtent]! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
morphExtent: aPoint

	"The extent of this widget is set once when initializing it. Then it does not change anymore."
	"We need to ignore further calls from LayoutMorphs so that extent doesn't change."
	extent ifNil: [super morphExtent: aPoint]! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
mouseButton1Down: aMouseButtonEvent localPosition: localEventPosition

	isPressed _ true.
	self redrawNeeded.
	(actWhen == #buttonDown or: [ actWhen == #buttonStillDown ])
		ifTrue: [
			self performAction ]
		ifFalse: [
			"Don't make multi-click slower if we act on button down, just do multiple actions"
			aMouseButtonEvent hand
				waitForClicksOrDragOrSimulatedMouseButton2: self
				event: aMouseButtonEvent
				clkSel: nil
				clkNHalf: nil
				dblClkSel: #doubleClick:localPosition:
				dblClkNHalfSel: nil
				tripleClkSel: nil ]! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
performAction
	"Inform the model that this button has been pressed. "

	actionSelector ifNotNil: [
		actionSelector isBlock ifTrue: [actionSelector value]
		ifFalse: [	model perform: actionSelector ]]
	! !

!PreferenceToggleButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
value

	^ model perform: getStateSelector ! !

!PreferenceToggleButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:46:47'!
example1

	|s|
	
	s := Switch newOff.
	
	(PreferenceToggleButtonMorph on: s)
		getStateSelector: #isOn;
		actionSelector: #switch;
		morphExtent: 30@16;
		openInWorld
	
	! !

!PreferenceToggleButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 21:22:20'!
example2

	|s|
	
	s := Switch newOff.
	
	(PreferenceToggleButtonMorph on: s)
		getStateSelector: #isOn;
		actionSelector: #switch;
		openInWorld
	
	! !

!PreferenceToggleButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
model: aModel

	^ self new 
		model: aModel;
		yourself! !

!PreferenceToggleButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
model: anObject stateGetter: getStateSel action: actionSel

	^ self new
		model: anObject;
		getStateSelector: getStateSel;
		actionSelector: actionSel;
		yourself! !

!PreferenceToggleButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:45:06'!
on: aModel

	^ self new 
		model: aModel;
		yourself! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'jmv 9/12/2024 12:28:53'!
evaluatePreferenceValue
	
	| input |
	
	input := StringRequestMorph 
					request: 'Preference value (evaluate and set)' 
					initialAnswer: preference value printString
					orCancel: #cancelPreferenceValue.

	(input = #cancelPreferenceValue) ifFalse: [ | val |
		val  := Compiler evaluate: input.
		self setPreferenceTo: val]! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 16:43'!
handlesMouseDown: aMouseEvent
	^ true! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 16:53'!
handlesMouseOver: aMouseEvent
	^ true! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 19:43:37'!
initialize: aPreference
	
	| preferenceName nameMorph |
	
	preference := aPreference.
	
	self color: Color white.
	preferenceName := self printSymbol: aPreference name.
	self setBalloonText: aPreference description.
	nameMorph := LabelMorph contents: preferenceName.
	self addMorph: nameMorph
		proportionalWidth: 0.95;
		addMorph: (	self widgetForPreference: aPreference)! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 18:18'!
inspectPreference
	preference inspect! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 21:39:41'!
mouseButton2Activity
	
	self openPreferenceMenu! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 17:10'!
mouseEnter: aMouseEvent
	self color: (Color r: 0.942 g: 0.942 b: 0.942).! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 17:08'!
mouseLeave: aMouseEvent
	self color: Color white.! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 21:43:37'!
openPreferenceMenu

	| menu |
	
	menu := MenuMorph new defaultTarget: self; yourself.
	
	menu addTitle: ((self printSymbol: preference name) squeezedTo: 30).
	
	"menu add: 'Set default (', (preference defaultValue printString), ')'
		    target: self
		    action: #setDefault."
		
	menu add: 'Set value'
		    target: self
		    action: #evaluatePreferenceValue.
		
	menu add: 'Inspect'
		     target: self
			action: #inspectPreference.
			
	menu add: 'Browse references' 
		target: [Smalltalk browseAllCallsOn: preference name]
		action: #value.		
	
	(preference description isNil not and: [
		preference description isEmpty not]) ifTrue: [
		menu addMorphBack: (TextModelMorph withText: preference description)].
		
	menu popUpInWorld: self world! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 16:25'!
printSymbol: aSymbol
	| stream printed |
	stream _ aSymbol string readStream.
	printed _ WriteStream on: ''.
	printed nextPut: stream next asUppercase.
	[ stream atEnd ] whileFalse: [ | char |
		char _ stream next.
		char isUppercase ifTrue: [
			printed nextPut: Character space.
			char _ char asLowercase ].
		printed nextPut: char ].
	^ printed contents.! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 18:34:54'!
realTypeOfPreference: aPreference

	(aPreference type = BlockClosure) ifTrue: [^ aPreference value class].
	^ aPreference type! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 22:47:13'!
setPreference: aPreference to: anObject

	aPreference value: 
		((aPreference type = BlockClosure) 
			ifTrue: [	[anObject]]
			ifFalse: [anObject]).
	self changed: aPreference! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/15/2023 11:43:15'!
setPreferenceTo: anObject

	preference value: 
		((preference type = BlockClosure) 
			ifTrue: [	[anObject]]
			ifFalse: [anObject]).
	self changed: preference.! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 22:53:13'!
setPreferenceToFont

	| fontFamily |
			
	fontFamily := FontFamily promptUser.
	fontFamily ifNotNil: [
		self request:  'Point size' do: [:pointSizeStr | |font|
			font := fontFamily atPointSize: pointSizeStr asNumber.
			self setPreference: preference to: font.
			self changed: (font familyName , ' ', font pointSize asString)]]! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'jmv 9/12/2024 12:28:58'!
setPreferenceToString
	
	| input |
	
	input := StringRequestMorph 
					request: 'Preference value (string):' 
					initialAnswer: preference value
					orCancel: #cancelPreferenceValue.

	(input = #cancelPreferenceValue) ifFalse: [ 
		self setPreferenceTo: input]! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 20:46:35'!
widgetForBooleanPreference: aPreference label: aLabel

	|model|
	
	model := Switch new
		onAction: [ self setPreferenceTo: true ];
		offAction: [ self setPreferenceTo: false ];
		yourself.
	aPreference value
		ifTrue: [ model turnOn ]
		ifFalse: [ model turnOff ].
	^ PreferenceToggleButtonMorph
		model: model
		stateGetter: #isOn
		action: #switch	! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 16:48:21'!
widgetForDefaultPreference: aPreference label: aLabel

	| widget |
	widget := PreferenceButtonMorph 
					model: self 
					action: #evaluatePreferenceValue  
					label: aLabel .
	widget setBalloonText: preference value printString.
	widget fitContents.
	
	^ widget! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 22:49:02'!
widgetForFontPreference: aPreference label: aLabel

	|font|
	
	font := aPreference value.
	
	^ PreferenceButtonMorph 
		model: self
		action: #setPreferenceToFont
		label: (font familyName, ' ', font pointSize asString)

	! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 11:54:38'!
widgetForOptionsPreference: aPreference label: aLabel

	^ PreferenceSelectionButtonMorph on: aPreference elems: aPreference type! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 19:01:41'!
widgetForPreference: aPreference

	| valString preferenceType |
	
	valString := preference value printString truncateWithElipsisTo: 20.
	preferenceType := self realTypeOfPreference: aPreference.
	
	"Booleans"	
	(preferenceType = Boolean) ifTrue: [ ^ self widgetForBooleanPreference: aPreference	 label: valString].
	
	"Array with options"	
	(preferenceType isArray) ifTrue: [^ self widgetForOptionsPreference: aPreference label: valString].
		
	"Strings"	
	((preferenceType = CharacterSequence) or: [preferenceType inheritsFrom: CharacterSequence]) 
		ifTrue: [^ self widgetForStringPreference: aPreference label: valString		].	
	
	"Fonts"
	((preferenceType = AbstractFont) or: [aPreference type inheritsFrom: AbstractFont])
		ifTrue: [^ self widgetForFontPreference: aPreference label: valString].
	
	"Otherwise, create a button for evaluating a Smalltalk expression and setting the preference value with the result."
	^ self widgetForDefaultPreference: aPreference label: valString! !

!PreferenceEditorMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/15/2023 11:46:51'!
widgetForStringPreference: aPreference label: aLabel

	^ PreferenceButtonMorph
			model: self
			action: #setPreferenceToString
			label: aLabel! !

!PreferenceEditorMorph class methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 16:23'!
on: aPreference
	^ self newRow initialize: aPreference.! !

!PreferencesPanel methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 22:41:51'!
adjustExtent

	self morphWidth: owner morphWidth! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 19:55:20'!
fitContents

	^ self morphExtent: `0@0`! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 15:11:39'!
fontToUse

	^ FontFamily defaultFamilyPointSize: FontFamily defaultPointSize - 1! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 19:54:12'!
measureContents
	| f |
	f := self fontToUse.
	^((f widthOfString: label) max: 3)  @ f lineSpacing! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 11:38:39'!
minimumExtent

	^ self measureContents + (10@10)! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 11:52:03'!
model: anObject stateGetter: getStateSel action: actionSel label: aString
	
	super model: anObject stateGetter: getStateSel action: actionSel label: aString.
	self model: anObject! !

!PreferenceButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 11:52:39'!
update: updated 

	(updated isKindOf: Preference)
		ifTrue: [
			label := updated value printString.
			self morphExtent: 0@0.
			^ self redrawNeeded].
		
	updated isString ifTrue: [
		label := updated.
		self morphExtent: 0@0.
		^ self redrawNeeded].
		
	^ super update: updated! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:26:52'!
elems
	"Answer the value of elems"

	^ elems isBlock ifTrue: [elems value]
		ifFalse: [elems]! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:13'!
getter
	"Answer the value of getter"

	^ getter! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:19'!
getter: anObject
	"Set the value of getter"

	getter := anObject! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 10:45:14'!
initialize: aModel getter: getSymbol setter: setSymbol elems: aCollection printer: aSymbol

	model := aModel.
	placeHolder := '--'.
	printer := aSymbol.
	elems := aCollection.
	getter := getSymbol.
	setter := setSymbol.
	label := self label.
	
	! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 10:43:52'!
label
	^ self value ifNil: [placeHolder] ifNotNil: [self value perform: printer]! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:33:12'!
performAction

	 self selectItem! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:31'!
placeHolder
	"Answer the value of placeHolder"

	^ placeHolder! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:37'!
placeHolder: anObject
	"Set the value of placeHolder"

	placeHolder := anObject! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:47'!
printer
	"Answer the value of printer"

	^ printer! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:27:56'!
printer: anObject
	"Set the value of printer"

	printer := anObject! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:30:20'!
selectItem
	^ self selectItemWithMenu! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:22:11'!
selectItem: item

	self value: item.
	self 
		triggerEvent: #itemSelected:
		with: item! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:10:26'!
selectItemWithMenu

	| item menu |
	
	(self elems collect:[:elem | elem perform: printer]) ifNotEmpty: [:labelList |
		menu := self selectionMenuClass labelList: labelList selections: self elems .
		item := menu startUpMenu.
	
		item ifNotNil: [		self selectItem: item ]]! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:11:03'!
selectionMenuClass
	^ SelectionMenu! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:28:14'!
setter
	"Answer the value of setter"

	^ setter! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:17:47'!
value
	^ self model perform: getter! !

!PreferenceSelectionButtonMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 10:46:57'!
value: anObject
	self model perform: setter with: anObject.
	self update: self label! !

!PreferenceSelectionButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:14:38'!
on: aModel 
	^ self
		on: aModel
		elems: #()
		printer: #asString.! !

!PreferenceSelectionButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:14:47'!
on: aModel elems: aCollection
	^ self
		on: aModel
		elems: aCollection
		printer: #asString.! !

!PreferenceSelectionButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:14:55'!
on: aModel elems: aCollection printer: aSymbol
	"(SelectionButtonMorph on: (ValueHolder value: #foo))
	elems: #(foo bar baz);
	color: Color lightGray ;
	openInWorld"
	^ self on: aModel getter: #value setter: #value: elems: aCollection printer: aSymbol! !

!PreferenceSelectionButtonMorph class methodsFor: 'as yet unclassified' stamp: 'MM 9/18/2024 09:15:03'!
on: aModel getter: getter setter: setter elems: aCollection printer: aSymbol
	"(SelectionButtonMorph on: (ValueHolder value: #foo))
	elems: #(foo bar baz);
	color: Color lightGray ;
	openInWorld"
	^ self new initialize: aModel getter: getter setter: setter elems: aCollection printer: aSymbol! !

!CompactPreferenceBrowser methodsFor: 'GUI building' stamp: 'MM 7/21/2016 16:23'!
buildPreferenceEditorFor: aPreference
	^ PreferenceEditorMorph on: aPreference! !

!CompactPreferenceBrowser methodsFor: 'GUI building' stamp: 'MM 6/14/2023 11:08:30'!
buildPreferenceEditorsPane
	preferencesPane := PreferencesPanel newColumn.
	"preferencesPane color: Color white."
	self buildPreferencesPane.
	scroller := PluggableScrollPane new.
	scroller scroller: preferencesPane.
	scroller color: Color white.
	scroller scroller color: Color white.
	scroller setScrollDeltas.
	^ scroller.! !

!CompactPreferenceBrowser methodsFor: 'GUI building' stamp: 'MM 6/14/2023 10:21:52'!
buildPreferencesPane
	preferencesPane axisEdgeWeight: 0.
	self selectedCategoryPreferences do: [ :aPreference |
		preferencesPane
			addMorph: (self buildPreferenceEditorFor: aPreference)
			fixedHeight: 20 ].
	
	^ preferencesPane.! !

!CompactPreferenceBrowser methodsFor: 'GUI building' stamp: 'MM 6/15/2023 12:30:02'!
updatePreferencesList

	preferencesPane removeAllMorphs.
	self buildPreferencesPane.
	preferencesPane adoptWidgetsColor: self windowColor.
	scroller scroller morphHeight: (self selectedCategoryPreferences size * 20).
	scroller setScrollDeltas.! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/15/2023 08:59:56'!
buildWindowMenu

	| menu |
	
	menu := super buildWindowMenu.
	
	menu addLine.
	menu add: 'Reset system preferences' action: #resetSystemPreferences icon: #refreshIcon.
	
	^ menu ! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 11/1/2018 11:32'!
categories
	^ #(#'-- all --') , (categories ifNil: [categories := Preferences categories. categories])! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 17:51'!
initialExtent
	^  552.0@389.0! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 7/21/2016 17:47'!
minimumExtent
	^  546.0@163.0! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 11/4/2022 10:52:40'!
preferences
	^ Preferences allPreferences! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 15:01:51'!
preferencesInCategory: aCategory
	
	^ self preferences select: [:aPreference | aPreference category = aCategory]! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/16/2023 18:49:54'!
resetSystemPreferences

	self confirm: 'Reset system preferences?'
		:: ifTrue: [PreferenceSet init. CompactPreferenceBrowser initialize].! !

!CompactPreferenceBrowser methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 15:02:39'!
selectedCategoryPreferences

	|preferences|
	
	preferences := (self selectedCategory == #'-- all --') 
		ifTrue: [self preferences]	
		ifFalse: [self preferencesInCategory: self selectedCategory].
		
	filter ifNotEmpty: [
		preferences := preferences select: [:p | p name asString includesSubstring: filter asString caseSensitive: false]].
	
	preferences := preferences sorted: [:p1 :p2 | p1 name < p2 name].
	
	^ preferences! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 7/21/2016 12:16'!
categoriesList
	"Answer the value of categoriesList"

	^ categoriesList! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 7/21/2016 12:16'!
categoriesList: anObject
	"Set the value of categoriesList"

	categoriesList _ anObject! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 11/1/2018 11:51'!
filter

	^ filter! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 11/1/2018 12:17'!
filter: aText

	filter _ aText.
	
	self changed: #clearUserEdits.
	self updatePreferencesList ! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 7/21/2016 12:16'!
selectedCategory
	"Answer the value of selectedCategory"

	^ selectedCategory! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 11/1/2018 12:13'!
selectedCategory: anObject
	"Set the value of selectedCategory"
	selectedCategory _ anObject.
	
	self updatePreferencesList.! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 7/21/2016 12:16'!
selectedPreference
	"Answer the value of selectedPreference"

	^ selectedPreference! !

!CompactPreferenceBrowser methodsFor: 'accessing' stamp: 'MM 7/21/2016 12:16'!
selectedPreference: anObject
	"Set the value of selectedPreference"

	selectedPreference _ anObject! !

!CompactPreferenceBrowser methodsFor: 'initialization' stamp: 'jmv 5/17/2024 18:07:42'!
initialize
	
	| row leftPane filterInput |
	
	super initialize.
	self setLabel: 'Preferences'.
	selectedCategory := self categories first.
	filter := ''.
	
	row := LayoutMorph newRow.
	
	leftPane := LayoutMorph newColumn.
	leftPane axisEdgeWeight: 0.
	
	categoriesList := PluggableListMorphByItem
		withModel: self
		listGetter: #categories
		indexGetter: #selectedCategory
		indexSetter: #selectedCategory:.
		
	leftPane addMorphUseAll: categoriesList.
	
	filterInput := 	(TextModelMorph
						textProvider: self
						textGetter: #filter
						textSetter: #filter:) 
						acceptOnCR: true;
						hideScrollBarsIndefinitely;
						borderWidth: 1;
						setBalloonText: 'Preferences filter';
						yourself.
	leftPane addMorph: filterInput layoutSpec: (LayoutSpec proportionalWidth: 1 fixedHeight: 15).
	
	row
		addMorph: leftPane
		proportionalWidth: 0.3.
	row addAdjusterAndMorph:  self buildPreferenceEditorsPane layoutSpec: LayoutSpec useAll.
	self addMorph: row.! !

!CompactPreferenceBrowser class methodsFor: 'as yet unclassified' stamp: 'MM 6/14/2023 19:33:13'!
initialize

	"This is a fix to Cuis core. Should be moved to core, and removed from here."
	Preferences at: #classFinder put:  [ [BrowserWindow findClass] ].! !

!CompactPreferenceBrowser class methodsFor: 'as yet unclassified' stamp: 'MM 6/13/2023 19:33:42'!
open
	
	"self open"
	
	self new openInWorld! !

!PreferenceSet class methodsFor: '*CompactPreferenceBrowser' stamp: 'MM 6/16/2023 18:49:54'!
openPreferencesInspector
	CompactPreferenceBrowser open! !
CompactPreferenceBrowser initialize!
