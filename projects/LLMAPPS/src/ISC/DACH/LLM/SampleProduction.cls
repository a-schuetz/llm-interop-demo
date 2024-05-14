Class ISC.DACH.LLM.SampleProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="ISC.DACH.LLM.SampleProduction" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Pull Ollama Model" Category="" ClassName="ISC.DACH.LLM.Operation.Ollama.ModelPullOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="OllamaHost">http://ollama:11434</Setting>
  </Item>
  <Item Name="Huggingface Hub" Category="" ClassName="ISC.DACH.LLM.Operation.Huggingface.HubOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Model">NousResearch/Nous-Hermes-2-Mixtral-8x7B-DPO</Setting>
    <Setting Target="Host" Name="APICredentials">HuggingFaceToken</Setting>
    <Setting Target="Host" Name="CustomModel"></Setting>
  </Item>
  <Item Name="Llama3 Text Local" Category="" ClassName="ISC.DACH.LLM.Operation.Ollama.GenerateOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Model">llama3:text</Setting>
    <Setting Target="Host" Name="OllamaHost">http://ollama:11434</Setting>
  </Item>
  <Item Name="Llama3 Instruct Local" Category="" ClassName="ISC.DACH.LLM.Operation.Ollama.GenerateOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Model">llama3:instruct</Setting>
    <Setting Target="Host" Name="OllamaHost">http://ollama:11434</Setting>
  </Item>
  <Item Name="Mistral Text Local" Category="" ClassName="ISC.DACH.LLM.Operation.Ollama.GenerateOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Model">mistral:text</Setting>
    <Setting Target="Host" Name="OllamaHost">http://ollama:11434</Setting>
  </Item>
  <Item Name="Word Translation Prompt" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Template"><![CDATA[Pferd:horse
Stuhl:chair
laufen:to walk
<#INPUT#>:]]></Setting>
  </Item>
  <Item Name="Extract Response" Category="" ClassName="ISC.DACH.LLM.Response.Operation.ExtractOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Word Translation" Category="" ClassName="ISC.DACH.LLM.Process.WordTranslation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="LLM App Service" Category="" ClassName="ISC.DACH.LLM.Service.AppService" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">LLM App Router</Setting>
  </Item>
  <Item Name="LLM App Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">ISC.DACH.LLM.Process.AppRouter</Setting>
    <Setting Target="Host" Name="ResponseFrom">Word Translation</Setting>
    <Setting Target="Host" Name="ForwardGeneratedResponseToTargets">0</Setting>
    <Setting Target="Host" Name="ForceSyncSend">0</Setting>
  </Item>
</Production>
}

}
