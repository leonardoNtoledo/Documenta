//
//  CatastrarService.swift
//  SwiftBaseProject
//
//  Created by Konecta S.A. on 29/8/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//
import CoreData
import Foundation
import UIKit
import Moya

func getCatastro(){
   // Metodo POST PARA OBTENER DATOS DEL API (URL,CLIENTEID) PANTALLA 1 CATASTRAR
    let imei = "012345678901234"
    let url = URL(string: "http://desa03.konecta.com.py:8010/gfdc/api/catastrar")!
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postString = "imei=\(imei)"
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }

        //Se convierten los datos a Json, se parsea, y se guardan en la memoria del telefono.
        let datos: Data! // received from a network request, for example
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
       // print(json)
        do{
            let contenido = json!["authServer"]! as! [String:Any]
            //se parsea catastro y se guarda en la memoria del telefono
            let urlcatastro = contenido["url"]! as! String
            UserDefaults.standard.setValue( urlcatastro, forKey: "urlCatastro")
            //se parsea id y se guarda en la memoria del telefono
            let idcatrastro = contenido["clientId"]! as! String
            UserDefaults.standard.setValue( idcatrastro, forKey: "idCatrastro")
        }catch {
            print("El Json tiene un error: \(error)")
        }
        //se verifica que todo este bien

        if let httpStatus = response! as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http error
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString!))")
    }
    task.resume()
    
    //de esta manera se obtienen los datos guardados en el telefono
    let printurl = UserDefaults.standard.value(forKey: "urlCatastro")
    print(printurl)
    let printId = UserDefaults.standard.value(forKey: "idCatrastro")
    print(printId)
}
