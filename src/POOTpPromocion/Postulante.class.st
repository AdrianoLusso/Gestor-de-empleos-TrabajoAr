Class {
	#name : #Postulante,
	#superclass : #Object,
	#instVars : [
		'idLaboral',
		'emparejado'
	],
	#classInstVars : [
		'empresasSolicitantes',
		'propuestas',
		'solicitudesPendientes',
		'solicitudesCompletas',
		'postulantes'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #comparing }
Postulante >> = otro [

	|iguales|

	iguales := false.

	self species == otro species 
	ifTrue: [ iguales := idLaboral = otro getIdLaboral].

	^iguales.
]

{ #category : #polimorficos }
Postulante >> aplicarASolicitud: solicitud [

	"Mensaje polimorfico.Se implementa en su subclases."

	self subclassResponsibility .
]

{ #category : #polimorficos }
Postulante >> esEmpresa [

	self subclassResponsibility .
]

{ #category : #polimorficos }
Postulante >> esEmpresaCombinada [ 

	self subclassResponsibility .
]

{ #category : #IsFromClass }
Postulante >> esPersona [ 

	self subclassResponsibility .
]

{ #category : #Accessing }
Postulante >> getEsEmparejado [

	^emparejado .
]

{ #category : #Accessing }
Postulante >> getIdLaboral [ 


	^idLaboral .
]

{ #category : #initialization }
Postulante >> inicializarIdLaboral:id [ 

	""
	
	idLaboral := id.
	emparejado := false.
	
]

{ #category : #Setting }
Postulante >> setEsEmparejado: valor [

	emparejado := valor.
]

{ #category : #comparing }
Postulante >> ~= otro [

	^(self = otro) not
]
