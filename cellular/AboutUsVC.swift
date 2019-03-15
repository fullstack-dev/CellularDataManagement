//
//  AboutUsVC.swift
//  cellular
//
//  Created by miniMac on 3/14/19.
//  Copyright © 2019 Christopher. All rights reserved.
//

import UIKit
import Foundation

class AboutUsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.purple]
        navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }
    
}

