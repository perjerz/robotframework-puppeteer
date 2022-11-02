*** Settings ***
Suite Setup    TestLifeCycle.Default Suite Setup
Suite Teardown    TestLifeCycle.Default Suite Teardown
Test Setup    TestLifeCycle.Default Test Setup
Test Teardown    TestLifeCycle.Default Test Teardown
Resource    ../Utils/TestLifeCycle.resource
Resource  ../Pages/Home_Page.resource
Variables    ../Config/TEST_DATA_DEFAULT.yml


*** Test Cases ***
Ensure Home page should load successfully
    Wait Until Page Contains    text    