Class {
	#name : #Pantalla,
	#superclass : #BorderedMorph,
	#instVars : [
		'cerrar',
		'listaS'
	],
	#category : #'POOTpPromocion-Vista'
}

{ #category : #'as yet unclassified' }
Pantalla >> agregarElemento:unElem [

	listaS appendText: unElem,String cr.
]

{ #category : #initialization }
Pantalla >> initialize [ 

	|origen|

	super initialize.
	
	self color: Color white;position: (100@100);bounds:(self position extent: 1500@200).
	origen := self innerBounds origin.
	
	listaS := RubScrolledTextMorph new.
	listaS position:origen + (0@30);bounds: (listaS position extent: 1498@170) .
	
	cerrar := Boton new.
	cerrar position: origen;label: 'X' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize: 13).
	
	self addMorph:listaS.
	self addMorph:cerrar.
	
	cerrar mouseAction: [ self delete]
	
]
