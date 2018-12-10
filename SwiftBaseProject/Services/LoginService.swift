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
import Alamofire
import OAuthSwiftAlamofire
import OAuthSwift
import AeroGearOAuth2
import AeroGearHttp

 
func getLogin(){
    //se obtine url desde la memoria del telefono
     let urlCatastro = UserDefaults.standard.value(forKey: "urlCatastro")

    //se obtiene username desde la memoria del telefono
    let username = UserDefaults.standard.value(forKey: "userNameId")

    //se obtiene password desde la memoria del telefono
    let password = UserDefaults.standard.value(forKey: "passwordId")

    //se obtiene client_id desde la memoria del telefono
    let client_id = UserDefaults.standard.value(forKey: "idCatrastro")

    
   
//    let http = Http()
//
//    let keycloak = KeycloakConfig(
//        clientId: "\(postString)",
//        host: "\(urlCatastro!)",
//        realm: "shoot-realm")
//    let keycloakModule = AccountManager.addKeycloakAccount(config: keycloak)
//    http.authzModule = keycloakModule
//
//    http.request(method: .post, path: "http://desa03.konecta.com.py:8090/auth/realms/gfdc/protocol/openid-connect/token",  parameters: ["grant_type":"password","username":"\(username!)","password":"\(password!)","client_id":"\(client_id!)"],
//                 completionHandler: {(response, error) in
//                    print("ingreso")
//                    print(response,error)})

//
//    post();
//

//    let sessionManager = SessionManager.default
//    sessionManager.adapter = OAuthSwift2RequestAdapter.self as? RequestAdapter
//
//
    let url = URL(string:urlCatastro as! String)!
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postString = "grant_type=password&username=\(username!)&password=\(password!)&client_id=\(client_id!)"
    print(postString)
    request.httpBody = postString.data(using: .utf8)
   let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(String(describing: error))")
            return
        }

        //Se convierten los datos a Json, se parsea, y se guardan en la memoria del telefono.
        let datos: Data // received from a network request, for example
        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        // print(json)
        do{


         let token = json!["access_token"]
//            //se parsea access token y se guarda en la memoria del telefono
            UserDefaults.standard.setValue( token, forKey: "token")

        }catch {
            print("El Json tiene un error: \(error)")
        }

     //   se verifica que todo este bien

        if let httpStatus = response! as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http error
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(String(describing: responseString!))")
    }
    task.resume()
    getUserData()

   // de esta manera se obtienen los datos guardados en el telefono
//    let printToken = UserDefaults.standard.value(forKey: "token")
//print(printToken)
}





