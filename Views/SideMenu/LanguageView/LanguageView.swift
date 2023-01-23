//
//  LanguageView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit

class LanguageView : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedValue : String = "en"
    let languages : [language] = [
        language(language: "English", abbreviation: "en"),
        language(language: "Spanish", abbreviation: "es"),
        language(language: "French", abbreviation: "fr"),
        language(language: "Italian", abbreviation: "it"),
        language(language: "Russia", abbreviation: "ru"),
        language(language: "German", abbreviation: "de"),
        language(language: "Greek", abbreviation: "el"),
        language(language: "Arabic", abbreviation: "ar"),
        language(language: "Portuguese", abbreviation: "pt"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setUpViewTitle()
        setUpViewDescription()
        setUpPicker()
        setUpConfirmButton()
    }
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Language"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .center
        return title
    }()
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    let viewDescription : UILabel = {
        var title = UILabel()
        title.text = "select a language"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 20)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    func setUpViewDescription() {
        viewDescription.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewDescription)
        viewDescription.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 40).isActive = true
        viewDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        viewDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    let picker : UIPickerView = {
        var picker = UIPickerView()
        return picker
    }()
    
    func setUpPicker() {
        picker.dataSource = self
        picker.delegate = self
        //
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        //
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
    let confirmButton : UIButton = {
        var button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
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
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        // selected value in Uipickerview in Swift
        let value = languages[row].abbreviation
        BackendSingleton.s.language = value
        BackendSingleton.s.pageList = []
        BackendSingleton.s.networkRequest()
    }
    
    @objc func confirm() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "\(languages[row].language)"
    }
    
    
}


struct language {
    var language : String
    var abbreviation : String
}
