//
//  MainScreenViewController.swift
//  NYTimesTest
//
//  Created by Kito on 11/24/22.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private let vm = MainScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.sendRequest()
    }
}
