#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
#Include "RwMake.ch"
#Include "TBIConn.ch"
#include 'parmtype.ch'

User Function zExecA()
	Local aVetor1 := {}
	Private lMsErroAuto := .F.
	aAdd(aVetor1, {"E1_FILIAL"    ,FWxFilial("SE1")  ,Nil})
	aAdd(aVetor1, {"E1_NUM"		  ,MV_PAR01		     ,Nil})
	//aAdd(aVetor1, {"E1_PREFIXO" ,"MAN"			 ,Nil})
	//aAdd(aVetor1, {"E1_PARCELA" , "6"				 ,Nil})
	aAdd(aVetor1, {"E1_TIPO"	  ,MV_PAR02	 	   	 ,Nil})
	aAdd(aVetor1, {"E1_NATUREZ"	  ,MV_PAR03	 	     ,Nil})
	aAdd(aVetor1, {"E1_VALOR"	  ,ZZ1->ZZ1_VP 	     ,Nil})
	aAdd(aVetor1, {"E1_CLIENTE"	  ,ZZ1->ZZ1_CODCLI   ,Nil})
	aAdd(aVetor1, {"E1_LOJA"	  ,ZZ1->ZZ1_LOJACL 	 ,Nil})
	aAdd(aVetor1, {"E1_EMISSAO"   ,ZZ1->ZZ1_DC		 ,Nil})
	aAdd(aVetor1, {"E1_VENCTO"	  ,MV_PAR04		     ,Nil})
	//aAdd(aVetor1, {"E1_VENCREA"   ,ZZ1->ZZ1_DF	  	 ,Nil})
	//aAdd(aVetor1, {"E1_VALJUR"  ,0			     ,Nil})
	//aAdd(aVetor1, {"E1_PORCJUR" ,0			     ,Nil})
	//aAdd(aVetor1, {"E1_HIST"      ,ZZ1->ZZ1_OBS      ,Nil})
	//aAdd(aVetor1, {"E1_MOEDA"	  ,1			     ,Nil})
	
	MSExecAuto({|x,y| FINA040(x,y)}, aVetor1, 3)
	If !lMsErroAuto
        ConOut("**** Incluido com sucesso! ****")
    Else
        MostraErro()
        ConOut("Erro na Inclusao!")
    EndIf
Return
