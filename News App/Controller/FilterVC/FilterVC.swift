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
    
    //Variables
    var selectedCountryCode: String = "us"
    var selectedSource: String = "techcrunch"
    var sources = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
        setupDropDown()
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
    
    func loadData() {
        NewsService.instance.getSourcesList { (error: Error?, sources: [SourceModel]?) in
            if let sources = sources {
                for i in 0..<sources.count {
                    self.sources.append(sources[i].id)
                    print(self.sources)
                    self.setupDropDown()
                }
            }
        }
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
        if countryRadioBtn.imageView?.image == UIImage(named: "RadioChecked") {
//            self.selectedCountryCode = MainVC.selectedCountryCode
            Helper.saveCC(CC: selectedCountryCode)
            
//            print(Helper.getCC())
//            MainVC.instance.loadData()
////            NewsService.instance.getArticlesListByCountry(countryCode: selectedCountryCode) { (error: Error?, news: [NewsModel]?) in
////                if let news = news {
////                    MainVC.news = news
////                    MainVC.title = self.selectedCountryCode
//                    self.dismiss(animated: true, completion: nil)
////                }
////            }
        }
        else if sourceRadioBtn.imageView?.image == UIImage(named: "RadioChecked") {
            Helper.saveSource(Source: selectedSource)
        }
        else { return }
    }
    
    @IBAction func countryRadioBtnPressed(_ sender: Any) {
        if countryRadioBtn.imageView?.image == UIImage(named: "RadioUnchecked") {
            Helper.saveFT(FT: 1)
            countryRadioBtn.setImage(UIImage(named: "RadioChecked"), for: .normal)
            sourceRadioBtn.setImage(UIImage(named: "RadioUnchecked"), for: .normal)
        } else {
            countryRadioBtn.setImage(UIImage(named: "RadioUnchecked"), for: .normal)
        }
    }
    
    @IBAction func sourceRadioBtnPressed(_ sender: Any) {
        if sourceRadioBtn.imageView?.image == UIImage(named: "RadioUnchecked") {
            Helper.saveFT(FT: 2)
            sourceRadioBtn.setImage(UIImage(named: "RadioChecked"), for: .normal)
            countryRadioBtn.setImage(UIImage(named: "RadioUnchecked"), for: .normal)
        } else {
            sourceRadioBtn.setImage(UIImage(named: "RadioUnchecked"), for: .normal)
        }
    }
    
    func setupDropDown() {
        sourceDropDown.optionArray = self.sources
        sourceDropDown.didSelect{(selectedText , index, id) in
            print("Selected String: \(selectedText) \n index: \(index)")
            self.selectedSource = selectedText
        }
        
        countryDropDown.optionArray = ["Argentina","Australia","Austria","Belgium","Brazil","Bulgaria","Canada","China","Colombia","Cuba","CzechRepublic","Egypt","France","Germany","Greece","HongKong","Hungary","India","Indonesia","Ireland","Israel","Italy","Japan","Latvia","Lithuania","Malaysia","Mexico","Morocco","Netherlands","NewZealand","Nigeria","Norway","Philippines","Poland","Portugal","Romania","Russia","SaudiArabia","Serbia","Singapore","Slovakia","Slovenia","SouthAfrica","SouthKorea","Sweden","Switzerland","Taiwan","Thailand","Turkey","UAE","Ukraine","United Kingdom","United States","Venuzuela"]
        countryDropDown.optionIds = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54]
        countryDropDown.didSelect{(selectedText , index ,id) in
            print("Selected String: \(selectedText) \n index: \(index) \n id: \(id)")
            switch id {
            case 1:
                self.selectedCountryCode = "ar"
            case 2:
                self.selectedCountryCode = "au"
            case 3:
                self.selectedCountryCode = "at"
            case 4:
                self.selectedCountryCode = "be"
            case 5:
                self.selectedCountryCode = "br"
            case 6:
                self.selectedCountryCode = "bg"
            case 7:
                self.selectedCountryCode = "ca"
            case 8:
                self.selectedCountryCode = "cn"
            case 9:
                self.selectedCountryCode = "co"
            case 10:
                self.selectedCountryCode = "cu"
            case 11:
                self.selectedCountryCode = "cz"
            case 12:
                self.selectedCountryCode = "eg"
            case 13:
                self.selectedCountryCode = "fr"
            case 14:
                self.selectedCountryCode = "de"
            case 15:
                self.selectedCountryCode = "gr"
            case 16:
                self.selectedCountryCode = "hk"
            case 17:
                self.selectedCountryCode = "hu"
            case 18:
                self.selectedCountryCode = "in"
            case 19:
                self.selectedCountryCode = "id"
            case 20:
                self.selectedCountryCode = "ie"
            case 21:
                self.selectedCountryCode = "il"
            case 22:
                self.selectedCountryCode = "it"
            case 23:
                self.selectedCountryCode = "jp"
            case 24:
                self.selectedCountryCode = "lv"
            case 25:
                self.selectedCountryCode = "lt"
            case 26:
                self.selectedCountryCode = "my"
            case 27:
                self.selectedCountryCode = "mx"
            case 28:
                self.selectedCountryCode = "ma"
            case 29:
                self.selectedCountryCode = "nl"
            case 30:
                self.selectedCountryCode = "nz"
            case 31:
                self.selectedCountryCode = "ng"
            case 32:
                self.selectedCountryCode = "no"
            case 33:
                self.selectedCountryCode = "ph"
            case 34:
                self.selectedCountryCode = "pl"
            case 35:
                self.selectedCountryCode = "pt"
            case 36:
                self.selectedCountryCode = "ro"
            case 37:
                self.selectedCountryCode = "ru"
            case 38:
                self.selectedCountryCode = "sa"
            case 39:
                self.selectedCountryCode = "rs"
            case 40:
                self.selectedCountryCode = "sg"
            case 41:
                self.selectedCountryCode = "sk"
            case 42:
                self.selectedCountryCode = "si"
            case 43:
                self.selectedCountryCode = "za"
            case 44:
                self.selectedCountryCode = "kr"
            case 45:
                self.selectedCountryCode = "se"
            case 46:
                self.selectedCountryCode = "ch"
            case 47:
                self.selectedCountryCode = "tw"
            case 48:
                self.selectedCountryCode = "th"
            case 49:
                self.selectedCountryCode = "tr"
            case 50:
                self.selectedCountryCode = "ae"
            case 51:
                self.selectedCountryCode = "ua"
            case 52:
                self.selectedCountryCode = "gb"
            case 53:
                self.selectedCountryCode = "us"
                
            default:
                self.selectedCountryCode = "ve"
            }
            
        }
    }
}
