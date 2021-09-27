Class {
	#name : #Persona,
	#superclass : #Postulante,
	#instVars : [
		'aptitudes'
	],
	#classVars : [
		'maximoIndividual'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
Persona class >> crearPostulante:id aptitudes: apts [

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarIdLaboral: id aptitudes: apts.
	
	^nuevo. 
]

{ #category : #'as yet unclassified' }
Persona class >> inicializar:max [

	maximoIndividual := max.
]

{ #category : #AplicacionSolicitud }
Persona >> aplicarASolicitud: solicitud [

	"Este mensaje evalua si el receptor puede aplicar para la solicitud"

	^solicitud evaluarAptitudes: aptitudes  maximo: maximoIndividual . 
]

{ #category : #IsFromClass }
Persona >> esEmpresa [ 

	^false.
]

{ #category : #IsFromClass }
Persona >> esEmpresaCombinada [ 

	^false.
]

{ #category : #'as yet unclassified' }
Persona >> esPersona [

	^true
]

{ #category : #initialization }
Persona >> inicializarIdLaboral: id aptitudes: apts [

	""

	self inicializarIdLaboral: id.
	
	aptitudes := apts.
]

{ #category : #printing }
Persona >> toString [ 

	^'persona de id laboral: ',idLaboral asString,' aptitudes: ',aptitudes  .
]
