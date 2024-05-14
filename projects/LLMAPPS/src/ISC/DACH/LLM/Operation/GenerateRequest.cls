Class ISC.DACH.LLM.Operation.GenerateRequest Extends Ens.Request
{

/// Input prompt.
Property Prompt As %String(MAXLEN = "");

/// Max number of tokens/words to predict.
Property MaxNewTokens As %Integer [ InitialExpression = 50 ];

/// Top K tokens to sample from.
Property TopK As %Integer [ InitialExpression = 40 ];

/// Top P threshold. Samples from tokens with the highest probability scores until threshold is reached.
Property TopP As %Float [ InitialExpression = 0.9 ];

Storage Default
{
<Data name="GenerateRequestDefaultData">
<Subscript>"GenerateRequest"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
<Value name="2">
<Value>MaxNewTokens</Value>
</Value>
<Value name="3">
<Value>TopK</Value>
</Value>
<Value name="4">
<Value>TopN</Value>
</Value>
<Value name="5">
<Value>TopP</Value>
</Value>
</Data>
<DefaultData>GenerateRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
