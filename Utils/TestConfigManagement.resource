*** Settings ***
Variables    ../Config/TEST_DATA_DEFAULT.yml

*** Keywords ***
Load test data variables
    ${ARGS_DATA} =    Get Variable Value    ${SITE}    DEFAULT
    Import Variables    ${CURDIR}/../Config/TEST_DATA_${ARGS_DATA}.yml

Load site config variables
    ${ARGS_DATA} =    Get Variable Value    ${SITE}    DEFAULT
    Import Variables    ${CURDIR}/../Config/SITE_CONFIG_${ARGS_DATA}.yml
