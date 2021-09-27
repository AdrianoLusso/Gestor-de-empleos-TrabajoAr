Class {
	#name : #PantallaPrincipal,
	#superclass : #BorderedMorph,
	#instVars : [
		'botonRP',
		'botonRS',
		'botonRES',
		'botonGP',
		'botonAP',
		'botonGL',
		'botonProd',
		'cerrar',
		'minimizar',
		'titulo',
		'listaP',
		'listaS',
		'listaES',
		'error'
	],
	#category : #'POOTpPromocion-Vista'
}

{ #category : #Propuestas }
PantallaPrincipal >> aceptarPropuesta [

	"Este mensaje gestiona graficamente la aceptacion de propuestas"

	|propuestaAceptada|
	
	propuestaAceptada := UIManager default
   chooseFrom: (GestorEmpleados getPropuestas collect: [ :x | x toString ])
   values:GestorEmpleados getPropuestas title: 'Elige la propuesta a aceptar:'.

	GestorEmpleados aceptarPropuesta: propuestaAceptada .
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> agregarProducto [

	"Este mensaje gestiona graficamente el registro de productos a una empresa combinada"

	|id prod|
	
	id := UIManager default request: 'Ingrese el id de la empresa combinada,cuyo producto desee agregar:'.
	prod := UIManager default request: 'Ingrese el producto de la empresa combinada:'.
	
	GestorEmpleados agregarProducto: prod aEmpresa: id asInteger. 
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> completarAtributosEmpresa:id num: num [

	"Este mensaje gestiona graficamente el registro de atributos de empresas"

	|rubro rango tipo|

	rubro := UIManager default request: 'Ingrese el rubro de la empresa:'.
	rango := UIManager default request: 'Ingrese el rango de la empresa:'.
	tipo := UIManager default
		        chooseFrom: #( 'Puntual' 'Uniforme' )
		        values: #( 'P' 'U' )
		        title: 'Elija el tipo de empresa'.
		
	num = 1
	ifTrue: [GestorEmpleados completarInfoEmpresaPostulante: id asInteger rubro: rubro  rango: rango asInteger asInteger tipo: tipo.] 
	ifFalse: 	[ GestorEmpleados completarInfoEmpresaSolicitante: id asInteger rubro: rubro rango: rango asInteger tipo: tipo ].
]

{ #category : #Listados }
PantallaPrincipal >> generarListadoDos:aux [

	"Este mensaje gestiona graficamente la generacion de listado de
	 solicitudes pendientes registradas en una fecha dada."

	|dia mes anio|
	
	dia:= (UIManager default request: 'Ingrese el numero del dia:')asInteger .
	mes:= (UIManager default request: 'Ingrese el numero del mes:') asInteger .
	anio:= (UIManager default request: 'Ingrese el numero del anio:') asInteger .
	
	aux openInWorld .
	
	(GestorEmpleados solicitudesPendienteConFecha: (Date year: anio month: mes  day: dia) )
	 do:[:x |aux agregarElemento: x toString ]
]

{ #category : #Listados }
PantallaPrincipal >> generarListadoTres:aux [
	
	"Este mensaje gestiona graficamente la generacion de listado de solicitudes que han sido atendidas, 
	con toda la información correspondiente"
	
	aux openInWorld .
	
	(GestorEmpleados solicitudesAtendidas ) do: [ :x | aux agregarElemento: x toString]
]

{ #category : #Listados }
PantallaPrincipal >> generarListadoUno:aux [

	"Este mensaje gestiona graficamente la generacion de listado de
	 solicitudes pendientes realizadas por una Empresa."

	|empresa|
	
	empresa := UIManager default chooseFrom: (GestorEmpleados getEmpresasSolicitantes collect:[:x | x toString ])
	 values: GestorEmpleados getEmpresasSolicitantes   title: 'Seleccione la empresa solicitante para armar la lista:'.
	
	aux openInWorld.
	
	(GestorEmpleados solicitudesPendientesPor: empresa getIdLaboral) do:[:x |aux agregarElemento: x toString]
]

{ #category : #Listados }
PantallaPrincipal >> generarListados [

	"Este mensaje gestiona graficamente la generacion de listados."

	|opcion aux|
	
	opcion := UIManager default chooseFrom: #('Solicitudes pendientes realizadas por una Empresa'
														 'Solicitudes pendientes registradas en una fecha dada'
														  'Solicitudes que han sido atendidas, con toda la información correspondiente') 
				 values:#(1 2 3)  title:'Elija la lista que desea ver:'. 
		
	aux := Pantalla new.	
		
	opcion = 1
	ifTrue: [ self generarListadoUno:aux ]
	ifFalse: [ opcion = 2
					ifTrue: [ self generarListadoDos:aux]
					ifFalse:[self generarListadoTres:aux]].
	
]

{ #category : #initialization }
PantallaPrincipal >> initialize [ 

	"Este metodo inicializa una instacia de PantallaPrincipal"

	|origen miGestor|
	
	super initialize.
	
	self color: Color white; position: 100@20;bounds:(self position extent: 1200@800).
	origen := self innerBounds origin.
	
	miGestor := GestorEmpleados inicializar .
	
	titulo := StringMorph new;contents: 'Gestor de Empleos'.
   titulo color: Color black;position: origen + (390@10);
	font: (LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 40 ).
	
	error := StringMorph new;contents: '>>>(Panel de error)<<<'.
   error color: Color black;position: origen + (490@260);
	font: (LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 20).
	
	listaP := RubScrolledTextMorph  new.
	listaP position:origen + (10@310);bounds: (listaP position extent: 1175@150).
	listaP appendText: 'Postulantes',String cr.
	
	listaES := RubScrolledTextMorph  new.
	listaES position:origen + (10@470);bounds: (listaES position extent: 1175@150).
	listaES appendText: 'Empresas solicitantes',String cr.
	
	listaS := RubScrolledTextMorph  new.
	listaS position:origen + (10@630);bounds: (listaS position extent: 1175@150).
	listaS appendText: 'Solicitudes pendientes',String cr.
	
	cerrar := Boton new.
	cerrar position: origen + (5@5);color: Color black.
	cerrar label: '  X  ' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
	 pointSize:  20).
	
	minimizar := Boton  new.
	minimizar  position: origen + (1150@5);color: Color black .
	minimizar  label: '  -  ' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:  20).
		
	botonRP := Boton new.
	botonRP position: origen + (70@100).
	botonRP label: 'Registrar postulante' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .

	botonRS := Boton new.
	botonRS position: origen + (360@100).
	botonRS label: 'Registrar solicitud' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .

	botonRES := Boton new.
	botonRES position: origen + (660@100).
	botonRES label: 'Registrar solicitante' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .

	botonProd := Boton new.
	botonProd position: origen + (950@100).
	botonProd label: 'Agregar producto' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .
	

	botonGP := Boton new.
	botonGP position: origen + (200@200).
	botonGP label: 'Generar propuestas' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .

	botonGL := Boton new.
	botonGL position: origen + (510@200).
	botonGL label: 'Generar listados' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .
	
	botonAP := Boton new.
	botonAP position: origen + (820@200).
	botonAP label: 'Aceptar propuesta' font: (LogicalFont familyName: StandardFonts defaultFont familyName 
   pointSize:15) .
	
	self addMorph: titulo.
	self addMorph:minimizar;addMorph: cerrar.
	self addMorph: botonRP.
	self addMorph: botonRS.
	self addMorph: botonRES.
	self addMorph: botonGP.
	self addMorph: botonAP.
	self addMorph: botonGL.
	self addMorph:listaP.
	self addMorph:listaES.
	self addMorph: listaS .
	self addMorph:botonProd.
	self addMorph:error.
	
	miGestor addDependent: self.
	
	cerrar mouseAction: [self delete].
	minimizar mouseAction: [ self collapse ].
	botonRP mouseAction: [ self registroPostulante].
	botonRS mouseAction: [ self registroSolicitud ].
	botonRES mouseAction: [ self registroSolicitante ].
	botonProd mouseAction: [ self agregarProducto  ].
	botonGP mouseAction: [ GestorEmpleados generarPropuestas].
	botonAP  mouseAction: [ self aceptarPropuesta  ].
	botonGL mouseAction: [ self generarListados . ]
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> registroEmpresa: id num: num [

	"Este mensaje gestiona graficamente el registro de empresas"

	|retorno|
	
	retorno := num = 2
		           ifTrue: [ GestorEmpleados registrarEmpresa: id asInteger ]
		           ifFalse: [ GestorEmpleados registrarEmpresaCombinada: id asInteger ].

	retorno = 1
	ifTrue: [self completarAtributosEmpresa: id asInteger num: 1].

	
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> registroPersona:id [

	"Este mensaje gestiona graficamente el registro de personas"

	|apts|

	apts := UIManager default request: 'Ingrese las aptitudes de la persona:'.
	
	GestorEmpleados registrarPersona: id asInteger aptitudes: apts. 	
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> registroPostulante [

	"Este mensaje gestiona graficamente el registro de postulantes"

	|opcion id|
	
	opcion := UIManager default chooseFrom: #('Persona' 'Empresa' 'Empresa combinada') values: #(1 2 3)
	title:'Elija el tipo de postulante'.
	
	id := UIManager default request:'Ingrese el id laboral:'.
	
	(opcion = 1)
	ifTrue: [ self registroPersona: id]
	ifFalse: [self registroEmpresa:id num: opcion ].
]

{ #category : #Solicitudes }
PantallaPrincipal >> registroServicio:id descrp:descrp num:num [

	"Este mensaje gestiona graficamente el registro de servicios"

	|mon prod|

	mon := UIManager default request:'Ingrese el monto total del servicio:'.
	prod := UIManager default chooseFrom: #('Si' 'No') values: #(1 nil) 
   title:'El servicio tiene producto adherido?'.
	
	(prod = 1)
	ifTrue: [ prod :=  UIManager default request:'Ingrese el producto adherido:'].
	
	(num = 2)
	ifTrue: [ GestorEmpleados registrarSolicitudServicioPuntual: id asInteger sobre: descrp
		  por: mon asInteger producto: prod  ] 
	 ifFalse: [ self registroServicioProlongado: id descrp: descrp montoTotal: mon  producto: prod ]
]

{ #category : #Solicitudes }
PantallaPrincipal >> registroServicioProlongado:id descrp:descrp montoTotal:mon producto:prod [

	"Este mensaje gestiona graficamente el registro de servicios prolongados"

	|dur tiPa|
	
	dur := UIManager default request:'Ingrese el tiempo,en meses, del servicio: '.
	tiPa:= UIManager default chooseFrom: #('Anual' 'Semanal' 'Diario') values: #('A' 'S' 'D')
   title: 'Ingrese el tipo de pago del servicio:'. 

	GestorEmpleados registrarSolicitudServicioProlongado: id asInteger sobre: descrp
   por:mon asInteger tipoPago:tiPa  duracion:dur asInteger producto:prod.
]

{ #category : #PostulantesSolicitantes }
PantallaPrincipal >> registroSolicitante [

	"Este mensaje gestiona graficamente el registro de solicitantes"

	|opcion retorno id|
	
	opcion := UIManager default chooseFrom: #('Empresa' 'Empresa combinada') values: #(1 2)
	title:'Elija el tipo de postulante'.

	id := UIManager default request:'Ingrese el id laboral:'.
	
	retorno := opcion = 1
	ifTrue: [GestorEmpleados registrarEmpresaSolicitante: id asInteger.]
	ifFalse: [GestorEmpleados registrarEmpresaCombinadaSolicitante: id asInteger].
	
	retorno = 1
	ifTrue: [ self completarAtributosEmpresa: id num: 2].

]

{ #category : #Solicitudes }
PantallaPrincipal >> registroSolicitud [

	"Este mensaje gestiona graficamente el registro de solicitudes"

		|opcion id descrp|
	
	opcion := UIManager default chooseFrom: #('Trabajo' 'Servicio puntual' 'Servicio prolongado')
	 values: #(1 2 3) title:'Elija el tipo de servicio'.
	
	id := UIManager default request:'Ingrese el id laboral de la empresa que realiza la solicitud:'.
	descrp := UIManager default request: 'Ingrese la descripcion de la solicitud:'.
	
	(opcion = 1)
	ifTrue: [GestorEmpleados registrarSolicitudDeTrabajo: id asInteger sobre: descrp]
	ifFalse: [self registroServicio:id descrp:descrp num: opcion ].
]

{ #category : #updating }
PantallaPrincipal >> update:unObjeto [
	
	unObjeto
	ifNil: [ error contents: 'ERROR' ] 
	ifNotNil: [ error contents: '' ].
	
	listaP setText: 'Postulantes',String cr.
	GestorEmpleados getPostulantes do: [ :x |listaP appendText: x toString,String cr].
	
	listaES setText: 'Empresas solicitantes',String cr.
	GestorEmpleados getEmpresasSolicitantes do:[ :x |listaES appendText: x toString,String cr].
	
	listaS setText: 'Solicitudes pendientes',String cr.
	GestorEmpleados getSolicitudes  do:[ :x |listaS appendText: x toString,String cr]. 
	
	
]
