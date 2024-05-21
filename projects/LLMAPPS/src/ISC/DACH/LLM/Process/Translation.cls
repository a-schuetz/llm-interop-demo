/// 
Class ISC.DACH.LLM.Process.Translation Extends Ens.BusinessProcessBPL
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
<property name='TranslationPrompt' type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' instantiate='0' />
<property name='LangIdPrompt' type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' instantiate='0' />
<property name='TranslationResponse' type='ISC.DACH.LLM.Operation.GenerateResponse' instantiate='0' />
<property name='LangIdResponse' type='ISC.DACH.LLM.Operation.GenerateResponse' instantiate='0' />
</context>
<sequence xend='200' yend='950' >
<call name='Prompt Identify' target='Language Detection Prompt' async='0' xpos='200' ypos='250' >
<annotation><![CDATA[Call prompt generator for language indentification]]></annotation>
<request type='ISC.DACH.LLM.Operation.Prompt.PromptRequest' >
<assign property="callrequest.InputSequence" value="request.InputSequence" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' >
<assign property="context.LangIdPrompt" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='Prompt Translate' target='Translation Prompt' async='0' xpos='200' ypos='350' >
<annotation><![CDATA[Call prompt generation BO for translation]]></annotation>
<request type='ISC.DACH.LLM.Operation.Prompt.PromptRequest' >
<assign property="callrequest.InputSequence" value="request.InputSequence" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.Prompt.PromptResponse' >
<assign property="context.TranslationPrompt" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='LLM Id' target='Ollama Local' async='1' xpos='200' ypos='450' >
<annotation><![CDATA[Call LLM Bo to identify language of input]]></annotation>
<request type='ISC.DACH.LLM.Operation.GenerateRequest' >
<assign property="callrequest.Prompt" value="context.LangIdPrompt.Prompt" action="set" languageOverride="" />
<assign property="callrequest.MaxNewTokens" value="8" action="set" languageOverride="" />
<assign property="callrequest.TopK" value="1" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.GenerateResponse' >
<assign property="context.LangIdResponse" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='LLM Translation' target='OpenAI API' async='1' xpos='200' ypos='550' >
<annotation><![CDATA[Call LLM BO to generate translation]]></annotation>
<request type='ISC.DACH.LLM.Operation.GenerateRequest' >
<assign property="callrequest.Prompt" value="context.TranslationPrompt.Prompt" action="set" languageOverride="" />
<assign property="callrequest.MaxNewTokens" value="120" action="set" languageOverride="" />
<assign property="callrequest.TopK" value="10" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Operation.GenerateResponse' >
<assign property="context.TranslationResponse" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<sync name='Wait for responses' calls='LLM Id,LLM Translation' type='all' xpos='200' ypos='650' />
<call name='Extract Translation' target='Extract Response' async='0' xpos='200' ypos='750' >
<request type='ISC.DACH.LLM.Response.Operation.ExtractRequest' >
<assign property="callrequest.ModelResponse" value="context.TranslationResponse.Response" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Response.Operation.ExtractResponse' >
<assign property="response.AppResponse" value="callresponse.ExtractedResponse" action="set" languageOverride="" />
</response>
</call>
<call name='Extract LangId' target='Extract Response' async='0' xpos='200' ypos='850' >
<request type='ISC.DACH.LLM.Response.Operation.ExtractRequest' >
<assign property="callrequest.ModelResponse" value="context.LangIdResponse.Response" action="set" languageOverride="" />
</request>
<response type='ISC.DACH.LLM.Response.Operation.ExtractResponse' >
<assign property="response.AdditionalResponses" value="callresponse.ExtractedResponse" action="set" languageOverride="" key="&quot;language&quot;" />
</response>
</call>
</sequence>
</process>
}

}
