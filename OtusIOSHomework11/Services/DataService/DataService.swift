//
//  DataService.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class DataService: DataServiceProtocol {
    
    func getNewsData(filter: String?) -> ([NewsData]?, Error?) {
        guard let options = try? BaseOptions<NewsModel>() else { return (nil, DataError.initializationRealmError) }
        
        let data = options.get(filter: filter)
        let newsData = data.map{ (author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
        
        return (newsData, nil)
    }
    
    func deleteNewsData(filter: String?) -> Error? {
        guard let options = try? BaseOptions<NewsModel>() else { return DataError.initializationRealmError }
        
        return options.delete(filter: filter)
    }
    
    func putNewsData(listNewsData: [NewsData]) -> Error? {
        guard let options = try? BaseOptions<NewsModel>() else { return DataError.initializationRealmError }
        
        let data = listNewsData.map{ NewsModel(author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
        return options.put(objects: data)
    }
    
}
