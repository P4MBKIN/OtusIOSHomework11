//
//  NewsTableViewCell.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 16.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    static let reuseID = "NewsTableViewCell"
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func set(news: News) {
        self.authorLabel.text = news.author
        self.infoLabel.text = news.info
        if let url = URL(string: news.imageUrl ?? "") {
            DispatchQueue.main.async {
                self.newsImage.kf.setImage(with: url)
            }
        }
    }
}
