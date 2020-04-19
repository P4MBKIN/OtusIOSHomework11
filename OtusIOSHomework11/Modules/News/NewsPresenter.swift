//
//  NewsPresenter.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

final class NewsPresenter: NewsPresenterProtocol, NewsPresenterInputsProtocol, NewsPresenterOutputsProtocol {
    
    var interactor: NewsInteractorProtocol!
    var router: NewsRouterProtocol!
    
    var inputs: NewsPresenterInputsProtocol { return self }
    var outputs: NewsPresenterOutputsProtocol { return self }
    
    /// Inputs
    let viewDidLoadTrigger = PublishSubject<Void>()
    let refreshControlTrigger = PublishSubject<Void>()
    
    /// Outputs
    let newsList = BehaviorRelay<[News]>(value: [])
    let error = PublishSubject<Error>()
    
    private var searchNewsParams: NewsSearchParams
    private let disposeBag = DisposeBag()
    
    required init(dependencies: NewsPresenterDependencies) {
        self.interactor = dependencies.interactor
        self.router = dependencies.router
        
        self.searchNewsParams = NewsSearchParams(topic: "bitcoin", page: 1)
        
        /// Inputs setup
        self.viewDidLoadTrigger.asObserver()
            .bind(to: self.interactor.inputs.dataBaseNewsTrigger)
            .disposed(by: disposeBag)
        
        self.refreshControlTrigger.asObserver()
            .withLatestFrom(Observable.just(self.searchNewsParams))
            .bind(to: self.interactor.inputs.searchNewsTrigger)
            .disposed(by: disposeBag)
        
        /// Outputs setup
        self.interactor.outputs.searchNewsResponse
            .subscribe(onNext: { [weak self] list in
                self?.newsList.accept(list)
            }, onError: { [weak self] e in
                self?.error.onNext(e)
            })
        .disposed(by: disposeBag)
    }
}
