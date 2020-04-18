//
//  BaseOptions.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RealmSwift
import Foundation

struct BaseOptions<Model: Object> {
    
    let realm: Realm
    
    init() throws {
        self.realm = try Realm()
    }
}

// MARK: - Base Get Protocol methods
extension BaseOptions: BaseGetProtocol {
    
    typealias TG = Model
    
    func get(filter: String?) -> [Model] {
        var results = realm.objects(Model.self)
        if let filter = filter { results = results.filter(filter) }
        return results.toArray()
    }
}

// MARK: - Base Delete Protocol methods
extension BaseOptions: BaseDeleteProtocol {
    
    typealias TD = Model
    
    func delete(filter: String?) -> Error? {
        var error: Error? = nil
        
        let result = self.realm.objects(Model.self)
        self.realm.beginWrite()
        self.realm.delete(result)
        
        let group = DispatchGroup()
        DispatchQueue.main.async(group: group) {
            do {
                try self.realm.commitWrite()
            } catch let e {
                error = e
            }
        }
        group.wait()
        
        return error
    }
}

// MARK: - Base Put Protocol methods
extension BaseOptions: BasePutProtocol {
    
    typealias TP = Model
    
    func put(object: Model) -> Error? {
        var error: Error? = nil
        
        self.realm.beginWrite()
        self.realm.add(object)
        
        let group = DispatchGroup()
        DispatchQueue.main.async(group: group) {
            do {
                try self.realm.commitWrite()
            } catch let e {
                error = e
            }
        }
        group.wait()
        
        return error
    }
    
    func put(objects: [Model]) -> Error? {
        var error: Error? = nil
        
        self.realm.beginWrite()
        self.realm.add(objects)
        
        let group = DispatchGroup()
        DispatchQueue.main.async(group: group) {
            do {
                try self.realm.commitWrite()
            } catch let e {
                error = e
            }
        }
        group.wait()
        
        return error
    }
}
