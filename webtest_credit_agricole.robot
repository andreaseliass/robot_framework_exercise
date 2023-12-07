*** Settings ***
Documentation    Testing the automationexercise.com website
Resource         webtest_resources.robot
Test Setup       Launch Browser
Test Teardown    Close Browser


*** Test Cases ***
Exercise Test
    [Documentation]    Testing features of the store
    [Tags]             cart products
    Navigate to page
    Navigate To Products Page
    Verify Search Bar Visibility
    Search For 'men tshirt'
    Click Search Button
    Verify 'Men Tshirt' Visibility
    Add Product To Cart
    Continue Shopping
    Search For 'Stylish Dress'
    Click Search Button
    Add Product To Cart
    Go To Cart
    Verify Products In Cart
    Verify Total Product Value

