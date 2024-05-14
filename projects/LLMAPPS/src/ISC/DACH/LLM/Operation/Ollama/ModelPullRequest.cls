Class ISC.DACH.LLM.Operation.Ollama.ModelPullRequest Extends Ens.Request
{

/// Model
Property Model As %String(VALUELIST = ",llama3:text,llama3:instruct,mistral:text,mistral:instruct,phi3");

/// Custom Model (Use for models not in list. Property 'Model' will be ignored).
Property CustomModel As %String;

Storage Default
{
<Data name="ModelPullRequestDefaultData">
<Subscript>"ModelPullRequest"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>CustomModel</Value>
</Value>
</Data>
<DefaultData>ModelPullRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
