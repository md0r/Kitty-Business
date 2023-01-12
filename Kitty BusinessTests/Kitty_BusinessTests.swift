//
//  RateMyCatTests.swift
//  RateMyCatTests
//
//  Created by Mihai Dorhan on 09.01.2023.
//

import XCTest
@testable import Kitty_Business


class test_the_login_view_model: XCTestCase {
    
    
    @MainActor func test_should_detect_empty_credentials_when_trying_to_login() async {
        
        //we are using here the actual "live" login service because it works instantly, being a mock/fake backend that I created for demo purposes for this app. It returns instantly.
        
        //in an application with a real backend, you want to use a different mock/fake/test backend service for your UNIT tests with a local db or something like that, so that you don't have to wait for a response from the actual "live" server
        let loginUserService = LoginUserService()
        let loginViewModel = LoginViewModel(loginUserService: loginUserService)
        
        //we test if we can login with empty strings
        loginViewModel.username = ""
        loginViewModel.password = ""
        
        //we test the actual method of the view model, using our fake empty strings
        await loginViewModel.validateInputAndTryToPerformLogin()
        
        //we assert that this class having empty logins, the validation message needs to be the ERROR message we have in settings
        XCTAssertEqual(loginViewModel.validationMessage, "Please check username or password.")
        
    }
    
    
    
    @MainActor func test_should_login_user_with_correct_credentials() async {
        
        let loginUserService = LoginUserService()
        let loginViewModel = LoginViewModel(loginUserService: loginUserService)
        
        //we test if we can login with the correct credentials
        loginViewModel.username = "1"
        loginViewModel.password = "1"
        
        //this variable needs to change to TRUE if the credentials are correct
        loginViewModel.navigateToNextView = false
        
        //this method tests the credentials against the backend and will change the variable to TRUE if the credentials are correct
        await loginViewModel.validateLogin()
        
        //if the credentials are correct, the @Published variable navigatetoNextView needs to change to true, in order to trigger the navigation to a new screen in the view
        XCTAssertEqual(loginViewModel.navigateToNextView, true)
        
    }
    
    
}



