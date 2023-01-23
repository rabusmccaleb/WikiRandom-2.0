//
//  FavoritesWebView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit
import WebKit

class FavoritesWebView: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webURL : String = ""
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .black
        setUpBackButton()
        setupWebView()

        let url = URL(string: webURL)!

        webView.load(URLRequest(url: url))

        webView.allowsBackForwardNavigationGestures = true
        
    }
    
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


extension FavoritesWebView {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.webView.layer.opacity = 1.0
        })
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        deleteCache()
        self.webView.scrollView.contentOffset = CGPoint(x:0, y: -200) //
        let js = """
                    var Timer = setInterval(function() {
                      const footer = document.querySelector('footer');
                      if (footer) {
                        const link = document.createElement('link');
                        link.setAttribute('href', 'https://rabusmccaleb.github.io/wikiRandomStyles/WikiPageStyles.css');
                        link.setAttribute('rel', 'stylesheet');
                        link.setAttribute('type', 'text/css"');
                        const scriptElem = document.createElement('script');
                        scriptElem.setAttribute('src', 'https://rabusmccaleb.github.io/wikiRandomStyles/index.js');
                        document.querySelector('footer').appendChild(link);
                        document.querySelector('footer').appendChild(scriptElem);
                        clearInterval(Timer);
                      }
                    }, 10)
                    Timer;
                """
        webView.evaluateJavaScript(js, completionHandler: {Status, Error  in
            print(" Error JS Run : \(Error)")
            print(" Status : \(Status)")
            print("JS should have been ran")
        })
        webView.callAsyncJavaScript(js, in: .none, in: .defaultClient)
    }

    private func deleteCache(){
            if #available(iOS 9.0, *) {
              let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
              let date = NSDate(timeIntervalSince1970: 0)
                WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
            } else {
                var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
                libraryPath += "/Cookies"

                do {
                    try FileManager.default.removeItem(atPath: libraryPath)
                } catch {
                  print("error")
                }
                URLCache.shared.removeAllCachedResponses()
            }
        }
}

