//
//  RealmService.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/26/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init() {}
    
    static let shared = RealmService()
    let realm = try! Realm()
    
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
//                realm.add(object)
             realm.add(object, update: true)
            }
        } catch {
            post(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }
    
    func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object )
            }
        } catch {
            post(error)
        }
    }
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            post(error)
        }
    }
    
    
    func post(_ error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
    
    
    func stopObservingErrors(in vc: UIViewController) {
        NotificationCenter.default.removeObserver(vc, name: NSNotification.Name("RealmError"), object: nil)
    }

    
    

}

