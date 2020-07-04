//
//  PetDetailViewController.swift
//  SmartVet
//
//  Created by Koushal, KumarAjitesh on 2020/07/05.
//  Copyright © 2020 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit
import WebKit

class PetDetailViewController: UIViewController {
    
    var webview: WKWebView?
    var petInfo = Pets.init(image_url: "", title: "", content_url: "", date_added: "")

    override func loadView() {
        webview = WKWebView()
        webview?.navigationDelegate = self
        view = webview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let contentUrl = petInfo.content_url else {return}
        guard let url = URL(string: contentUrl) else {return}
        webview?.load(URLRequest(url: url))
        
        // Refresh Item at the bootom of the page to refresh the page
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview?.reload))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
    }
}

//MARK: WKNavigation Delegate

extension PetDetailViewController: WKNavigationDelegate {
    //MARK: WKNavigation Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview?.title
    }
}
