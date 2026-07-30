/// 
Class trans.BP.ProcessaTransporte.Process Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='trans.BP.ProcessaTransporte.Request' response='trans.BP.ProcessaTransporte.Response' version='1' height='1900' width='1700' >
<context>
<property name='Cep5n' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='5' />
</parameters>
</property>
<property name='AtendidoSpeedy' type='%Boolean' instantiate='0' />
<property name='PrazoEntregaDias' type='%String' instantiate='0' />
<property name='PesoKg' type='%Double' instantiate='0' />
</context>
<sequence xend='200' yend='1700' >
<call name='ChamaDetalhesPedido' target='DetalhesPedido BO' async='1' xpos='200' ypos='250' >
<request type='trans.BO.RecupDetalhesPedidos.Request' >
<assign property="callrequest.CodigoPedido" value="request.CodigoPedido" action="set" />
</request>
<response type='trans.BO.RecupDetalhesPedidos.Response' >
<assign property="context.Cep5n" value="callresponse.CEP" action="set" />
<assign property="context.PesoKg" value="callresponse.PesoKg" action="set" />
</response>
</call>
<sync name='AguardaDetalhesPedido' calls='ChamaDetalhesPedido' type='all' xpos='200' ypos='350' />
<alert name='Cep5n' value='55555' xpos='200' ypos='450' />
<if name='PedidoValido' condition='context.Cep5n&apos;=""' xpos='200' ypos='550' xend='200' yend='1600' >
<true>
<assign name="DefineStatusPedidoValido" property="response.Status" value="1" action="set" xpos='470' ypos='700' />
<assign name="DefineCep5n" property="context.Cep5n" value="$extract(context.Cep5n,1,5)" action="set" xpos='470' ypos='800' />
<call name='ChamaVerificaDestinoSpeedy' target='DetalhesSpeedy BO' async='1' xpos='470' ypos='900' >
<request type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response' >
<assign property="context.AtendidoSpeedy" value="callresponse.AtendidoSpeedy" action="set" />
</response>
</call>
<call name='ChamaRecupPrazoEntrega' target='DetalhesSpeedy BO' async='1' xpos='470' ypos='1000' >
<request type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response' >
<assign property="context.PrazoEntregaDias" value="callresponse.PrazoEntregaDias" action="set" />
</response>
</call>
<sync name='AguardaDetalhesSpeedy' calls='ChamaVerificaDestinoSpeedy,ChamaRecupPrazoEntrega' type='all' xpos='470' ypos='1100' />
<if name='AceitavelSpeedy?' condition='context.AtendidoSpeedy=1&amp;(context.PesoKg&lt;=50)' xpos='470' ypos='1200' xend='470' yend='1500' >
<true>
<assign name="AtribuiSpeed" property="response.CodigoTransp" value="1" action="set" xpos='740' ypos='1350' />
<assign name="CalculaAtribuiDataEntrega" property="response.DataPrevisaoEntrega" value='$Piece($Horolog,",",1) + context.PrazoEntregaDias' action="set" xpos='740' ypos='1420' />
</true>
<false>
<assign name="AtribuiFlex" property="response.CodigoTransp" value="2" action="set" xpos='470' ypos='1350' />
<assign name="CalculaAtribuiDataEntregaFlex" property="response.DataPrevisaoEntrega" value='$Piece($Horolog,",",1) + 5' action="set" xpos='470' ypos='1420' />
</false>
</if>
</true>
<false>
<assign name="DefineStatusPedidoInvalido" property="response.Status" value="0" action="set" xpos='200' ypos='700' />
</false>
</if>
</sequence>
</process>
}

}
