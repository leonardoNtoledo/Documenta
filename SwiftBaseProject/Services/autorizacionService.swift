//
//  autorizacionService.swift
//  SwiftBaseProject
//
//  Created by Konecta S.A. on 4/9/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import Foundation
import RxCocoa
import RxSwift
import UIKit
import Foundation
import Alamofire

//se obtiene token desde la memoria del telefono
func getUserData(){

  
    var token = UserDefaults.standard.value(forKey: "token")
    
    //if ("\(token)" == nil){
     //   getLogin()
    //}else{
    
        
    let url = URL(string:"http://desa03.konecta.com.py:8010/gfdc/api/session/me/")!
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
//    let postString = ""
//    request.httpBody = postString.data(using: .utf8)
     let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }
        
         if let httpStatusToken = response! as? HTTPURLResponse, httpStatusToken.statusCode == 401  {
            //print("devueltatodo")
           // getLogin()
        }

        //Se convierten los datos a Json, se parsea, y se guardan en la memoria del telefono.
        let datos: Data // received from a network request, for example
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        do{
                    print(json)
//
            let nombreUsuario2 = json!["firstName"]
            //            //se parsea nombre del usuario se guarda en la memoria del telefono
            UserDefaults.standard.setValue( nombreUsuario2, forKey: "nombreUsuario")
            let cedulaUsuario = json!["cedula"]
            //            //se parsea nombre del usuario se guarda en la memoria del telefono
            UserDefaults.standard.setValue( cedulaUsuario, forKey: "cedulaUsuario")
            let EmpresaUsuario = json!["empresa"]
            //            //se parsea nombre del usuario se guarda en la memoria del telefono
            UserDefaults.standard.setValue( EmpresaUsuario, forKey: "EmpresaUsuario")


        }catch {
            print("El Json tiene un error: \(error)")
        }
        //   se verifica que todo este bien

        if let httpStatus = response! as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http error
         //   print("statusCode should be 200, but is \(httpStatus.statusCode)")
        //    print("response = \(String(describing: response))")
        }
        let responseString = String(data: data, encoding: .utf8)
       // print("responseString = \(String(describing: responseString!))")
    }
    task.resume()
       //downloadDataFromAPI()

  //  de esta manera se obtienen los datos guardados en el telefono
        let nombreUsuario2 = UserDefaults.standard.value(forKey: "nombreUsuario")
        print(nombreUsuario2)
        let cedulaUsuario = UserDefaults.standard.value(forKey: "cedulaUsuario")
        print(cedulaUsuario)
        let EmpresaUsuario = UserDefaults.standard.value(forKey: "EmpresaUsuario")
        print(EmpresaUsuario)
  //  }
}

