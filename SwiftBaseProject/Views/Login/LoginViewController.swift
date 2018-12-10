//
//  ViewController.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var userNameField: UITextField!
    var userName:String?
  @IBOutlet weak var passwordField: UITextField!
    var passwordId:String?
  @IBOutlet weak var errorLabel: UILabel!

  var viewModel: LoginViewModel!
  private var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    func gotoDash() {
        AppRouter.sharedInstance.navigate(to: HomeRoute.dashboard, with: .reset)
    }
    @IBAction func gotoDashboard(_ sender: UIButton) {
        
        //al pulsar el boton de login, se guarda el usuario y se almacena en la memoria del telefono para luego usarlo en el post
        userName = userNameField.text
        UserDefaults.standard.setValue( userName, forKey: "userNameId")
        //para ver en consola.
        let printUsername = UserDefaults.standard.value(forKey: "userNameId")
        print(printUsername)
      
        //al pulsar el boton de login, se guarda el password y se almacena en la memoria del telefono para luego usarlo en el post
        passwordId = passwordField.text
        UserDefaults.standard.setValue( passwordId, forKey: "passwordId")
         //para ver en consola.
        let password = UserDefaults.standard.value(forKey: "passwordId")
        print(password)
        getLogin()
        gotoDash();
   
}
}
