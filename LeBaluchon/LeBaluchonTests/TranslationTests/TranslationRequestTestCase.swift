//
//  TranslationRequestTestCase.swift
//  LeBaluchonTests
//
//  Created by Fabrice Ortega on 09/12/2020.
//

import XCTest
@testable import LeBaluchon

class TranslationRequestTestCase: XCTestCase {
    
    func testGetAPIShouldPostAnErrorifError(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: nil, response: nil, error: FakeResponseDataTranslation.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let translation):
                XCTAssertNil(translation)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifNoData(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let translation):
                XCTAssertNil(translation)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectResponse(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: FakeResponseDataTranslation.APICorrectData, response: FakeResponseDataTranslation.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let translation):
                XCTAssertNotNil(translation)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldNotPostAnErrorifCorrectResponse(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: FakeResponseDataTranslation.APICorrectData, response: FakeResponseDataTranslation.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let translation):
                XCTAssertNotNil(translation)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldPostAnErrorifIncorrectData(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: FakeResponseDataTranslation.APIIncorrectData, response: FakeResponseDataTranslation.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success(let translation):
                XCTAssertNotNil(translation)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAPIShouldBeSuccessfullWhenAllIsCorrect(){
        var myAPI = TranslationRequest(session: URLSessionFake(data: FakeResponseDataTranslation.APICorrectData, response: FakeResponseDataTranslation.responseOK, error: nil))
        
        // Build the expected result
        let translationList = LeBaluchon.TranslateAPI(data: LeBaluchon.Data(translations: [LeBaluchon.Translations(translatedText: "Salut")]))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        myAPI.getRequest(text: "Hello") { result in
            // Switch pour succes ou failure
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let translation):
                XCTAssertNotNil(translation)
                XCTAssertEqual(translation, translationList)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}


