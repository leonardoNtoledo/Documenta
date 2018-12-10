//
//  DashboardViewModel.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class DashboardViewModel : UITableViewCell {
    
    @IBOutlet weak var codigo: UILabel!
    @IBOutlet weak var periodo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
