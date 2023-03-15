//
//  EndpointTests.swift
//  CoreNetworking-Unit-CoreNetworkingTests
//
//  Created by Hussam Elsadany on 19/07/2022.
//

import XCTest
import CoreNetworking

class EndpointTests: XCTestCase {

    private var sut: EndpointProtocol!
    
    override func setUpWithError() throws {
        sut = MockedEndPoint.mocks(path: "2022/EG")
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    
    func testValidEndpointShouldGenerateURLRequest() throws {
        let urlRequest = sut.urlRequest
        XCTAssertNotNil(urlRequest)
        XCTAssertNotNil(urlRequest?.url)
        XCTAssertEqual(urlRequest?.url?.path ?? "", "/2022/EG")
    }
}
