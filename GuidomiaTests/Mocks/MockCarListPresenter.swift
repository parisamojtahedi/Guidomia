//
//  MockCarListPresenter.swift
//  GuidomiaTests
//
//  Created by Parisa Mojtahedi on 2021-11-30.
//

import Foundation
@testable import Guidomia

class MockCarListPresenter: CarListPresenter {
    var controller: CarListView?
    var interactor: CarListInteractor!
    var router: CarListRouter?
    
    var sections: [TableViewSectionTypes] = []
    
    func onViewDidLoad() {
        
    }
    
    func updateUI(using sections: [TableViewSectionTypes]) {
        self.sections.append(contentsOf: sections)
    }
    
    func updateCarSection(using sections: [TableViewSectionTypes]) {
        self.sections = sections
    }
}
