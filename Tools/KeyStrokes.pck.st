'From Cuis7.1 [latest update: #6877] on 3 December 2024 at 10:19:30 pm'!
'Description Extensible keystrokes handler.

Author: Mariano Montone <marianomontone@gmail.com>'!
!provides: 'KeyStrokes' 1 37!
SystemOrganization addCategory: #KeyStrokes!


!classDefinition: #KeyStroke category: #KeyStrokes!
Object subclass: #KeyStroke
	instanceVariableNames: 'shift alt control keyCharacter keyValue keySelector'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStroke class' category: #KeyStrokes!
KeyStroke class
	instanceVariableNames: ''!

!classDefinition: #KeyStrokeHandler category: #KeyStrokes!
Object subclass: #KeyStrokeHandler
	instanceVariableNames: 'keyStroke context handler'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokeHandler class' category: #KeyStrokes!
KeyStrokeHandler class
	instanceVariableNames: ''!

!classDefinition: #KeyStrokes category: #KeyStrokes!
Object subclass: #KeyStrokes
	instanceVariableNames: ''
	classVariableNames: 'KeyStrokesHandlers'
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokes class' category: #KeyStrokes!
KeyStrokes class
	instanceVariableNames: ''!

!classDefinition: #KeyStrokesEditor category: #KeyStrokes!
TextEditor subclass: #KeyStrokesEditor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokesEditor class' category: #KeyStrokes!
KeyStrokesEditor class
	instanceVariableNames: ''!


!KeyStroke commentStamp: '<historical>' prior: 0!
A key combination.!

!KeyStrokeHandler commentStamp: '<historical>' prior: 0!
Handler for reacting to a KeyStroke.!

!KeyStrokes commentStamp: '<historical>' prior: 0!
Holds keystoke handlers.

Use KeyStrokes>>addKeyStroke:handler: for adding a handler for a particular key stroke.

You can also add a key stroke handler for a key stroke event with KeyStrokes>>addKeyStrokeHandler:.
The block passed as argument is passed the key stroke event and should return a boolean that indicates if the event was handled or not.

For example, use this to install a handler for ctrl-p for opening preferences inspector:

KeyStrokes 
	addKeyStroke: 'ctrl+$p' asKeyStroke
	receiver: Preferences selector: #openPreferencesInspector.
	
KeyStrokes openHelp!

!KeyStrokesEditor commentStamp: '<historical>' prior: 0!
Text editor that provides the editing of keystrokes.!

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
alt
	"Answer the value of alt"

	^ alt! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
alt: anObject
	"Set the value of alt"

	alt _ anObject! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
control
	"Answer the value of control"

	^ control! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
control: anObject
	"Set the value of control"

	control _ anObject! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:17:43'!
keyCharacter
	"Answer the value of character"

	^ keyCharacter! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:17:08'!
keyCharacter: anObject
	"Set the value of character"

	keyCharacter _ anObject! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 11/21/2024 13:25:31'!
keySelector
	"Answer the value of keyMessage"

	^ keySelector! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 11/21/2024 13:25:44'!
keySelector: anObject
	"Set the value of keyMessage"

	keySelector := anObject! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:10:18'!
keyValue
	"Answer the value of keyValue"

	^ keyValue! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:10:18'!
keyValue: anObject
	"Set the value of keyValue"

	keyValue _ anObject! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
shift
	"Answer the value of shift"

	^ shift! !

!KeyStroke methodsFor: 'accessing' stamp: 'MM 2/8/2021 15:09:19'!
shift: anObject
	"Set the value of shift"

	shift _ anObject! !

!KeyStroke methodsFor: 'testing' stamp: 'MM 11/21/2024 13:25:17'!
handles: aKeyboardEvent

	(shift not or: [aKeyboardEvent shiftPressed]) ifFalse: [^false].
	(control not or: [aKeyboardEvent controlKeyPressed]) ifFalse: [^false].
	(alt not or: [aKeyboardEvent commandAltKeyPressed]) ifFalse: [^false].
	(keyValue isNil or: [aKeyboardEvent keyValue == keyValue]) ifFalse: [^false].
	(keyCharacter isNil or: [aKeyboardEvent keyCharacter == keyCharacter]) ifFalse: [^false].
	(keySelector isNil or: [aKeyboardEvent perform: keySelector]) ifFalse: [^false].
	
	^ true! !

