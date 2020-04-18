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
    
    private let disposeBag = DisposeBag()
    
    required init(dependencies: NewsPresenterDependencies) {
        self.interactor = dependencies.interactor
        self.router = dependencies.router
        
        /// Inputs setup
        self.refreshControlTrigger.asObserver()
            .bind(to: self.interactor.inputs.searchNewsTrigger)
            .disposed(by: disposeBag)
        
        /// Outputs setup
        self.interactor.outputs.searchNewsResponse
            .subscribe(onNext: { [weak self] newsList in
                self?.newsList.accept(newsList)
            }, onError: { [weak self] newsError in
                self?.error.onNext(newsError)
            })
        .disposed(by: disposeBag)
    }
}
