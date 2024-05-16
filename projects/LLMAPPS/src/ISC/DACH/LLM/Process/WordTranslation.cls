/// 
Class ISC.DACH.LLM.Process.WordTranslation Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='ISC.DACH.LLM.Msg.LLMAppRequest' response='ISC.DACH.LLM.Msg.LLMAppResponse' height='2000' width='2000' >
<context>
<property name='PromptResponse' type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' instantiate='0' />
<property name='ModelResponse' type='ISC.DACH.LLM.Operation.GenerateResponse' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<call name='Prompt' target='Word Translation Prompt' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[Call prompt generation BO]]></annotation>
<request type='ISC.DACH.LLM.Operation.Prompt.PromptRequest' >
<assign property="callrequest.InputSequence" value="request.InputSequence" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' >
<assign property="context.PromptResponse" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='LLM' target='Ollama Local' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Call LLM BO to generate output]]></annotation>
<request type='ISC.DACH.LLM.Operation.GenerateRequest' >
<assign property="callrequest.Prompt" value="context.PromptResponse.Prompt" action="set" languageOverride="" />
<assign property="callrequest.MaxNewTokens" value="10" action="set" languageOverride="" />
<assign property="callrequest.TopK" value="1" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.GenerateResponse' >
<assign property="context.ModelResponse" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='Extract' target='Extract Response' async='0' xpos='200' ypos='450' >
<request type='ISC.DACH.LLM.Response.Operation.ExtractRequest' >
<assign property="callrequest.ModelResponse" value="context.ModelResponse.Response" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Response.Operation.ExtractResponse' >
<assign property="response.AppResponse" value="callresponse.ExtractedResponse" action="set" languageOverride="" />
</response>
</call>
</sequence>
</process>
}

}
