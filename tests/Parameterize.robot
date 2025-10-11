*** Settings ***
Documentation    Login on Multiple username and password combination
Library    SeleniumLibrary
Test Setup    Open the browser with the mortgage payment url
Test Template    Validate Unsuccessful Login
Test Teardown    Close Browser

*** Variables ***
${Error_Message_Login}    css:.alert-danger
*** Test Cases ***    username    password
Invalid username    asasa    learning
Invalid password    rahulshettyacademy    21321
Special characters    %^*    learning

*** Keywords ***
Validate Unsuccessful Login
    [Arguments]    ${username}    ${password}
    Fill the login form    ${username}    ${password}
    wait until it checks and display error message
    verify error message is correct

Open the browser with the mortgage payment url
    Create Webdriver    Firefox
    Go To    https://rahulshettyacademy.com/loginpagePractise/

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    username    ${username}
    Input Text    password    ${password}
    Click Button    signInBtn

wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}

verify error message is correct
    #${result}=    Get Text    ${Error_Message_Login}
    #Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.