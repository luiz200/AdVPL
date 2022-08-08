//BY-LUIZ FELIPE
#include 'protheus.ch'
#include 'parmtype.ch'
#include "fwmvcdef.ch"
#include "topconn.ch"

User Function relat001()
	Local oReport
	oReport:=ReportDef()
	oReport:PrintDialog()
Return

Static Function ReportDef()
	Local cPerg  	:= "LUIZ"
	Local cTitle 	:= "Listagem de Projetos"
	Local cHelp  	:= "Listagem de Projetos"
	Local oReport
	Local oSection1
	Local oSection2
	Local oSection3
    Local oBreak
	Local oTrFuntion
	


    
    oReport:= TReport():New("LUIZ",cTitle,cPerg,{|oReport| ReportPrint(oReport)},cHelp)
	Pergunte(cPerg,.F.)
	oReport:SetLandscape() 
	oReport:SetTotalInLine(.F.)
	oReport:nFontBody := 10
	
	oSection1:= TRSection():New(oReport,OemToAnsi("Listagem de Projetos"),{"ZZ1"}) 
	oSection1:SetTotalInLine(.F.)
	TrCell():New(oSection1,"CODIGO"     ,"","Codigo Projeto",PesqPict("ZZ1","ZZ1_CODIGO")  ,GetSX3Cache("ZZ1_CODIGO","X3_TAMANHO"))
	TrCell():New(oSection1,"NOME"    	,"","Nome Projeto"  ,PesqPict("ZZ1","ZZ1_NOME")   ,GetSX3Cache("ZZ1_NOME","X3_TAMANHO"))
	TrCell():New(oSection1,"CLIENTE"    ,"","Cod. Cliente"  ,PesqPict("ZZ1","ZZ1_CODCLI ") ,GetSX3Cache("ZZ1_CODCLI","X3_TAMANHO"))
	TrCell():New(oSection1,"NOMECLI" 	,"","Nome Cliente"  ,PesqPict("SA1","A1_NOME ")    ,GetSX3Cache("A1_NOME","X3_TAMANHO"))
	TrCell():New(oSection1,"VALOR" 		,"","Valor Projeto" ,PesqPict("ZZ1","ZZ1_VP ") ,GetSX3Cache("ZZ1_VP","X3_TAMANHO"))
	
	oSection2:= TRSection():New(oReport,OemToAnsi("Listagem de Analistas"),{"ZZ3"}) 
	oSection2:SetTotalInLine(.F.)
	TrCell():New(oSection2,"CODIGO"     ,"","Codigo Analista",PesqPict("ZZ3","ZZ3_CODANA")  ,GetSX3Cache("ZZ3_CODANA","X3_TAMANHO"))
	TrCell():New(oSection2,"NOME"    	,"","Nome Projeto"  ,PesqPict("ZZ3","ZZ3_NOMEAN")   ,GetSX3Cache("ZZ3_NOMEAN","X3_TAMANHO"))
	TrCell():New(oSection2,"SALARIO"    ,"","Salário"  ,PesqPict("ZZ3","ZZ3_VSALAR ") ,GetSX3Cache("ZZ3_VSALAR","X3_TAMANHO"))

	oSection3:= TRSection():New(oReport,OemToAnsi("Listagem de Projetos"),{"SE1"}) 
	oSection3:SetTotalInLine(.F.)
	TrCell():New(oSection3,"TITULO"     	 	 ,"","Numero Titulo" 		,PesqPict("SE1","E1_NUM")  			,GetSX3Cache("E1_NUM","X3_TAMANHO"))
	TrCell():New(oSection3,"DEMISSAO"    		 ,"","Data Emissao"  		,PesqPict("SE1","E1_EMISSAO")   	,GetSX3Cache("E1_EMISSAO","X3_TAMANHO"))
	TrCell():New(oSection3,"DVENCI"    		 	 ,"","Data Vencimento"  	,PesqPict("SE1","E1_VENCTO")    	,GetSX3Cache("E1_VENCTO","X3_TAMANHO"))
	TrCell():New(oSection3,"VALORE1"    		 ,"","Valor"  	 			,PesqPict("SE1","E1_VALOR")    		,GetSX3Cache("E1_VALOR","X3_TAMANHO"))
	TrCell():New(oSection3,"HISTOR"    			 ,"","Historico"  	 		,PesqPict("SE1","E1_HIST")    	    ,GetSX3Cache("E1_HIST","X3_TAMANHO"))

	oTrFuntion:= TRFunction():New(oSection1:Cell("VALOR"),"VALOR DO CUSTO: ","SUM",oBreak,,PesqPict("ZZ1","ZZ1_VP ") , ,.F.,.T.,,,)
	oTrFuntion:= TRFunction():New(oSection2:Cell("SALARIO"),"SALARIO ANALISTA: ","SUM",oBreak,,PesqPict("ZZ3","ZZ3_VSALAR" ),,.F.,.T.,,,)
	oTrFuntion:= TRFunction():New(oSection3:Cell("VALORE1"),"VALOR DO HISTORICO","SUM",oBreak,,PesqPict("SE1","E1_VALOR" ),,.F.,.T.,,,)
  
 Return(oReport)

