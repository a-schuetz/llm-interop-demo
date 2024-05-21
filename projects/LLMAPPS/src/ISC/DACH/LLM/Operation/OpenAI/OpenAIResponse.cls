Class ISC.DACH.LLM.Operation.OpenAI.OpenAIResponse Extends ISC.DACH.LLM.Operation.GenerateResponse
{

Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = 200);

Property Created As %Integer(%JSONFIELDNAME = "created");

Property Response As %String(%JSONFIELDNAME = "response", MAXLEN = "");

Property FinishReason As %String(%JSONFIELDNAME = "finish_reason", MAXLEN = "");

Property CompletionTokens As %Integer(%JSONFIELDNAME = "completion_tokens");

Property PromptTokens As %Integer(%JSONFIELDNAME = "prompt_tokens");

Property TotalTokens As %Integer(%JSONFIELDNAME = "total_tokens");

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
<Value name="11">
<Value>Created</Value>
</Value>
<Value name="12">
<Value>FinishReason</Value>
</Value>
<Value name="13">
<Value>CompletionTokens</Value>
</Value>
<Value name="14">
<Value>PromptTokens</Value>
</Value>
<Value name="15">
<Value>TotalTokens</Value>
</Value>
</Data>
<DefaultData>GenerateResponseDefaultData1</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
