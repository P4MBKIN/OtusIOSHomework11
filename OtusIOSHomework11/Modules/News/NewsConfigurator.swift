//
//  NewsConfigurator.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class NewsConfigurator: NewsConfiguratorProtocol {
    
    func configure(with viewController: NewsViewController) {
        let presenter: NewsPresenterProtocol & NewsInteractorToPresenterProtocol = NewsPresenter(view: viewController)
        let interactor: NewsInteractorProtocol = NewsInteractor(presenter: presenter)
        let router: NewsRouterProtocol? = nil
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
