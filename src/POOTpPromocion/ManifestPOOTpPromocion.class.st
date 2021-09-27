"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPOOTpPromocion,
	#superclass : #PackageManifest,
	#category : #'POOTpPromocion-Manifest'
}

{ #category : #'code-critics' }
ManifestPOOTpPromocion class >> ruleGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'GestorEmpleados class' #completarInfoEmpresaPostulante:rubro:rango:tipo: #true)) #'2021-09-09T18:55:50.90634-03:00') )
]
