//
//  DataService.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 17.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class DataService: DataServiceProtocol {
    
    func getNewsData(filter: String?, sortedByKeyPath: String?, ascending: Bool?) -> ([NewsData]?, Error?) {
        let options = BaseOptions<NewsModel>()
        
        let (data, error) = options.get(filter: filter, sortedByKeyPath: sortedByKeyPath, ascending: ascending)
        if error != nil { return (nil, error!) }
        guard let list = data else { return (nil, nil) }
        let newsData = list.map{ (author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
        
        return (newsData, nil)
    }
    
    func deleteNewsData(filter: String?) -> Error? {
        let options = BaseOptions<NewsModel>()
        
        return options.delete(filter: filter)
    }
    
    func putNewsData(listNewsData: [NewsData]) -> Error? {
        let options = BaseOptions<NewsModel>()
        
        let data = listNewsData.map{ NewsModel(author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
        
        return options.put(objects: data)
    }
    
}
