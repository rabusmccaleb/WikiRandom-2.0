//
//  TenDollarArticle.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit
import WebKit

class TenDollarArticleView : UIViewController, WKUIDelegate {
    var tenDollarData : tenDollarObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTenDollarArticle()
        setUpBackButton()
        setupWebView()
    }
    
    func getTenDollarArticle() {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection("10DollarArticleOfTheWeek").document("10DollarArticleOfTheWeek")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(tenDollarObject.self, from: jsonData)
                        self.tenDollarData = tenDollarObject(ArticleData: model.ArticleData, Language: model.Language, someOneHasWon: model.someOneHasWon, userIDOfWinner: model.userIDOfWinner, userNameOfWinner: model.userNameOfWinner)
                        //
                        var webURL : String = "http://\(model.Language).m.wikipedia.org/?curid=\(model.ArticleData)"
                        let url = URL(string: webURL)!
                        self.webView.load(URLRequest(url: url))
                        self.webView.allowsBackForwardNavigationGestures = true
                        
                    } catch {
                        print(error)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
        
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 12)
        button.backgroundColor = .black
        return button
    }()
    
    func setUpBackButton() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupWebView() {
        webView.backgroundColor = .black
        self.view.addSubview(webView)
        //
        webView.layer.cornerRadius = 8
        webView.clipsToBounds = true
        //
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: backButton.bottomAnchor),
            webView.leftAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: self.view.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
}

struct tenDollarObject : Decodable {
    var ArticleData : String
    var Language : String
    var someOneHasWon : Bool
    var userIDOfWinner : String
    var userNameOfWinner : String
}
