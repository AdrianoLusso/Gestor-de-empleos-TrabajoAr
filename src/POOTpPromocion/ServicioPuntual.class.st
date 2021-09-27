Class {
	#name : #ServicioPuntual,
	#superclass : #DeServicio,
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
ServicioPuntual class >> crearSolicitudDe:empresa sobre: descrp por:monto producto:prod [

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarDescripcion:descrp  solicitante:empresa 
   montoTotal:monto producto:prod.
	
	^nuevo.
]

{ #category : #EvaluacionPostulante }
ServicioPuntual >> evaluarRubro: rubro tipo:tipo maximo: montoMaximo [

	"Este mensaje evalua que se cumplan las condiciones de aplicacion a la solicitud"
	
	|resultadoTemp|

	resultadoTemp := self evaluarRubro: rubro maximo: montoMaximo .
	^(resultadoTemp and: tipo  = 'P').
]

{ #category : #printing }
ServicioPuntual >> toString [ 

	|prod|

	producto 
	ifNil: [ prod := ' ,Sin producto adherido' ]
   ifNotNil: [ (prod := ' producto adherido:',producto)].

	^'Servicio puntual con numero id:',numId asString ,' id empresa solicitante:',
	empresaSolicitante getIdLaboral asString,' descripcion:',descripcion,' fecha:',fecha asString,' monto total:',
	montoTotal asString,prod.
]
