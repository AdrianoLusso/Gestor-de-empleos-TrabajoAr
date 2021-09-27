Class {
	#name : #Empresa,
	#superclass : #Postulante,
	#instVars : [
		'rubro',
		'rango',
		'tipo'
	],
	#classVars : [
		'maximo'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
Empresa class >> crearPostulante:id [

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarIdLaboral: id.
	
	^nuevo. 
]

{ #category : #'as yet unclassified' }
Empresa class >> inicializar:max [

	maximo := max.
]

{ #category : #AplicacionSolicitud }
Empresa >> aplicarASolicitud: solicitud [ 

	"Este mensaje evalua si el receptor puede aplicar para la solicitud"
	|resultado|	

   (resultado := self evaluacionGeneral: solicitud)
	ifTrue: [ resultado := ( solicitud getProducto isNil) ].

	^resultado.
]

{ #category : #AplicacionSolicitud }
Empresa >> controlPrevio: solicitud [

	"Este mensaje realiza un control previo,donde se incluye el control antifraudes"
	
	^ (solicitud esDeServicio and: solicitud getEmpresaSolicitante ~= self).
]

{ #category : #IsFromClass }
Empresa >> esEmpresa [

	^true.
]

{ #category : #IsFromClass }
Empresa >> esEmpresaCombinada [ 

	^false.
]

{ #category : #'as yet unclassified' }
Empresa >> esPersona [ 
	
	^false
]

{ #category : #AplicacionSolicitud }
Empresa >> evaluacionGeneral:solicitud [ 

	"Este mensaje se encarga de la evaluacion general para aplicar a la solicitud"
	
	|resultado|
	
	resultado := false.

	(self controlPrevio: solicitud)
	ifTrue: [resultado := solicitud evaluarRubro: rubro 
	tipo: tipo  maximo: (rango * maximo)].

	
	^resultado.
]

{ #category : #initialization }
Empresa >> inicializarIdLaboral:id [

	"Los atributos rubro,rango,tipo se inicializan con valores por defecto.Es necesario
	setearlos posterior a la creacion e inicializacion de la instancia."

	super inicializarIdLaboral: id.
	
	rubro := 'no ingresado'.
	rango := 0.
	tipo := 'P'.
]

{ #category : #initialization }
Empresa >> setRubro: rubr rango:rang tipo:tip [

	rubro := rubr.
	rango := rang.
	tipo := tip.
	
	
]

{ #category : #printing }
Empresa >> toString [

	| ti |
	
	ti := tipo = 'U'
		      ifTrue: [ 'Uniforme' ]
		      ifFalse: [ 'Puntual' ].

	^ 'Empresa de id laboral: ' , idLaboral asString  , ' rubro: ' , rubro
	  , ' rango: ' , rango asString, ' tipo: ' , ti.
]
