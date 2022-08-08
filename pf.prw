//FE
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

Static cTitulo := "Projetos"

User Function PF()
	
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	SetFunName("PF")
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ1")
	oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()
	SetFunName(cFunBkp)
	RestArea(aArea)

Return NIL

Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.PF" OPERATION MODEL_OPERATION_VIEW   ACCESS 0 
	ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.PF" OPERATION MODEL_OPERATION_INSERT ACCESS 0
	ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.PF" OPERATION MODEL_OPERATION_UPDATE ACCESS 0
	ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.PF" OPERATION MODEL_OPERATION_DELETE ACCESS 0

Return aRotina

Static Function ModelDef()
	
	Local oModel	:= NIL
	Local oStZZ1 := FWFormStruct(1, "ZZ1")
	oModel := MPFormModel():New("PFM",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
	oModel:AddFields("FORMZZ1",/*cOwner*/, oStZZ1)
	oModel:SetPrimaryKey({'ZZ1_CODIGO', 'ZZ1_NOME'})
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	oModel:GetModel("FORMZZ1"):SetDescription("Formulário do Cadastro "+cTitulo)

Return oModel

Static Function ViewDef()
	
	Local oModel := FWLoadModel("PF")
	Local oStZZ1 := FWFormStruct(2, "ZZ1")
	Local oView := NIL
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZZ1", oStZZ1, "FORMZZ1")
	oView:CreateHorizontalBox("TELA",100) 
    oView:EnableTitleView('VIEW_ZZ1', 'Dados dos Projetos' )
	oView:SetOwnerView("VIEW_ZZ1","TELA")

Return oView
