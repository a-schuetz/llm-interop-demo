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
  <Item Name="Ollama Local" Category="" ClassName="ISC.DACH.LLM.Operation.Ollama.OllamaOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Model">llama3:text</Setting>
    <Setting Target="Host" Name="OllamaHost">http://ollama:11434</Setting>
    <Setting Target="Host" Name="FailureTimeout">300</Setting>
  </Item>
  <Item Name="Extract Response" Category="" ClassName="ISC.DACH.LLM.Operation.Response.ExtractOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="LLM App Service" Category="" ClassName="ISC.DACH.LLM.Service.AppService" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">LLM App Router</Setting>
  </Item>
  <Item Name="LLM App Router" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">ISC.DACH.LLM.Process.AppRouter</Setting>
    <Setting Target="Host" Name="ResponseFrom">Translate To English,Sentiment Analysis,Unknown App Hanlder,Chatbot</Setting>
    <Setting Target="Host" Name="ForwardGeneratedResponseToTargets">0</Setting>
    <Setting Target="Host" Name="ForceSyncSend">0</Setting>
    <Setting Target="Host" Name="FailureTimeout">120</Setting>
  </Item>
  <Item Name="Translation Prompt" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Template"><![CDATA[Translate to English.
La marine américaine a également déclaré qu'elle enquêtait sur l'incident.:The US Navy also said it was investigating the incident.
Direkt am Flussufer steht das blaue Haus.:The blue house stands directly on the riverbank.
Il cane corre sul prato.:The dog runs on the lawn.
<#INPUT#>:]]></Setting>
  </Item>
  <Item Name="Language Detection Prompt" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.AdvancedPromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Template">Hallo `n
Test</Setting>
    <Setting Target="Host" Name="SampleClass">ISC.DACH.LLM.TestSampleClass</Setting>
    <Setting Target="Host" Name="SampleIDs">1-6</Setting>
    <Setting Target="Host" Name="SampleLabelProperty">Lang</Setting>
    <Setting Target="Host" Name="SampleTextProperty">Text</Setting>
    <Setting Target="Host" Name="PromptHeader">What is the language of the input?</Setting>
  </Item>
  <Item Name="Translate To English" Category="" ClassName="ISC.DACH.LLM.Process.Translation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
  </Item>
  <Item Name="Sentiment Prompt" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Placeholder"><![CDATA[<#INPUT#>]]></Setting>
    <Setting Target="Host" Name="Template"><![CDATA[Answer using only positive, neutral or negative. What is the sentiment of the following statement:
<#INPUT#>]]></Setting>
  </Item>
  <Item Name="Unknown App Hanlder" Category="" ClassName="ISC.DACH.LLM.Process.UnknownAppHandler" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Sentiment Analysis" Category="" ClassName="ISC.DACH.LLM.Process.SentimentAnalysis" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Chatbot Prompt" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Template"><![CDATA[You are a chatbot named Bob. Try to answer as helpful as possible.

Bob: Hi, I am a Chatbot and I am here to assist you.
User: That is nice, thank you.
Bob: You're welcome! So what can I do for you?
User: <#INPUT#>
Bob:]]></Setting>
  </Item>
  <Item Name="Chatbot" Category="" ClassName="ISC.DACH.LLM.Process.Chatbot" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Chatbot Prompt Mean" Category="" ClassName="ISC.DACH.LLM.Operation.Prompt.SimplePromptOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Template"><![CDATA[You are a mean chatbot named Bob. Try to answer as mean as possible.

Bob: Hi, I'm bob and I don't want to help you.
User: Wow, that's mean. Why are you that mean?.
Bob: I don't care.
User: <#INPUT#>
Bob:]]></Setting>
  </Item>
  <Item Name="OpenAI API" Category="" ClassName="ISC.DACH.LLM.Operation.OpenAI.APIOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="OrganizationCredentials">OpenAIOrganization</Setting>
    <Setting Target="Host" Name="ProjectCredentials">OpenAIProject</Setting>
    <Setting Target="Host" Name="Model">gpt-3.5-turbo</Setting>
  </Item>
</Production>
}

}
