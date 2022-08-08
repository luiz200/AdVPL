//FE
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

Static cTitulo := "Analistas"

User Function ANA()
	
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	Private menu := MenuDef()                     
    
	SetFunName("ANA")
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ2")
	oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()
	SetFunName(cFunBkp)
	RestArea(aArea)

Return NIL

Static Function MenuDef()
	Local aRotina := {}

	ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.ANA" OPERATION MODEL_OPERATION_VIEW   ACCESS 0 
	ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.ANA" OPERATION MODEL_OPERATION_INSERT ACCESS 0
	ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.ANA" OPERATION MODEL_OPERATION_UPDATE ACCESS 0
	ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.ANA" OPERATION MODEL_OPERATION_DELETE ACCESS 0

Return aRotina

Static Function ModelDef()
	
	Local oModel	:= NIL
	Local oStZZ2 := FWFormStruct(1, "ZZ2")
	oModel := MPFormModel():New("ANAM",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
	oModel:AddFields("FORMZZ2",/*cOwner*/, oStZZ2)
	oModel:SetPrimaryKey({'ZZ2_FILIAL', 'ZZ2_CODIGO'})
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	oModel:GetModel("FORMZZ2"):SetDescription("Formulário do Cadastro "+cTitulo)

Return oModel

Static Function ViewDef()
	
	Local oModel := FWLoadModel("ANA")
	Local oStZZ2 := FWFormStruct(2, "ZZ2")
	Local oView := NIL
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_ZZ2", oStZZ2, "FORMZZ2")
	oView:CreateHorizontalBox("TELA",100) 
    oView:EnableTitleView('VIEW_ZZ2', 'Dados dos Analistas' )
	oView:SetOwnerView("VIEW_ZZ2","TELA")

Return oView
