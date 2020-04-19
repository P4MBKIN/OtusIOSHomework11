//
//  NewsInteractor.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RxSwift
import RxCocoa
import Action
import Foundation

final class NewsInteractor: NewsInteractorProtocol, NewsInteractorInputsProtocol, NewsInteractorOutputsProtocol {
    
    var inputs: NewsInteractorInputsProtocol { return self }
    var outputs: NewsInteractorOutputsProtocol { return self }
    
    /// Inputs
    let dataBaseNewsTrigger = PublishSubject<Void>()
    let searchNewsTrigger = PublishSubject<NewsSearchParams>()
    
    /// Outputs
    let searchNewsResponse = PublishSubject<[News]>()
    
    private let dbGetAction: Action<Void, [News]>
    private let dbUpdateAction: Action<[News], Void>
    private let searchNewsAction: Action<NewsSearchParams, [News]>
    private let disposeBag = DisposeBag()
    
    static private let dataService: DataServiceProtocol = DataService()
    static private let networkService: NetworkServiceProtocol = NetworkService()
    
    init() {
        self.dbGetAction = Action { return NewsInteractor.getNewsFromDB() }
        self.dbUpdateAction = Action { newsList in return NewsInteractor.updateNewsToDB(newsList: newsList) }
        self.searchNewsAction = Action { params in return NewsInteractor.getNewsFromNetwork(params: params)}
        
        /// Inputs setup
        self.dataBaseNewsTrigger.asObserver()
            .bind(to: self.dbGetAction.inputs)
            .disposed(by: disposeBag)
        
        self.searchNewsTrigger.asObserver()
            .bind(to: self.searchNewsAction.inputs)
            .disposed(by: disposeBag)
        
        /// Outputs setup
        self.dbGetAction.elements.asObservable()
            .bind(to: self.searchNewsResponse)
            .disposed(by: disposeBag)
        
        self.dbUpdateAction.elements.asObservable()
            .bind(to: self.dbGetAction.inputs)
            .disposed(by: disposeBag)
        
        self.searchNewsAction.elements.asObservable()
            .bind(to: self.dbUpdateAction.inputs)
            .disposed(by: disposeBag)
        
        /// Errors setup
        self.dbGetAction.errors.asObservable()
            .subscribe(onNext: { [weak self] error in
                self?.searchNewsResponse.onError(error)
            })
            .disposed(by: disposeBag)
        self.dbUpdateAction.errors.asObservable()
            .subscribe(onNext: { [weak self] error in
                self?.searchNewsResponse.onError(error)
            })
            .disposed(by: disposeBag)
        self.searchNewsAction.errors.asObservable()
            .subscribe(onNext: { [weak self] error in
                self?.searchNewsResponse.onError(error)
            })
            .disposed(by: disposeBag)
    }
}

extension NewsInteractor {
    
    private static func getNewsFromDB() -> Single<[News]> {
        return Single<[News]>.create { observer in
            let (data, error) = NewsInteractor.dataService.getNewsData(filter: nil, sortedByKeyPath: "date", ascending: false)
            guard error == nil else {
                observer(.error(error!))
                return Disposables.create()
            }
            guard let dataList = data else {
                observer(.success([]))
                return Disposables.create()
            }
            let newsList = dataList.map{ News(source: nil, author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
            observer(.success(newsList))
            return Disposables.create()
        }
    }
    
    private static func updateNewsToDB(newsList: [News]) -> Single<Void> {
        return Single<Void>.create{ observer in
            if let error = NewsInteractor.dataService.deleteNewsData(filter: nil) {
                observer(.error(error))
                return Disposables.create()
            }
            let list = newsList.map{ (author: $0.author, title: $0.title, info: $0.info, imageUrl: $0.imageUrl, date: $0.date) }
            if let error = NewsInteractor.dataService.putNewsData(listNewsData: list) {
                observer(.error(error))
                return Disposables.create()
            } else {
                observer(.success(()))
                return Disposables.create()
            }
        }
    }
    
    private static func getNewsFromNetwork(params: NewsSearchParams) -> Single<[News]> {
        return Single<[News]>.create { observer in
            let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date.init()
            NewsInteractor.networkService.everythingGet(topicName: params.topic, dateFrom: date, page: params.page) { (newsList: NewsList?, newsError: NewsError?, error) in
                guard newsError == nil else {
                    observer(.error(newsError!))
                    return
                }
                guard error == nil else {
                    observer(.error(error!))
                    return
                }
                if let newsList = newsList { observer(.success(newsList.list ?? [])) }
            }
            return Disposables.create()
        }
    }
}
