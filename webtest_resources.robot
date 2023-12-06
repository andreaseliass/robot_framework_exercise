*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://automationexercise.com
${MENU_PRODUCTS}    //a[contains(.,' Products')]
${ALL_PRODUCTS}    //h2[@class='title text-center'][contains(.,'All Products')]
${PRODUCT_SEARCH_BAR}    search_product
${PRODUCT_SEARCH_BUTTON}    submit_search
${CONTINUE_SHOPPING}    //button[contains(@class,'btn btn-success close-modal btn-block')]

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
    
