*** Settings ***
Library    PuppeteerLibrary
Resource    ./TestConfigManagement.resource
Variables    ../Config/TEST_DATA_DEFAULT.yml
Variables    ../Config/SITE_CONFIG_DEFAULT.yml


*** Keywords ***
Default Suite Setup
    Load test data variables
    Load site config variables

Default Suite Teardown
    Close Puppeteer

Default Test Setup
    &{options} =    create dictionary    headless=${False}
    Open Browser    ${HOME_CMS_URL}    options=${options}

Default Test Teardown
    Close All Browser
