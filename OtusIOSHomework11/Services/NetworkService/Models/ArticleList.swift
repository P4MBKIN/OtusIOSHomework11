//
//  Article.swift
//  OtusIOSHomework11
//
//  Created by Pavel on 12.04.2020.
//  Copyright © 2020 OtusCourse. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String?.self, forKey: .status)
        totalResults = try container.decode(Int?.self, forKey: .totalResults)
        articles = try container.decode([Article]?.self, forKey: .articles)
    }
}

struct Source: Decodable {
    
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String?.self, forKey: .id)
        name = try container.decode(String?.self, forKey: .name)
    }
}

struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let info: String?
    let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case publishedAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decode(Source?.self, forKey: .source)
        author = try container.decode(String?.self, forKey: .author)
        title = try container.decode(String?.self, forKey: .title)
        info = try container.decode(String?.self, forKey: .description)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        date = formatter.date(from: try container.decode(String.self, forKey: .publishedAt))
    }
}
