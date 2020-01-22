//
//  SearchEnterprisesTest.swift
//  empresas-iosTests
//
//  Created by Renan Benatti Dias on 22/01/20.
//  Copyright © 2020 empresas. All rights reserved.
//

import XCTest
import Combine
@testable import empresas_ios

class SearchEnterprisesTest: XCTestCase {
    
    var cancelables = Set<AnyCancellable>()
    lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cancelables = Set<AnyCancellable>()
        
        let expectationSuccess = expectation(description: "Success")
        
        let service = LoginService(network: UserRoutes())
        
        service.login(email: "testeapple@ioasys.com.br", password: "12341234")
            .map { _ in }
            .sink {
                expectationSuccess.fulfill()
            }
            .store(in: &cancelables)
        
        wait(for: [expectationSuccess], timeout: 10)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_search_enterprises() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectationSuccess = expectation(description: "Success")
        
        let api = EnterpriseRoutes()
        
        var enterprises: [Enterprise] = []
        
        api.search(text: "aQm")
            .map(\.data)
            .decode(type: EnterpriseResponse.self, decoder: jsonDecoder)
            .map { .success($0.enterprises) }
            .catch { Just(Result.failure($0)) }
            .sink { (result) in
                if case .success(let enterprisesResponse) = result {
                    enterprises = enterprisesResponse
                    expectationSuccess.fulfill()
                }
            }
            .store(in: &cancelables)
        
        wait(for: [expectationSuccess], timeout: 10)
        
        XCTAssertFalse(enterprises.isEmpty)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
