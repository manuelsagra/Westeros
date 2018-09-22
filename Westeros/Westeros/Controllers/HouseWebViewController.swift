//
//  HouseWebViewController.swift
//  Westeros
//
//  Created by Manuel Sagra de Diego on 16/9/18.
//  Copyright © 2018 Manuel Sagra de Diego. All rights reserved.
//

import UIKit
import WebKit

class HouseWebViewController: UIViewController {
    // MARK: - Properties
    var webView: WKWebView
    var model: House
    
    // MARK: - Initialization
    init(model: House) {
        self.model = model
        webView = WKWebView()
        
        super.init(nibName: nil, bundle: nil)
        // O también
        //super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        
        webView.navigationDelegate = self
        // Spinner hasta que cargue
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.startAnimating()
        spinner.center = view.center
        view = spinner
    }
    
    // Chapuza de Apple, necesaria para Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotitication, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let house: House = info[Constants.houseKey] as? House else { return }
        model = house
        syncModelWithView()
    }    
    
    // MARK: - Sync
    func syncModelWithView() {
        title = "\(model.name) Wiki"
        webView.load(URLRequest(url: model.wikiUrl))
    }
}

extension HouseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view = webView
    }
    
    // Evitar navegación
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let type = navigationAction.navigationType
        switch(type) {
            case .linkActivated, .formSubmitted, .formResubmitted:
                decisionHandler(.cancel)
                
            default:
                decisionHandler(.allow)
        }
    }
}
