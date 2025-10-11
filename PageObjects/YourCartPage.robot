*** Settings ***
Documentation    All the page objects and keywords of Your Cart page
Library    SeleniumLibrary

*** Variables ***
${continueShopping}=    xpath://a[text()='Continue Shopping']
${checkOut}=    xpath://a[text()='CHECKOUT']
${Products}=    xpath://div[text()='Products']
*** Keywords ***

Verify that user is navigated back to products Page after selecting "Continue Shopping"
    Click Element    ${continueShopping}
    Element Text Should Be    ${Products}    Products

Click on Checkout and navigate to Your Information page
    Click Element    ${checkOut}

