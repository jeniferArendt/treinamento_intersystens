Class Treinamento.Data.LogMensagem Extends %Persistent
{

Property Metodo As %String;

Property Classe As %String;

Property LogMensagem As %String;

Property Inicio As %TimeStamp;

Property Fim As %TimeStamp;

Property Status As %String;

Property StatusProcesso As %String;

Property ListaLog As list Of Treinamento.VO.LogMensagem;

ClassMethod CriarEntrada(pMetodo As %String, pClasse As %String) As Treinamento.Data.LogMensagem
{
	set tSC = $$$OK
	#dim logMensagem                As Treinamento.Data.LogMensagem = $$$NULLOREF
	try
	{
		set classe                  = ..%ClassName()
		set name                    = $zname
		#dim exception              As %Exception.General   = ""
		#dim statuCode              As %Status              = $SYSTEM.Status.OK()

		set logMensagem             = ##class(Treinamento.Data.LogMensagem).%New()
		set logMensagem.Metodo      = pMetodo
		set logMensagem.Classe      = pClasse
		set logMensagem.Inicio      = $zdatetime($horolog, 3)
		set logMensagem.Status      = "Ativo"

		set statuCode               = logMensagem.%Save()
	} catch ex {
		set tSC = ex.AsStatus()
		set logMensagem = $$$NULLOREF
	}
	quit logMensagem
}

ClassMethod Finalizar(pIdLog As %String, pStatusProcesso As %String, pStatusCode As %String) As %Status
{
	set tSC = $$$OK
	#dim logMensagem                As Treinamento.Data.LogMensagem = $$$NULLOREF
	try
	{
		set classe                      = ..%ClassName()
		set name                        = $zname
		#dim exception                  As %Exception.General   = ""

		set logMensagem                 = ##class(Treinamento.Data.LogMensagem).%OpenId(pIdLog)
		if '$isObject(logMensagem) {
			set tSC = $$$ERROR($$$GeneralError, "Log nao encontrado para ID: " _ pIdLog)
			quit
		}

		set logMensagem.Fim             = $zdatetime($horolog, 3)
		set logMensagem.StatusProcesso  = pStatusProcesso
		set logMensagem.Status          = pStatusCode

		set tSC                         = logMensagem.%Save()
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

ClassMethod ConsultaLog(pStatus As %String, pDataInicio As %TimeStamp, pDataFim As %TimeStamp) As %Status
{
	set tSC = $$$OK
	try
	{
		set classe                      = ..%ClassName()
		set name                        = $zname
		#dim exception                  As %Exception.General   = ""
		#dim rs                         As %SQL.StatementResult

		set sql = "SELECT ID, Metodo, Classe, Inicio, Fim, Status, StatusProcesso"
			_ " FROM Treinamento_Data.LogMensagem"
			_ " WHERE Status = ?"
			_ " AND Inicio >= ?"
			_ " AND Inicio <= ?"
			_ " ORDER BY Inicio"

		set rs = ##class(%SQL.Statement).%ExecDirect(, sql, pStatus, pDataInicio, pDataFim)

		if rs.%SQLCODE < 0 {
			set tSC = $$$ERROR($$$GeneralError, rs.%Message)
			quit
		}

		set count = 0
		write !,"=== Consulta de Log ==="
		write !,"Status: ", pStatus, " | De: ", pDataInicio, " Ate: ", pDataFim
		write !,"---------------------------------------------------------"

		while rs.%Next() {
			set count = count + 1
			write !,"ID: ", rs.%Get("ID")
			write !,"  Classe : ", rs.%Get("Classe"), " | Metodo: ", rs.%Get("Metodo")
			write !,"  Inicio : ", rs.%Get("Inicio")
			write !,"  Fim    : ", rs.%Get("Fim")
			write !,"  Status : ", rs.%Get("Status"), " | StatusProcesso: ", rs.%Get("StatusProcesso")
			write !,"---------------------------------------------------------"
		}
		write !,"Total de registros: ", count
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

ClassMethod BuscarLogPorIdJSON(pId As %String) As %DynamicObject
{
	#dim logMensagem                As Treinamento.Data.LogMensagem = $$$NULLOREF
	#dim json                       As %DynamicObject = $$$NULLOREF
	try
	{
		set logMensagem = ##class(Treinamento.Data.LogMensagem).%OpenId(pId)
		if '$isObject(logMensagem) {
			quit
		}

		set json = {}
		set json.ID             = pId
		set json.Metodo         = logMensagem.Metodo
		set json.Classe         = logMensagem.Classe
		set json.LogMensagem    = logMensagem.LogMensagem
		set json.Inicio         = logMensagem.Inicio
		set json.Fim            = logMensagem.Fim
		set json.Status         = logMensagem.Status
		set json.StatusProcesso = logMensagem.StatusProcesso
	} catch ex {
		set json = $$$NULLOREF
	}
	quit json
}

Storage Default
{
<Data name="LogMensagemDefaultData">
<Value name="1"/>
<Value name="2"/>
<Value name="3"/>
<Value name="4">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="5">
<Value>Metodo</Value>
</Value>
<Value name="6">
<Value>Classe</Value>
</Value>
<Value name="7">
<Value>LogMensagem</Value>
</Value>
<Value name="8">
<Value>Inicio</Value>
</Value>
<Value name="9">
<Value>Fim</Value>
</Value>
<Value name="10">
<Value>Status</Value>
</Value>
<Value name="11">
<Value>StatusProcesso</Value>
</Value>
<Value name="12">
<Value>ListaLog</Value>
</Value>
</Data>
<DataLocation>^Treinamento.Data.LogMensagemD</DataLocation>
<DefaultData>LogMensagemDefaultData</DefaultData>
<ExtentSize>11</ExtentSize>
<IdLocation>^Treinamento.Data.LogMensagemD</IdLocation>
<IndexLocation>^Treinamento.Data.LogMensagemI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Classe">
<AverageFieldSize>14</AverageFieldSize>
<OutlierSelectivity>.999999:"ExercicioLog"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Fim">
<AverageFieldSize>17.55</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="Inicio">
<AverageFieldSize>21</AverageFieldSize>
<Selectivity>9.0909%</Selectivity>
</Property>
<Property name="ListaLog">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="LogMensagem">
<AverageFieldSize>2</AverageFieldSize>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="Metodo">
<AverageFieldSize>11.55</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Status">
<AverageFieldSize>5.64</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="StatusProcesso">
<AverageFieldSize>9.36</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Treinamento.Data.LogMensagemS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}