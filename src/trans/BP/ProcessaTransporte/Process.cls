Class trans.BP.ProcessaTransporte.Process Extends Ens.BusinessProcessBPL
{

XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process request='trans.BP.ProcessaTransporte.Request' response='trans.BP.ProcessaTransporte.Response' height="2800" width="2000" >
<context>
<property name='Endereco' type='%String' />
<property name='CEP' type='%String' />
<property name='Cidade' type='%String' />
<property name='Estado' type='%String' />
<property name='Email' type='%String' />
<property name='NomeEmpresa' type='%String' />
<property name='NomeContato' type='%String' />
<property name='PesoKg' type='%String' />
<property name='Volumes' type='%String' />
<property name='Cep5n' type='%String' />
<property name='AtendidoSpeedy' type='%Boolean' />
<property name='PrazoEntregaDias' type='%String' />
</context>
<sequence xend='210' yend='1150' xstart='210' ystart='50' >
<call name='ChamaDetalhesPedido' target='DetalhesPedido BO' async='1' xpos='210' ypos='150' >
<annotation>
<![CDATA[Chama o Business Operation "DetalhesPedido BO" para recuperar os detalhes do pedido.]]>
</annotation>
<request type='trans.BO.RecupDetalhesPedidos.Request' >
<assign property="callrequest.CodigoPedido" value="request.CodigoPedido" action="set" />
</request>
<response type='trans.BO.RecupDetalhesPedidos.Response' >
<assign property="context.Endereco" value="callresponse.Endereco" action="set" />
<assign property="context.CEP" value="callresponse.CEP" action="set" />
<assign property="context.Cidade" value="callresponse.Cidade" action="set" />
<assign property="context.Estado" value="callresponse.Estado" action="set" />
<assign property="context.Email" value="callresponse.Email" action="set" />
<assign property="context.NomeEmpresa" value="callresponse.NomeEmpresa" action="set" />
<assign property="context.NomeContato" value="callresponse.NomeContato" action="set" />
<assign property="context.PesoKg" value="callresponse.PesoKg" action="set" />
<assign property="context.Volumes" value="callresponse.Volumes" action="set" />
</response>
</call>
<sync name='AguardaDetalhesPedido' calls='ChamaDetalhesPedido' timeout="10" xpos='210' ypos='250' >
</sync>
<if name='PedidoValido?' condition="context.NomeEmpresa'=&quot;&quot;" xpos='210' ypos='350' >
<annotation>
<![CDATA[Verifica se o pedido informado existe na base (o Business Operation retorna NomeEmpresa vazio quando o CodigoPedido não é encontrado).]]>
</annotation>
<true>
<assign name='DefineCep5n' property="context.Cep5n" value="$extract(context.CEP,1,5)" action="set" xpos='150' ypos='450' >
<annotation>
<![CDATA[Extrai os 5 primeiros dígitos do CEP para enviar às BOs da Speedy.]]>
</annotation>
</assign>
<call name='ChamaVerificaDestinoSpeedy' target='DetalhesSpeedy BO' async='1' xpos='150' ypos='550' >
<request type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.VerificaDestinoSpeedy.Response' >
<assign property="context.AtendidoSpeedy" value="callresponse.AtendidoSpeedy" action="set" />
</response>
</call>
<call name='ChamaRecupPrazoEntrega' target='DetalhesSpeedy BO' async='1' xpos='350' ypos='550' >
<request type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Request' >
<assign property="callrequest.Cep5n" value="context.Cep5n" action="set" />
</request>
<response type='trans.BO.DetalhesSpeedy.RecupPrazoEntrega.Response' >
<assign property="context.PrazoEntregaDias" value="callresponse.PrazoEntregaDias" action="set" />
</response>
</call>
<sync name='AguardaDetalhesSpeedy' calls='ChamaVerificaDestinoSpeedy,ChamaRecupPrazoEntrega' timeout="10" xpos='150' ypos='650' >
</sync>
<if name='AceitavelSpeedy?' condition="context.AtendidoSpeedy=1&amp;(context.PesoKg'&gt;50)" xpos='150' ypos='750' >
<annotation>
<![CDATA[Speedy atende se a região é coberta e o peso do pedido não passa de 50 Kg.]]>
</annotation>
<true>
<assign name='AtribuiSpeed' property="response.CodigoTransp" value="1" action="set" xpos='100' ypos='850' />
<assign name='CalculaAtribuiDataEntrega' property="response.DataPrevisaoEntrega" value="$Piece($Horolog,&quot;,&quot;,1) + context.PrazoEntregaDias" action="set" xpos='100' ypos='950' />
</true>
<false>
<assign name='AtribuiFlex' property="response.CodigoTransp" value="2" action="set" xpos='300' ypos='850' />
<assign name='CalculaAtribuiDataEntregaFlex' property="response.DataPrevisaoEntrega" value="$Piece($Horolog,&quot;,&quot;,1) + 5" action="set" xpos='300' ypos='950' />
</false>
</if>
<assign name='DefineStatusPedidoValido' property="response.Status" value="1" action="set" xpos='150' ypos='1050' />
</true>
<false>
<assign name='DefineStatusPedidoInvalido' property="response.Status" value="0" action="set" xpos='350' ypos='450' />
</false>
</if>
</sequence>
</process>
}

}
