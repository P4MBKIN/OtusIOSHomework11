//
//  NewsProtocols.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

protocol NewsViewProtocol: class {
    var presenter: NewsPresenterProtocol! { get set }
}

/// VIEW -> PRESENTER
protocol NewsPresenterInputsProtocol: class {
    var viewDidLoadTrigger: PublishSubject<Void> { get }
    var refreshControlTrigger: PublishSubject<Void> { get }
}

/// PRESENTER -> VIEW
protocol NewsPresenterOutputsProtocol: class {
    var newsList: BehaviorRelay<[News]> { get }
    var error: PublishSubject<Error> { get }
}

typealias NewsPresenterDependencies = (
    interactor: NewsInteractorProtocol,
    router: NewsRouterProtocol
)

protocol NewsPresenterProtocol: class {
    var interactor: NewsInteractorProtocol! { get set }
    var router: NewsRouterProtocol! { get set }
    var inputs: NewsPresenterInputsProtocol { get }
    var outputs: NewsPresenterOutputsProtocol { get }
}

/// PRESENTER -> INTERACTOR
protocol NewsInteractorInputsProtocol: class {
    var dataBaseNewsTrigger: PublishSubject<Void> { get }
    var searchNewsTrigger: PublishSubject<NewsSearchParams> { get }
}

/// INTERACTOR -> PRESENTER
protocol NewsInteractorOutputsProtocol: class {
    var searchNewsResponse: PublishSubject<[News]> { get }
}

protocol NewsInteractorProtocol: class {
    var inputs: NewsInteractorInputsProtocol { get }
    var outputs: NewsInteractorOutputsProtocol { get }
}

protocol NewsRouterProtocol: class {
}

protocol NewsConfiguratorProtocol: class {
    func configure(with viewController: NewsViewController)
}
