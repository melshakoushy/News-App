//
//  Constants.swift
//  News App
//
//  Created by Mahmoud Elshakoushy on 1/10/20.
//  Copyright © 2020 Mahmoud Elshakoushy. All rights reserved.
//

import Foundation

//API_SPECIFICATIONS
let API_KEY = "dfd25f12c6034b60be7517dd3cdc4957"

//URLS
let BASE_URL = "https://newsapi.org/v2/"
let TOPHEADLINE_URL = "\(BASE_URL)top-headlines?country="
let ARTICLE_URL = "\(BASE_URL)everything?q="
let SOURCES_URL = "\(BASE_URL)top-headlines?sources="
let ALLSOURCES_URL = "\(BASE_URL)sources?apiKey=\(API_KEY)"

//MainVCSources
let SOURCES = "bbc-news,cnn,the-new-york-times,cbs-news,business-insider,reuters,the-new-york-times,techradar"
