//
//  iOS_PetDayTests.swift
//  iOS-PetDayTests
//
//  Created by Fidetro on 03/01/2018.
//  Copyright © 2018 Fidetro. All rights reserved.
//

import XCTest

class iOS_PetDayTests: XCTestCase {
    
    
    func testCalculator() {
        let calculator = DateCalculator.init(today: Date())
        for day in calculator.last90Day() {
            print("\(day.year)-\(day.month)-\(day.day)")
        }
//        print(calculator.next90Day())
        
    }

    func testRequest() {
//        let loginApi = LoginApi.init()
//        loginApi.username = "134"
//        loginApi.password = "666"
//        loginApi.request().success { (_, data) in
//            print(data)
//            }.failure { (response, request, error) in
//                print(error)
//        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
