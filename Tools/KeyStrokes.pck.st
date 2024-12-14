'From Cuis7.3 [latest update: #6912] on 14 December 2024 at 9:09:11 am'!
'Description Extensible keystrokes handler.

Author: Mariano Montone <marianomontone@gmail.com>

Edit keystrokes via WorldMenu -> Open -> Edit keystrokes.

KeyStrokes installEmacsLikeKeyBindings ; edit.'!
!provides: 'KeyStrokes' 1 71!
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

!classDefinition: #KeyStrokesRegistry category: #KeyStrokes!
Object subclass: #KeyStrokesRegistry
	instanceVariableNames: 'keyStrokesHandlers traceKeyStrokes fullScreen'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'KeyStrokes'!
!classDefinition: 'KeyStrokesRegistry class' category: #KeyStrokes!
KeyStrokesRegistry class
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

!KeyStrokesRegistry commentStamp: '<historical>' prior: 0!
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

!KeyStroke methodsFor: 'testing' stamp: 'MM 12/13/2024 08:38:47'!
handles: aKeyboardEvent

	aKeyboardEvent shiftPressed = shift ifFalse: [^false].
	aKeyboardEvent controlKeyPressed = control ifFalse: [^false].
	aKeyboardEvent commandAltKeyPressed = alt ifFalse: [^false].
	keySelector ifNotNil: [^aKeyboardEvent perform: keySelector].
	"aKeyboardEvent keyValue == keyValue ifFalse: [^false]."
	aKeyboardEvent keyCharacter = keyCharacter ifFalse: [^false].	
	
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

!KeyStroke class methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 09:06:44'!
fromKeyboardEvent: aKeyboardEvent

	^ self new
		control: aKeyboardEvent controlKeyPressed ;
		shift: aKeyboardEvent shiftPressed ;
		alt: aKeyboardEvent commandAltKeyPressed ;
		keyCharacter: aKeyboardEvent keyCharacter ;
		yourself! !

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

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:35:30'!
add: aHandler
	^ self addKeyStrokeHandler: aHandler! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:35:39'!
addAll: aCollection
	"Example:
		KeyStrokes addAll: #(('alt+$p' open CompactPreferenceBrowser)
                                                ('alt+$s' open SearchBrowserWindow ))
	"
	aCollection do: [:keyStrokeHandler |
		self add: keyStrokeHandler]! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 12:28:09'!
addKeyStrokeHandler: aHandlerOrArray

	(aHandlerOrArray isKindOf: KeyStrokeHandler)
		ifTrue: [keyStrokesHandlers remove: aHandlerOrArray ifAbsent: [].
				^keyStrokesHandlers add: aHandlerOrArray].
	aHandlerOrArray isArray ifTrue: [
		^self add: (KeyStrokeHandler fromArray: aHandlerOrArray)].
	self error: 'Bad key stroke handler spec'! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:35:53'!
edit

	KeyStrokesEditorWindow open! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/14/2024 09:08:38'!
handleKeyStroke: aKeyboardEvent in: aMorph
	
	"If #worldKeyStrokesPrecedence preference is enabled, give preference to world keystrokes."
	aMorph isWorldMorph ifFalse: [
		(Preferences at: #worldKeyStrokesPrecedence) ifTrue: [
			(self handleKeyStroke: aKeyboardEvent in: self runningWorld) ifTrue: [^true]]].
	
	traceKeyStrokes ifTrue: [self traceOutput: aKeyboardEvent in: aMorph].
	keyStrokesHandlers do: [:handler |
		(handler value: aKeyboardEvent value: aMorph keyStrokeContext) ifTrue: [
			traceKeyStrokes ifTrue: [Transcript nextPutAll: 'Handled by: '; show: handler; cr].
			^true]].
	^ false! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:52:57'!
help

	^ String streamContents: [:s |
		keyStrokesHandlers do: [:handler |
			handler keyStroke printOn: s.
			s nextPutAll: ' in '.
			handler context printOn: s.
			s nextPutAll: ': '.
			handler handler printOn: s.
			s newLine]]
			! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:40:17'!
initialize
	keyStrokesHandlers := Set new.
	traceKeyStrokes := false.
	self initializeDefaults.
	self initializeHelpers.! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:37:03'!
initializeDefaults

	self on: 'alt+$b' send: #open to: Browser.! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:40:33'!
initializeHelpers

	fullScreen := false.! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:37:12'!
installEmacsLikeKeyBindings

	self addAll: #(('alt+$w' copySelection TextEditor)
	                       ('ctrl+$w' cut TextEditor)
	                       ('ctrl+$e' cursorEnd: TextEditor)
	                       ('ctrl+$y' paste TextEditor))! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:41:02'!
keyStrokesHandlers

	^ keyStrokesHandlers! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:37:24'!
on: aKeyStroke in: aContext send: aSelector to: anObject
	self addKeyStrokeHandler: (KeyStrokeHandler keyStroke: aKeyStroke asKeyStroke context: aContext handler:  (MessageSend receiver: anObject selector: aSelector))! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:37:28'!
on: aKeyStroke send: aSelector to: anObject
	^self on: aKeyStroke in: WorldMorph send: aSelector to: anObject! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:37:41'!
