'From Cuis7.1 [latest update: #6669] on 2 September 2024 at 7:52:18 pm'!
'Description Simple desktop notifications.'!
!provides: 'DesktopNotifications' 1 7!
SystemOrganization addCategory: #DesktopNotifications!


!classDefinition: #DesktopNotification category: #DesktopNotifications!
Object subclass: #DesktopNotification
	instanceVariableNames: 'message category'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesktopNotifications'!
!classDefinition: 'DesktopNotification class' category: #DesktopNotifications!
DesktopNotification class
	instanceVariableNames: ''!

!classDefinition: #DesktopNotificationMorph category: #DesktopNotifications!
TextParagraphMorph subclass: #DesktopNotificationMorph
	instanceVariableNames: 'desktopNotification startedOpen beingOpen duration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'DesktopNotifications'!
!classDefinition: 'DesktopNotificationMorph class' category: #DesktopNotifications!
DesktopNotificationMorph class
	instanceVariableNames: ''!


!DesktopNotification commentStamp: '<historical>' prior: 0!
Examples:

DesktopNotification info: 'hello'.

DesktopNotification warn: 'I''m warning you!!'.
DesktopNotification error: 'An error ocurred'.
DesktopNotification info: 'long' duration: 5000.!

!DesktopNotification methodsFor: 'accessing' stamp: 'MM 2/22/2022 15:10:45'!
category
	"Answer the value of category"

	^ category! !

!DesktopNotification methodsFor: 'accessing' stamp: 'MM 2/22/2022 15:10:45'!
category: anObject
	"Set the value of category"

	category _ anObject! !

!DesktopNotification methodsFor: 'accessing' stamp: 'MM 2/22/2022 15:10:45'!
message
	"Answer the value of message"

	^ message! !

!DesktopNotification methodsFor: 'accessing' stamp: 'MM 2/22/2022 15:10:45'!
message: anObject
	"Set the value of message"

	message _ anObject! !

!DesktopNotification methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:08:07'!
initialize: aString category: aSymbol

	message _ aString.
	category _ aSymbol.! !

!DesktopNotification methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:10:02'!
open

	(DesktopNotificationMorph on: self)
		openInWorld! !

!DesktopNotification methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:16:02'!
openWithDuration: milliseconds

	(DesktopNotificationMorph on: self)
		duration: milliseconds;
		openInWorld! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:09:06'!
error: aString
	^ self message: aString category: #error! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:16:30'!
error: aString duration: milliseconds
	^ self message: aString category: #error duration: milliseconds! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:07:19'!
info: aString
	^ self message: aString category: #info! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:16:47'!
info: aString duration: milliseconds
	^ self message: aString category: #info duration: milliseconds! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:10:14'!
message: aString category: aSymbol
	^ (self new initialize: aString category: aSymbol) open! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:17:19'!
message: aString category: aSymbol duration: milliseconds
	^ (self new initialize: aString category: aSymbol) openWithDuration: milliseconds! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:08:58'!
warn: aString
	^ self message: aString category: #warning! !

!DesktopNotification class methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:16:57'!
warn: aString duration: milliseconds
	^ self message: aString category: #warning duration: milliseconds! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:06:11'!
categoryColors

	^ `{#info -> Color lightBlue.
		#warning -> Color lightOrange .
		#error -> Color lightRed
		} asDictionary`! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 10/22/2022 21:28:35'!
defaultDuration

	^ Preferences at: #DesktopNotificationDuration! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 9/2/2024 19:51:59'!
drawOn: aCanvas

	| bounds |
	
	bounds := self localBounds insetBy: 8.
	
	aCanvas
		fillRectangle: self localBounds color: color.
	aCanvas
		drawTextComposition: textComposition
		at: bounds origin
		extent: bounds extent 
		color: Theme current text
		selectionColor: `Color red`.
	aCanvas
		frameRectangle: self localBounds
		color: borderColor
		borderWidth: borderWidth
		borderStyleSymbol: nil! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:17:55'!
duration: milliseconds
	duration _ milliseconds! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:21:40'!
extentForComposing

	^ extent x - (4 * 5) @ 9999999! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:33:55'!
findPositionInWorld

	|pos y|
	
	pos _ Display extent - self morphExtent.
	y _ Display extent y.
	
	DesktopNotificationMorph allInstancesDo: [:instance | 
		instance owner ifNotNil: [
			y _ instance morphPosition y min: y]].
	(y < Display extent y) ifTrue: [
		pos _ pos x @ (y - self morphExtent y)].
	
	self morphPosition: pos.
	
	
	
	! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 15:04:56'!
getColorForCategory: aNotificationCategory

	^ self categoryColors at: aNotificationCategory! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:13:45'!
initialize: aDesktopNotification

	desktopNotification _ aDesktopNotification.
	duration _ self defaultDuration.
	
	self borderWidth: 1.
	self contents: desktopNotification message.
	self color: (self getColorForCategory: desktopNotification category).
	self morphExtent: 200@70.
	self sticky: true.
	
	self findPositionInWorld.! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/23/2022 12:13:20'!
stepAt: millisecondSinceLast
	
	startedOpen _ startedOpen ifNil: [millisecondSinceLast ].
	beingOpen _ beingOpen ifNil: [startedOpen] ifNotNil: [beingOpen + millisecondSinceLast ].
	beingOpen >= duration  ifTrue: [self stopStepping . self delete].
	
	! !

!DesktopNotificationMorph methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 14:57:05'!
wantsSteps
	^ true! !

!DesktopNotificationMorph class methodsFor: 'as yet unclassified' stamp: 'MM 10/22/2022 21:27:43'!
initialize

	Preferences name: #DesktopNotificationDuration 
			description: 'Duration in milliseconds of a desktop notification'  
			category: #DesktopNotification 
			type: Integer 
			value: 3000! !

!DesktopNotificationMorph class methodsFor: 'as yet unclassified' stamp: 'MM 2/22/2022 14:52:50'!
on: aDesktopNotification
	^ self new initialize: aDesktopNotification! !
DesktopNotificationMorph initialize!
