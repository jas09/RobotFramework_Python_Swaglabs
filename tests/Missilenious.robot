*** Settings ***
Documentation    Miscellaneous functionalities Validation Test
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    ../PageObjects/Generic.robot
*** Test Cases ***
Select the form and navigate to child window
    Navigate to LoginPage Url
    Fill the login details and select user option

Validate Child Window Functionality
    Select the link of child window
    Verify the user is switched to child window
    Grab the Email ID in the child window
    Switch to parent window and enter the email

*** Keywords ***
Navigate to LoginPage Url
    Create Webdriver    Edge
    #${options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()
    #Call Method    ${options}    add_argument    --headless
    #Create Webdriver    Firefox    options=${options}
    Go To    ${url_loginPage}

Fill the login details and select user option
    Input Text    id:username    rahulshettyacademy
    Input Password    id:password    learning
    Click Element    css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body
    Click Button    id:okayBtn
    Click Button    id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms
    Element Should Be Visible    css:.blinkingText
    #Click Button    signInBtn

Select the link of child window
    Click Element    xpath://a[contains(text(),'ResumeAssistance')]
    Sleep    3

Verify the user is switched to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST
    
Grab the Email ID in the child window
    ${text}=    Get Text    css:.red
    @{words}=    Split String    ${text}    at
    ${text_split}=    Get From List    ${words}    1
    Log    ${text_split}
    @{words_2}=    Split String    ${text_split}    
    ${email}=    Get From List    ${words_2}    0
    Set Global Variable    ${email}

Switch to parent window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}





    