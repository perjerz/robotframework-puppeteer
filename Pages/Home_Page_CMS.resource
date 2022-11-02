*** Settings ***
Library    PuppeteerLibrary

*** Variables ***
${Login_Test.URL}   https://cms.more-commerce.com/login-test
${Login_Button}  id=login-button-3
${Browser}  Chrome


*** Keywords ***
Wait for login test page load
    Wait Until Page Contains Element   ${Login_Button}
Bypass Login
    Click Element    ${Login_Button}
I have logined
    Wait for login test page load
    ByPass Login
