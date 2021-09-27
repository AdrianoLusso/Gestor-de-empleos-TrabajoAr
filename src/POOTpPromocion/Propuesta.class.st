Class {
	#name : #Propuesta,
	#superclass : #Object,
	#instVars : [
		'solicitud',
		'postulante'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
Propuesta class >> proponerSolicitud:solicitud postulante:postulante [

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarSolicitud: solicitud postulante: postulante .
	
	^nuevo.
]

{ #category : #Accesing }
Propuesta >> getPostulante [

	^postulante .
]

{ #category : #Accesing }
Propuesta >> getSolicitud [
	
	^solicitud .
]

{ #category : #initialization }
Propuesta >> inicializarSolicitud: sol postulante:post [ 

	solicitud := sol.
	postulante := post.
]

{ #category : #printing }
Propuesta >> toString [ 

	^'(Solicitud:',solicitud getNumId asString  ,', Postulante',postulante getIdLaboral asString ,')'.
]
