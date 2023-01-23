//
//  NoteView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit
import FirebaseFirestore

class NoteView : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUpViewTitle()
        setUpDescriptionLabel()
        setUpTitleFild()
        setUpConfirmButton()
        setUpTextView()
    }

    
    let descriptionLabel = UILabel()
    let titleFeild = UITextField()
    let contentTextView = UITextView()
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Note"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
    
    let confirmButton : UIButton = {
        var button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setUpDescriptionLabel () {
        descriptionLabel.text = "Create a Note..."
        descriptionLabel.textAlignment = .left
        //
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant : 20).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setUpTitleFild() {
        titleFeild.translatesAutoresizingMaskIntoConstraints = false
        titleFeild.borderStyle = .roundedRect
        self.view.addSubview(titleFeild)
        titleFeild.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant : 20).isActive = true
        titleFeild.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        titleFeild.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        titleFeild.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleFeild.placeholder = "Add Title"
    }
    
    func setUpConfirmButton() {
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(confirmButton)
        confirmButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant : -40).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.layer.cornerRadius = 12.5
        confirmButton.clipsToBounds = true
        //
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
    }
    
    @objc func confirm() {
        if titleFeild.text != nil && contentTextView.text != nil {
            updateNotes(title: titleFeild.text!, content: contentTextView.text!)
        }
    }
    
    func updateNotes(title : String, content : String) {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("notes").document("notes")

            docRef.updateData([
                "notes" : FieldValue.arrayUnion([
                    [
                        "title" : title,
                        "content" : content
                    ]
                ])
            ]){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setUpTextView() {
        //
        contentTextView.layer.cornerRadius = 10
        contentTextView.clipsToBounds = true
        //
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5).cgColor
        self.view.addSubview(contentTextView)
        //
        contentTextView.topAnchor.constraint(equalTo: titleFeild.bottomAnchor, constant: 20).isActive = true
        contentTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        contentTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20).isActive = true
    }
    //
}
