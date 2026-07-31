Class Ecommerce.BP.Process Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ecommerce.BP.Msg.Request' response='Ecommerce.BP.Msg.Response' version='1' height='1400' width='900' >
<context>
<property name='Nome' type='%String' instantiate='0' />
<property name='TipoAvaliacao' type='%String' instantiate='0' />
<property name='Indicador' type='%String' instantiate='0' />
<property name='Score' type='%Integer' instantiate='0' />
<property name='Resultado' type='%String' instantiate='0' />
</context>
<sequence xend='200' yend='1300' >
<call name='ChamaDadosCreditoBO' target='Dados Credito BO' async='1' xpos='200' ypos='200' >
<request type='Ecommerce.BO.Msg.Request' >
<assign property="callrequest.CodigoCliente" value="request.CodigoCliente" action="set" />
<assign property="callrequest.Indicador" value="request.Indicador" action="set" />
</request>
<response type='Ecommerce.BO.Msg.Response' >
<assign property="context.Nome" value="callresponse.Nome" action="set" />
<assign property="context.TipoAvaliacao" value="callresponse.TipoAvaliacao" action="set" />
<assign property="context.Indicador" value="callresponse.Indicador" action="set" />
<assign property="context.Score" value="callresponse.Score" action="set" />
</response>
</call>
<sync name='AguardaDadosCreditoBO' calls='ChamaDadosCreditoBO' type='all' xpos='200' ypos='300' />
<if name='TipoAvaliacaoCadastral?' condition='context.TipoAvaliacao="Cadastral"' xpos='200' ypos='400' xend='200' yend='1050' >
<true>
<if name='ScoreCadastralAprovado?' condition='context.Score&gt;=6' xpos='400' ypos='500' xend='400' yend='750' >
<true>
<assign name="AprovaCadastral" property="context.Resultado" value='"APROVADO"' action="set" xpos='550' ypos='600' />
</true>
<false>
<assign name="ReprovaCadastral" property="context.Resultado" value='"REPROVADO"' action="set" xpos='250' ypos='600' />
</false>
</if>
</true>
<false>
<if name='ScoreComportamentalAprovado?' condition='context.Score&gt;=7' xpos='200' ypos='800' xend='200' yend='950' >
<true>
<assign name="AprovaComportamental" property="context.Resultado" value='"APROVADO"' action="set" xpos='350' ypos='900' />
</true>
<false>
<assign name="ReprovaComportamental" property="context.Resultado" value='"REPROVADO"' action="set" xpos='100' ypos='900' />
</false>
</if>
</false>
</if>
<assign name="MontaResponseIndicador" property="response.Indicador" value="context.Indicador" action="set" xpos='200' ypos='1150' />
<assign name="MontaResponseResultado" property="response.Resultado" value="context.Resultado" action="set" xpos='200' ypos='1200' />
</sequence>
</process>
}

}
