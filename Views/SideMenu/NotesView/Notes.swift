//
//  Notes.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit
import FirebaseFirestore

class NotesView : UIViewController {
    var NotesData : Notes?
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
        getNoteContent()
        addLoadingView()
        setUpAddNoteButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //
    }
    
    func getNoteContent() {
        if BackendSingleton.s.userId != nil {
            let docRef = BackendSingleton.s.db.collection(AppConstant.s.savedContentPath).document(BackendSingleton.s.userId!).collection("notes").document("notes")

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(Notes.self, from: jsonData)
                        self.NotesData = model
                        self.tableView.reloadData()
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
    
    let AddNoteButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewTitle : UILabel = {
        var title = UILabel()
        title.text = "Notes"
        title.font = StyleSingleton.s.fontType(fonts: .AvenirNextBold, fontSize: 30)
        title.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        title.textAlignment = .left
        return title
    }()
    
    let loadingView : UIView = UIView()
}


extension NotesView : UITableViewDelegate, UITableViewDataSource {
    
    func setUpViewTitle() {
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewTitle)
        viewTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant : 12).isActive = true
        viewTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        viewTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20).isActive = true
    }
    
    func setUpTableView() {
        tableView.register(NotesCell.self, forCellReuseIdentifier: NotesCell().reuseID)
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
    
    func setUpAddNoteButton() {
        self.view.addSubview(AddNoteButton)
        let dimesions : CGFloat = 60
        AddNoteButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        AddNoteButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        AddNoteButton.heightAnchor.constraint(equalToConstant: dimesions).isActive = true
        AddNoteButton.widthAnchor.constraint(equalToConstant: dimesions).isActive = true
        //
        AddNoteButton.backgroundColor = .white
        AddNoteButton.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        AddNoteButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        AddNoteButton.layer.shadowOpacity = 1.0
        AddNoteButton.layer.shadowRadius = 0.0
        AddNoteButton.layer.masksToBounds = false
        
        AddNoteButton.layer.cornerRadius = CGFloat((dimesions / 2) - 0.5)
//        AddCategoryButton.clipsToBounds = true
        AddNoteButton.addTarget(self, action: #selector(addNoteButton), for: .touchUpInside)
    }
    
    @objc func addNoteButton() {
        let view = NoteView()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if NotesData != nil {
            return NotesData!.notes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesCell().reuseID, for: indexPath) as! NotesCell
        if NotesData != nil {
            cell.setUpTableViewLabel(text: NotesData!.notes[indexPath.row].title)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight : CGFloat = 50
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NotesData != nil {
            let title = NotesData!.notes[indexPath.row].title
            let content = NotesData!.notes[indexPath.row].content
            let view = NotesTextView()
            view.titleText = title
            view.contentText = content
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}

public struct Notes : Decodable {
    let notes: [Note]
}

public struct Note : Decodable {
    let title : String
    let content : String
}
