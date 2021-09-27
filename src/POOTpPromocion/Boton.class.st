Class {
	#name : #Boton,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'bloqueAccion'
	],
	#category : #'POOTpPromocion-Vista'
}

{ #category : #'as yet unclassified' }
Boton >> mouseAction: unBloque [.

	bloqueAccion := unBloque.
]

{ #category : #'event handling' }
Boton >> mouseUp: unEvento [
	super mouseUp: unEvento.
	bloqueAccion value.

]
