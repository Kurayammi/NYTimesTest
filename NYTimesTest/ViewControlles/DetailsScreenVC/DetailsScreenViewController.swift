//
//  DetailsScreenViewController.swift
//  NYTimesTest
//
//  Created by Kito on 11/25/22.
//

import UIKit
import WebKit

#warning("When open webView bug: This method should not be called on the main thread as it may lead to UI unresponsiveness. This bug new in iOS 16 from apple")

class DetailsScreenViewController: UIViewController, WKUIDelegate {
    
    private var webVeiewContent: WKWebView!
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        start()
    }
    
    func start() {
        if let url = url {
            let request = URLRequest(url: url)
            webVeiewContent.load(request)
        }
    }
    
    private func setupWebView() {
        webVeiewContent = WKWebView()
        webVeiewContent.uiDelegate = self
        view.addSubview(webVeiewContent)
        webVeiewContent.translatesAutoresizingMaskIntoConstraints = false
        webVeiewContent.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        webVeiewContent.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        webVeiewContent.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        webVeiewContent.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
}
