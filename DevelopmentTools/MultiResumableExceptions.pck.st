'From Cuis7.1 [latest update: #6409] on 26 May 2024 at 11:18:01 am'!
'Description Implementation of Errors that can be resumed in multiple ways.

Inspired by Common Lisp''s restartable conditions. See: https://gigamonkeys.com/book/beyond-exception-handling-conditions-and-restarts.html'!
!provides: 'MultiResumableExceptions' 1 12!
SystemOrganization addCategory: #MultiResumableExceptions!


!classDefinition: #MultiResumableError category: #MultiResumableExceptions!
Error subclass: #MultiResumableError
	instanceVariableNames: 'cases default'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MultiResumableExceptions'!
!classDefinition: 'MultiResumableError class' category: #MultiResumableExceptions!
MultiResumableError class
	instanceVariableNames: ''!


!MultiResumableError commentStamp: '<historical>' prior: 0!
An Error that can be resumed in multiple ways.

The signaler of the exception sets up different ways of resuming the exception using #case:do: selector family of methods.

If the error is not programmatically handled, then the user is given the choice of what case to resume the error with via an interactive menu.

The error can also be also be resumed programmatically, setting up an error handler using #on:do:, and then choosing the resumable case with #resumeCase: family of methods.

A basic example of how this works, signal a MultiResumableError with some options and handlers that just print the selected resuming handler to the Transcript:

MultiResumableError new
	messageText: 'Something';
	case: #foo do: [Transcript show: 'foo'];
	case: #bar do: [Transcript show: 'bar'];
	signal.
	
See more examples on class side.!

