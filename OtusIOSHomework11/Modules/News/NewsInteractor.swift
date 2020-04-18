//
//  NewsInteractor.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class NewsInteractor: NewsInteractorProtocol {
    
    weak var presenter: NewsInteractorToPresenterProtocol?
    let networkService: NetworkServiceProtocol = NetworkService()
    let dataService: DataServiceProtocol = DataService()
    
    required init(presenter: NewsInteractorToPresenterProtocol) {
        self.presenter = presenter
    }
    
    func fetchInitialNews() {
        let (data, error) = self.dataService.getNewsData(filter: nil)
        if error != nil { self.presenter?.newsFetchedFailed(error: String(describing: error)) }
        guard let listData = data, listData.isEmpty, error == nil else {
            updateNews()
            return
        }
        let newsList = listData.map{ News(source: nil, author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
        self.presenter?.newsFetched(newsList: newsList)
    }
    
    func updateNews() {
        if let deleteError = self.dataService.deleteNewsData(filter: nil) {
            self.presenter?.newsDataFailed(error: String(describing: deleteError))
            return
        }
        fetchNews()
        
    }
    
    private func fetchNews() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date.init()
        self.networkService.everythingGet(topicName: "bitcoin", dateFrom: date, page: 1) { (newsList: NewsList?, newsError: NewsError?, error) in
            guard newsError == nil else {
                DispatchQueue.main.async {
                    self.presenter?.newsFetchedFailed(error: String(describing: newsError))
                }
                return
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    self.presenter?.newsFetchedFailed(error: error!.localizedDescription)
                }
                return
            }
            if let list = newsList?.list {
                let listData = list.map{ (author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
                if let error = self.dataService.putNewsData(listNewsData: listData) {
                    DispatchQueue.main.async {
                        self.presenter?.newsDataFailed(error: String(describing: error))
                    }
                }
                return
            }
        }
    }
}
