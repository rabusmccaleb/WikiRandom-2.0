//
//  NotesCell.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/22/23.
//

import Foundation
import UIKit

class NotesCell : UITableViewCell {
    let reuseID = "NotesCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
     }
    
    func setUpTableViewLabel(text : String) {
        let cellLabel = UILabel()
        cellLabel.text = text
        cellLabel.textAlignment = .left
        cellLabel.textColor = .white
        cellLabel.font = StyleSingleton.s.fontType(fonts: .AvenirNextMedium, fontSize: 18)
        
        let cellStyleView = UIView()
        cellStyleView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellStyleView)
        cellStyleView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellStyleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        cellStyleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellStyleView.widthAnchor.constraint(equalToConstant : 8).isActive = true
        cellStyleView.backgroundColor = .darkGray
        cellStyleView.layer.cornerRadius = 2
        cellStyleView.clipsToBounds = true
        
        //
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellLabel)
        cellLabel.leadingAnchor.constraint(equalTo: cellStyleView.trailingAnchor, constant: 20).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -0).isActive = true
        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
    }
 
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 
 
}
