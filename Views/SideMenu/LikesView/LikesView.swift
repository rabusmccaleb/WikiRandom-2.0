//
//  LikesView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/21/23.
//

import Foundation
import UIKit

class LikesView : UIViewController {
    // Default Declarations
    var likesData : Likes?
    // Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurView)
        
        setUpViewTitle()
        setUpTableView()
        getLikeContent()
        addLoadingView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    func getLikeContent() {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(Likes.self, from: jsonData)
                        self.likesData = model
                        self.tableView.reloadData()
                        self.loadingView.stopLoading()
                        self.removeFromSubview()
                        print(model)
                    } catch {
                        print(error)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    // View Declarations
    let tableView : UITableView = {
        var tabel = UITableView()
        return tabel
    }()
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Likes"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
    
    let loadingView : UIView = UIView()
}


extension LikesView : UITableViewDelegate, UITableViewDataSource {
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setUpTableView() {
        tableView.register(LikesViewCell.self, forCellReuseIdentifier: LikesViewCell().reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        // Setup
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 12).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //
        tableView.backgroundColor = .black
    }
    
    func addLoadingView() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingView)
        loadingView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loadingView.backgroundColor = .clear
        loadingView.showLoading()
    }
    
    func removeFromSubview() {
        loadingView.isHidden = true
        loadingView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if likesData != nil {
            return likesData!.likes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LikesViewCell().reuseID, for: indexPath) as! LikesViewCell
        if likesData != nil {
            cell.setUpTableViewLabel(text: likesData!.likes[indexPath.row].title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight : CGFloat = 50
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if likesData != nil {
            let pageID = likesData?.likes[indexPath.row].id
            if let id = pageID {
                let url : String = "http://en.m.wikipedia.org/?curid=\(id)"
                let wikiView = LikesWebView()
                wikiView.webURL = url
                self.navigationController?.pushViewController(wikiView, animated: true)
            }
        }
    }
}
