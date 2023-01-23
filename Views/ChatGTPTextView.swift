//
//  ChatGTPTextView.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/13/23.
//

import UIKit

class ChatGTPTextView: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    var questionText = ""
    var contentText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        setupScrollView()
        setupViews()
        questionLabel.text = questionText
        contentLabel.text = contentText
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
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleSingleton.s.fontType(fonts: .AvenirNextDemiBold, fontSize: 24)
        label.textAlignment = .left
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleSingleton.s.fontType(fonts: .AvenirNextMedium, fontSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    let chatLogoImage : UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "OpenAI_Logo.svg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func setupViews(){
        //
        contentView.addSubview(chatLogoImage)
        chatLogoImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        chatLogoImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        chatLogoImage.topAnchor.constraint(
            equalTo: self.view.safeAreaLayoutGuide.topAnchor,
            constant: 20).isActive = true
        chatLogoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //
        contentView.addSubview(questionLabel)
        questionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: chatLogoImage.bottomAnchor, constant: 20).isActive = true
        questionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        //
        contentView.addSubview(contentLabel)
        contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 25).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
