//
//  NewsViewController.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

final class NewsViewController: UIViewController, NewsViewProtocol {
    
    @IBOutlet weak var newsTableView: UITableView!
    var refreshControl: UIRefreshControl?
    
    var presenter: NewsPresenterProtocol!
    let configurator: NewsConfiguratorProtocol = NewsConfigurator()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(with: self)
        setup()
    }
    
    private func setup() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
        self.newsTableView.refreshControl = refreshControl
        
        // News received
        self.presenter.outputs.newsList.asObservable()
            //.filter{ !$0.isEmpty }
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.newsTableView.reloadData()
                self?.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
        
        // Error received
        self.presenter.outputs.error
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { error in
                let alert = UIAlertController(title: "Error", message: String(describing: error), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
        
        // First view load
        self.presenter.inputs.viewDidLoadTrigger.onNext(())
    }
    
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        self.presenter.inputs.refreshControlTrigger.onNext(())
    }
}

// MARK: - Table View Data Source
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.outputs.newsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.presenter.outputs.newsList.value.indices.contains(indexPath.row) else { return UITableViewCell() }
        let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID) as? NewsTableViewCell
        guard let newsCell = cell else { return UITableViewCell() }
        newsCell.set(news: self.presenter.outputs.newsList.value[indexPath.row])
        return newsCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pull to refresh"
    }
}

// MARK: - Table View Delegate
extension NewsViewController: UITableViewDelegate {
    
}
