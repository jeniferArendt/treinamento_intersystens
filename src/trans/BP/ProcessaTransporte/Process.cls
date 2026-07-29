/// 
Class trans.BP.ProcessaTransporte.Process Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='trans.BP.ProcessaTransporte.Request' response='trans.BP.ProcessaTransporte.Response' version='1' height='2000' width='2000' >
<sequence xend='200' yend='450' >
<call name='ChamaDetalhesPedido' target='DetalhesPedidos' async='1' xpos='200' ypos='250' >
<request type='trans.BO.RecupDetalhesPedidos.Request' >
<assign property="callrequest.CodigoPedido" value="request.CodigoPedido" action="set" />
</request>
<response type='trans.BO.RecupDetalhesPedidos.Response' />
</call>
<sync name='AguardaDetalhesPedido' calls='ChamaDetalhesPedido' type='all' xpos='200' ypos='350' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
