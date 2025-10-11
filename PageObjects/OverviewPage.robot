*** Settings ***
Documentation    All the page objects and keywords of Overview page
Library    SeleniumLibrary

*** Variables ***
${finishButton}=    xpath://a[text()='FINISH']
${total}=    css:.summary_total_label
${itemTotal}=    css:.summary_subtotal_label
${tax}=    css:.summary_tax_label
${orderSuccessMessage}=    css:h2


*** Keywords ***

Click on Finish and verify order success message
    Click Element    ${finishButton}
    Element Text Should Be    ${orderSuccessMessage}    THANK YOU FOR YOUR ORDER
    
    


