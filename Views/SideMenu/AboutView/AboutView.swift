//
//  AboutView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit
import FirebaseFirestore

class AboutView : UIViewController {
    let titleView : UILabel = UILabel()
    let contentLabel : UILabel = UILabel()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupScrollView()
        setupContent()
        getAboutContent()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupContent() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        self.view.addSubview(contentLabel)
        //
        titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        //
        titleView.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        titleView.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        titleView.textAlignment = .left
        //
        contentLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        //
        contentLabel.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 18)
        contentLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        contentLabel.textAlignment = .left
        contentLabel.numberOfLines = 0
    }
    
    //About
    func getAboutContent() {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection("About").document("About")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(About.self, from: jsonData)
                        self.titleView.text = model.title
                        self.contentLabel.text = model.content
                    } catch {
                        print(error)
                    }
                } else {
                    print("Document does not exist")
                }
            }
            
            
        }
    }
}


public struct About : Decodable {
    let title : String
    let content : String
}
