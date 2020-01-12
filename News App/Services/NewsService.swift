//
//  NewsService.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NewsService {
    
    static let instance = NewsService()
    
    func getSourcesList(completion: @escaping (_ error: Error?, _ sources: [SourceModel]?) -> Void) {
        Alamofire.request("\(ALLSOURCES_URL)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                if let sources = json["sources"].array {
                    var newsources = [SourceModel]()
                    for source in sources {
                        guard let source = source.dictionary else {return}
                        let newSource = SourceModel()
                        newSource.id = source["id"]?.string ?? ""
                        newSource.name = source["name"]?.string ?? ""
                        newsources.append(newSource)
                    }
                    completion(nil, newsources)
                }
            }
        }
    }
    
    func getArticleByTitle(title: String,completion: @escaping (_ error: Error?, _ articles: [NewsModel]?) -> Void) {
        let url = "\(ARTICLE_URL)\(title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&apiKey=\(API_KEY)"
        Alamofire.request("\(url)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                if let articles = json["articles"].array {
                    var newArticles = [NewsModel]()
                    for article in articles {
                        guard let article = article.dictionary else {return}
                        let newArticle = NewsModel()
                        newArticle.title = article["title"]?.string ?? ""
                        newArticle.urlToImage = article["urlToImage"]?.string ?? ""
                        newArticle.publishedAt = article["publishedAt"]?.string ?? ""
                        newArticle.auther = article["author"]?.string ?? ""
                        newArticle.desk = article["description"]?.string ?? ""
                        newArticle.url = article["url"]?.string ?? ""
                        newArticle.sourceName = article["source"]?["name"].string ?? ""
                        newArticles.append(newArticle)
                    }
                    completion(nil, newArticles)
                }
            }
        }
    }
    
    func getArticlesListByCountry(countryCode:String,completion: @escaping (_ error: Error?, _ News: [NewsModel]?) -> Void) {
        Alamofire.request("\(TOPHEADLINE_URL)\(countryCode)&apiKey=\(API_KEY)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                if let articles = json["articles"].array {
                    var newArticles = [NewsModel]()
                    for article in articles {
                        guard let article = article.dictionary else {return}
                        let newArticle = NewsModel()
                        newArticle.title = article["title"]?.string ?? ""
                        newArticle.urlToImage = article["urlToImage"]?.string ?? ""
                        newArticle.publishedAt = article["publishedAt"]?.string ?? ""
                        newArticles.append(newArticle)
                    }
                    completion(nil, newArticles)
                }
            }
        }
    }
    
    func getArticlesListBySource(source:String,completion: @escaping (_ error: Error?, _ News: [NewsModel]?) -> Void) {
        Alamofire.request("\(SOURCES_URL)\(source)&apiKey=\(API_KEY)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                completion(error, nil)
            case .success(let value):
                let json = JSON(value)
                if let articles = json["articles"].array {
                    var newArticles = [NewsModel]()
                    for article in articles {
                        guard let article = article.dictionary else {return}
                        let newArticle = NewsModel()
                        newArticle.title = article["title"]?.string ?? ""
                        newArticle.urlToImage = article["urlToImage"]?.string ?? ""
                        newArticle.publishedAt = article["publishedAt"]?.string ?? ""
                        newArticles.append(newArticle)
                    }
                    completion(nil, newArticles)
                }
            }
        }
    }
}
