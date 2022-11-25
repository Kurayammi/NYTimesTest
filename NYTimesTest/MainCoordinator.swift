//
//  MainCoordinator.swift
//  NYTimesTest
//
//  Created by Kito on 11/24/22.
//

import UIKit

final class MainCoordinator {
    
    private(set) var window: UIWindow
    private var navigationController: UINavigationController?
    
    func start() {
        let newsScreen = MainScreenViewController()
        
        navigationController = UINavigationController(rootViewController: newsScreen)
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
    
    func openSavedNewsScreen() {
        
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
