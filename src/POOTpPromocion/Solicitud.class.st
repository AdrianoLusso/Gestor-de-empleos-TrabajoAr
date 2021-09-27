Class {
	#name : #Solicitud,
	#superclass : #Object,
	#instVars : [
		'numId',
		'fecha',
		'empresaSolicitante',
		'descripcion'
	],
	#classVars : [
		'ultimoId'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
Solicitud class >> inicializar [

	ultimoId := 999
]

{ #category : #comparing }
Solicitud >> = otro [

	|iguales|

	iguales := false.

	self species == otro species 
	ifTrue: [ iguales := numId  = otro getNumId].

	^iguales.
]

{ #category : #comparing }
Solicitud >> comparacionFechas:unaFecha [
	
	"Este metodo compara la fecha de la solicitud y la ingresada por parametro y retorna:
	-1:La fecha de la solicitud receptor es de antes.
	0:Son iguales
	1:La fecha de la solicitud receptor es de despues.
	"
	
	|comparacion|
	
	(fecha equals: unaFecha)
	ifTrue: [comparacion := 0]
	ifFalse:[(fecha isBefore: unaFecha)
					ifTrue: [comparacion := -1]
					ifFalse:[comparacion := 1]].
	
	^comparacion .
]

{ #category : #polimorficos }
Solicitud >> esDeServicio [ 

	self subclassResponsibility .
]

{ #category : #Accesing }
Solicitud >> esSolicitadaPor:id [

	""
	
	^empresaSolicitante getIdLaboral = id.
]

{ #category : #polimorficos }
Solicitud >> evaluarAptitudes: apts maximo: montoMaximo [ 

	"Mensaje polimorfico.Implementando en sus subclases."

	self subclassResponsibility .
]

{ #category : #Accesing }
Solicitud >> getEmpresaSolicitante [

	^empresaSolicitante .
]

{ #category : #Accesing }
Solicitud >> getFecha [

	^fecha .
]

{ #category : #Accesing }
Solicitud >> getNumId [ 

	^numId .
]

{ #category : #initialization }
Solicitud >> inicializarDescripcion: descrp solicitante: empresa [

	""

	descripcion := descrp .
	empresaSolicitante := empresa.
	ultimoId := ultimoId + 1.
	numId := ultimoId.
	fecha := Date today.
]
