'From Cuis7.1 [latest update: #6877] on 3 December 2024 at 12:49:50 pm'!
'Description Extensible keystrokes handler.

Author: Mariano Montone <marianomontone@gmail.com>'!
!provides: 'KeyStrokes' 1 21!
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
	classVariableNames: 'KeyStrokesHandlers KeyStrokesInterceptors KeyStrokesMapping'
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

For example, use this to install a handler for Cmd-p for opening preferences inspector:

KeyStrokes 
	addKeyStroke: [:ev | (ev commandAltKeyPressed or: [ ev controlKeyPressed ]) and: [ev keyCharacter = $p]]
	handler: [Preferences openPreferencesInspector]. 
	
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

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 11:49:38'!
handle: aKeyboardEvent in: aContext

	^ (self handles: aKeyboardEvent in: aContext)
		ifTrue: [handler value. true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:08:35'!
handles: aKeyboardEvent

	^ keyStroke handles: aKeyboardEvent! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 11:16:03'!
handles: aKeyboardEvent in: aContext

	^ (context isKindOf: aContext) and: [keyStroke handles: aKeyboardEvent]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 10:58:40'!
initialize: aKeyStroke context: aContext handler: aBlock

	keyStroke := aKeyStroke.
	context := aContext.
	handler := aBlock! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:09:34'!
value: aKeyboardEvent

	^ (self handles: aKeyboardEvent)
		ifTrue: [handler value. true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:07:29'!
value: aKeyboardEvent value: aContext

	^ self handle: aKeyboardEvent in: aContext! !

!KeyStrokeHandler class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 10:58:08'!
keyStroke: aKeyStroke context: aContext handler: aBlock

	^ super new initialize: aKeyStroke context: aContext handler: aBlock! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 8/16/2020 11:43:09'!
addKeyStroke: aKeyStroke handler: aBlock
	KeyStrokesMapping at: aKeyStroke put: aBlock! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 2/6/2021 13:40:21'!
addKeyStrokeHandler: aBlock
	KeyStrokesHandlers addFirst: aBlock! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 2/6/2021 16:28:41'!
addKeyStrokeInterceptor: aBlock
	KeyStrokesInterceptors addFirst: aBlock! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 08:00:59'!
defaultWorldKeyStrokeHandler: aKeyboardEvent
	(aKeyboardEvent commandAltKeyPressed or: [ aKeyboardEvent controlKeyPressed ])
		ifTrue: [
			aKeyboardEvent keyCharacter = $b ifTrue: [ Browser open . ^true].
			aKeyboardEvent keyCharacter = $f ifTrue: [ BrowserWindow findAndBrowseClass.^true ].
			aKeyboardEvent keyCharacter = $F ifTrue: [ MessageNames open . ^true ]		].
	^false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 2/6/2021 16:32:25'!
defaultWorldKeyStrokeInterceptor: aKeyboardEvent morph: aMorph

	aKeyboardEvent isFindClassShortcut
			ifTrue: [ Preferences classFinder value. ^ true ].
	aKeyboardEvent isCloseWindowShortcut
			ifTrue: [ aKeyboardEvent closeCurrentWindowOf: aMorph. ^ true ].
			
	^ false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 8/16/2020 11:49:43'!
handleKeyStroke: aKeyboardEvent
	KeyStrokesHandlers do: [:handler |
		(handler value: aKeyboardEvent) ifTrue: [^true]].
	^ false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 13:33:37'!
help

	^ String streamContents: [:s |
		KeyStrokesHandlers do: [:handler |
			handler keyStroke printOn: s.
			s nextPutAll: ' ['.
			handler context printOn: s.
			s nextPutAll: ']  -  '.
			handler handler printOn: s.
			s newLine]]
			! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:02:27'!
initialize
	"self initialize"
	KeyStrokesHandlers := OrderedCollection new.
	KeyStrokesInterceptors := OrderedCollection new.
	KeyStrokesMapping := Dictionary new.
	KeyStrokes addKeyStrokeHandler: (KeyStrokeHandler keyStroke: (KeyStroke new alt: true; keyCharacter: $b)
														 context: WorldMorph  
														 handler: (MessageSend 		receiver: Browser selector: #open)). 
	KeyStrokes addKeyStrokeInterceptor: (KeyStrokeHandler keyStroke: (KeyStroke new alt: true; keyCharacter: $b)
														 context: WorldMorph  
														 handler: (MessageSend 		receiver: Browser selector: #open)). 
	"KeyStrokes addKeyStrokeHandler: [:ev | KeyStrokes defaultWorldKeyStrokeHandler: ev].
	KeyStrokes addKeyStrokeHandler: [:ev | KeyStrokes keyStrokeMappingsHandler: ev].
	KeyStrokes addKeyStrokeInterceptor: [:ev :morph | KeyStrokes defaultWorldKeyStrokeInterceptor: ev morph: morph]. "! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 2/6/2021 16:34:55'!
interceptKeyStroke: aKeyboardEvent morph: aMorph
	KeyStrokesInterceptors do: [:handler |
		(handler value: aKeyboardEvent value: aMorph) ifTrue: [^true]].
	^ false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 8/16/2020 11:48:34'!
keyStrokeMappingsHandler: aKeyboardEvent
	KeyStrokesMapping keysAndValuesDo: [:ks :handler |
		(ks value: aKeyboardEvent) ifTrue: [
			handler value. ^true]].
	^false! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 13:33:47'!
openHelp

	self help edit! !

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

!Theme methodsFor: '*KeyStrokes-icons' stamp: 'MM 12/3/2024 10:22:20'!
accessoriesCharacterMapIcon
	^ self fetch: #( '16x16' 'apps' 'accessories-character-map' )
! !

!KeyboardEvent methodsFor: '*KeyStrokes' stamp: 'MM 2/6/2021 16:34:13'!
sendEventTo: aMorph
	"Dispatch the receiver into anObject"
	type == #keystroke ifTrue: [
		(KeyStrokes interceptKeyStroke: self morph: aMorph)
			ifTrue: [^self].
		^ aMorph processKeystroke: self ].
	type == #keyDown ifTrue: [
		^ aMorph processKeyDown: self ].
	type == #keyUp ifTrue: [ 
		^ aMorph processKeyUp: self ].
	^ super sendEventTo: aMorph.! !

!WorldMorph methodsFor: '*KeyStrokes' stamp: 'MM 2/6/2021 13:36:38'!
keyStroke: aKeyboardEvent
	"Handle a keystroke event."
	
	^ (KeyStrokes handleKeyStroke: aKeyboardEvent)
		ifFalse: [ super keyStroke: aKeyboardEvent ]! !
KeyStrokes initialize!
