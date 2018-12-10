//: Playground - noun: a place where people can play

import UIKit
import Foundation

let url = URL(string:"http://desa03.konecta.com.py:8010/gfdc/api/comprobantes")
var components = URLComponents()
let queryCount = URLQueryItem(name : "count", value: "20")
let queryPage = URLQueryItem(name : "page", value: "1")
let querysortBy = URLQueryItem(name : "sortBy", value: "[\"id\"]")
let querysortOrder = URLQueryItem(name : "sortOrder", value: "[\"DESC\"]")
components.queryItems = [queryCount, queryPage, querysortBy, querysortOrder]
