//
//  NewsViewController.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 15.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var refreshControl: UIRefreshControl?
    
    var presenter: NewsPresenterProtocol?
    let configurator: NewsConfiguratorProtocol = NewsConfigurator()
    
    private var newsList: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.configurator.configure(with: self)
        self.presenter?.configurateView()
    }
    
    private func setupViews() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
        self.newsTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        self.presenter?.refreshControlValueChanged()
    }
}

// MARK: - Table View Data Source
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID) as? NewsTableViewCell
        guard let newsCell = cell else { return UITableViewCell() }
        newsCell.set(news: self.newsList[indexPath.row])
        return newsCell
    }
}

// MARK: - Table View Delegate
extension NewsViewController: UITableViewDelegate {
    
}

// MARK: - News View Protocol methods
extension NewsViewController: NewsViewProtocol {
    
    func resetNews() {
        self.newsList = []
        self.newsTableView.reloadData()
    }
    
    func updateNews(with newsList: [News]) {
        self.newsList.append(contentsOf: newsList)
        self.newsTableView.reloadData()
    }
    
    func displayError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
