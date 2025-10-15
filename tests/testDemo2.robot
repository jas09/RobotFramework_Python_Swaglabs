*** Settings ***
Documentation    To validate login form test 2
Library    SeleniumLibrary
Library    Collections
Test Setup    Open the browser with Swaglabs URL
Test Teardown    Close Browser Session
Resource    ../PageObjects/Generic.robot

*** Test Cases ***
Validate Successful Login
    fill the login form    ${standardUser}    ${password}
    Verify products page is displayed
    
Validate Locked_out_user Login
    Fill The Login Form    ${lockedOutUser}    ${password}
    Verify that locked out error message is displayed

Validate Problem_user Login
    Fill The Login Form    ${problemUser}    ${password}
    Verify products page is displayed
    Verify that products images are not displayed
    
Validate Products displayed in the Products Page
    Fill The Login Form    ${standardUser}    ${password}
    Verify products page is displayed
    verify products title in the products page
    Select the product    Sauce Labs Fleece Jacket
    

*** Keywords ***
fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    id:user-name    ${username}
    Input Password    id:password    ${password}
    Click Button    login-button

Verify products page is displayed
    #${result}=    Get Text    xpath://div[text()='Products']
    #Should Be Equal As Strings    ${result}    Products
    Element Text Should Be    xpath://div[text()='Products']    Products

Verify that locked out error message is displayed
    ${errorMessage}=    Get Text    xpath://h3
    Should Be Equal As Strings    ${errorMessage}    Epic sadface: Sorry, this user has been locked out.
    Log    ${errorMessage}
    #Element Text Should Be    xpath://*[contains(text(), 'locked out')]    Sorry, this user has been locked out.

Verify that products images are not displayed
    Element Should Be Visible    xpath://img[contains(@src, 'WithGarbageOnItToBreakTheUrl')]    Images are not visible for problem user

verify products title in the products page
    @{expectedList}=    Create List    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
    ${elements}=    Get Webelements    css:.inventory_item_name
    @{actualList}=    Create List
    FOR    ${element}    IN    @{elements}
        log    ${element.text}
        Append To List    ${actualList}    ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${actualList}
    
Select the product
    [Arguments]    ${productName}
    ${elements}=    Get Webelements    css:.inventory_item_name
    ${index}=    Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${productName}' == '${element.text}'
        ${index}=    Evaluate    ${index} + 1
    END
    Click Button    xpath:(//*[@class='pricebar'])[${index}]/button

