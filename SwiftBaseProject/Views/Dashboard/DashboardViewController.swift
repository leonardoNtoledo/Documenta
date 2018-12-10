//
//  DashboardViewController.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import Foundation
import Alamofire

var viewModel: DashboardViewModel!

class DashaboardViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonArray: NSArray?
    var codigoSas: Array<String> = []
    var periodo: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        downloadDataFromAPI()
    }
    
    func downloadDataFromAPI(){
        
        let nombreUsuario2 = UserDefaults.standard.value(forKey: "nombreUsuario")
        let cedulaUsuario = UserDefaults.standard.value(forKey: "cedulaUsuario")
        let EmpresaUsuario = UserDefaults.standard.value(forKey: "EmpresaUsuario")
        
        var token = UserDefaults.standard.value(forKey: "token")
        
        let params = "{\"cedula\":\"\(cedulaUsuario!)\",\"nombre\":\"\(nombreUsuario2!)\",\"anhoPago\":\"2018\",\"firmaFuncionario\":\"false\",\"mesPago\":\"01\",\"codigo\":\"agosto\"}"
     
        let DESC = "DESC"
        let url = URL(string:"http://desa03.konecta.com.py:8010/gfdc/api/comprobantes")!
        var components = URLComponents()
        components.scheme = "http"
        components.host = "desa03.konecta.com.py"
        components.port = 8010
        components.path = "/gfdc/api/comprobantes"
        let queryFilter = URLQueryItem(name: "filters", value:"\(params)")
        let queryCount = URLQueryItem(name : "count", value: "20")
        let queryPage = URLQueryItem(name : "page", value: "1")
        let querysortBy = URLQueryItem(name : "sortBy", value: "id")
        let querysortOrder = URLQueryItem(name : "sortOrder", value: "\(DESC)")
        components.queryItems = [queryFilter, queryCount, queryPage, querysortBy, querysortOrder]
        var request = URLRequest(url: components.url!)
        print(request)
        request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatusToken = response! as? HTTPURLResponse, httpStatusToken.statusCode == 401  {
                print("devueltatodo")
            }
            
            //Se convierten los datos a Json, se parsea, y se guardan en la memoria del telefono.
            let datos: Data // received from a network request, for example
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            print(json)
            
            do{
                
                var count = json!["count"]
                UserDefaults.standard.setValue( count, forKey: "count")
                print (count)
               // let countS = count
                var myResult : Int = 0
                let datos = json!["rows"] as! [NSDictionary]
                _ = [String]()
                for i in datos{
                    if let codigoS = i["codigoLiquidacion"] as? String {
                        self.codigoSas.append((codigoS))
                        myResult += 1
                    }
                }
                let dates = json!["rows"] as! [[String : AnyObject]]
                var TokenTransaccion = [String]()
                for i in dates{
                    TokenTransaccion.append(i["tokenTransaccion"]! as! String)
                    //print(TokenTransaccion)
                }
                
            }catch {
                print("El Json tiene un error: \(error)")
            }
            
            if let httpStatus = response! as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http error
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                //  print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString!))")
            //            //print(url)
        }
        self.tableView.reloadData()
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
     //   self.tableView.reloadData()
        return 1
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("holas")
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("hola")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DashboardViewModel
        
        cell.codigo.text = self.codigoSas[indexPath.row]
        
        //cell.periodo.text = self.periodo[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        return height/3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