Static Function ReportPrint(oReport)
	Local oSection1 := oReport:Section(1)
	Local oSection2 := oReport:Section(2)
	Local oSection3 := oReport:Section(3)
	Local cQuery    := ""
	Local cQuery2   := ""
	Local cQuery3   := ""
	
	cQuery+= " SELECT ZZ1_CODIGO,ZZ1_NOME,ZZ1_CODCLI,A1_NOME,ZZ1_VP "
	cQuery+= " FROM "+RetSqlName("ZZ1")+" ZZ1 "
	cQuery+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "
	cQuery+= " ON ZZ1_CODCLI = A1_COD "
	cQuery+= " WHERE ZZ1.D_E_L_E_T_= ' ' "
	cQuery+= " AND SA1.D_E_L_E_T_= ' '  "
	cQuery+= " AND ZZ1_CODIGO BETWEEN '"+mv_par01+"' AND '"+mv_par02+"' "
	cQuery+= " AND ZZ1_CODCLI BETWEEN '"+mv_par03+"' AND '"+mv_par04+"' "
	cQuery+= " ORDER BY ZZ1_CODIGO, ZZ1_NOME "
	
	mpSysOpenQuery(cQuery,"REL")

	dbSelectArea("REL")
	
	oSection1:Init()
	While REL->(!Eof())
		
		oSection1:Cell("CODIGO"):SetValue(REL->ZZ1_CODIGO)
		oSection1:Cell("NOME"):SetValue(ZZ1_NOME)
		oSection1:Cell("CLIENTE"):SetValue(ZZ1_CODCLI)
		oSection1:Cell("NOMECLI"):SetValue(REL->A1_NOME)
		oSection1:Cell("VALOR"):SetValue(REL->ZZ1_VP)


		oSection1:Printline()
		
		oReport:IncMeter()
		IncProc("Imprimindo relatório de Projetos")	
		
		If oReport:Cancel()
			Exit
		EndIf

		REL->(dbSkip())
	EndDo
	oSection1:Finish()
	
	cQuery2+= " SELECT ZZ2_CODIGO,ZZ2_NOME,ZZ2_SALAAN "
	cQuery2+= " FROM "+RetSqlName("ZZ2")+" ZZ2 "
	cQuery2+= " WHERE ZZ2.D_E_L_E_T_= ' ' "
	cQuery2+= " ORDER BY ZZ2_CODIGO, ZZ2_NOME "
	mpSysOpenQuery(cQuery2,"REL")

	dbSelectArea("REL")
	
	oSection2:Init()
	While REL->(!Eof())

		oSection2:Cell("CODIGO"):SetValue(REL->ZZ2_CODIGO)
		oSection2:Cell("NOME"):SetValue(REL->ZZ2_NOME)
		oSection2:Cell("SALARIO"):SetValue(REL->ZZ2_SALAAN)

		oSection2:Printline()
		
		oReport:IncMeter()
		IncProc("Imprimindo relatório de Analistas")	
		
		If oReport:Cancel()
			Exit
		EndIf

		REL->(dbSkip())
	EndDo
	oSection2:Finish()
	REL->(dbCloseArea())

	cQuery3+= " SELECT E1_NUM,E1_EMISSAO,E1_VENCTO,E1_VALOR,E1_HIST "
	cQuery3+= " FROM "+RetSqlName("SE1")+" SE1 "
	cQuery3+= " WHERE SE1.D_E_L_E_T_= ' ' "
	cQuery3+= " ORDER BY E1_NUM,E1_EMISSAO,E1_VENCTO,E1_VALOR,E1_HIST "
	//TcQuery3 cQuery3 New Alias REL
	mpSysOpenQuery(cQuery3,"REL")

	dbSelectArea("REL")
	
	oSection3:Init()
	While REL->(!Eof())
		
		oSection3:Cell("TITULO"):SetValue(REL->E1_NUM)
		oSection3:Cell("DEMISSAO"):SetValue(REL->E1_EMISSAO)
		oSection3:Cell("DVENCI"):SetValue(REL->E1_VENCTO)
		oSection3:Cell("VALORE1"):SetValue(REL->E1_VALOR)
		oSection3:Cell("HISTOR"):SetValue(REL->E1_HIST)

		oSection3:Printline()
		
		oReport:IncMeter()
		IncProc("Imprimindo relatório de Titulos")	
		
		If oReport:Cancel()
			Exit
		EndIf

		REL->(dbSkip())
	EndDo
	oSection2:Finish()
	REL->(dbCloseArea())
Return
    