Class ISC.DACH.LLM.Operation.Ollama.OllamaResponse Extends ISC.DACH.LLM.Operation.GenerateResponse
{

Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = 200);

Property CreatedAt As %String(%JSONFIELDNAME = "created_at", MAXLEN = "");

Property Response As %String(%JSONFIELDNAME = "response", MAXLEN = "");

Property Done As %Boolean(%JSONFIELDNAME = "done");

Property DoneReason As %String(%JSONFIELDNAME = "done_reason", MAXLEN = "");

Property TotalDuration As %Integer(%JSONFIELDNAME = "total_duration");

Property LoadDuration As %Integer(%JSONFIELDNAME = "load_duration");

Storage Default
{
<Data name="GenerateResponseDefaultData1">
<Subscript>"GenerateResponse1"</Subscript>
<Value name="1">
<Value>Done</Value>
</Value>
<Value name="2">
<Value>DoneReason</Value>
</Value>
<Value name="3">
<Value>Context</Value>
</Value>
<Value name="4">
<Value>TotalDuration</Value>
</Value>
<Value name="5">
<Value>LoadDuration</Value>
</Value>
<Value name="6">
<Value>PromptEvalCount</Value>
</Value>
<Value name="7">
<Value>PromptEvalDuration</Value>
</Value>
<Value name="8">
<Value>EvalCount</Value>
</Value>
<Value name="9">
<Value>EvalDuration</Value>
</Value>
<Value name="10">
<Value>CreatedAt</Value>
</Value>
</Data>
<DefaultData>GenerateResponseDefaultData1</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