!MultiResumableError methodsFor: 'exceptionDescription' stamp: 'MM 5/26/2024 11:15:34'!
defaultAction

	"The default action for a MultiResumableException is to ask the user how to
	resume the exception using a PopUpMenu."

	| menuOptions optionIndex caseSelected |
	
	menuOptions := cases keys, {#debug}.
	
	optionIndex := PopUpMenu withCaption: self messageText chooseFrom: menuOptions.
	
	optionIndex isZero ifTrue: [
		"Only resume if default was set"
		^ default ifNotNil: [self resume: default]
				ifNil: [self noHandler]].
	
	caseSelected := menuOptions at: optionIndex.
	
	caseSelected == #debug ifTrue: [^ self noHandler].
	
	self resumeCaseInteractively: caseSelected! !

!MultiResumableError methodsFor: 'defaults' stamp: 'MM 5/26/2024 11:16:43'!
defaultResumeValue
	
	"The resume value returned by default.
	If not explicitly set via #default:, it is nil."

	^ default! !

!MultiResumableError methodsFor: 'initialization' stamp: 'MM 6/23/2023 11:33:10'!
initialize

	super initialize.
	
	cases := Dictionary new! !

!MultiResumableError methodsFor: 'priv handling' stamp: 'MM 6/23/2023 15:22:12'!
caseHandlerAt: caseName

	| caseEntry |
	
	caseEntry := cases at: caseName ifAbsent: [self error: 'Case not valid: ', caseName asString].
	
	caseEntry isBlock ifTrue: [^caseEntry].
	^ caseEntry at: #handler! !

!MultiResumableError methodsFor: 'priv handling' stamp: 'MM 6/23/2023 17:51:33'!
caseInteractorAt: caseName

	|case |
	
	case := cases at: caseName.
	
	case isBlock ifTrue: [^nil].
	^ case at: #interactor ifAbsent: [nil]! !

!MultiResumableError methodsFor: 'priv handling' stamp: 'MM 5/26/2024 11:17:00'!
isResumable

	"Determine whether an exception is resumable."

	^ true! !

!MultiResumableError methodsFor: 'priv handling' stamp: 'MM 6/23/2023 15:34:10'!
resumeCaseInteractively: caseName

	| caseHandler interactor |
	
	interactor := self caseInteractorAt: caseName.
	
	interactor ifNil: [^self resumeCase: caseName].
	
	caseHandler := self caseHandlerAt: caseName.
	
	^ self resume: (caseHandler value: interactor value).! !

!MultiResumableError methodsFor: 'api' stamp: 'MM 6/23/2023 19:54:21'!
case: caseName do: aBlock
	
	"Add resume case handler.
	
	Arguments:
		- caseName <String|Symbol>: The name of the resume handler.
		- aBlock: The handler."
	
	cases at: caseName put: aBlock.
	
	^ self! !

!MultiResumableError methodsFor: 'api' stamp: 'MM 6/23/2023 19:54:34'!
case: caseName do: aBlock interactor: otherBlock

	"Add a resume case handler and interactor.
	
	Arguments:
		- caseName <String|Symbol>: Name of the resume case.
		- aBlock: The block for handling the resume case. Receives the result of the interactor as argument.
		- otherBlock: The interactor block. Gets the argument to use for the resume case handler from the user, interactively."
	
	cases at: caseName put: {
		#handler -> aBlock. 
		#interactor -> otherBlock
	} asDictionary.
	
	^ self! !

!MultiResumableError methodsFor: 'api' stamp: 'MM 6/23/2023 19:53:18'!
default: anObject

	"Set the default value to resume the exception with if user doesn't select one of the resume cases."
	
	default := anObject! !

!MultiResumableError methodsFor: 'api' stamp: 'MM 6/23/2023 19:54:02'!
resumeCase: caseName

	"Resume the error using the resume case handler at caseName."

	| caseHandler |
	
	caseHandler := self caseHandlerAt: caseName.
	
	^ self resume: caseHandler value! !

!MultiResumableError methodsFor: 'api' stamp: 'MM 6/23/2023 19:55:13'!
resumeCase: caseName with: argument

	"Resume the error using the resume case handler at caseName, passing argument."

	| caseHandler |
	
	caseHandler := self caseHandlerAt: caseName.
	
	^ self resume: (caseHandler value: argument)! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/23/2023 20:53:13'!
example1

	"The most basic example of MultiResumableErrors.
	Just setup two different resume cases that write something to the Transcript.
	When signaled, the user is asked one of the cases to resume the error execution."
	
	"self example1"
	
	MultiResumableError new
		messageText: 'Something';
		case: #foo do: [Transcript show: 'foo'];
		case: #bar do: [Transcript show: 'bar'];
		signal! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/23/2023 23:21:31'!
example2

	"In this example, a MultiResumableError is signaled for when a file does not exist.
	 Two resume cases, one that creates an empty file, and another for creating a file with some text."

	"self example2"

	| fileName fileEntry |
	
	fileName := 'something.log'.
	fileEntry := fileName asFileEntry.
	
	fileEntry exists 
		ifFalse: [
			MultiResumableError new "Should use a subclass of MultiResumableError instead."
				messageText: 'File does not exist';
				case: 'create empty file' do: [
					Transcript show: 'Creating file'. 
					fileEntry forceWriteStream];
				case: 'create with text' do: [|text|
					text := FillInTheBlankMorph request: 'Text for the file:'.
					text ifNotNil: [fileEntry textContents: text]];
				signal].
	
	fileEntry textContents edit! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/24/2023 12:47:23'!
example3

	"In this example, a MultiResumableError is signaled for when a file does not exist.
	A resume case for using other file name if the file is not found."
	
	"self example3"
	
	| fileName fileEntry |
	
	fileName := 'something.log'.
	fileEntry := fileName asFileEntry.
	
	[fileEntry exists] 
		whileFalse: [
			MultiResumableError new "Should use a subclass of MultiResumableError instead."
				messageText: 'File does not exist';
				case: 'retry' do: [];
				case: 'use other file name' do: [ |newFileName|
					newFileName := FillInTheBlankMorph request: 'Filename:' initialAnswer: fileName.
					newFileName ifNotNil: [fileName := newFileName. fileEntry := fileName asFileEntry]];
				signal].
	
	fileEntry textContents edit! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/24/2023 13:14:14'!
example4

	"Example of MultiResumableErrors for long running tasks.
	In this example we simulate long running tasks, and their success or failure.
	MultiResumableErrors can be specially useful for long running tasks as they can prevent
	having to start over again when one of the tasks fail.
	This example attaches two cases to the task failing exception, one for retrying the task, and another for skipping it.	"
	
	"self example4"
	
	| successful failed retried runTask skipAll |
	
	skipAll := false.
	successful := OrderedCollection new.
	retried := Set new.
	failed := OrderedCollection new.
	runTask := [:i |
		Transcript log: 'Task ', i asString, ': running ....'.
		"Simulate some work"
		(Delay forMilliseconds: 300 atRandom) wait.
		
		"Simulate success or not."
		{true. false} atRandom].	
	
	1 to: 15 do: [:i | | success skip |
		skip := false.		
		success := runTask value: i.
		
		(success not and: [skipAll]) ifTrue: [failed add: i. skip := true].
			
		[success not and: [skip not]] whileTrue: [
			MultiResumableError new "Should use a proper subclass of MultiResumableError instead."
				messageText: ('Task failed: task', i asString);
				case: 'retry' do: [
					Transcript log: 'Task ', i asString, ': retrying...'.
					retried add: i.
					success := runTask value: i];
				case: 'skip' do: [
					Transcript log: 'Task ', i asString, ': failed and skipped.'.
					failed add: i. "Add to the list of failed tasks."
					skip := true "Skip the retry loop"		];
				case: 'skip all' do: [
					Transcript log: 'Skipping all...'.
					skipAll := true.
					failed add: i.
					skip := true];
				signal].
			success ifTrue: [
				"Add to the list of successful"
				Transcript log: 'Task', i asString, ': success.'.
				successful add: i]].
	
	{'successful' -> successful.
	'failed' -> failed.
	'retried' -> retried} asDictionary explore! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/23/2023 23:32:47'!
example5

	"Retry with interactor example."
	
	"self example5"
	
	| fileName fileEntry |
	
	fileName := 'something.log'.
	fileEntry := fileName asFileEntry.
	
	[fileEntry exists] 
		whileFalse: [
			MultiResumableError new "Should use a subclass of MultiResumableError instead."
				messageText: 'File does not exist';
				case: 'retry' do: [];
				case: 'use other file name' do: [:newFileName | 					
					newFileName ifNotNil: [fileName := newFileName. fileEntry := fileName asFileEntry]]
				interactor: [FillInTheBlankMorph request: 'Text for the file:' initialAnswer: fileName];
				signal].
	
	fileEntry textContents edit! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/23/2023 21:13:52'!
example6

	"Example of choosing the exception case to resume with, non interactively.
	The exception handler selects the resume case using #resumeCase:"
	
	"self example6"
	
	"Skip all failed tasks"
	[self example4]
		on: MultiResumableError
		do: [:error | error resumeCase: 'skip']! !

!MultiResumableError class methodsFor: 'examples' stamp: 'MM 6/24/2023 10:07:42'!
example7

	"Example of choosing the exception case to resume with, non interactively.
	 The exception handler selects the resume case using #resumeCase:with:, passing an argument."
	
	"self example7"
	
	[self example5]
		on: MultiResumableError
		do: [:error | error resumeCase: 'use other file name' 
					with: (DirectoryEntry smalltalkImageDirectory  // 'README.md') asString]! !
