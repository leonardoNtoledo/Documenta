import Foundation
import RxCocoa
import RxSwift
import UIKit


class CatastrarViewController: UIViewController {
    
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var error: UILabel!
   
    
    var viewModel: CatastrarViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCatastro();
//
        
        }
    //funcion que utiliza App Router para llevarnos al Login
    func gotoLogin() {
        AppRouter.sharedInstance.navigate(to: LoginRoute.login, with: .reset)
    
    }
    //boton que llama a la funcion del Router
    @IBAction func goLogin(_ sender: UIButton) {
        gotoLogin();
    }
   
}
