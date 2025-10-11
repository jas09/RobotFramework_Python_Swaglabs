*** Settings ***
Documentation    All the page objects and keywords of Your Information page
Library    SeleniumLibrary

*** Variables ***
${FirstName}=    first-name
${LastName}=    last-name
${PostalCode}=    postal-code
${continueButton}=    css:input[type='submit']

*** Keywords ***
Provide buyer details and click on continue
    [Arguments]    ${firstname}    ${lastname}    ${postalcode}
    Input Text    first-name    ${firstname}
    Input Text    last-name    ${lastname}
    Input Text    postal-code    ${postalcode}
    Click Element    ${continueButton}

