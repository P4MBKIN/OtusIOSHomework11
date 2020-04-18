//
//  NewsPresenter.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewProtocol?
    var interactor: NewsInteractorProtocol?
    var router: NewsRouterProtocol?
    
    required init(view: NewsViewProtocol) {
        self.view = view
    }
    
    func configurateView() {
        self.interactor?.fetchInitialNews()
    }
    
    func refreshControlValueChanged() {
        
    }
}

// MARK: - News Interator To Presenter Protocol methods
extension NewsPresenter: NewsInteractorToPresenterProtocol {
    
    func newsFetched(newsList: [News]) {
        self.view?.updateNews(with: newsList)
    }
    
    func newsFetchedFailed(error: String) {
        self.view?.displayError(error: error)
    }
    
    func newsDataFailed(error: String) {
        self.view?.displayError(error: error)
    }
}
