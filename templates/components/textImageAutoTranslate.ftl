[#-------------- INCLUDE AND ASSIGN PART --------------]
[#include "/mtk2/templates/includes/init.ftl"]
[#-- Image --]
[#-- Basic positioning of an image below or above the text --]
[#assign imagePosition = content.imagePosition!"below"]

[#-- CSS default --]
[#if !divClass?has_content]
    [#assign divClass = "text-section"]
[/#if]

[#-- Image css classes --]
[#assign hasImage = false]
[#assign imageHtml = ""]

[#if content.image?has_content]
    [#assign hasImage = true]
    [#assign divClass = "${divClass} text-image-section"]
    [#assign imageClass = "content-image-${imagePosition}"]
    [#assign rendition = damfn.getRendition(content.image, "original")]
    [#include "/travel-demo/templates/macros/imageResponsive.ftl"]
    [#assign imageHtml][@imageResponsive rendition content imageClass false def.parameters /][/#assign]
[/#if]

[#assign translate = false /]
[#assign autoTranslate = true /]
[#-- autoTranslate could be turned on or off in site config, rootPage, ... --]
[#assign defaultLanguage = sitefn.site().i18n.defaultLocale.language /]
[#assign currentLanguage = cmsfn.language()?keep_before("_") /]
[#if autoTranslate && currentLanguage != defaultLanguage]
    [#assign possibleLanguages = restfn.call("libreTranslate", "languages") /]
    [#list possibleLanguages.iterator() as pl]
        [#if pl.code?remove_beginning("\"")?remove_ending("\"") == currentLanguage]
            [#assign translate = true /]
            [#break]
        [/#if]
    [/#list]
[/#if]


[#-------------- RENDERING PART --------------]
[#-- Rendering: Text/Image item --]
<div class="${divClass!}"${divID!}>

    [#-- Headline --]
    [#if content.headline?has_content]
        [#assign headline = content.headline /]
        [#-- TODO find better to way to check if content has been manually translated --]
        [#if translate && !content['headline_'+currentLanguage]?has_content]
            [#assign headlineRest = restfn.call("libreTranslate", "translate", { "q": content.headline, "format": "text", "source": defaultLanguage, "target": currentLanguage })!'' /]
            [#-- TODO error handling --]
            [#if headlineRest.translatedText?has_content]
                [#assign headline = headlineRest.translatedText?remove_beginning("\"")?remove_ending("\"") /]
            [/#if]
        [/#if]
        <${headlineLevel}>${headline!}</${headlineLevel}>
    [/#if]

    [#-- Image above text --]
    [#if hasImage && imagePosition == "above"]
        ${imageHtml}
    [/#if]

    [#-- Text --]
    [#if content.text?has_content]
        [#assign text = cmsfn.decode(content).text /]
        [#-- TODO find better to way to check if content has been manually translated --]
        [#if translate && !content['text_'+currentLanguage]?has_content]
            [#assign textRest = restfn.call("libreTranslate", "translate", { "q": (cmsfn.decode(content).text)?js_string, "format": "html", "source": defaultLanguage, "target": currentLanguage })!'' /]
            [#-- TODO error handling --]
            [#if textRest.translatedText?has_content]
                [#assign text = textRest.translatedText?remove_beginning("\"")?remove_ending("\"") /]
            [/#if]
        [/#if]
        ${text!}
    [/#if]

    [#-- Image below text --]
    [#if hasImage && imagePosition == "below"]
        ${imageHtml}
    [/#if]

</div><!-- end ${divClass} -->
