//
//  MockServiceProvider.swift
//  GuidomiaTests
//
//  Created by Parisa Mojtahedi on 2021-11-30.
//

import Foundation
import RealmSwift
import Realm
@testable import Guidomia

class MockServiceProvider: ServiceProvider {
    private let carItems = [CarItem(model: "Sentra",
                                    marketPrice: 200,
                                    rating: 4,
                                    prosList: ["not expensive", "drives well"],
                                    consList: ["makes noise"],
                                    make: "Nissan")]
    
    func fetchItems(completion: (Result<[CarItem], Error>) -> Void) {
        completion(.success(carItems))
    }
    
    func getMockedList() -> [CarItem] {
        return carItems
    }
}

class MockDataStore: DataStoreCompatible {
    
    var realm: Realm!
    var config = Realm.Configuration()
    var retrieveItemsArr: [String] = []
    var savedItemsArr: [String] = []
    var comp: (() -> Void)?
    
    init() {
        config.inMemoryIdentifier = "MockDataStore"
        realm = try! Realm(configuration: config)
    }
    
    func retrieveItemsFromRealm() -> Results<RealmCarItem> {
        retrieveItemsArr.append("MockDataStore")
        return realm.objects(RealmCarItem.self)
    }
    
    func saveInRealm(using items: [RealmCarItem]) {
        savedItemsArr.append(items.first?.model ?? "")
        do {
            realm.beginWrite()
            realm.add(items)
            try! realm.commitWrite()
            comp?()
        }
    }
    
    private func convertToRealmCarItem(using object: Results<MockRealmCarItem>) -> [RealmCarItem] {
        var realmCarItemList: [RealmCarItem] = []

        for obj in object {
            let item = RealmCarItem()
            item.model = obj.model
            item.make = obj.make
            item.marketPrice = obj.marketPrice
            item.rating = obj.rating
            item.prosList = obj.prosList
            item.consList = obj.consList
            realmCarItemList.append(item)
        }
        
        return realmCarItemList
    }
}
class MockRealmCarItem: RealmSwiftObject {
    @objc dynamic var model: String = ""
    @objc dynamic var marketPrice: Double = 0.0
    @objc dynamic var rating: Int = 0
    var prosList = List<String>()
    var consList = List<String>()
    @objc dynamic var make: String = ""
}
