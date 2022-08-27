//
//  TestThreadSafe.swift
//  Intelligent systems testTests
//
//  Created by Jakob Skov Søndergård on 19/08/2022.
//

import XCTest

class TestThreadSafe: XCTestCase {
  var sut:MyThreadSafeClass?

    override func setUpWithError() throws {
        sut = nil
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testClassWithInstanceVarCanBeInitialized() throws{
    sut = MyThreadSafeClass(instanceVar: 27)
    XCTAssertNotNil(sut)
  }

  func testInstanceVarCanBeFetched()async throws{
//    given
    let expected = 27
//    when
    sut = MyThreadSafeClass(instanceVar: expected)
     let actual = sut?.instanceVar
//    then

    XCTAssertEqual(expected, actual)
  }

  func testInstanceVarCanBeChangedAndFetched()async throws{
    //    given
    let expected = 27
    //    when
    sut = MyThreadSafeClass(instanceVar: 0)
    sut?.instanceVar = 1
    sut?.instanceVar = 2
    sut?.instanceVar = 3
    sut?.instanceVar = expected
//    sleep(5)
    let actual = sut?.instanceVar
    //    then

    XCTAssertEqual(expected, actual)
  }

  func testClassVarCanBeFetched()throws{
    //    given
    let expected = "classVar"
    //    when
    let actual = MyThreadSafeClass.classVar
    //    then

    XCTAssertEqual(expected, actual)

  }
  func testStaticVarCanBeFetched()throws{
    //    given
    let expected = "staticVar"
    //    when
    let actual = MyThreadSafeClass.staticVar
    //    then

    XCTAssertEqual(expected, actual)

  }

   func testNoDeadlock()async throws {
    //given
    let expected = true
    //when
    let actual = false
    //then
    XCTAssertEqual(expected, actual)
  }

  func testThreadSafety()throws{
    //given
    let expected = true
    //when
    let actual = false
    //then
    XCTAssertEqual(expected, actual)

  }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
