//FE
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
#Include "RwMake.ch"
#Include "TBIConn.ch"
#include 'parmtype.ch'

Static cTitulo := "Analistas X Projetos"

User Function AXP()

	Local oBrowse                     
	SetFunName("AXP")
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ1")
	oBrowse:SetDescription(cTitulo)
	oBrowse:AddLegend( "ZZ1->ZZ1_STATUS == 'A'", "GREEN",	"Ativo" )
	oBrowse:AddLegend( "ZZ1->ZZ1_STATUS ==  'I'", "RED",	"Inativo" )
	oBrowse:AddLegend( "ZZ1->ZZ1_STATUS ==  'F'", "BLUE",	"Faturado" )
    oBrowse:Activate()
 
Return NIL

Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.AXP" OPERATION MODEL_OPERATION_VIEW   ACCESS 0 
	ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.AXP" OPERATION MODEL_OPERATION_INSERT ACCESS 0
	ADD OPTION aRotina TITLE "Faturar"	  ACTION "u_zParamB"   OPERATION 5						ACCESS 0
	ADD OPTION aRotina TITLE "G. Relat."  ACTION "u_relat001"  OPERATION 7						ACCESS 0
	ADD OPTION aRotina TITLE "Legenda"    ACTION "u_zMod2Leg"  OPERATION 6                      ACCESS 0
	ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.AXP" OPERATION MODEL_OPERATION_UPDATE ACCESS 0
	ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.AXP" OPERATION MODEL_OPERATION_DELETE ACCESS 0

Return aRotina
Static Function ModelDef()

	
	Local bVldPre := {|| u_zM1xPre()}
	Local dVlePre := {|| u_zM1yPre()}
	Local oModel := NIL
	Local aRel := {}
	Local oStZZ1 := FWFormStruct(1, 'ZZ1')
	Local oStZZ3 := FWFormStruct(1, 'ZZ3')
	oModel := MPFormModel():New('ModelZZ11',bVldPre, dVlePre,/*bCommit*/,/*bCancel*/)
	oModel:AddFields('FORMZZ1',/*cOwner*/, oStZZ1)
	oModel:AddGrid('ZZ3DETAIL','FORMZZ1',oStZZ3,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence 
	aAdd(aRel, {'ZZ3_FILIAL', 'ZZ1_FILIAL'})
	aAdd(aRel, {'ZZ3_CODANA', 'ZZ1_CODIGO'})
	oModel:SetRelation('ZZ3DETAIL', aRel, ZZ3->(IndexKey(1)))
	oModel:GetModel('ZZ3DETAIL'):SetUniqueLine({'ZZ3_FILIAL','ZZ3_CODPRO','ZZ3_CODANA'}) 
	oModel:SetPrimaryKey({'ZZ1_FILIAL', 'ZZ1_CODIGO'})
	oModel:SetDescription(cTitulo)
	oModel:GetModel('FORMZZ1'):SetDescription(cTitulo)
	oModel:GetModel('ZZ3DETAIL'):SetDescription('Analistas do Projeto')

Return oModel

Static Function ViewDef()
	
	Local oModel := FWLoadModel("AXP")
	Local oStZZ1 := FWFormStruct(2, "ZZ1")
	Local oStZZ3 := FWFormStruct(2, "ZZ3")
	Local oView := NIL
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField('VIEW_ZZ1', oStZZ1, 'FORMZZ1')
	oView:AddGrid('VIEW_ZZ3', oStZZ3, 'ZZ3DETAIL')
	oView:CreateHorizontalBox("TELA",30)
	oView:CreateHorizontalBox("GRID",70) 
	oView:EnableTitleView('VIEW_ZZ1', 'Dados do Projeto - '+cTitulo )  
	oView:EnableTitleView('VIEW_ZZ3','Grid de Analistas')
	oView:SetOwnerView("VIEW_ZZ1","TELA")
	oView:SetOwnerView('VIEW_ZZ3','GRID')

Return oView

User Function zM1xPre()
	Local oModelPad  := FWModelActive()
	Local nOpc       := oModelPad:GetOperation()
	Local lRet       := .T.
	
	If ZZ1->ZZ1_STATUS == "F" .AND. (nOpc == MODEL_OPERATION_UPDATE)
		Aviso('Atenção!', 'PROJETO FATURADO NÃO PODE SER EDITADO!!!', {'OK'}, 03)
		RETURN .F.
			
	EndIf
Return lRet

User Function zM1yPre()
	Local oModelPad  := FWModelActive()
	Local nOpc       := oModelPad:GetOperation()
	Local lRet       := .T.
		
	If ZZ1->ZZ1_STATUS == "F" .AND. (nOpc == MODEL_OPERATION_DELETE)
		Aviso('Atenção!', 'PROJETO FATURADO NÃO PODE SER DELETADO!!!', {'OK'}, 03)
		RETURN .F.
			
	EndIf
Return lRet

User Function zMod2Leg()
	Local aLegenda := {}
	
	AADD(aLegenda,{"BR_VERDE",		"Ativo"  })
	AADD(aLegenda,{"BR_VERMELHO",	"Inativo"})
	AADD(aLegenda,{"BR_AZUL",	"Faturado"})

	BrwLegenda(cTitulo, "Status", aLegenda)
Return
