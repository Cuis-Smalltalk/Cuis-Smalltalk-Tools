'From Cuis7.3 [latest update: #6910] on 12 December 2024 at 8:30:23 am'!
'Description Extensible keystrokes handler.

Author: Mariano Montone <marianomontone@gmail.com>

Edit keystrokes via WorldMenu -> Open -> Edit keystrokes.

KeyStrokes installEmacsLikeKeyBindings ; edit.'!
!provides: 'KeyStrokes' 1 58!
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
	classVariableNames: 'FullScreen KeyStrokesHandlers'
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokes class' category: #KeyStrokes!
KeyStrokes class
	instanceVariableNames: ''!

!classDefinition: #KeyStrokesEditorWindow category: #KeyStrokes!
SystemWindow subclass: #KeyStrokesEditorWindow
	instanceVariableNames: 'keyStrokeIndex keyStrokeString context selector receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokesEditorWindow class' category: #KeyStrokes!
KeyStrokesEditorWindow class
	instanceVariableNames: ''!


!KeyStroke commentStamp: '<historical>' prior: 0!
I represent a combination of key presses.

Instance vars:
- shift (Boolean): true when shift key is pressed.
- alt (Boolean): true when alt key is pressed.
- control (Boolean): true when control key is pressed.
- keyCharacter (Character): the key character that finalizes the combination.
- keySelector (Symbol): message selector to send to the KeyboardEvent involved to determine if the KeyStroke applies. For instance, #isEsc, #isReturnKey, etc.

Usage:

Create a KeyStroke, then use #handles: with a KeyboardEvent to determine if the KeyStroke matches it.
To create a KeyStroke it is possible to use #asKeyStroke on a String.
syntax ::= mod1+mod2+characterOrMessage
mod ::= shift | ctrl | alt
characterOrMessage ::= $character | #message

Examples:

KeyStroke new shift: true; keyCharacter: $a.
'shift+$a' asKeyStroke.
'shift+#isEsc' asKeyStroke.
'ctrl+alt+$c' asKeyStroke.!

!KeyStrokeHandler commentStamp: 'MM 12/4/2024 10:45:32' prior: 0!
I handle KeyStrokes that ocurred in a certain context.

Instance variables:
- keyStroke (KeyStroke): the KeyStroke to handle.
- context (Class): the class under which the KeyStroke is to be handled.
- handler (Symbol|MessageSend): The selector or MessageSend to be used to handle the key stroke.

The context is the Morph class under which the key event occurs, or some other object that is in the context of the key event. The context to use and match is determined by #keyStrokeContext of the receiving Morph.
The context of the handler is compared to the key event context by a type relation.
For global handlers, WorldMorph is used. For text editing handlers, a subclass of TextEditor can be used.

I support creation from an array spec. See #fromArray: in class side.

Examples:

KeyStrokeHandler fromArray: #('alt+$b' (open Browser)).
KeyStrokeHandler fromArray: #('alt+$b' (open Browser) WorldMorph).
KeyStrokeHandler fromArray: #('alt+$p' printIt SmalltalkEditor).!

!KeyStrokes commentStamp: '<historical>' prior: 0!
I'm a registry of KeyStrokeHandlers.

Use #on:send:to for adding a handler for a particular global key stroke.

For example, use this to install a handler for ctrl+$p for opening preferences inspector:

KeyStrokes on: 'ctrl+$p' send: #openPreferencesInspector to: Preferences.

Key strokes can also be set using array syntax (see KeyStrokeHandler>>fromArray: ) :

KeyStrokes addAll: #(('alt+$p' (open CompactPreferenceBrowser))
                                  ('alt+$s' (open SearchBrowserWindow )))
	
KeyStrokes openHelp.
KeyStrokes edit.
KeyStrokes installEmacsLikeKeyBindings.
KeyStrokes initialize. "reset keystrokes"!

!KeyStrokesEditorWindow commentStamp: '<historical>' prior: 0!
Tool for editing key bindings.

KeyStrokesEditorWindow open.!

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

!KeyStroke methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:35:41'!
hash

	^ {shift. control. alt. keyCharacter. keyValue. keySelector } hash
	! !

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

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:26:13'!
= aKeyStrokeHandler

	keyStroke = aKeyStrokeHandler keyStroke ifFalse: [^false].
	context = aKeyStrokeHandler context ifFalse: [^false].
	^true! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 10:22:08'!
