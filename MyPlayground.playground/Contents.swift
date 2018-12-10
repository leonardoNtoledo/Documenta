//: Playground - noun: a place where people can play
import Foundation
let url = URL(string:"http://desa03.konecta.com.py:8010/gfdc/api/comprobantes")!
var components = URLComponents()
components.url
let queryfilter = URLQueryItem(name: "item", value:"{id : \"null\", nombre : \"null\", cedula : \"null\", email : \"null\" , token_transaccion : \"null\", firmaFuncionario:\"null\", codigoLiquidacion: \"null\"}")
let queryCount = URLQueryItem(name : "count", value: "20")
let queryPage = URLQueryItem(name : "page", value: "1")
let querysortBy = URLQueryItem(name : "sortBy", value: "[\"id\"]")
let querysortOrder = URLQueryItem(name : "sortOrder", value: "[\"DESC\"]")
components.queryItems = [queryCount, queryPage, querysortBy, querysortOrder,queryfilter]
components.url


//let url = URL(string: "http://desa03.konecta.com.py:8010/gfdc/api/comprobantes")!
//
//let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
//if let components = components {
//    components.host
//    components.query
//    components.percentEncodedQuery
//    components.path
//
//    if let queryItems = components.queryItems {
//        for queryItem in queryItems {
//            print("\(queryItem.name): \(queryItem.value)")
//        }
//    }
//}
