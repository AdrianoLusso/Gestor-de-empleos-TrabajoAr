Class {
	#name : #DeTrabajo,
	#superclass : #Solicitud,
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
DeTrabajo class >> crearSolicitudDe: empresa  sobre:descrp [

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarDescripcion: descrp solicitante: empresa.
	
	^nuevo.
]

{ #category : #IsFromClass }
DeTrabajo >> esDeServicio [ 

	^false.
]

{ #category : #EvaluacionPostulante }
DeTrabajo >> evaluarAptitudes:apts maximo: montoMaximo [

	"Este mensaje compara las aptitudes con la descripcion"

	^apts = descripcion .
]

{ #category : #printing }
DeTrabajo >> toString [

	^'Trabajo con numero id:', numId asString ,' id empresa solicitante:',
	empresaSolicitante getIdLaboral asString,' descripcion:',descripcion,' fecha:',fecha asString.
]
