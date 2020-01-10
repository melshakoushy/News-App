//
//  FilterVC.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import UIKit
import iOSDropDown

class FilterVC: UIViewController {

    //Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var countryRadioBtn: UIButton!
    @IBOutlet weak var sourceRadioBtn: UIButton!
    @IBOutlet weak var countryDropDown: DropDown!
    @IBOutlet weak var sourceDropDown: DropDown!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 7
        closeBtn.clipsToBounds = true
        closeBtn.layer.cornerRadius = 7
        cancelBtn.clipsToBounds = true
        cancelBtn.layer.cornerRadius = 7
        filterBtn.clipsToBounds = true
        filterBtn.layer.cornerRadius = 7
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(FilterVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterBtnPressed(_ sender: Any) {
    }
    
    @IBAction func countryRadioBtnPressed(_ sender: Any) {
    }
    
    @IBAction func sourceRadioBtnPressed(_ sender: Any) {
    }
    
}
