*** Settings ***
Documentation    All the page objects and keywords of Products page
Library    SeleniumLibrary
Library    Collections
Resource    ../PageObjects/Generic.robot
Library    ../customLibraries/Products.py

*** Variables ***
${Products}=    xpath://div[text()='Products']
${noImages}=    xpath://img[contains(@src, 'WithGarbageOnItToBreakTheUrl')]
${basket}=    xpath://a[@href='./cart.html']
${productNames}=    css:.inventory_item_name
${yourCart}=    xpath://div[text()='Your Cart']
${sortOptions}=    css:.product_sort_container
${productPrice}=    css:.inventory_item_price

*** Keywords ***
Verify products page is displayed
    #${result}=    Get Text    xpath://div[text()='Products']
    #Should Be Equal As Strings    ${result}    Products
    Element Text Should Be    ${Products}    Products
    
Verify that products images are not displayed
    Wait until element passed is located on the page    ${noImages}
    
verify products title in the products page
    @{expectedList}=    Create List    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Sauce Labs Fleece Jacket    Sauce Labs Onesie    Test.allTheThings() T-Shirt (Red)
    ${elements}=    Get Webelements    ${productNames}
    @{actualList}=    Create List
    FOR    ${element}    IN    @{elements}
        log    ${element.text}
        Append To List    ${actualList}    ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${actualList}
    
Apply Sort (Low to High) and verify ordering changes accordingly
    @{expectedSortedList_lowToHigh}=    Create List    Sauce Labs Onesie    Sauce Labs Bike Light    Sauce Labs Bolt T-Shirt    Test.allTheThings() T-Shirt (Red)    Sauce Labs Backpack    Sauce Labs Fleece Jacket
    Select From List By Value    ${sortOptions}    lohi