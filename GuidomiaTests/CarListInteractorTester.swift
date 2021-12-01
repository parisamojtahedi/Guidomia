//
//  CarListInteractorTester.swift
//  GuidomiaTests
//
//  Created by Parisa Mojtahedi on 2021-11-30.
//

import Foundation
import XCTest
@testable import Guidomia

class CarListInteractorTester {
    var classToTest: CarListInteractorImp
    let dataStore = MockDataStore()
    let serviceProvider = MockServiceProvider()
    var presenter: MockCarListPresenter = MockCarListPresenter()
    
    init() {
        classToTest = CarListInteractorImp(serviceProvider: serviceProvider,
                                              dataStoreHandler: dataStore)
        classToTest.presenter = presenter
    }
    
    func emulateFetchItems() {
        classToTest.fetchItems()
    }
    
    func fetch_items_check_realm_first() {
        XCTAssertTrue(!dataStore.retrieveItemsArr.isEmpty)
    }
    
    func fetch_items_save_items_in_realm(savedModel: String) {
        dataStore.comp = { [weak self] in
            guard let self = self else {
                XCTFail()
                return
            }
            XCTAssertTrue(!self.dataStore.savedItemsArr.isEmpty)
            XCTAssertEqual(self.dataStore.savedItemsArr.last, savedModel)
        }
    }
    
    func fetch_items_updates_sections() {
        XCTAssertTrue(!presenter.sections.isEmpty)
    }
    
    func first_section_is_type_image() {
        var imageSection: Int = 0
        switch classToTest.sections.first {
        case .image:
            imageSection += 1
        default:
            break
        }
        XCTAssertEqual(imageSection, 1)
    }
    
    func second_section_is_type_filter() {
        var filterSection: Int = 0
        switch classToTest.sections[1] {
        case .filter(_):
            filterSection += 1
        default:
            break
        }
        XCTAssertEqual(filterSection, 1)
    }
    
    func third_section_is_type_car_item() {
        var carSection: Int = 0
        switch classToTest.sections.last {
        case .car:
            carSection += 1
        default:
            break
        }
        XCTAssertEqual(carSection, 1)
    }
}
