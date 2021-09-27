Class {
	#name : #ServicioProlongado,
	#superclass : #DeServicio,
	#instVars : [
		'duracion',
		'tipoPago'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
ServicioProlongado class >> crearSolicitudDe: empresa sobre: descrp por: monto tipoPago:tipo
 duracion:durc producto: prod [ 

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarDescripcion: descrp solicitante: empresa  montoTotal: monto 
	 tipoPago: tipo  duracion: durc  producto: prod.
	
	^nuevo. 
]

{ #category : #EvaluacionPostulante }
ServicioProlongado >> evaluarRubro: rubro tipo:tipo maximo: montoMaximo [

	"Este mensaje evalua que se cumplan las condiciones de aplicacion a la solicitud"
	
	|resultadoTemp|
	
	resultadoTemp := self evaluarRubro: rubro maximo: montoMaximo .
	
	^(resultadoTemp and: (tipo  = 'U')).
]

{ #category : #initialization }
ServicioProlongado >> inicializarDescripcion: descrp solicitante: empresa montoTotal: monto tipoPago: tipo
 duracion:durc producto: prod [

	self inicializarDescripcion: descrp  solicitante: empresa   montoTotal: monto
	   producto: prod.
	
	duracion :=durc.
	tipoPago := tipo.
	 
]

{ #category : #printing }
ServicioProlongado >> toString [ 

	|prod|
	
	producto 
	ifNil: [ prod := ' ,Sin producto adherido' ]
   ifNotNil: [ prod := (' producto adherido:',producto)  ].

	^'Servicio prolongado con numero id:',numId asString ,' id empresa solicitante:',
	empresaSolicitante getIdLaboral asString,' descripcion:',descripcion,' fecha: ',fecha asString, ' monto total:',
	montoTotal asString,prod,' Duracion(meses):',duracion asString,' tipo de pago:',tipoPago.
]