openHelp

	self help edit! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 16:00:11'!
printOn: aStream
	aStream nextPutAll: 'KeyStrokes'! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:53:02'!
remove: aKeyStrokeHandler

	keyStrokesHandlers remove: aKeyStrokeHandler! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:42:15'!
traceKeyStrokes

	traceKeyStrokes := true! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:42:35'!
traceKeyStrokesEnabled

	^ traceKeyStrokes! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:38:01'!
traceOutput: aKeyboardEvent in: aMorph

	|keyStroke|
	
	keyStroke := KeyStroke fromKeyboardEvent: aKeyboardEvent.

	Transcript nextPutAll: 'In: '; show: aMorph keyStrokeContext ;
		nextPutAll: ' -> ';
		show: keyStroke;
		cr.! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:42:56'!
tracingKeyStrokes

	^ traceKeyStrokes ! !

!KeyStrokesRegistry methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 11:43:19'!
untraceKeyStrokes

	traceKeyStrokes := false. ! !

!KeyStrokesRegistry methodsFor: 'helpers' stamp: 'MM 12/12/2024 11:41:51'!
fullScreenOff
	fullScreen := false.
	Display fullScreenMode: fullScreen.! !

!KeyStrokesRegistry methodsFor: 'helpers' stamp: 'MM 12/12/2024 11:41:42'!
fullScreenOn
	fullScreen := true.
	Display fullScreenMode: fullScreen.! !

!KeyStrokesRegistry methodsFor: 'helpers' stamp: 'MM 12/12/2024 11:41:29'!
toggleFullScreen
	fullScreen := fullScreen not.
	Display fullScreenMode: fullScreen.! !

!KeyStrokesRegistry class methodsFor: 'as yet unclassified' stamp: 'MM 12/14/2024 09:01:26'!
initialize

	Smalltalk at: #KeyStrokes put: KeyStrokesRegistry new.
	
	Preferences name: #worldKeyStrokesPrecedence
		description: 'Keystrokes that occur in World take precedence over the others'
		category: 'gui'
		type: Boolean
		value: true.! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/13/2024 08:44:57'!
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
	keyStrokeBar addMorphUseAll: ((TextModelMorph textProvider: self textGetter: #keyStrokeString  textSetter: #keyStrokeString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 100;
								setBalloonText: 'Key stroke spec';
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'in: ').
	keyStrokeBar addMorphUseAll: ((TextModelMorph textProvider: self textGetter: #contextString  textSetter: #contextString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 150;
								setBalloonText: 'Key stroke context';
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'send: ').
	keyStrokeBar addMorphUseAll: ((TextModelMorph textProvider: self textGetter: #selectorString  textSetter: #selectorString: )
								acceptOnAny: true;
								askBeforeDiscardingEdits: false;
								hideScrollBarsIndefinitely;
								morphHeight: 15;
								morphWidth: 150;
								setBalloonText: 'Message selector'; 
								yourself).
	keyStrokeBar addMorph:(LabelMorph contents: 'to: ').
	keyStrokeBar addMorphUseAll: ((TextModelMorph textProvider: self textGetter: #receiverString  textSetter: #receiverString: )
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
	buttonsBar addMorph: ((PluggableButtonMorph model: self stateGetter: #tracingKeyStrokes action: #toggleTracing label: 'Trace')
		setBalloonText: 'Trace keystrokes on Transcript'; yourself).
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

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 10:23:56'!
toggleTracing

	model tracingKeyStrokes 
		ifTrue: [model untraceKeyStrokes ]
		ifFalse: [model traceKeyStrokes ]! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 10:24:48'!
tracingKeyStrokes

	^ model tracingKeyStrokes ! !

!KeyStrokesEditorWindow methodsFor: 'as yet unclassified' stamp: 'MM 12/3/2024 23:04:48'!
windowColor

	^Color lightYellow! !

!KeyStrokesEditorWindow class methodsFor: 'as yet unclassified' stamp: 'MM 12/12/2024 12:12:58'!
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

!KeyboardEvent methodsFor: '*KeyStrokes' stamp: 'MM 12/12/2024 16:07:44'!
sendEventTo: aMorph
	"Dispatch the receiver into anObject"
	type == #keystroke ifTrue: [ 
		(KeyStrokes handleKeyStroke: self in: aMorph)
			ifTrue: [^self wasHandled: true].
		aMorph processKeystroke: self.
		self wasHandled ifFalse: [
			KeyStrokes handleKeyStroke: self in: self runningWorld].
		^self].
	type == #keyDown ifTrue: [
		^ aMorph processKeyDown: self ].
	type == #keyUp ifTrue: [ 
		^ aMorph processKeyUp: self ].
	^ super sendEventTo: aMorph.! !

!Morph methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 19:20:31'!
keyStrokeContext

	^ self! !

!PluggableMorph methodsFor: '*KeyStrokes' stamp: 'MM 12/12/2024 10:31:18'!
keyStrokeContext

	^ model! !

!InnerTextMorph methodsFor: '*KeyStrokes' stamp: 'MM 12/3/2024 19:32:03'!
keyStrokeContext

	^ editor! !
KeyStrokesRegistry initialize!
