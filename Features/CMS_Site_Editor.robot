*** Settings ***
Resource    ../Pages/Home_Page_CMS.resource
Resource    ../Utils/TestLifeCycle.resource
Test Setup    TestLifeCycle.Default Test Setup
Test Teardown    TestLifeCycle.Default Test Teardown

*** Variable ***
${SiteEditorButton}   css=cms-next-edit-site-button
${Dropzone}   css=cms-next-cms-edit-rendering
${Header}   css=cms-next-cms-header-container-rendering
${HeaderDropzone}   css=cms-next-cms-header-container-rendering>div.dropzone
${TemplateMenu}   css=cms-next-cms-template
${Template1}   css=div[id="6331192eb3c606ad9d32d04e"]
${DeleteButton}    css=.delete-btn
${ConfirmButton}    css=.confirm-btn
${Template1Rendering}    css=cms-next-cms-template-rendering[data-template="6331192eb3c606ad9d32d04e"]
${UpdateButton}   css=cms-next-cms-action
${SaveURL}   https://cms-api.more-commerce.com/graphql
${Spinner}   css=svg.animate-spin

*** Keywords ***

move mouse up if not in dropzone
  Mouse Move    x    y
  Element Should Be Visible    locator

drag and drop
    [Arguments]    ${source}  ${destination}
    Mouse Down    ${source}
    Mouse Over  ${destination}
    Mouse Over  ${destination}
    Sleep   1
    Wait Until Keyword Succeeds   10   1000  Element Should Not Be Visible     ${Spinner}
    Mouse Up

I go to site editor
    Wait Until Page Contains Element    ${SiteEditorButton}
    Click Element    ${SiteEditorButton}
    Wait Until Page Contains Element    ${DropZone}

I drag template1 to header
    Wait Until Page Contains Element    ${TemplateMenu}
    Click Element    ${TemplateMenu}
    Wait Until Page Contains Element    ${Template1}
    drag and drop   ${Template1}  ${HeaderDropzone}

Template1 is shown in header
    Wait Until Page Contains Element    ${Template1Rendering}  10
    Element Should Be Visible    ${Template1Rendering}

Template1 is saved
    Wait Until Page Contains Element     ${Spinner}
    Wait Until Keyword Succeeds   3   5000  Element Should Not Be Visible     ${Spinner}

I delete template1 in header
    Wait Until Page Contains Element    ${Template1Rendering}
    Mouse Over  ${Template1Rendering}
    Wait Until Page Contains Element    ${DeleteButton}
    Mouse Over   ${DeleteButton}
    Click Element    ${DeleteButton}
    Click Element  ${ConfirmButton}

Template1 is gone
    Wait Until Page Does Not Contains    ${Template1Rendering}

*** Test Cases ***
I can drop template
    Given I have logined
    And I go to site editor
    When I drag template1 to header
    Then Template1 is shown in header
    Then Template1 is saved

I can delete template1
    Given I have logined
    And I go to site editor
    When I delete template1 in header
    Then Template1 is gone

