//
//  NewsConfigurator.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

final class NewsConfigurator: NewsConfiguratorProtocol {
    
    func configure(with viewController: NewsViewController) {
        let router: NewsRouterProtocol = NewsRouter()
        let interactor: NewsInteractorProtocol = NewsInteractor()
        let presenter: NewsPresenterProtocol = NewsPresenter(dependencies: (interactor: interactor, router: router))
        viewController.presenter = presenter
    }
}
