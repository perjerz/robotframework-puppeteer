*** Settings ***
Resource    ../Pages/Home_Page_More_Commerce.resource
Resource    ../Utils/TestLifeCycle.resource
Test Setup    TestLifeCycle.Default Test Setup
Test Teardown    TestLifeCycle.Default Test Teardown
Library    String

*** Variables ***
${FirstAudience}    id=audience-button-0
${ChatboxTextArea}  id=chatbox-textarea
${ChatboxSendButton}    id=chatbox-send-button
${MessageText}    Message From RobotFramework
${ExpectedMessageText}    Expected

${NoteTextArea}    id=customer-note-input
${NoteText}    Note From Robotframework
${ExpectedNoteText}    Expected
${AddNoteButton}    id=customer-note-add
${DeleteNote}  id=customer-note-delete-0
${OKButton}    css:.btn-ok

${ChatboxAddTagButton}    id=chatbox-add-tag
${TagTab}    id=mat-tab-label-0-1
${AddTag}    id=customer-tag-add-0
${SaveAddTagButton}    id=customer-tag-save-button
${Chips}    css:mat-chip
${DeleteTag}    id:customer-tag-0
${ChipCount}    0

${Timeout}    5

*** Keywords ***
Create Unique Text
    [Arguments]    ${arg}
    ${RandomString} =    Generate Random String    8
    [Return]    ${arg} ${RandomString}

I select first audience
    Wait Until Page Contains Element    ${FirstAudience}
    Click Element    ${FirstAudience}

I send message
    ${ExpectedMessageText} =   Create Unique Text    ${MessageText}
    Input Text    ${ChatboxTextArea}    ${ExpectedMessageText}
    Click Button    ${ChatboxSendButton}
    Set Suite Variable    ${ExpectedMessageText}

Message has been sent
    Wait Until Page Contains    ${ExpectedMessageText}    ${Timeout}

I add note
    Wait Until Page Contains Element    ${NoteTextArea}    ${Timeout}
    ${ExpectedNoteText} =    Create Unique Text    ${NoteText}
    Input Text      ${NoteTextArea}    ${ExpectedNoteText}
    Click Button    ${AddNoteButton}
    Set Suite Variable    ${ExpectedNoteText}

Note has been added
    Wait Until Page Contains    ${ExpectedNoteText}    ${Timeout}

I delete note
    Click Element    ${DeleteNote}

I confirm
    Press Keys    ${OKButton}    Enter
    # Click Element    ${OKButton}

Note has been deleted
    Wait Until Page Does Not Contains    ${ExpectedNoteText}    30

I select tag & note tab
    Click Element    ${TagTab}

I add tag
    Click Button    ${ChatboxAddTagButton}
    ${ChipCount}  Get Element Count    ${Chips}
    Click Element    ${AddTag}
    Set Suite Variable    ${ChipCount}

I save added tag
    Click Button    ${SaveAddTagButton}

Tag has been added
    ${ChipCountAfter}  Get Element Count    ${Chips}
    ${Expected}    Convert To Integer    ${ChipCount}
    Should Be Equal    ${Expected+1}    ${ChipCountAfter}

I delete tag
    ${ChipCount}  Get Element Count    ${Chips}
    Click Element     ${DeleteTag}

Tag has been deleted
    ${ChipCountAfter}  Get Element Count    ${Chips}
    ${Expected}    Convert To Integer    ${ChipCount}
    Should Be Equal    ${ChipCount}    ${ChipCountAfter}

*** Test Cases ***
User can send message
    Given I have logined
    And I select first audience
    When I send message
    Then Message has been sent

User can add note
    Given I have logined
    And I select first audience
    And I select tag & note tab
    When I add note
    Then Note has been added

User can delete note
    Given I have logined
    And I select first audience
    And I select tag & note tab
    And I add note
    When I delete note
    And I confirm
    Then Note has been deleted

User can add tag
    Given I have logined
    And I select first audience
    And I select tag & note tab
    When I add tag
    And I save added tag
    Then Tag has been added

User can delete tag
    Given I have logined
    And I select first audience
    And I select tag & note tab
    And I add tag
    And I save added tag
    When I delete tag
    Then Tag has been deleted