!KeyStroke methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 18:53:21'!
asKeyStroke

	^self! !

!KeyStroke methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 11:50:59'!
initialize

	shift := false.
	control := false.
	alt := false! !

!KeyStroke methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 13:26:36'!
printOn: aStream

	shift ifTrue: [aStream nextPutAll: 'shift+'].
	control ifTrue: [aStream nextPutAll: 'ctrl+'].
	alt ifTrue: [aStream nextPutAll: 'alt+'].
	keyCharacter ifNotNil: [keyCharacter printOn: aStream].
	keyValue ifNotNil: [keyValue printOn: aStream].
	keySelector ifNotNil: [keySelector printOn: aStream].! !

!KeyStroke methodsFor: 'comparing' stamp: 'MM 12/3/2024 18:49:35'!
= aKeyStroke
	aKeyStroke == self ifTrue: [^true].
	aKeyStroke shift = shift ifFalse: [^false].
	aKeyStroke control = control ifFalse: [^false].
	aKeyStroke alt = alt ifFalse: [^false].
	aKeyStroke keyValue = keyValue ifFalse: [^false].
	aKeyStroke keyCharacter = keyCharacter ifFalse: [^false].
	aKeyStroke keySelector = keySelector ifFalse: [^false].
	^true! !

!KeyStroke class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 12:46:43'!
readFrom: aStream

	"
	KeyStroke readFrom: 'alt+$b' readStream.
	KeyStroke readFrom: 'shift+ctrl+#isEsc' readStream.
	"

	| readModifier alt ctrl shift character message done |
	
	alt := false.
	ctrl := false.
	shift := false.
	done := false.
	
	readModifier := [aStream peek = $a ifTrue: [ "alt"
						self assert: ((aStream next: 'alt' size) = 'alt') description: 'alt expected'.
						alt := true].
					aStream peek = $c ifTrue: [ "ctrl"
						self assert: ((aStream next: 'ctrl' size) = 'ctrl') description: 'ctrl expected'.
						ctrl := true].
					aStream peek = $s ifTrue: [ "shift"
						self assert: ((aStream next: 'shift' size) = 'shift') description: 'shift expected'.
						shift := true]].
	readModifier value.
	[aStream atEnd or: [done]] whileFalse: [
		self assert: ((aStream next: 1) = '+') description: '+ expected'.
		({$$. $#} includes: aStream peek) ifTrue: [
			(aStream peek = $$) ifTrue: [ "character"
				character := Character readFrom: aStream.
				done := true].
			(aStream peek = $#) ifTrue: ["message"
				message := Symbol readFrom: aStream.
				done := true]]
			ifFalse: [readModifier value]].
	
	^KeyStroke new
		alt: alt;
		control: ctrl;
		shift: shift;
		keyCharacter: character;
		keySelector: message;
		yourself
			! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
context
	"Answer the value of context"

	^ context! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
context: anObject
	"Set the value of context"

	context := anObject! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
handler
	"Answer the value of handler"

	^ handler! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
handler: anObject
	"Set the value of handler"

	handler := anObject! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
keyStroke
	"Answer the value of keyStroke"

	^ keyStroke! !

!KeyStrokeHandler methodsFor: 'accessing' stamp: 'MM 11/21/2024 10:57:26'!
keyStroke: anObject
	"Set the value of keyStroke"

	keyStroke := anObject! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 19:26:33'!
handle: aKeyboardEvent in: aContext

	^ (self handles: aKeyboardEvent in: aContext)
		ifTrue: [
			handler isSymbol 
				ifTrue: [aContext perform: handler]
				ifFalse: [handler value].
			true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:08:35'!
handles: aKeyboardEvent

	^ keyStroke handles: aKeyboardEvent! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 19:45:07'!
handles: aKeyboardEvent in: aContext
	
	^ (aContext isKindOf: context) and: [keyStroke handles: aKeyboardEvent]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 10:58:40'!
initialize: aKeyStroke context: aContext handler: aBlock

	keyStroke := aKeyStroke.
	context := aContext.
	handler := aBlock! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 19:48:52'!
printOn: aStream

	keyStroke printOn: aStream.
	aStream nextPutAll: ' in '.
	context printOn: aStream.
	aStream nextPutAll: ' -> '.
	handler printOn: aStream! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:09:34'!
value: aKeyboardEvent

	^ (self handles: aKeyboardEvent)
		ifTrue: [handler value. true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:07:29'!
value: aKeyboardEvent value: aContext

	^ self handle: aKeyboardEvent in: aContext! !

!KeyStrokeHandler class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:19:10'!
fromArray: anArray

	"
	Syntax: #('KeyStroke spec' messageSpec contextSpec?)
	messageSpec := selector | (selector class).
	
	If messageSpec is selector, then the selector is sent to the result of #keyStrokeContext sent to the context.
	If messageSpec is (selector class), then the message is sent to class.
	
	contextSpec is optional. If not specified, then WorldMorph is used as default.
	
	Examples:
	KeyStrokeHandler fromArray: #('alt+$b' (open Browser)).
	KeyStrokeHandler fromArray: #('alt+$b' (open Browser) WorldMorph).
	KeyStrokeHandler fromArray: #('alt+$p' printIt SmalltalkEditor).
	"
	| context handler handlerSpec |
	
	self assert: (anArray size between: 2  and: 3). 
	context := anArray size = 3 ifTrue: [Smalltalk at: (anArray at: 3)] ifFalse: [WorldMorph].
	handlerSpec := anArray at: 2.
	handler := handlerSpec isSymbol ifTrue: [handlerSpec] ifFalse: [MessageSend receiver: (handlerSpec at: 2) selector: (handlerSpec at: 1)].
	
	^KeyStrokeHandler 
			keyStroke: (anArray at: 1) asKeyStroke
			context: context
			handler: handler! !

!KeyStrokeHandler class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:14:59'!
keyStroke: aKeyStroke context: aContext handler: aSelectorOrHandler

	^ super new initialize: aKeyStroke context: aContext handler: aSelectorOrHandler! !

!KeyStrokeHandler class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:15:28'!
keyStroke: aKeyStroke context: aContext receiver: aReceiver selector: aSelector

	^ self keyStroke: aKeyStroke context: aContext handler: (MessageSend receiver: aReceiver selector: aSelector)! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 16:17:10'!
add: aHandler
	^ self addKeyStrokeHandler: aHandler! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 16:50:05'!
addAll: aCollection
	"Example:
		KeyStrokes addAll: #(('alt+$p' open CompactPreferenceBrowser)
                                                ('alt+$s' open SearchBrowserWindow ))
	"
	aCollection do: [:keyStrokeHandler |
		self add: keyStrokeHandler]! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 15:56:35'!
addKeyStroke: aKeyStroke handler: aBlock
	KeyStrokesHandlers add: (KeyStrokeHandler keyStroke: aKeyStroke context: WorldMorph handler: aBlock)! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 18:53:03'!
addKeyStroke: aKeyStroke receiver: aReceiver selector: aSelector
	KeyStrokesHandlers add: (KeyStrokeHandler keyStroke: aKeyStroke asKeyStroke context: WorldMorph handler:  (MessageSend receiver: aReceiver selector: aSelector))! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 16:16:29'!
addKeyStrokeHandler: aHandlerOrArray

	(aHandlerOrArray isKindOf: KeyStrokeHandler)
		ifTrue: [^KeyStrokesHandlers addFirst: aHandlerOrArray].
	aHandlerOrArray isArray ifTrue: [
		^KeyStrokesHandlers addFirst: (KeyStrokeHandler fromArray: aHandlerOrArray)].
	self error: 'Bad key stroke handler spec'! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 21:56:40'!
handleKeyStroke: aKeyboardEvent in: aMorph
	KeyStrokesHandlers do: [:handler |
		(handler value: aKeyboardEvent value: aMorph keyStrokeContext) ifTrue: [^true]].
	^ false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 16:58:46'!
help

	^ String streamContents: [:s |
		KeyStrokesHandlers do: [:handler |
			handler keyStroke printOn: s.
			s nextPutAll: ' in '.
			handler context printOn: s.
			s nextPutAll: ': '.
			handler handler printOn: s.
			s newLine]]
			! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 21:58:00'!
initialize
	"self initialize"
	KeyStrokesHandlers := OrderedCollection new.
	self initializeDefaults.! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 21:58:48'!
initializeDefaults

	self on: 'alt+$b' send: #open to: Browser.! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 18:52:50'!
on: aKeyStroke send: aSelector to: anObject

	^self addKeyStroke: aKeyStroke receiver: anObject selector: aSelector! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 13:33:47'!
openHelp

	self help edit! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 21:53:53'!
reset
	KeyStrokesHandlers := OrderedCollection new! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 10:20:47'!
worldMenuOptions
	^ `{{
			#submenuOf 			-> 		TheWorldMenu helpLabel.
			#itemGroup 			-> 		20.
			#itemOrder 			-> 		20.
			#label 			-> 		'Keystrokes'.
			#object 			-> 		KeyStrokes.
			#selector 			-> 		#openHelp.
			#icon 			-> 		#accessoriesCharacterMapIcon.
			#balloonText 			-> 		'Visualize system keystrokes'.
		} asDictionary}`! !

!KeyStrokesEditor methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 15:22:09'!
updateKeyStrokes

	| contents separatorCharacter handlers |
	
	contents := self actualContents readStream.
	separatorCharacter := [:char | {Character space. Character tab} includes: char].
	handlers := OrderedCollection new.
		
	[contents nextLine = 'Keywords:'] whileFalse.
	
	[contents atEnd] whileFalse: [ |line|
		line := contents nextLine.
		line ifNotEmpty: [| readLine escapeWhiteSpace keyStroke context handler |
			readLine := line readStream.
			escapeWhiteSpace := [[separatorCharacter value: line peek] whileTrue: [readLine next]].
			escapeWhiteSpace value.
			keyStroke := KeyStroke readFrom: line.
			escapeWhiteSpace value.
			context := self readContextFrom: line.
			escapeWhiteSpace value.
			self assert: (line next = $-) description: 'dash separator expected'.
			handler := self readHandlerFrom: line.
			escapeWhiteSpace value.
			handlers add: (KeyStrokeHandler keyStroke: keyStroke context: context handler: handler)]].! !

!CharacterSequence methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 15:51:55'!
asKeyStroke
	^KeyStroke readFrom: self readStream! !

!Theme methodsFor: '*KeyStrokes-icons' stamp: 'MM 12/3/2024 10:22:20'!
accessoriesCharacterMapIcon
	^ self fetch: #( '16x16' 'apps' 'accessories-character-map' )
! !

!KeyboardEvent methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 21:56:40'!
sendEventTo: aMorph
	"Dispatch the receiver into anObject"
	type == #keystroke ifTrue: [
		(KeyStrokes handleKeyStroke: self in: aMorph)
			ifTrue: [^self].
		^ aMorph processKeystroke: self ].
	type == #keyDown ifTrue: [
		^ aMorph processKeyDown: self ].
	type == #keyUp ifTrue: [ 
		^ aMorph processKeyUp: self ].
	^ super sendEventTo: aMorph.! !

!Morph methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 19:20:31'!
keyStrokeContext

	^ self! !

!InnerTextMorph methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 19:32:03'!
keyStrokeContext

	^ editor! !
KeyStrokes initialize!
