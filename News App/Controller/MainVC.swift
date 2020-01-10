//
//  ViewController.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //Outlets
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let newsCellId = "NewsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: newsCellId, bundle: nil), forCellReuseIdentifier: newsCellId)
    }
    
    @IBAction func filterBtnPressed(_ sender: Any) {
        let filterVC = FilterVC()
        filterVC.modalPresentationStyle = .custom
        present(filterVC, animated: true, completion: nil)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellId, for: indexPath) as! NewsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

