Class {
	#name : #DeServicio,
	#superclass : #Solicitud,
	#instVars : [
		'montoTotal',
		'producto'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #IsFromClass }
DeServicio >> esDeServicio [ 

	^true.
]

{ #category : #EvaluacionPostulante }
DeServicio >> evaluarAptitudes: apts maximo: montoMaximo [

	"Este mensaje evalua que se cumplan las condiciones de aplicacion a la solicitud"

	^apts = descripcion and: (montoTotal <= montoMaximo and: producto isNil).
]

{ #category : #EvaluacionPostulante }
DeServicio >> evaluarRubro:rubro maximo:montoMaximo [

	"Este mensaje evalua que se cumplan las condiciones de aplicacion a la solicitud"
	
	^(rubro = descripcion) and: (montoMaximo >= montoTotal ).
]

{ #category : #initialization }
DeServicio >> evaluarRubro: rubro tipo: tipo  maximo: maximo [

	"Mensaje polimorfico.Implementando en sus subclases."

	self subclassResponsibility . 
]

{ #category : #Accesing }
DeServicio >> getProducto [

	^producto
]

{ #category : #initialization }
DeServicio >> inicializarDescripcion: descrp solicitante: empresa montoTotal: monto producto: prod [ 

	self inicializarDescripcion: descrp solicitante: empresa.
	
	montoTotal :=monto.
	producto :=prod. 

]
