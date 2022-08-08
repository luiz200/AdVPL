#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
#Include "RwMake.ch"
#Include "TBIConn.ch"
#include 'parmtype.ch'

User Function zParamB()
	
	Local aPergs   := {}
	Local nNumTit := Space(TamSX3('E1_NUM')[1])
	Local cTipo  := Space(TamSX3('E1_TIPO')[1])
	Local cNatureza  := Space(TamSX3('E1_NATUREZ')[1])
	Local dVenc  := LastDate(Date())
	
	aAdd(aPergs, {1, "Número do Título"   ,nNumTit   ,"" ,".T." ,""    ,".T."	,80 ,.T.})
	aAdd(aPergs, {1, "Tipo do Título"     ,cTipo	 ,"" ,".T." ,"05"  ,".T."	,80 ,.F.})
	aAdd(aPergs, {1, "Natureza do Título" ,cNatureza ,"" ,".T." ,"SED" ,".T."	,80 ,.T.})
	aAdd(aPergs, {1, "Data de Vencimento" ,dVenc	 ,"" ,".T." ,""    ,".T."	,80 ,.F.})
	
	If ParamBox(aPergs, "Informe os parâmetros")
		
		Alert(MV_PAR01)
		Alert(MV_PAR02)
		Alert(MV_PAR03)
		Alert(MV_PAR04)
		
	EndIf
    u_vStatus()
	u_zExecA()
Return

User Function vStatus()
    If ZZ1->ZZ1_STATUS != "F"
        RecLock('ZZ1', .F.)
            ZZ1->ZZ1_STATUS := "F"
        ZZ1->(MsUnlock())
    EndIf 
return
