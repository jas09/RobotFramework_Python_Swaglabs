*** Settings ***
Documentation    To validate login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Products.py    WITH NAME    Products
Library    ../customLibraries/YourCart.py    WITH NAME    YourCart
Library    ../customLibraries/Overview.py    WITH NAME    Overview
Test Setup    Open the browser with Swaglabs URL
Test Teardown    Close Browser Session
Resource    ../PageObjects/Generic.robot
Resource    ../PageObjects/LogInPage.robot
Resource    ../PageObjects/ProductsPage.robot
Resource    ../PageObjects/YourCartPage.robot
Resource    ../PageObjects/InformationPage.robot
Resource    ../PageObjects/OverviewPage.robot

*** Variables ***
@{listOfProducts}    Sauce Labs Onesie    Sauce Labs Bike Light    Test.allTheThings() T-Shirt (Red)

*** Test Cases ***
Validate Successful Login
    [Tags]    SMOKE
    LogInPage.Fill the login form    ${standardUser}    ${password}
    ProductsPage.Verify products page is displayed

Validate Locked_out_user Login
    [Tags]    NEW_FEATURE
    LogInPage.Fill The Login Form    ${lockedOutUser}    ${password}
    LogInPage.Verify that locked out error message is displayed

Validate Problem_user Login
    [Tags]    SMOKE
    LogInPage.Fill The Login Form    ${problemUser}    ${password}
    ProductsPage.Verify products page is displayed
    ProductsPage.Verify that products images are not displayed
    
Validating End to End Flow till successful product placement
    [Tags]    REGRESSION    SMOKE
    LogInPage.Fill The Login Form    ${standardUser}    ${password}
    ProductsPage.Verify products page is displayed
    ProductsPage.verify products title in the products page
    ProductsPage.Apply Sort (Low to High) and verify ordering changes accordingly
    Products.Add Products To Cart And Checkout    ${listOfProducts}
    YourCart.Verify Products In YourCart
    YourCartPage.Click on Checkout and navigate to Your Information page
    InformationPage.Provide buyer details and click on continue    Azharulla    Mohammed    560036
    Overview.Verify Products In OverviewPage
    Click on Finish and verify order success message



*** Keywords ***





