Class Treinamento.VO.LogMensagem Extends (%RegisteredObject, %XML.Adaptor)
{

Property Metodo As %String;

Property Classe As %String;

Property LogMensagem As %String;

Property Inicio As %TimeStamp;

Property Fim As %TimeStamp;

Property Status As %String;

Property StatusProcesso As %String;

ClassMethod ConsultaLogPaginacao(pStatus As %String, pLastId As %String, pPagSize As %Integer, pDataFim As %TimeStamp, Output pUltimoId As %String) As %ListOfObjects
{
	set tSC = $$$OK
	#dim lista                      As %ListOfObjects            = ##class(%ListOfObjects).%New()
	
	try
	{
		set classe                      = ..%ClassName()
		set name                        = $zname
		#dim exception                  As %Exception.General       = ""
		#dim rs                         As %SQL.StatementResult
		#dim vo                         As Treinamento.VO.LogMensagem

		set pUltimoId = pLastId

		set sql = "SELECT TOP ? ID, Metodo, Classe, Inicio, Fim, Status, StatusProcesso"
			_ " FROM Treinamento_Data.LogMensagem"
			_ " WHERE Status = ?"
			_ " AND ID > ?"
			_ " AND Inicio <= ?"
			_ " ORDER BY ID"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pPagSize, pStatus, pLastId, pDataFim)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		while rs.%Next() {
			set vo                  = ##class(Treinamento.VO.LogMensagem).%New()
			set vo.Metodo           = rs.%Get("Metodo")
			set vo.Classe           = rs.%Get("Classe")
			set vo.Inicio           = rs.%Get("Inicio")
			set vo.Fim              = rs.%Get("Fim")
			set vo.Status           = rs.%Get("Status")
			set vo.StatusProcesso   = rs.%Get("StatusProcesso")
			do lista.Insert(vo)
			set pUltimoId           = rs.%Get("ID")
		}
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit lista
}

ClassMethod ConsultaLogPaginacaoJSON(pStatus As %String, pLastId As %String, pPagSize As %Integer, pDataFim As %TimeStamp) As %DynamicObject
{
	#dim json                       As %DynamicObject = $$$NULLOREF
	try
	{
		#dim rs                         As %SQL.StatementResult
		#dim itens                      As %DynamicArray = []

		set proximoLastId = pLastId

		set sql = "SELECT TOP ? ID, Metodo, Classe, Inicio, Fim, Status, StatusProcesso"
			_ " FROM Treinamento_Data.LogMensagem"
			_ " WHERE Status = ?"
			_ " AND ID > ?"
			_ " AND Inicio <= ?"
			_ " ORDER BY ID"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pPagSize, pStatus, pLastId, pDataFim)

		if rs.%SQLCODE < 0 {
			quit
		}

		set total = 0
		while rs.%Next() {
			set item = {}
			set item.ID             = rs.%Get("ID")
			set item.Metodo         = rs.%Get("Metodo")
			set item.Classe         = rs.%Get("Classe")
			set item.Inicio         = rs.%Get("Inicio")
			set item.Fim            = rs.%Get("Fim")
			set item.Status         = rs.%Get("Status")
			set item.StatusProcesso = rs.%Get("StatusProcesso")
			do itens.%Push(item)
			set proximoLastId       = rs.%Get("ID")
			set total               = total + 1
		}

		set json = {}
		set json.Itens          = itens
		set json.Total          = total
		set json.ProximoLastId  = $select(total = pPagSize: proximoLastId, 1: "")
	} catch ex {
		set json = $$$NULLOREF
	}
	quit json
}

}
