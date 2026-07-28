Class trans.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="trans.Production" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Pedido BO" Category="" ClassName="trans.BO.DetalhesPedido.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesPedido BO" Category="" ClassName="trans.BO.RecupDetalhesPedidos.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesSpeedy BO" Category="" ClassName="trans.BO.DetalhesSpeedy.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcessaTransporte" Category="" ClassName="trans.BP.ProcessaTransporte.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
