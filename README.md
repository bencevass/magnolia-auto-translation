# The problem this integration solves
Any multilingual Magnolia site that uses the single tree structure and is not completely translated will display some texts in the wrong language, when viewed in its secondary language.

# The functionality the integration provides and how it solves the problem
The idea of this integration is that these texts are translated automatically, until they are translated manually. This is achieved by REST calls to a translation service during the rendering process.

# How to install and set up the integration
The light modul auto-translation has to be placed in the resources folder for Magnolia light modules.
A prerequisite is that the Magnolia travel-demo is installed, which will then be decorated.
It has been tested with magnolia-community-demo-webapp-6.2.24-tomcat-bundle.zip
The translation service (LibreTranslate) has to be hosted locally. Please refer to the manual at https://github.com/LibreTranslate/LibreTranslate. The API at https://libretranslate.com/ can be used alternatively with an API key.

# How to use the integration
When everything is up and running, a new textImageAutoTranslate will be available in the main area of the standard page template.
Each textImageAutoTranslate will have its headline and text automatically translated, when the page is viewed in any other language than the default (and if the chosen language is supported by LibreTranslate).

Create a component
![Alt text](/../main/component-english.png?raw=true "Manually entered text in original language")

When switching language, headline and text are automatically translated
![Alt text](/../main/component-german-translated.png?raw=true "Automatically translated")
