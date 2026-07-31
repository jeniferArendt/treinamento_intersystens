Class trans.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="trans.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="ProcessaPedido" Category="" ClassName="trans.BS.ProcessaPedido" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="EnableStandardRequests">true</Setting>
  </Item>
  <Item Name="Pedido BO" Category="" ClassName="trans.BO.DetalhesPedido.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesPedido BO" Category="Pedido" ClassName="trans.BO.RecupDetalhesPedidos.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesSpeedy BO" Category="Speedy" ClassName="trans.BO.DetalhesSpeedy.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcessaTransporte" Category="Transporte" ClassName="trans.BP.ProcessaTransporte.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcessaTransporteCustom" Category="Transporte" ClassName="trans.BP.ProcessaTransporteCustom.ProcessCustom" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="DetalhesCliente" Category="Cliente" ClassName="trans.BS.DetalhesCliente" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ProcessCliente" Category="Cliente" ClassName="trans.BP.DetalhesCliente.ProcessaCliente" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Dados Credito BO" Category="Credito" ClassName="Ecommerce.BO.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Avalia Credito BP" Category="Credito" ClassName="Ecommerce.BP.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Avalia Credito BS" Category="Credito" ClassName="Ecommerce.BS.AvaliaCredito" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
