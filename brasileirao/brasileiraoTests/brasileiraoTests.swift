//
//  brasileiraoTests.swift
//  brasileiraoTests
//
//  Created by Ana Julia on 1/23/20.
//  Copyright © 2020 Ana Julia. All rights reserved.
//

import XCTest
@testable import brasileirao

class brasileiraoTests: XCTestCase {
    
    var tabelaJogosController : TabelaJogosController!
    

    override func setUp() {
        super.setUp()
        _ = tabelaJogosController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
