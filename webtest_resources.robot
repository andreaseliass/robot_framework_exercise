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
${SCROLL}    //a[contains(.,'(5)Biba')]
${ADD_TO_CART}    //div[@class='productinfo text-center']//a[@class='btn btn-default add-to-cart'][normalize-space()='Add to cart']
${CART_BUTTON}    //u[contains(.,'View Cart')]
${CART_PAGE}    //li[@class='active'][contains(.,'Shopping Cart')]
${CHECKOUT}    //a[@class='btn btn-default check_out']
${LOGIN_BUTTON}    //u[contains(.,'Register / Login')]
${LOGIN_PAGE}    //h2[contains(.,'Login to your account')]
${LOGIN_FIELD}    //input[@data-qa='login-email']
${LOGIN}    andreaengcomp@gmail.com 
${PASSWORD_FIELD}    //input[contains(@data-qa,'login-password')]
${PASSWORD}    adminadmin
${LOGIN_LINK}    //button[@type='submit'][contains(.,'Login')]
${CART_MENU}    (//a[@href='/view_cart'][contains(.,'Cart')])[1]
${REVIEW_ORDER}    //h2[@class='heading'][contains(.,'Review Your Order')]

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
    Scroll Element Into View    locator=${SCROLL}
    Sleep    3s
    Click Element    locator=${ADD_TO_CART}
    Wait Until Element Is Visible    locator=${CONTINUE_SHOPPING}


Continue Shopping
    Click Button    locator=${CONTINUE_SHOPPING} 

Go To Cart
    Click Element    locator=${CART_BUTTON}

Verify Products In Cart
    Element Should Be Visible    locator=${CART_PAGE}
    Page Should Contain Element    locator=//a[contains(.,'Men Tshirt')]
    Page Should Contain Element    locator=//a[contains(.,'Stylish Dress')]


Verify Total Product Value
    #For being possible to see the total value of products it is necessary to proceed to checkout 
    #Then it's necessary to login
    Click Element    locator=${CHECKOUT}
    Wait Until Element Is Visible    locator=${LOGIN_BUTTON}
    Click Element    locator=${LOGIN_BUTTON}
    #Login
    Wait Until Element Is Visible    locator=${LOGIN_PAGE}
    Input Text    locator=${LOGIN_FIELD}    text=${LOGIN}
    Input Text    locator=${PASSWORD_FIELD}    text=${PASSWORD}
    Click Button    locator=${LOGIN_LINK}
    Wait Until Element Is Visible    locator=${CART_MENU}
    Click Element    locator=${CART_MENU}
    Wait Until Element Is Visible    locator=${CHECKOUT}
    Click Element    locator=${CHECKOUT}
    Wait Until Element Is Visible    locator=${REVIEW_ORDER}

    #Verifying values and asserting results of first product:
    ${VALUE_PROD_1}=    Get Text  locator=//*[@id="product-2"]/td[3]/p   
    ${QTD_PROD_1}=    Get Text    locator=//*[@id="product-2"]/td[4]/button
    ${PROD_1_TOTAL}=    Get Text    locator=//*[@id="product-2"]/td[5]/p

    ${value_prod_1}=    Get Substring    ${VALUE_PROD_1}    4    
    ${value_integer_prod_1}=    Convert To Integer    ${value_prod_1}
    ${quantity_prod_1}=    Convert To Integer    ${QTD_PROD_1}
    ${result_prod_1}=    Evaluate    ${value_integer_prod_1} * ${quantity_prod_1}

    ${value_total_prod_1}=    Get Substring    ${PROD_1_TOTAL}    4 
    ${value_int_total_prod_1}=    Convert To Integer    ${value_total_prod_1}

    Should Be Equal As Numbers    first=${value_int_total_prod_1}    second=${result_prod_1}
    
    #Verifying values and asserting results of second product:
    ${VALUE_PROD_2}=    Get Text  locator=//*[@id="product-4"]/td[3]/p  
    ${QTD_PROD_2}=    Get Text    locator=//*[@id="product-4"]/td[4]/button
    ${PROD_2_TOTAL}=    Get Text    locator=//*[@id="product-4"]/td[5]/p

    ${value_prod_2}=    Get Substring    ${VALUE_PROD_2}    4    
    ${value_integer_prod_2}=    Convert To Integer    ${value_prod_2}
    ${quantity_prod_2}=    Convert To Integer    ${QTD_PROD_2}
    ${result_prod_2}=    Evaluate    ${value_integer_prod_2} * ${quantity_prod_2}

    ${value_total_prod_2}=    Get Substring    ${PROD_2_TOTAL}    4 
    ${value_int_total_prod_2}=    Convert To Integer    ${value_total_prod_2}

    Should Be Equal As Numbers    first=${value_int_total_prod_2}    second=${result_prod_2}

    #Verifying values and asserting result of total amount:
    ${TOTAL_AMOUNT}=    Get Text  locator=//*[@id="cart_info"]/table/tbody/tr[3]/td[4]/p 
    ${Total_amount_prods}=    Get Substring    ${TOTAL_AMOUNT}    4  
    ${total_value_integer}=    Convert To Integer    ${Total_amount_prods}
    ${Total_Result_Amount}=    Evaluate    ${result_prod_1} + ${result_prod_2}
    Should Be Equal As Numbers    first=${Total_Result_Amount}    second=${total_value_integer}

    # Log    O total do prod 1 é: ${result_prod_1} o total do prod 2 é: ${result_prod_2} e o valor total é: ${total_value_integer}


  