handle: aKeyboardEvent in: aContext

	"Handle aKeyboardEvent that ocurred in aContext."

	^ (self handles: aKeyboardEvent in: aContext)
		ifTrue: [
			handler isSymbol 
				ifTrue: [
					handler isKeyword 
						ifTrue: [aContext perform: handler with: aKeyboardEvent]
						ifFalse: [	aContext perform: handler]]
				ifFalse: [handler value].
			true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:37:41'!
hash

	^ keyStroke hash bitXor: context hash! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:42:28'!
initialize: aKeyStroke context: aContext handler: aSelectorOrMessageSend

	keyStroke := aKeyStroke.
	context := aContext.
	handler := aSelectorOrMessageSend.
	
	self assert: aContext class class = Metaclass .
	self assert: (keyStroke isKindOf: KeyStroke).
	self assert: (handler isSymbol or: [handler isKindOf: MessageSend])! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:19:58'!
printOn: aStream

	keyStroke printOn: aStream.
	aStream nextPutAll: ' in '.
	context printOn: aStream.
	aStream nextPutAll: ': '.
	handler printOn: aStream! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:09:34'!
value: aKeyboardEvent

	^ (self handles: aKeyboardEvent)
		ifTrue: [handler value. true]
		ifFalse: [false]! !

!KeyStrokeHandler methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 12:07:29'!
value: aKeyboardEvent value: aContext

	^ self handle: aKeyboardEvent in: aContext! !

!KeyStrokeHandler methodsFor: 'testing' stamp: 'MM 12/3/2024 19:45:07'!
handles: aKeyboardEvent in: aContext
	
	^ (aContext isKindOf: context) and: [keyStroke handles: aKeyboardEvent]! !

!KeyStrokeHandler class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:23:31'!
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
	handler := handlerSpec isSymbol 
					ifTrue: [handlerSpec] 
					ifFalse: [MessageSend receiver: (Smalltalk at: (handlerSpec at: 2)) 
											selector: (handlerSpec at: 1)].
	
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

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:45:09'!
addKeyStrokeHandler: aHandlerOrArray

	(aHandlerOrArray isKindOf: KeyStrokeHandler)
		ifTrue: [KeyStrokesHandlers remove: aHandlerOrArray ifAbsent: [].
				^KeyStrokesHandlers add: aHandlerOrArray].
	aHandlerOrArray isArray ifTrue: [
		^self add: (KeyStrokeHandler fromArray: aHandlerOrArray)].
	self error: 'Bad key stroke handler spec'! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 10:56:52'!
edit

	KeyStrokesEditorWindow open! !

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

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 08:28:45'!
initialize
	"self initialize"
	KeyStrokesHandlers := Set new.
	self initializeDefaults.
	self initializeHelpers.! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 21:58:48'!
initializeDefaults

	self on: 'alt+$b' send: #open to: Browser.! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 08:29:00'!
initializeHelpers

	FullScreen := false.! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:35:48'!
installEmacsLikeKeyBindings

	self addAll: #(('alt+$w' copySelection TextEditor)
	                       ('ctrl+$w' cut TextEditor)
	                       ('ctrl+$e' cursorEnd: TextEditor)
	                       ('ctrl+$y' paste TextEditor))! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:03:04'!
keyStrokesHandlers

	^ KeyStrokesHandlers ! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:47:53'!
on: aKeyStroke in: aContext send: aSelector to: anObject
	self addKeyStrokeHandler: (KeyStrokeHandler keyStroke: aKeyStroke asKeyStroke context: aContext handler:  (MessageSend receiver: anObject selector: aSelector))! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:48:13'!
on: aKeyStroke send: aSelector to: anObject
	^self on: aKeyStroke in: WorldMorph send: aSelector to: anObject! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 11/21/2024 13:33:47'!
openHelp

	self help edit! !

!KeyStrokes class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 08:54:16'!
remove: aKeyStrokeHandler

	KeyStrokesHandlers remove: aKeyStrokeHandler! !

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

!KeyStrokes class methodsFor: 'helpers' stamp: 'MM 12/12/2024 08:27:16'!
fullScreenOff
	FullScreen := false.
	Display fullScreenMode: FullScreen.! !

!KeyStrokes class methodsFor: 'helpers' stamp: 'MM 12/12/2024 08:26:42'!
fullScreenOn
	FullScreen := true.
	Display fullScreenMode: FullScreen.! !

!KeyStrokes class methodsFor: 'helpers' stamp: 'MM 12/12/2024 08:28:15'!
toggleFullScreen
	FullScreen := FullScreen not.
	Display fullScreenMode: FullScreen.! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:53:27'!
