//
//  SideMenuView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/15/23.
//

import Foundation
import UIKit

class SideMenuView : UIViewController {
    // Instantiation Variables
    //
    // Life Cycle Methods and Default functions
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        //
        self.view.backgroundColor = .black
        setUpBackgroundImage()
        setUpUserProfileImage()
        setUpViewTitle()
        setUpLikesButton()
        setUpFavoritesButton()
        setUpNotesButton()
        setUplanguageButton()
        setUpTenDollarArticleOfTheWeekButton()
        setUpAboutButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    //
    let userProfileImage : UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    let LikeButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let FavoritesButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let NotesButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let languageButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let tenDollarArticleOfTheWeekButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let AboutButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Filled button"
        config.imagePadding = 8
        var button = UIButton(configuration: config)
        return button
    }()
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Menu"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
    
    let backgroundImage : UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    func setUpUserProfileImage() {
        let dimensions : CGFloat = 100
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(userProfileImage)
        userProfileImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userProfileImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        userProfileImage.widthAnchor.constraint(equalToConstant: dimensions).isActive = true
        userProfileImage.heightAnchor.constraint(equalToConstant: dimensions).isActive = true
        //
        userProfileImage.layer.cornerRadius = 29.5
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.borderColor = UIColor.white.cgColor
        userProfileImage.layer.borderWidth = 1.0
        //
        userProfileImage.image = BackendSingleton.s.userBackgroundImage
    }
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: userProfileImage.bottomAnchor, constant : 20).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setUpBackgroundImage() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundImage)
        backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        //
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.opacity = 1
        backgroundImage.image = BackendSingleton.s.userBackgroundImage
        //
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundImage.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurView)
    }
    
    func setUpLikesButton() {
        LikeButton.setTitle("Likes", for: .normal)
        LikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        LikeButton.tintColor = .red
        FavoritesButton.tintColor = .white
        LikeButton.setTitleColor(.white, for: .normal)
        LikeButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        LikeButton.titleLabel?.textAlignment = .left
        LikeButton.contentHorizontalAlignment = .left
        LikeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        //
        LikeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(LikeButton)
        LikeButton.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        LikeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        LikeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        LikeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        LikeButton.addTarget(self, action: #selector(showLikeView), for: .touchUpInside)
    }
    
    @objc func showLikeView() {
        self.navigationController?.pushViewController(LikesView(), animated: true)
    }
    
    func setUpFavoritesButton() {
        FavoritesButton.setTitle("Favorites", for: .normal)
        FavoritesButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        FavoritesButton.tintColor = UIColor(red: 0.15, green: 0.45, blue: 0.75, alpha: 1)
        FavoritesButton.tintColor = .white
        FavoritesButton.setTitleColor(.black, for: .normal)
        FavoritesButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        FavoritesButton.titleLabel?.textAlignment = .left
        FavoritesButton.contentHorizontalAlignment = .left
        let config = UIButton.Configuration.filled()
        
        //
        FavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(FavoritesButton)
        FavoritesButton.topAnchor.constraint(equalTo: LikeButton.bottomAnchor, constant: 12).isActive = true
        FavoritesButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        FavoritesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        FavoritesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        FavoritesButton.addTarget(self, action: #selector(showFavoriteCategoriesView), for: .touchUpInside)
    }
    
    @objc func showFavoriteCategoriesView() {
        self.navigationController?.pushViewController(FavoriteCategoriesView(), animated: true)
    }
    
    func setUpNotesButton() {
        NotesButton.setTitle("Notes", for: .normal)
        NotesButton.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        NotesButton.tintColor = UIColor(red: 0.15, green: 0.45, blue: 0.75, alpha: 1)
        NotesButton.tintColor = .white
        NotesButton.setTitleColor(.darkGray, for: .normal)
        NotesButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        NotesButton.titleLabel?.textAlignment = .left
        NotesButton.contentHorizontalAlignment = .left
        //
        NotesButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(NotesButton)
        NotesButton.topAnchor.constraint(equalTo: FavoritesButton.bottomAnchor, constant: 12).isActive = true
        NotesButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        NotesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        NotesButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        NotesButton.addTarget(self, action: #selector(showNotesButtonView), for: .touchUpInside)
    }
    
    @objc func showNotesButtonView() {
        self.navigationController?.pushViewController(NotesView(), animated: true)
    }
    
    func setUplanguageButton() {
        languageButton.setTitle("Language", for: .normal)
        languageButton.setImage(UIImage(systemName: "character.book.closed.fill.ar"), for: .normal)
        languageButton.tintColor = UIColor(red: 0.15, green: 0.45, blue: 0.75, alpha: 1)
        languageButton.tintColor = .white
        languageButton.setTitleColor(.darkGray, for: .normal)
        languageButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        languageButton.titleLabel?.textAlignment = .left
        languageButton.contentHorizontalAlignment = .left
        //
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(languageButton)
        languageButton.topAnchor.constraint(equalTo: NotesButton.bottomAnchor, constant: 12).isActive = true
        languageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        languageButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        languageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        languageButton.addTarget(self, action: #selector(showlanguageButtonView), for: .touchUpInside)
    }
    
    @objc func showlanguageButtonView() {
        self.navigationController?.pushViewController(LanguageView(), animated: true)
    }
    
    func setUpTenDollarArticleOfTheWeekButton() {
        tenDollarArticleOfTheWeekButton.setTitle("$10 Article", for: .normal)
        tenDollarArticleOfTheWeekButton.setImage(UIImage(systemName: "dollarsign.circle.fill"), for: .normal)
        tenDollarArticleOfTheWeekButton.tintColor = UIColor(red: 0.01, green: 0.85, blue: 0.5, alpha: 1)
//        AboutButton.tintColor = .white
        tenDollarArticleOfTheWeekButton.setTitleColor(.white, for: .normal)
        tenDollarArticleOfTheWeekButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        tenDollarArticleOfTheWeekButton.titleLabel?.textAlignment = .left
        tenDollarArticleOfTheWeekButton.contentHorizontalAlignment = .left
        //
        tenDollarArticleOfTheWeekButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tenDollarArticleOfTheWeekButton)
        tenDollarArticleOfTheWeekButton.topAnchor.constraint(equalTo: languageButton.bottomAnchor, constant: 12).isActive = true
        tenDollarArticleOfTheWeekButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        tenDollarArticleOfTheWeekButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        tenDollarArticleOfTheWeekButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        tenDollarArticleOfTheWeekButton.addTarget(self, action: #selector(showTenDollarArticleOfTheWeekButtonView), for: .touchUpInside)
    }
    
    @objc func showTenDollarArticleOfTheWeekButtonView() {
        self.navigationController?.pushViewController(TenDollarArticleView(), animated: true)
    }
    
    func setUpAboutButton() {
        AboutButton.setTitle("About", for: .normal)
        AboutButton.setImage(UIImage(systemName: "questionmark.app.fill"), for: .normal)
        AboutButton.tintColor = UIColor(red: 0.15, green: 0.45, blue: 0.75, alpha: 1)
        AboutButton.tintColor = .white
        AboutButton.setTitleColor(.darkGray, for: .normal)
        AboutButton.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 22)
        AboutButton.titleLabel?.textAlignment = .left
        AboutButton.contentHorizontalAlignment = .left
        //
        AboutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(AboutButton)
        AboutButton.topAnchor.constraint(equalTo: tenDollarArticleOfTheWeekButton.bottomAnchor, constant: 12).isActive = true
        AboutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        AboutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
        AboutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        AboutButton.addTarget(self, action: #selector(showAboutButtonView), for: .touchUpInside)
    }
    
    @objc func showAboutButtonView() {
        self.navigationController?.pushViewController(AboutView(), animated: true)
    }
    // View Setup
}
