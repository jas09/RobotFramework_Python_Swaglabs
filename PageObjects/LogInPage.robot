*** Settings ***
Documentation    All the page objects and keywords of LogInPage page
Library    SeleniumLibrary

*** Variables ***
${errorText_lockedOutUser}=    xpath://h3
${expectedErrorMessageLockedOutUser}=    Epic sadface: Sorry, this user has been locked out.


*** Keywords ***
Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Password    id:password    ${password}
    Click Button    login-button

Verify that locked out error message is displayed
    ${errorMessage}=    Get Text    ${errorText_lockedOutUser}
    Should Be Equal As Strings    ${errorMessage}    ${expectedErrorMessageLockedOutUser}
    Log    ${errorMessage}