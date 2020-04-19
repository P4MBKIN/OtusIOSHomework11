//
//  BaseOptionsProtocols.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RealmSwift
import Foundation

protocol BaseGetProtocol {
    associatedtype TG: Object
    func get(filter: String?, sortedByKeyPath: String?, ascending: Bool?) -> ([TG]?, Error?)
}

protocol BaseDeleteProtocol {
    associatedtype TD: Object
    func delete(filter: String?) -> Error?
}

protocol BasePutProtocol{
    associatedtype TP: Object
    func put(object: TP) -> Error?
    func put(objects: [TP]) -> Error?
}
