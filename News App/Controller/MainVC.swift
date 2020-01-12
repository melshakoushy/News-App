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
import NVActivityIndicatorView

class MainVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarTitleLbl: UILabel!
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    
    //Constants
    let newsCellId = "NewsCell"
    let errorCellId = "ErrorCell"
    
    //Variables
    var news = [NewsModel]()
    var selectedTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitleLbl.text = "News App"
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        indicator.isHidden = false
        indicator.startAnimating()
        loadData()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: newsCellId, bundle: nil), forCellReuseIdentifier: newsCellId)
        tableView.register(UINib(nibName: errorCellId, bundle: nil), forCellReuseIdentifier: errorCellId)
    }
    
    func loadData() {
        if Helper.getFT() == 1 {
            NewsService.instance.getArticlesListByCountry(countryCode: Helper.getCC() ?? "us") { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    self.news = news
                    self.tableView.reloadData()
                    self.navBarTitleLbl.text = "\(String(describing: Helper.getCC()!))"
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                }
                if let error = error {
                    let alert = UIAlertController(title: "", message: "\(error)", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
            
        } else if Helper.getFT() == 2 {
            NewsService.instance.getArticlesListBySource(source: Helper.getSource() ?? "") { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    self.news = news
                    self.tableView.reloadData()
                    self.navBarTitleLbl.text = "\(String(describing: Helper.getSource()!))"
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                }
                if let error = error {
                    let alert = UIAlertController(title: "", message: "\(error)", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        } else {
            NewsService.instance.getArticlesListBySource(source: SOURCES) { (error: Error?, news: [NewsModel]?) in
                if let news = news {
                    self.news = news
                    self.tableView.reloadData()
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                }
                if let error = error {
                    let alert = UIAlertController(title: "", message: "\(error)", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
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
            return self.news.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Connectivity.isConnectedToInternet() {
            let cell = tableView.dequeueReusableCell(withIdentifier: newsCellId, for: indexPath) as! NewsCell
            cell.newsTitleLbl.text = self.news[indexPath.row].title
            cell.newsDateLbl.text = self.news[indexPath.row].publishedAt
            Alamofire.request(self.news[indexPath.row].urlToImage).responseImage { (response) in
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
        selectedTitle = "\(self.news[indexPath.row].title)"
        performSegue(withIdentifier: "toDetails", sender: self)
    }
}

