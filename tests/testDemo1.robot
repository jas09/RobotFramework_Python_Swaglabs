*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Test Cases ***
Validate Successful Login
    Open the browser with Swaglabs URL
    fill the login form
    Verify products page is displayed

*** Keywords ***
Open the browser with Swaglabs URL
    Create Webdriver    Firefox
    Go To    https://www.saucedemo.com/v1/index.html

fill the login form
    Input Text    id:user-name    standard_user
    Input Password    id:password    secret_sauce
    Click Button    login-button

Verify products page is displayed
    #${result}=    Get Text    xpath://div[text()='Products']
    #Should Be Equal As Strings    ${result}    Products
    Element Text Should Be    xpath://div[text()='Products']    Products