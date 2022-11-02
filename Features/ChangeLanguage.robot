*** Settings ***
Resource    ../Pages/Home_Page_More_Commerce.resource
Resource    ../Utils/TestLifeCycle.resource
Test Setup    TestLifeCycle.Default Test Setup
Test Teardown    TestLifeCycle.Default Test Teardown

*** Variable ***
${LanguageButton}   css=.language
${EnglishLangaugeToggleSVG}  css=.language

*** Keywords ***
I change language
    Wait Until Page Contains Element    ${LanguageButton}
    Click Element    ${LanguageButton}
Language has been changed
    Element Should Be Visible    ${EnglishLangaugeToggleSVG}

*** Test Cases ***
I can change language
    Given I have logined
    When I change language
    Then Language has been changed
