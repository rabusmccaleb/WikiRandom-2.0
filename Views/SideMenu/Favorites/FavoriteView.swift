//
//  FavoriteView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit

class FavoriteView : UIViewController {
    // Default Declarations
    var favoritesData : [favorite]?
    // Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurView)
        //
        setUpViewTitle()
        setUpTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    // View Declarations
    let tableView : UITableView = {
        var tabel = UITableView()
        return tabel
    }()
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
}


extension FavoriteView : UITableViewDelegate, UITableViewDataSource {
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setUpTableView() {
        tableView.register(FavoritesCellView.self, forCellReuseIdentifier: FavoritesCellView().reuseID)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoritesData != nil {
            return favoritesData!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCellView().reuseID, for: indexPath) as! FavoritesCellView
        if favoritesData != nil {
            cell.setUpTableViewLabel(text: favoritesData![indexPath.row].title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight : CGFloat = 50
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if favoritesData != nil {
            let pageID = favoritesData?[indexPath.row].id
            if let id = pageID {
                let url : String = "http://en.m.wikipedia.org/?curid=\(id)"
                let wikiView = FavoritesWebView()
                wikiView.webURL = url
                self.navigationController?.pushViewController(wikiView, animated: true)
            }
        }
    }
}
