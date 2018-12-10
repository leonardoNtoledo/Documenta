//
//  ListadoComprobantesService.swift
//  SwiftBaseProject
//
//  Created by Konecta S.A. on 12/9/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

//se obtiene token desde la memoria del telefono
func getPDF(){
    
    let tokenTransaccion = UserDefaults.standard.value(forKey: "tokenTransaccion")
    let token = UserDefaults.standard.value(forKey: "token")
    let cedulaUsuario = UserDefaults.standard.value(forKey: "cedulaUsuario")
    
    //    if ("\(token)" == nil){
    //        getLogin()
    //    }else{
    
  //  let DESC = "DESC"
    //let url = URL(string:"http://desa03.konecta.com.py:8010/gfdc/api/consultas-publicas/comprobantes/{:tokenTransaccion}/obtener")!
    var components = URLComponents()
    components.scheme = "http"
    components.host = "desa03.konecta.com.py"
    components.port = 8010
    components.path = "/gfdc/api/consultas-publicas/comprobantes/{:\"\(tokenTransaccion!)\"}/obtener"
    print(components.url!)
    var request = URLRequest(url: components.url!)
    print(request)
    request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
        let postString = "ci=\(cedulaUsuario!)"
        request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }
        
        if let httpStatusToken = response! as? HTTPURLResponse, httpStatusToken.statusCode == 401  {
            print("devueltatodo")
            // getLogin()
        }
        
        //Se convierten los datos a Json, se parsea, y se guardan en la memoria del telefono.
        let datos: Data // received from a network request, for example
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        do{
//            print(json)
//            //
//            let tokenTransaccion = json!["tokenTransaccion"]
//            //            //se parsea nombre del usuario se guarda en la memoria del telefono
//            UserDefaults.standard.setValue( tokenTransaccion, forKey: "tokenTransaccion")
//
            
        }catch {
            print("El Json tiene un error: \(error)")
        }
        //   se verifica que todo este bien
        
        //   se verifica que todo este bien
        
        if let httpStatus = response! as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http error
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString!))")
    }
    
}
