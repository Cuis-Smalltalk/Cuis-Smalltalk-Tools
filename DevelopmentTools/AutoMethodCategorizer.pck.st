'From Cuis 6.0 [latest update: #5876] on 23 June 2023 at 6:43:00 pm'!
'Description Automatic categorizer of methods of a class.

Usage:

AutoMethodCategorizer categorize: MyClass.

How it works:

It goes through methods not categorized and tries to find a category for them (methods already categorized are untouched.)

First, sees if the method is categorized up the hierarchy chain, and uses that category.
Then, tries to categorize the methods applying the first matching rule in rules instVar.
Finally, if no category could be found, looks at the caller methods and extracts the category from them.'!
!provides: 'AutoMethodCategorizer' 1 1!
SystemOrganization addCategory: 'AutoMethodCategorizer'!


!classDefinition: #AutoMethodCategorizer category: 'AutoMethodCategorizer'!
Object subclass: #AutoMethodCategorizer
	instanceVariableNames: 'rules class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AutoMethodCategorizer'!
!classDefinition: 'AutoMethodCategorizer class' category: 'AutoMethodCategorizer'!
AutoMethodCategorizer class
	instanceVariableNames: ''!


!AutoMethodCategorizer commentStamp: '<historical>' prior: 0!
Categorizes a class methods automatically.

Usage:

AutoMethodCategorizer categorize: MyClass.

How it works:

It goes through methods not categorized and tries to find a category for them (methods already categorized are untouched.)

First, sees if the method is categorized up the hierarchy chain, and uses that category.
Then, tries to categorize the methods applying the first matching rule in rules instVar.
Finally, if no category could be found, looks at the caller methods and extracts the category from them.!

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:15:15'!
categorize
	self categorizeByInheritance.
	self categorizeByRules.
	self categorizeByCalls.! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:55:02'!
categorizeByCalls
	self uncategorizedClassMethods do: [:m | |calls cm|
		calls _ self localCallsOn: m.
		cm _ calls detect: [:im | self isClassified: im] ifNone: [nil].
		cm ifNotNil: [
			self classify: m under: cm category]]! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:34:39'!
categorizeByInheritance
	self uncategorizedClassMethods do: [:m | |chain cm|
		chain _ self methodHierarchyOf: m.
		cm _ chain detect: [:im | self isClassified: im] ifNone: [nil].
		cm ifNotNil: [
			self classify: m under: cm category]]! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 19:00:32'!
categorizeByRules
	self uncategorizedClassMethods do: [:m | |rule|
		rule _ self rules detect: [:r | r key value: m] ifNone: [nil].
		rule ifNotNil: [
			self classify: m under: rule value]]! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 17:30:04'!
classMethods
	^ class organization allMethodSelectors collect: [:selector |
		MethodReference class: class selector: selector] ! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/7/2019 09:17:38'!
defaultRules
	^ OrderedCollection new
		add: [:m | m selector asString beginsWith: 'initialize'] -> #initialization;
		add: [:m | m selector asString beginsWith: 'print'] -> #printing;
		add: [:m | m selector asString beginsWith: 'draw'] -> #drawing;
		add: [:m | m selector asString beginsWith: 'is'] -> #testing;
		add: [:m | #(mouseButton1Activity. mouseButton2Activity) includes: m selector] -> #'event handling';
		yourself! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:55:13'!
localCallsOn: aMethod
	^ class allLocalCallsOn: aMethod selector! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:35:03'!
methodHierarchyOf: aMethod

	|list|
	
	list _ OrderedCollection new.
	
	class allSuperclasses reverseDo: [ :cl |
		(cl includesSelector: aMethod selector) ifTrue: [
			list addLast: (MethodReference class: cl selector: aMethod selector)]].
	
	^ list! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:08:12'!
rules
	^ rules ifNil: [rules _ self defaultRules]! !

!AutoMethodCategorizer methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 18:30:08'!
uncategorizedClassMethods
	^ self classMethods select: [:m | |cat|
		cat _ m category.
		cat isNil or: [cat = #'as yet unclassified']]! !

!AutoMethodCategorizer methodsFor: 'initialization' stamp: 'MM 11/6/2019 17:55:09'!
initialize: aClass
	class _ aClass! !

!AutoMethodCategorizer methodsFor: 'testing' stamp: 'MM 11/6/2019 18:32:01'!
isClassified: aMethod
	^ (aMethod category = nil or: [aMethod category = #'as yet unclassified']) not! !

!AutoMethodCategorizer methodsFor: 'accessing method dictionary' stamp: 'MM 11/6/2019 18:47:58'!
classify: aMethod under: aCategory
	aMethod actualClass organization classify: aMethod selector under: aCategory.
	Transcript show: 'Classified '; show: aMethod; show: ' under: '; show: aCategory; newLine.! !

!AutoMethodCategorizer class methodsFor: 'as yet unclassified' stamp: 'MM 11/6/2019 17:06:48'!
categorize: aClass
	^ (self new initialize: aClass) categorize! !
