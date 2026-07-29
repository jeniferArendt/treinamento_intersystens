Class trans.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="trans.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Pedido BO" Category="" ClassName="trans.BO.DetalhesPedido.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesPedido BO" Category="Pedido" ClassName="trans.BO.RecupDetalhesPedidos.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesSpeedy BO" Category="Speedy" ClassName="trans.BO.DetalhesSpeedy.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcessaTransporte" Category="Transporte" ClassName="trans.BP.ProcessaTransporte.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
