//
//  ViewController.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 04.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date.init()
        ArticleApi().everythingGet(topicName: "bitcoin", dateFrom: date) { (articleList, articleError, error) in
            guard error == nil else { return print(error!)}
            guard articleError == nil else { return print(articleError!)}
            if let atricleList = articleList { print(articleList)}
        }
        // Do any additional setup after loading the view.
    }


}

