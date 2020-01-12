//
//  ViewController.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MainVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarTitleLbl: UILabel!
    
    //Constants
    let newsCellId = "NewsCell"
    let errorCellId = "ErrorCell"
    
    //Variables
    static var news = [NewsModel]()
    static var title: String = "News App"
    var selectedTitle: String = ""
    var selectedDate: String = ""
    var sources: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitleLbl.text = "News App"
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: newsCellId, bundle: nil), forCellReuseIdentifier: newsCellId)
        tableView.register(UINib(nibName: errorCellId, bundle: nil), forCellReuseIdentifier: errorCellId)
    }
    
    func loadData() {
        NewsService.instance.getSourcesList { (error: Error?, sources: [SourceModel]?) in
            if let sources = sources {
                for i in 0..<19 {
                    self.sources = "\(self.sources)" + "\(sources[i].id)"
                }
            }
        }
        if Helper.getFT() == 1 {
            NewsService.instance.getArticlesListByCountry(countryCode: Helper.getCC() ?? "us") { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    MainVC.news = news
                    self.tableView.reloadData()
                    self.navBarTitleLbl.text = "\(String(describing: Helper.getCC()!))"
                }
            }
            
        } else if Helper.getFT() == 2 {
            
            NewsService.instance.getArticlesListBySource(source: Helper.getSource() ?? "") { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    MainVC.news = news
                    self.tableView.reloadData()
                    self.navBarTitleLbl.text = "\(String(describing: Helper.getSource()!))"
                }
            }
        } else {
            NewsService.instance.getArticlesListByCountry(countryCode: Helper.getCC() ?? "us") { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    MainVC.news = news
                    self.tableView.reloadData()
                    self.navBarTitleLbl.text = "News App"
                }
            }
        }
    }
    
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        let filterVC = FilterVC()
        filterVC.modalPresentationStyle = .custom
        present(filterVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let destVC = segue.destination as! ArticleDetailsVC
            destVC.selectedTitle = self.selectedTitle
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Connectivity.isConnectedToInternet() {
            return MainVC.news.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Connectivity.isConnectedToInternet() {
            let cell = tableView.dequeueReusableCell(withIdentifier: newsCellId, for: indexPath) as! NewsCell
            cell.newsTitleLbl.text = MainVC.news[indexPath.row].title
            cell.newsDateLbl.text = MainVC.news[indexPath.row].publishedAt
            Alamofire.request(MainVC.news[indexPath.row].urlToImage).responseImage { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async {
                        cell.newsImg.image = image
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: errorCellId, for: indexPath) as! ErrorCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if Connectivity.isConnectedToInternet() {
            return 130
        } else {
            return 714
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: self)
        selectedTitle = "\(MainVC.news[indexPath.row].title)"
    }
}

