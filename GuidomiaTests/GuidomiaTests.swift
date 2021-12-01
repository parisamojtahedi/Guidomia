//
//  GuidomiaTests.swift
//  GuidomiaTests
//
//  Created by Parisa Mojtahedi on 2021-11-26.
//

import XCTest
@testable import Guidomia

class GuidomiaTests: XCTestCase {

    var tester: CarListInteractorTester!
    
    override func setUp() {
        super.setUp()
        tester = CarListInteractorTester()
    }

    func test_fetch_items_check_realm_first() {
        tester.emulateFetchItems()
        tester.fetch_items_check_realm_first()
    }
    
    func test_fetch_items_save_items_in_realm() {
        tester.emulateFetchItems()
        tester.fetch_items_save_items_in_realm(savedModel: tester.serviceProvider.getMockedList().last!.model)
    }
    
    func test_fetch_items_updates_sections() {
        tester.emulateFetchItems()
        tester.fetch_items_updates_sections()
    }
    
    func test_first_section_is_type_image() {
        tester.emulateFetchItems()
        tester.second_section_is_type_filter()
    }
    
    func test_second_section_is_type_filter() {
        tester.emulateFetchItems()
        tester.third_section_is_type_car_item()
    }
}
