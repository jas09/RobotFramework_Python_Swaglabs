*** Settings ***
Documentation    A resource file with reusable keywords and variables
Library    SeleniumLibrary

*** Variables ***
${standardUser}=    standard_user
${lockedOutUser}=    locked_out_user
${problemUser}=    problem_user
${performanceGlitchUser}=    performance_glitch_user
${password}=    secret_sauce
${url}=    https://www.saucedemo.com/v1/index.html
${url_loginPage}=    https://rahulshettyacademy.com/loginpagePractise/
${browser_name}=    Edge

*** Keywords ***
Open the browser with Swaglabs URL
    Create Webdriver    Firefox
    Go To    ${url}

Close Browser Session
    Close Browser
    
Wait until element passed is located on the page
    [Arguments]    ${page_locator}
    Wait Until Element Is Visible    ${page_locator}