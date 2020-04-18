//
//  NewsProtocols.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

/// PRESENTER -> VIEW
protocol NewsViewProtocol: class {
    var presenter: NewsPresenterProtocol? { get set }
    func resetNews()
    func updateNews(with newsList: [News])
    func displayError(error: String)
}

/// VIEW -> PRESENTER
protocol NewsPresenterProtocol: class {
    var view: NewsViewProtocol? { get set }
    var interactor: NewsInteractorProtocol? { get set }
    var router: NewsRouterProtocol? { get set }
    func configurateView()
    func refreshControlValueChanged()
}

/// PRESENTER -> INTERACTOR
protocol NewsInteractorProtocol: class {
    var presenter: NewsInteractorToPresenterProtocol? { get set }
    func fetchInitialNews()
    func updateNews()
}

/// INTERACTOR -> PRESENTER
protocol NewsInteractorToPresenterProtocol: class {
    func newsFetched(newsList: [News])
    func newsFetchedFailed(error: String)
    func newsDataFailed(error: String)
}

protocol NewsRouterProtocol: class {
}

protocol NewsConfiguratorProtocol: class {
    func configure(with viewController: NewsViewController)
}
