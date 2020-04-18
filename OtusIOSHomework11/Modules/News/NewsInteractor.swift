//
//  NewsInteractor.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

final class NewsInteractor: NewsInteractorProtocol, NewsInteractorInputsProtocol, NewsInteractorOutputsProtocol {
    
    var inputs: NewsInteractorInputsProtocol { return self }
    var outputs: NewsInteractorOutputsProtocol { return self }
    
    /// Inputs
    let searchNewsTrigger = PublishSubject<Void>()
    
    /// Outputs
    let searchNewsResponse = PublishSubject<[News]>()
    
    private let disposeBag = DisposeBag()
    
    static private let networkService: NetworkServiceProtocol = NetworkService()
    
    init() {
        /// Inputs setup
        self.searchNewsTrigger.asObservable()
            .subscribe(onNext: { [weak self] _ in
                let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date.init()
                NewsInteractor.networkService.everythingGet(topicName: "bitcoin", dateFrom: date, page: 1) { (newsList: NewsList?, newsError: NewsError?, error) in
                    guard newsError == nil else {
                        self?.searchNewsResponse.onError(newsError!)
                        return
                    }
                    guard error == nil else {
                        self?.searchNewsResponse.onError(error!)
                        return
                    }
                    if let newsList = newsList { self?.searchNewsResponse.onNext(newsList.list ?? []) }
                }
            })
            .disposed(by: disposeBag)
        
        /// Outputs setup
        
    }
}
