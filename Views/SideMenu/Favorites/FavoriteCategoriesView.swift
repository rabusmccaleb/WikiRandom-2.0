//
//  FavoriteCategoriesView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/21/23.
//

import Foundation
import UIKit
import Tags
import FirebaseFirestore

class FavoriteCategoriesView: UIViewController, TagsDelegate {
    var tags: [String]? = []
    var favoriteTags : [FavoritesUIObj] = []
    var purpose : telos = .toViewFavorites
    var wikiID : String?
    var wikiTitle: String?
    
    private let tagsView: TagsView = {
        let view = TagsView(width: UIScreen.main.bounds.width - 40)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        setupScrollView()
        setUpTagView()
        getFavoritesContent()
        addLoadingView()
        if purpose == telos.toAddFavorites {
            setUpAddCategoryButton()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var newCategoryTextFeild : UITextField?
    var paddingView : UIView = UIView()
    let loadingView : UIView = UIView()
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Favorites"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
    
    let AddCategoryButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

extension FavoriteCategoriesView {
    // Tag Touch Action
    func tagsTouchAction(_ tagsView: TagsView, tagButton: TagButton) {
        if purpose == telos.toAddFavorites && wikiID != nil && wikiTitle != nil && tagButton.title(for: .normal) != nil {
            let tagTitle = tagButton.title(for: .normal)!
            addFavoritesContent(id: wikiID!, title: wikiTitle!, documentName: tagTitle)
            self.dismiss(animated: true)
        }
        
        if purpose == telos.toViewFavorites && tagButton.title(for: .normal) != nil {
            let tagTitle = tagButton.title(for: .normal)!
            let view = FavoriteView()
            view.viewTitle.text = tagTitle //tagButton.titleLabel
            var favoritesObjectData : [favorite] = []
            for x in 0...favoriteTags.count - 1 {
                let category = favoriteTags[x].category
                if category == tagTitle {
                    favoritesObjectData = favoriteTags[x].favorites
                }
            }
            view.favoritesData = favoritesObjectData
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    // Last Tag Touch Action
    func tagsLastTagAction(_ tagsView: TagsView, tagButton: TagButton) {
    }
    
    // TagsView Change Height
    func tagsChangeHeight(_ tagsView: TagsView, height: CGFloat) {
    }
    
    private func makeButton(_ item: String) -> TagButton {
        let button = TagButton(type: .system)
        button.setTitle(item, for: .normal)
        button.backgroundColor = .white
        button.setEntity(
            ButtonOptions(
                layerColor: .white,
                layerRadius: 0,
                layerWidth: 0,
                tagTitleColor: .black,
                tagFont: StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 16)!,
                tagBackgroundColor: .white,
                lineBreakMode: NSLineBreakMode.byTruncatingTail
            )
        )
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }
    
    func reloadTagView() {
        tags?.removeAll()
        for x in 0...favoriteTags.count - 1 {
            tags?.append(favoriteTags[x].category)
        }
        if let tags = self.tags?.compactMap({ self.makeButton($0) }) {
            self.tagsView.set(contentsOf: tags)
        }
        tagsView.redraw()
    }
    
}

extension FavoriteCategoriesView : UITextFieldDelegate {
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setupScrollView() {
        scrollView.backgroundColor = .black
        //
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant : 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setUpPaddingView() {
        paddingView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(paddingView)
        paddingView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        paddingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        paddingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        paddingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setUpTagView () {
        self.tagsView.delegate = self
        self.tagsView.marginHorizontal = 8
        self.tagsView.marginVertical = 8
        self.tagsView.paddingHorizontal = 6
        self.tagsView.paddingVertical = 4
        //
        contentView.addSubview(self.tagsView)
        tagsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tagsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tagsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        tagsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80).isActive = true
        //
        tagsView.backgroundColor = .black
        //
        if let tags = self.tags?.compactMap({ self.makeButton($0) }) {
            self.tagsView.set(contentsOf: tags)
        }
    }
    
    func setUpAddCategoryButton() {
        self.view.addSubview(AddCategoryButton)
        let dimesions : CGFloat = 60
        AddCategoryButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        AddCategoryButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        AddCategoryButton.heightAnchor.constraint(equalToConstant: dimesions).isActive = true
        AddCategoryButton.widthAnchor.constraint(equalToConstant: dimesions).isActive = true
        //
        AddCategoryButton.backgroundColor = .white
        AddCategoryButton.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        AddCategoryButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        AddCategoryButton.layer.shadowOpacity = 1.0
        AddCategoryButton.layer.shadowRadius = 0.0
        AddCategoryButton.layer.masksToBounds = false
        
        AddCategoryButton.layer.cornerRadius = CGFloat((dimesions / 2) - 0.5)
//        AddCategoryButton.clipsToBounds = true
        AddCategoryButton.addTarget(self, action: #selector(addNewCategory), for: .touchUpInside)
    }
    
    @objc func addNewCategory() {
        showNewCategoryTextFeild()
        newCategoryTextFeild?.becomeFirstResponder()
    }
    
    func hideKeyboardIfViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        hideNewCategoryTextFeild()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        if purpose == telos.toAddFavorites &&
            wikiID != nil &&
            wikiTitle != nil &&
            newCategoryTextFeild != nil &&
            newCategoryTextFeild!.text != "" &&
            newCategoryTextFeild!.text != nil &&
            tags?.contains(newCategoryTextFeild!.text!) == false
        {
            addFavoritesContent(id: wikiID!, title: wikiTitle!, documentName: newCategoryTextFeild!.text!)
            self.dismiss(animated: true)
        }
        textField.resignFirstResponder()
        return false
    }
    
    // Search Controls
    func showNewCategoryTextFeild() {
        newCategoryTextFeild = {
            var textFeild = UITextField()
            return textFeild
        }()
        
        if newCategoryTextFeild != nil {
            // Hooking Up delegate
            newCategoryTextFeild!.delegate = self
            //
            newCategoryTextFeild!.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(newCategoryTextFeild!)
            newCategoryTextFeild!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            newCategoryTextFeild!.heightAnchor.constraint(equalToConstant: 50).isActive = true
            newCategoryTextFeild!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
            newCategoryTextFeild!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
            // Styles to Search Feild
            newCategoryTextFeild!.layer.cornerRadius = 10
            newCategoryTextFeild!.clipsToBounds = true
            newCategoryTextFeild!.textColor = UIColor.white
            newCategoryTextFeild!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
            newCategoryTextFeild!.setLeftPaddingPoints(8)
            // Default hidden :
            newCategoryTextFeild!.layer.opacity = 0.0
            newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            newCategoryTextFeild!.isHidden = false
            // Adding Blur Affect View
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = newCategoryTextFeild!.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newCategoryTextFeild!.addSubview(blurView)
            //
            UIView.animate(withDuration: 0.3, animations: {
                self.newCategoryTextFeild!.layer.opacity = 1.0
                self.newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: {_ in
                self.newCategoryTextFeild!.becomeFirstResponder()
            })
        }
    }
    
    func hideNewCategoryTextFeild() {
        if newCategoryTextFeild != nil {
            UIView.animate(withDuration: 0.3, animations: {
                self.newCategoryTextFeild!.layer.opacity = 0.0
                self.newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                //
                self.newCategoryTextFeild!.layer.opacity = 0.0
                self.newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }, completion: {_ in
                self.newCategoryTextFeild!.resignFirstResponder()
                self.newCategoryTextFeild!.isHidden = true
                self.newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                //
                self.newCategoryTextFeild!.resignFirstResponder()
                self.newCategoryTextFeild!.isHidden = true
                self.newCategoryTextFeild!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            })
        }
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
    
    func removeLoadingViewFromSubview() {
        loadingView.isHidden = true
        loadingView.removeFromSuperview()
    }
    
}

extension FavoriteCategoriesView {
    func getFavoritesContent() {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("favorites")
            
            docRef.getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                            let model = try JSONDecoder().decode(Favorites.self, from: jsonData)
                            self.favoriteTags.append(FavoritesUIObj(category: "\(document.documentID)", favorites: model.favorites))
                            print(self.favoriteTags)
                            
                        } catch {
                            print(error)
                        }
                    }
                    //
                    self.reloadTagView()
                    self.removeLoadingViewFromSubview()
                }
            }
        }
    }
    
    func addFavoritesContent(id : String, title : String, documentName : String) {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("favorites").document(documentName)
            docRef.getDocument { (document, error) in
                if document != nil && document!.data() != nil {
                    self.updateFavoritesContent(id: id, title: title, documentName: documentName)
                } else {
                    self.setFavoritesContent(id: id, title: title, documentName: documentName)
                }
            }
        }
    }
    
    func setFavoritesContent(id : String, title : String, documentName : String) {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("favorites").document(documentName)
            docRef.setData([
                "favorites" : [
                    [
                        "id" : id,
                        "title" : title
                    ]
                ]
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            BackendSingleton.s.likeContent(
                id: id ,
                title: title
            )
        }
    }
    
    func updateFavoritesContent(id : String, title : String, documentName : String) {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("favorites").document(documentName)
            docRef.updateData([
                "favorites" : FieldValue.arrayUnion([
                    [
                        "id" : id,
                        "title" : title
                    ]
                ])
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            BackendSingleton.s.likeContent(
                id: id ,
                title: title
            )
        }
    }
    
    
}

public struct FavoritesUIObj {
    var category : String
    var favorites: [favorite]
}

public struct Favorites : Decodable {
    let favorites: [favorite]
}

public struct favorite : Decodable {
    let id: String
    let title: String
}


public enum telos {
    case toViewFavorites
    case toAddFavorites
}