buildMorphicWindow

	| keyStrokesList keyStrokeBar buttonsBar |
	
	keyStrokesList := PluggableListMorph 
						withModel: self 
						listGetter: #keyStrokesList 
						indexGetter: #keyStrokeIndex
						indexSetter: #keyStrokeIndex:.
	layoutMorph addMorph: keyStrokesList proportionalWidth: 1.0.
	
	keyStrokeBar := LayoutMorph newRow.
	keyStrokeBar addMorph:(LabelMorph contents: 'on: ').
	keyStrokeBar addMorph: ((TextModelMorph textProvider: self textGetter: #keyStrokeString  textSetter: #keyStrokeString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 100;
								setBalloonText: 'Key stroke spec';
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'in: ').
	keyStrokeBar addMorph: ((TextModelMorph textProvider: self textGetter: #contextString  textSetter: #contextString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 150;
								setBalloonText: 'Key stroke context';
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'send: ').
	keyStrokeBar addMorph: ((TextModelMorph textProvider: self textGetter: #selectorString  textSetter: #selectorString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 150;
								setBalloonText: 'Message selector'; 
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'to: ').
	keyStrokeBar addMorph: ((TextModelMorph textProvider: self textGetter: #receiverString  textSetter: #receiverString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 150;
								setBalloonText: 'Receiver (optional)'; 
								yourself).	
								
	layoutMorph addMorph: keyStrokeBar fixedHeight: 15.
	
	buttonsBar := LayoutMorph newRow.
	buttonsBar addMorph: (PluggableButtonMorph model: self action: #setKeyStroke label: 'Set').
	buttonsBar addMorph: (PluggableButtonMorph model: self action: #deleteKeyStroke label: 'Delete').
	"buttonsBar addMorph: (PluggableButtonMorph model: self action: #help label: 'Help')."
	layoutMorph addMorph: buttonsBar fixedHeight: 30.! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:31:55'!
contextString

	^ context! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:31:55'!
contextString: aString

	context := aString asString.
	
	"return true to indicate acceptance"
	
	^true! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:54:48'!
deleteKeyStroke
	
	self keyStrokeHandler ifNotNil: [:kshandler |
		model remove: kshandler.
		self changed: #keyStrokesList.
		keyStrokeIndex := 0.
		self changed: #keyStrokeIndex]! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:53:29'!
initialExtent

	^ 200@400! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:46:26'!
initialize

	super initialize.
	keyStrokeString := 'alt+$t'.
	context := 'WorldMorph'.
	selector := 'openTranscript'.
	receiver := 'TranscriptWindow'! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 11:40:02'!
keyStrokeHandler
	^keyStrokeIndex isZero ifFalse: [self keyStrokesList at: keyStrokeIndex]! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:03:58'!
keyStrokeIndex

	^ keyStrokeIndex ifNil: [0]! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:47:02'!
keyStrokeIndex: index

	| handler |

	keyStrokeIndex := index.
	
	index isZero ifTrue: [^self].
	
	keyStrokeString := self keyStrokeHandler keyStroke asString.
	context := self keyStrokeHandler context asString.
	handler := self keyStrokeHandler handler.
	selector := handler isSymbol ifTrue: [handler asString] ifFalse: [handler selector asString].
	receiver := handler isSymbol ifTrue: [''] ifFalse: [handler receiver asString].
	self changed: #keyStrokeString.
	self changed: #contextString.
	self changed: #receiverString.
	self changed: #selectorString.! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 08:14:23'!
keyStrokeString

	^ keyStrokeString! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 08:48:47'!
keyStrokeString: aString

	keyStrokeString := aString asString.
	
	"return true to indicate acceptance"
	
	^true! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:52:20'!
keyStrokesList

	^ model keyStrokesHandlers asSortedCollection: [:h1 :h2 |
		h1 context asString < h2 context asString or:
			(h1 context asString = h2 context asString and: [
				h1 keyStroke asString < h2 keyStroke asString])]! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:34:12'!
receiverString

	^ receiver! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:46:05'!
receiverString: aString

	receiver := aString asString.
	
	^ true! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:34:19'!
selectorString
	^selector! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:46:15'!
selectorString: aString

	selector := aString asString.
	
	"return true to indicate acceptance"
	
	^true! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 13:39:12'!
setKeyStroke

	| handler |
	
	receiver isEmpty ifFalse: [
		handler := KeyStrokeHandler keyStroke: keyStrokeString asKeyStroke 
								context: (Smalltalk at: context asSymbol)
								receiver: (Smalltalk at: receiver asSymbol)
								selector: selector asSymbol]
		ifTrue: [
			handler := KeyStrokeHandler keyStroke: keyStrokeString asKeyStroke 
								context: (Smalltalk at: context asSymbol)
								handler: selector asSymbol].
							
	model addKeyStrokeHandler: handler.
							
	self changed: #keyStrokesList! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:04:48'!
windowColor

	^Color lightYellow! !

!KeyStrokesEditorWindow class methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 22:58:29'!
open
	^ self open: KeyStrokes label: 'Key strokes'! !

!KeyStrokesEditorWindow class methodsFor: 'as yet unclassified' stamp: 'MM 12/4/2024 09:30:57'!
worldMenuOptions
	^ `{{
			#submenuOf 			-> 		TheWorldMenu openLabel.
			#itemGroup 			-> 		20.
			#itemOrder 			-> 		20.
			#label 			-> 		'Edit keystrokes'.
			#object 			-> 		KeyStrokesEditorWindow.
			#selector 			-> 		#open.
			#icon 			-> 		#accessoriesCharacterMapIcon.
			#balloonText 			-> 		'Edit keystrokes'.
		} asDictionary}`! !

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
