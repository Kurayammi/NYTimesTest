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
        newsScreen.pushSavedArticlesScreen = openSavedNewsScreen
        navigationController = UINavigationController(rootViewController: newsScreen)
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
    
    func openSavedNewsScreen() {
        let vc = SavedNewsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}
