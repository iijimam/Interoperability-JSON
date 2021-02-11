Class JSONTest.Prod Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="JSONTest.Prod" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="JSONTest.FileBO" Category="" ClassName="JSONTest.FileBO" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/ISC/temp/out/</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
  </Item>
  <Item Name="JSONTest.FileBS" Category="" ClassName="JSONTest.FileBS" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/ISC/temp/in/</Setting>
    <Setting Target="Adapter" Name="FileSpec">json.txt</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
  </Item>
</Production>
}

}
