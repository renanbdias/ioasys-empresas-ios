//
//  empresas_iosTests.swift
//  empresas-iosTests
//
//  Created by Renan Benatti Dias on 20/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import XCTest
import Combine
@testable import empresas_ios

class empresas_iosTests: XCTestCase {
    
    var cancelables = Set<AnyCancellable>()
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancelables = Set<AnyCancellable>()
    }

    func test_login_request() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectationSuccess = expectation(description: "Success")
        
        let api = UserRoutes()
        
        api.login(email: "testeapple@ioasys.com.br", password: "12341234")
            .map { Result.success($0) }
            .catch { Just(Result.failure($0)) }
            .sink(receiveValue: { (result) in
                if case .success(let response) = result {
                    if let httpResponse = response.response as? HTTPURLResponse {
                        
                        let accessToken = httpResponse.allHeaderFields["access-token"]
                        let client = httpResponse.allHeaderFields["client"]
                        let uid = httpResponse.allHeaderFields["uid"]
                        
                        if accessToken != nil && client != nil && uid != nil {
                            expectationSuccess.fulfill()
                        }
                    }
                }
            })
            .store(in: &cancelables)
        
        wait(for: [expectationSuccess], timeout: 10)
    }
    
    func test_company_list_request() {
        
        let expectationSuccess = expectation(description: "Success")
        
        let api = EnterpriseRoutes()
        
        api.search(text: "aQm")
            .map { Result.success($0) }
            .catch { Just(Result.failure($0)) }
            .sink { (result) in
                switch result {
                case .success(let result):
                    print(result.data)
                    let response = result.response as! HTTPURLResponse
                    if response.statusCode == 200 {
                        expectationSuccess.fulfill()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancelables)
        
        wait(for: [expectationSuccess], timeout: 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
