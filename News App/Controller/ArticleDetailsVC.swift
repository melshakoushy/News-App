//
//  ArticleDetailsVC.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class ArticleDetailsVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var createdByLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var urlLbl: UILabel!
    
    //Variables
    var selectedTitle: String = ""
    var selectedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        NewsService.instance.getArticleByTitle(title: selectedTitle) { (error: Error?, news: [NewsModel]?) in
            if let news = news {
                let article = news[0]
                self.headlineLbl.text = article.title
                self.createdByLbl.text = "By \(article.auther)"
                self.contentLbl.text = article.desk
                self.urlLbl.text = "Source Url: \(article.url)"
            }
        }
    }
}
