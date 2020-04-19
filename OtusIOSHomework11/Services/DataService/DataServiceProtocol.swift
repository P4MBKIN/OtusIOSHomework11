//
//  DataServiceProtocol.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

protocol DataServiceProtocol: class {
    typealias NewsData = (author: String?, title: String?, info: String?, imageUrl: String?, date: Date?)
    func getNewsData(filter: String?, sortedByKeyPath: String?, ascending: Bool?) -> ([NewsData]?, Error?)
    func deleteNewsData(filter: String?) -> Error?
    func putNewsData(listNewsData: [NewsData]) -> Error?
}
