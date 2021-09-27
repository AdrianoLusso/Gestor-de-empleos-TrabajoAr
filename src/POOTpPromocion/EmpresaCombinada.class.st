Class {
	#name : #EmpresaCombinada,
	#superclass : #Empresa,
	#instVars : [
		'productos'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #'as yet unclassified' }
EmpresaCombinada class >> crearPostulante: id [

	""

	|nuevo|
	
	nuevo := self new.
	
	nuevo inicializarIdLaboral: id.
	
	^nuevo. 
]

{ #category : #Setting }
EmpresaCombinada >> agregarProducto:producto [

	"Este mensaje agrega el producto a la coleccion de productos"
	
	productos add: producto.
	
	^true.
]

{ #category : #AplicacionSolicitud }
EmpresaCombinada >> aplicarASolicitud: solicitud [
	
	"Este mensaje evalua si el receptor puede aplicar para la solicitud"
	
	|resultado|	

   (resultado:= self evaluacionGeneral: solicitud)
	ifTrue: [ resultado := (productos includes: solicitud getProducto)].
	
	^resultado.
]

{ #category : #IsFromClass }
EmpresaCombinada >> esEmpresa [ 

	^false.
]

{ #category : #IsFromClass }
EmpresaCombinada >> esEmpresaCombinada [ 

	^true.
]

{ #category : #initialization }
EmpresaCombinada >> inicializarIdLaboral: id [

	"Los atributos rubro,rango,tipo se inicializan con valores por defecto.Es necesario
	setearlos posterior a la creacion e inicializacion de la instancia."

	super inicializarIdLaboral: id.
	
	productos := OrderedCollection new. 
]

{ #category : #printing }
EmpresaCombinada >> toString [ 


	|res ti |
	
	ti := tipo = 'U'
		      ifTrue: [ 'Uniforme' ]
		      ifFalse: [ 'Puntual' ].
	
	 res:= 'Empresa combinada de id laboral: ' , idLaboral asString, ' rubro: ' , rubro
	  , ' rango: ' , rango asString, ' tipo: ' , ti,' productos:' .
	
	productos do: [ :x | res := res,'-',x ].
	
	^res.
]
