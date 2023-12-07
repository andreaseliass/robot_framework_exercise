*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    http://automationexercise.com
${MENU_PRODUCTS}    //a[contains(.,' Products')]
${ALL_PRODUCTS}    //h2[@class='title text-center'][contains(.,'All Products')]
${PRODUCT_SEARCH_BAR}    search_product
${PRODUCT_SEARCH_BUTTON}    submit_search
${CONTINUE_SHOPPING}    //button[contains(@class,'btn btn-success close-modal btn-block')]

${LOGIN}    andreaengcomp@gmail.com 
${PASSWORD}    adminadmin

*** Keywords ***
Launch Browser    
    Open Browser    browser=Chrome
    Maximize Browser Window

Navigate to page
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_PRODUCTS}

Navigate To Products Page
    Click Element    locator=${MENU_PRODUCTS}
    Wait Until Element Is Visible   locator=${ALL_PRODUCTS} 

Verify Search Bar Visibility
    Element Should Be Visible    locator=${PRODUCT_SEARCH_BAR}

Search For '${PRODUCT_NAME}'
    Input Text    locator=${PRODUCT_SEARCH_BAR}    text=${PRODUCT_NAME}

Click Search Button
    Click Element    locator=${PRODUCT_SEARCH_BUTTON} 

Verify '${PRODUCT_TEXT}' Visibility
    Element Should Be Visible    locator=(//p[contains(.,'${PRODUCT_TEXT}')])[1]

Add Product To Cart
    Scroll Element Into View    locator=//a[contains(.,'(5)Biba')]
    Sleep    3s
    Click Element    locator=//div[@class='productinfo text-center']//a[@class='btn btn-default add-to-cart'][normalize-space()='Add to cart']
    Wait Until Element Is Visible    locator=${CONTINUE_SHOPPING}


Continue Shopping
    Click Button    locator=${CONTINUE_SHOPPING} 

Go To Cart
    Click Element    locator=//u[contains(.,'View Cart')]

Verify Products In Cart
    Element Should Be Visible    locator=//li[@class='active'][contains(.,'Shopping Cart')]
    Page Should Contain Element    locator=//a[contains(.,'Men Tshirt')]
    Page Should Contain Element    locator=//a[contains(.,'Stylish Dress')]


Verify Total Product Value
    #For being possible to see the total value of products it is necessary to proceed to checkout 
    #Then it's necessary to login
    Click Element    locator=//a[@class='btn btn-default check_out']
    Wait Until Element Is Visible    locator=//u[contains(.,'Register / Login')]
    Click Element    locator=//u[contains(.,'Register / Login')]
    #Login
    Wait Until Element Is Visible    locator=//h2[contains(.,'Login to your account')]
    Input Text    locator=//input[@data-qa='login-email']    text=${LOGIN}
    Input Text    locator=//input[contains(@data-qa,'login-password')]    text=${PASSWORD}
    Click Button    locator=//button[@type='submit'][contains(.,'Login')]
    Wait Until Element Is Visible    locator=(//a[@href='/view_cart'][contains(.,'Cart')])[1]
    Click Element    locator=(//a[@href='/view_cart'][contains(.,'Cart')])[1]
    Wait Until Element Is Visible    locator=//li[@class='active'][contains(.,'Shopping Cart')]
    
    ${VALOR_PROD_1}=    Get Text  locator=//*[@id="product-2"]/td[3]/p   
    ${QTD_PROD_1}=    Get Text    locator=//*[@id="product-2"]/td[4]/button
    ${PROD_1_TOTAL}=    Get Text    locator=//*[@id="product-2"]/td[5]/p

    ${valor_prod_1}=    Get Substring    ${VALOR_PROD_1}    4    
    ${valor_inteiro_prod_1}=    Convert To Integer    ${valor_prod_1}
    ${quantity_prod_1}=    Convert To Integer    ${QTD_PROD_1}
    ${result_prod_1}=    Evaluate    ${valor_inteiro_prod_1} * ${quantity_prod_1}
    ${valor_total_prod_1}=    Get Substring    ${PROD_1_TOTAL}    4 
    ${valor_int_total_prod_1}=    Convert To Integer    ${valor_total_prod_1}

    Should Be Equal As Numbers    first=${valor_int_total_prod_1}    second=${result_prod_1}

    ${VALOR_PROD_2}=    Get Text  locator=//*[@id="product-4"]/td[3]/p  
    ${QTD_PROD_2}=    Get Text    locator=//*[@id="product-4"]/td[4]/button
    ${PROD_2_TOTAL}=    Get Text    locator=//*[@id="product-4"]/td[5]/p

    ${valor_prod_2}=    Get Substring    ${VALOR_PROD_2}    4    
    ${valor_inteiro_prod_2}=    Convert To Integer    ${valor_prod_2}
    ${quantity_prod_2}=    Convert To Integer    ${QTD_PROD_2}
    ${result_prod_2}=    Evaluate    ${valor_inteiro_prod_2} * ${quantity_prod_2}
    ${valor_total_prod_2}=    Get Substring    ${PROD_2_TOTAL}    4 
    ${valor_int_total_prod_2}=    Convert To Integer    ${valor_total_prod_2}

    Should Be Equal As Numbers    first=${valor_int_total_prod_2}    second=${result_prod_2}



  