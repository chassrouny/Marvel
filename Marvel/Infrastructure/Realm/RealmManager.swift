//
//  RealmManager.swift
//  Marvel
//
//  Created by Charbel Hasrouni on 24/09/2023.
//

import Foundation

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
   private var realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func getAll<T: RealmFetchable>(_ type: T.Type) -> [T]? {
        let realmResults = realm?.objects(T.self)
        return realmResults?.compactMap { $0 }
    }
    
    func save(object: Object) {
        try? realm?.write {
            realm?.add(object)
        }
    }
    
    func save(objects: [Object]) {
        try? realm?.write {
            for object in objects {
                realm?.add(object)
            }
        }
    }
    
    func deleteAll() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}
