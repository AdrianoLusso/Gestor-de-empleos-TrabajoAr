Class {
	#name : #GestorEmpleados,
	#superclass : #Object,
	#classVars : [
		'empresasSolicitantes',
		'postulantes',
		'propuestas\r\t',
		'solicitudesCompletas',
		'solicitudesPendientes'
	],
	#classInstVars : [
		'propuestas'
	],
	#category : #'POOTpPromocion-Modelo'
}

{ #category : #Propuestas }
GestorEmpleados class >> aceptarPropuesta:propuesta [
	
	"Este mensaje acepta la propuesta ingresada por parametro."
	
	|solicitud postulante col|

	solicitud := propuesta getSolicitud .
	postulante := propuesta getPostulante .
	col := (propuestas select:[:x | x getSolicitud = solicitud and: x getPostulante ~= postulante]).

	self reubicarPostulantes: col.
	
	self eliminarPropuesta: propuesta solicitud: solicitud postulante: postulante.
	
	self changed.
]

{ #category : #Postulantes }
GestorEmpleados class >> agregarProducto:producto aEmpresa:id [ 

	"Este mensaje agregar producto a la empresa combinada con id ingresado por 
	parametro, si es que existe.Retorna boolean dependiendo de si se logro
	agregar el producto."

	|empresaCombinada resultado|
	
	resultado := false.
	
	empresaCombinada := postulantes detect: [ :x | x esEmpresaCombinada and:
		x getIdLaboral = id] ifNone:[nil].
	
	empresaCombinada 
	ifNil: [ empresaCombinada := empresasSolicitantes  detect: [ :x | x esEmpresaCombinada and:
		x getIdLaboral = id] ifNone:[nil]. ].
	
	empresaCombinada 
	ifNotNil: [resultado := empresaCombinada agregarProducto: producto.
		self changed: producto]
	ifNil:[self changed:nil].
		
	^resultado.

]

{ #category : #'Propuestas-private' }
GestorEmpleados class >> buscarPostulantes:solicitud [ 
	
	"Este mensaje busca los postulantes aptos para aplicar a la solicitud de parametro."
	
	|aux|
	
	aux :=postulantes reject:[:x | x getEsEmparejado].
	"aux do:[:x | Transcript show:x getIdLaboral,String cr]."

	aux do: [ :x | (x aplicarASolicitud: solicitud)
				ifTrue:[self registrarPropuestaConSolicitud: solicitud  postulante:x]].
]

{ #category : #Postulantes }
GestorEmpleados class >> completarInfoEmpresaPostulante:id rubro: rubro rango: rango  tipo: tipo [

	"Este mensaje completa la info de empresa postulante de id ingresado por parametro,en caso
	de que exista tal empresa."

	|empresa|
	
	empresa := postulantes detect: [ :x | x getIdLaboral = id and: x esPersona = false]
	ifNone:[nil].
	
	empresa
	ifNotNil: [ empresa setRubro: rubro rango: rango  tipo: tipo.
					self changed: empresa].

]

{ #category : #Solicitantes }
GestorEmpleados class >> completarInfoEmpresaSolicitante:id rubro: rubro rango: rango  tipo: tipo [

	"Este mensaje completa la info de empresa postulante de id ingresado por parametro,en caso
	de que exista tal empresa."

	|empresa|
	
	empresa := empresasSolicitantes detect: [ :x | x getIdLaboral = id and: x esPersona = false].
	
	empresa
	ifNotNil: [.empresa setRubro: rubro rango: rango  tipo: tipo.
					self changed: empresa].

]

{ #category : #'PostulantesSolicitantes-private' }
GestorEmpleados class >> controlIdExclusivoDeEmpresa:id enCol:col [

	"Este mensaje retorna un boolean dependiendo de si existe un elemento
	en col que tenga el id ingresado por parametro,y NO sea empresa.
	Por disenio interno,col esta pensando para recibir colecciones de objetos Postulante."
	
	|postulante|
	
	postulante := col
		detect: [ :x | x getIdLaboral = id and: (x esEmpresa) not]
		ifNone: [ nil ].
	
	^postulante isNil.
	 
]

{ #category : #'PostulantesSolicitantes-private' }
GestorEmpleados class >> controlIdExclusivoDeEmpresaCombinada:id enCol:col [

	"Este mensaje retorna un boolean dependiendo de si existe un elemento
	en col que tenga el id ingresado por parametro,y NO sea empresa combinada.
	Por disenio interno,col esta pensando para recibir colecciones de objetos Postulante."
	
	|postulante|
	
	postulante := col
		detect: [ :x | x getIdLaboral = id and: (x esEmpresaCombinada) not]
		ifNone: [ nil ].
	
	^postulante isNil.
]

{ #category : #'Propuestas-private' }
GestorEmpleados class >> eliminarPropuesta:propuesta solicitud:sol postulante:post [

	"Este mensaje elimina la propuesta del sistema,y realiza las modificaciones necesarias."	
		
	solicitudesPendientes remove: sol .
	
	solicitudesCompletas add: sol .
	
	postulantes remove:post.
	
	propuestas remove: propuesta .
]

{ #category : #'PostulantesSolicitantes-private' }
GestorEmpleados class >> empresa: id  colGenerica: col otraColGenerica:otraCol [
	
	"Este mensaje registra una empresa.Este mensaje NO inicializa los atributos no claves
	de la instancia creada.Retorna:
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."


	|empresa retorno|
	
	empresa := col
		detect: [ :x | x getIdLaboral = id]
		ifNone: [ nil ].

	empresa
		ifNil: [ empresa := Empresa crearPostulante: id.retorno := 1]
		ifNotNil: [ retorno := 0].
	
	otraCol add: empresa.
	
	retorno = 0
		ifTrue: [ self changed: empresa].	
	
	^ retorno.
]

{ #category : #'PostulantesSolicitantes-private' }
GestorEmpleados class >> empresaCombinada: id  colGenerica: col otraColGenenerica:otraCol [
	
	"Este mensaje registra una empresa combinada.Este mensaje NO inicializa los atributos no claves
	de la instancia creada.Retorna:
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."

	|empresa retorno|
	
	empresa:= col
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
	empresa
		ifNil: [empresa := EmpresaCombinada crearPostulante: id. retorno := 1]
		ifNotNil: [retorno := 0].
		
	otraCol add: empresa .
		
	retorno = 0
		ifTrue: [ self changed: empresa].	
			
	 ^ retorno.
]

{ #category : #Propuestas }
GestorEmpleados class >> generarPropuestas [

	"Este mensaje genera propuestas para todas las solicitudes pendientes."
	
	solicitudesPendientes do: 
		[ :x |self buscarPostulantes: x].
		
	self changed.
]

{ #category : #Accesing }
GestorEmpleados class >> getEmpresasSolicitantes [

	^empresasSolicitantes .
]

{ #category : #Accesing }
GestorEmpleados class >> getPostulantes [

	^postulantes .
]

{ #category : #Accesing }
GestorEmpleados class >> getPropuestas [

	^propuestas . 
]

{ #category : #Accesing }
GestorEmpleados class >> getSolicitudes [

	^solicitudesPendientes 
	
]

{ #category : #Accesing }
GestorEmpleados class >> getSolicitudesComp [

	^solicitudesCompletas .
]

{ #category : #Accesing }
GestorEmpleados class >> getSolicitudesPend [

	^solicitudesPendientes 
]

{ #category : #initialize }
GestorEmpleados class >> inicializar [

	"Este mensaje inicializa las colecciones del gestor."

	empresasSolicitantes := OrderedCollection new.
	propuestas := OrderedCollection new.
	solicitudesPendientes := OrderedCollection new.
	solicitudesCompletas := OrderedCollection new.
	postulantes := OrderedCollection new.
	
	"Inicializo las clases que se usaran en el dominio del problema."
	Persona inicializar: 10000.
	Empresa inicializar: 100000.
	Solicitud inicializar.
	 
]

{ #category : #'PostulantesSolicitantes-private' }
GestorEmpleados class >> persona:id aptitudes:apts [

	"Este mensaje crea una persona"

	|persona|
	
	persona := Persona crearPostulante: id aptitudes: apts.
	
	postulantes add: persona.
	
	^persona.
]

{ #category : #Postulantes }
GestorEmpleados class >> registrarEmpresa:id [

	"Este mensaje registra una empresa,en caso de ser posible.Este
	 mensaje NO inicializa los atributos no claves de la instancia creada.Retorna:
	-1:No pudo crearse la instancia
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."
	
	| empresa retorno |
	
	empresa := postulantes
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
	(empresa isNil  and:
   (self controlIdExclusivoDeEmpresa: id enCol: empresasSolicitantes)) 
		ifTrue: [retorno :=  self empresa: id colGenerica: empresasSolicitantes 
				   otraColGenerica: postulantes]
		ifFalse: [self changed:nil.retorno := -1].

	^ retorno.
]

{ #category : #Postulantes }
GestorEmpleados class >> registrarEmpresaCombinada:id [ 

	"Este mensaje registra una empresa combinada,en caso de ser posible.Este
	 mensaje NO inicializa los atributos no claves de la instancia creada.Retorna:
	-1:No pudo crearse la instancia
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."	
	
	| empresa retorno|
	
	empresa := postulantes
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
   (empresa isNil and: 
   (self controlIdExclusivoDeEmpresaCombinada: id enCol: empresasSolicitantes )) 
		ifTrue: [retorno := self empresaCombinada: id colGenerica: empresasSolicitantes  
			 	  otraColGenenerica: postulantes ]
		ifFalse: [ self changed:nil.retorno := -1].
			
				
	^ retorno.
]

{ #category : #Solicitantes }
GestorEmpleados class >> registrarEmpresaCombinadaSolicitante:id [

	"Este mensaje registra una empresa combinada solicitante,en caso de ser posible.Este
	 mensaje NO inicializa los atributos no claves de la instancia creada.Retorna:
	-1:No pudo crearse la instancia
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."

	| empresa retorno |
	
	empresa := empresasSolicitantes 
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
	(empresa isNil and: 
	(self controlIdExclusivoDeEmpresaCombinada: id enCol: postulantes ))
		ifTrue:[retorno := self empresaCombinada: id colGenerica: postulantes
				 otraColGenenerica: empresasSolicitantes]
		ifFalse: [ self changed: nil.retorno := -1 ].

	^ retorno.
]

{ #category : #Solicitantes }
GestorEmpleados class >> registrarEmpresaSolicitante:id [

	"Este mensaje registra una empresa solicitante,en caso de ser posible.Este
	 mensaje NO inicializa los atributos no claves de la instancia creada.Retorna:
	-1:No pudo crearse la instancia
	0:La instancia ya existia en otra coleccion.No fue necesario crearlo.
	1:La instancia no existia.Fue creada."

		| empresa retorno |
	
	empresa := empresasSolicitantes 
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
	(empresa isNil and: 
	(self controlIdExclusivoDeEmpresa: id enCol: postulantes))
		ifTrue: [retorno := self empresa: id colGenerica: postulantes
				  otraColGenerica: empresasSolicitantes]
		ifFalse: [ self changed: nil.retorno := -1].
	
	^ retorno.
]

{ #category : #Postulantes }
GestorEmpleados class >> registrarPersona: id aptitudes: apts [

	"Este mensaje registra a una persona,en caso de ser posible."

	| persona |
	
	persona := postulantes
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
		
   persona 
		ifNil: [persona:=  self persona: id aptitudes: apts]
		ifNotNil: [persona := nil].
	
	self changed: persona.	

	^persona.
]

{ #category : #'Propuestas-private' }
GestorEmpleados class >> registrarPropuestaConSolicitud:solicitud postulante:postulante [

	"Este mensaje se encarga de la creacion de la propuesta,y de la actualizacion necesaria
	en colecciones y atributos"

	|propuesta|

	propuesta :=Propuesta proponerSolicitud: solicitud
	postulante: postulante.
	propuestas add: propuesta.
	postulante setEsEmparejado: true
	

]

{ #category : #Solicitudes }
GestorEmpleados class >> registrarSolicitudDeTrabajo: id sobre: descrp [

	"Este mensaje registra una solicitud de trabajo,y se retorna el objeto creado.En caso de no 
	existir una empresa solicitante con id,falla el registro y se retorna nil."

	| empresaSolicitante solicitud |
	
	empresaSolicitante := empresasSolicitantes
		detect: [ :x | x getIdLaboral = id ]
		ifNone: [ nil ].
	
	empresaSolicitante isNotNil
		ifTrue: [solicitud := self solicitudDe: empresaSolicitante sobre: descrp ]
		ifFalse: [solicitud := nil.self changed:solicitud].
		
	^ solicitud
]

{ #category : #Solicitudes }
GestorEmpleados class >> registrarSolicitudServicioProlongado: id  sobre: descrp  por: monto tipoPago: 
tipo duracion: durc producto: prod [ 
	
	"Este mensaje registra una solicitud de servicio prolongado,y se retorna el
	 objeto creado.En caso de no existir una empresa solicitante con id,falla el
	 registro y se retorna nil.El campo producto es nil si no hay producto asociado
	 al servicio."
	
	| empresaSolicitante solicitud |
	
	empresaSolicitante := empresasSolicitantes
		detect: [ :x | x getIdLaboral = id ]ifNone:[nil].
		
	empresaSolicitante isNotNil
		ifTrue: [solicitud := self solicitudDe: empresaSolicitante  sobre: descrp
			 por: monto tipoPago: tipo duracion: durc producto: prod  ]
		ifFalse: [solicitud := nil. self changed:nil].
	
	^ solicitud
]

{ #category : #Solicitudes }
GestorEmpleados class >> registrarSolicitudServicioPuntual: id  sobre: descrp  por: monto 
producto: prod [ 
	
	"Este mensaje registra una solicitud de servicio puntual,y se retorna el
	 objeto creado.En caso de no existir una empresa solicitante con id,falla el
	 registro y se retorna nil.El campo producto es nil si no hay producto asociado
	 al servicio."
	
	| empresaSolicitante solicitud |
	
	empresaSolicitante := empresasSolicitantes
		detect: [ :x | x getIdLaboral = id ]ifNone:[nil].
		
	empresaSolicitante isNotNil
		ifTrue: [solicitud :=  self solicitudDe: empresaSolicitante  sobre: descrp
			 por: monto producto: prod  ]
		ifFalse: [solicitud := nil. self changed:nil].
		
	^ solicitud
]

{ #category : #'Propuestas-private' }
GestorEmpleados class >> reubicarPostulantes: props [

	"Este metodo reubica a las propuestas de la coleccion,y sus postulantes."

	props do:[:x |x getPostulante setEsEmparejado: false.propuestas remove:x].

	
]

{ #category : #'Solicitudes-private' }
GestorEmpleados class >> solicitudDe: empresa sobre: descrp [ 

	"Proceso interno de creacion y enlistamiento de solicitud de trabajo."
	|solicitud|
	
	solicitud := DeTrabajo crearSolicitudDe: empresa sobre: descrp.

	solicitudesPendientes add: solicitud.
	self changed:solicitud.
	
	^solicitud.
]

{ #category : #'Solicitudes-private' }
GestorEmpleados class >> solicitudDe: empresa sobre: descrp por:monto producto:prod [

	"Proceso interno de creacion y enlistamiento de solicitud de servicio
	puntual."
	|solicitud|
	
	solicitud := ServicioPuntual crearSolicitudDe: empresa sobre: descrp
	por: monto producto: prod.
	
	solicitudesPendientes add: solicitud.
	self changed:solicitud.
	
	^solicitud.
	
]

{ #category : #'Solicitudes-private' }
GestorEmpleados class >> solicitudDe: empresa sobre: descrp por: monto tipoPago: tipo
 duracion: durc producto: prod [ 

	"Proceso interno de creacion y enlistamiento de solicitud de servicio
	prolongado."
	
	|solicitud|
	
	solicitud := ServicioProlongado crearSolicitudDe: empresa sobre: descrp
   por: monto tipoPago:tipo  duracion: durc producto: prod.

	solicitudesPendientes add: solicitud.
	self changed:solicitud.
	
	^solicitud.
]

{ #category : #Listas }
GestorEmpleados class >> solicitudesAtendidas [

	"Este mensaje genera una lista con las solicitudes ya atendidas."
	
	^solicitudesCompletas .
]

{ #category : #Listas }
GestorEmpleados class >> solicitudesPendienteConFecha:fecha [

	"Este mensaje genera una lista de solicitudes pendientes generadas en la fehca
	ingresa por parametro."
	
	^solicitudesPendientes select: [ :x | (x comparacionFechas: fecha) = 0 ].
]

{ #category : #Listas }
GestorEmpleados class >> solicitudesPendientesPor:id [ 

	"Este mensaje genera una lista de solicitudes pendientes generadas por la empresa de
	id ingresado pro parametro."
	
	^solicitudesPendientes select: [ :x | x esSolicitadaPor: id].
	
]
