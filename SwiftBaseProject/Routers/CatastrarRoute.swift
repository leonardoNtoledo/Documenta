//
//  DashBoardRoute.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/4/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

enum CatastrarRoute: Route {
    case catastrar

    var screen: UIViewController {
        switch self {
        case .catastrar:
            guard let catastrar = R.storyboard.catastrar.instantiateInitialViewController() else {
                return UIViewController()
            }
            catastrar.viewModel = CatastrarViewModel()
            return catastrar
        }
    }
}
