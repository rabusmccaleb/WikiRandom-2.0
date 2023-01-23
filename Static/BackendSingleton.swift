//
//  BackendSingleton.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/7/23.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Firebase

class BackendSingleton {
    private init () {}
    static var s = BackendSingleton()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let auth = Auth.auth()
    var userId : String?
    var userProfileImage : UIImage?
    var userBackgroundImage : UIImage?
    var pageList : [Page]?
    var likesData : Likes?
    var language : String = "en"
    
    func networkRequest() {
        let url = URL(string: "https://\(language).wikipedia.org/w/api.php?format=json&action=query&generator=random&grnnamespace=0&rvprop=content&grnlimit=1000")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse,
                   (200...299).contains(response.statusCode) {
                    // success
                    if let json = json as? [String: Any] {
                        let value = json["query"]
                        if let randomValues = value as? [String: Any] {
                            self.pageList = self.decodeJSON(dicData: randomValues)
                        }
                    }
                }
            } else {
                print(error as Any)
            }
        }
        task.resume()
    }
    
    func decodeJSON(dicData : Any) -> [Page]? {
        var dataArr : [Page]?
        if let data = try? JSONSerialization.data(withJSONObject: dicData, options: .prettyPrinted) {
            do {
                let pages = try JSONDecoder().decode(PagesContainer.self, from: data as! Data).pagesList//decoder.decode([Page].self, from: data as! Data)
                dataArr = pages
            } catch {
                print(error)
            }
        }
        return dataArr
    }
    
    func checkIfSignedIn() {
        auth.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.userId = user!.uid
            }
        }
    }
    
    func SignUp(email : String, password : String) {
        auth.createUser(withEmail: email, password: password)
        { authResult, error in
            if let user = authResult?.user {
                self.userId = user.uid
            }
        }
    }
        
    func SignIn(email : String, password : String) {
        auth.signIn(withEmail: email, password: password)
        { authResult, error in
            if let user = authResult?.user {
                self.userId = user.uid
            }
        }
    }
    
    func SignOut() {
        // https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
        do {
            try auth.signOut()
        } catch {
            print("Error While Attepting to Sign Out")
        }
    }
    
    func uploadImage(imageType : userImageType, image : UIImage) {
        if userId != nil {
            let imagePath : String = (imageType == userImageType.userProfileImage) ? AppConstant.s.profileImagePath : AppConstant.s.userbackgroundImagePath
            let storageRef = storage.reference().child("\(imagePath)/\(userId!)")
            let compressionQuality : CGFloat = (imageType == userImageType.userProfileImage) ? 0.1 : 0.85
            let data = image.jpegData(compressionQuality: compressionQuality)
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            if data != nil {
                storageRef.putData(data!, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                      return
                    }
                    let size = metadata.size
                    storageRef.downloadURL { (url, error) in
                      guard let downloadURL = url else {
                        return
                      }
                    }
                }
            }
        }
    }
        
    func getImage(imageType : userImageType, imageView : UIImageView) {
        if userId != nil {
            let imagePath : String = (imageType == userImageType.userProfileImage) ? AppConstant.s.profileImagePath : AppConstant.s.userbackgroundImagePath
            let storageRef = storage.reference().child("\(imagePath)/\(userId!)")
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print(error)
              } else {
                  if imageType == userImageType.userProfileImage {
                      self.userProfileImage = UIImage(data: data!)
                      imageView.image = UIImage(data: data!)
                  } else {
                      self.userBackgroundImage = UIImage(data: data!)
                      imageView.image = UIImage(data: data!)
                  }
              }
            }
        }
    }
    
    var staticLikedPagesList : [String] = []
    func likeContent(id : String, title : String) {
        if userId != nil {
            let dbPath = db.collection(AppConstant.s.savedContentPath).document(userId!)
            dbPath.updateData([
                "likes" : FieldValue.arrayUnion([
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
        }
    }
    
    func getLikeContent() {
        if userId != nil {
            let docRef = db.collection(AppConstant.s.savedContentPath).document(userId!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        let model = try JSONDecoder().decode(Likes.self, from: jsonData)
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
    
    //
    func favoriteContent(id : String, title : String, favoritesColletionTitle : String) {
        if userId != nil {
            let dbPath = db.collection(AppConstant.s.savedContentPath)
                .document(userId!)
                .collection(favoritesColletionTitle)
                .document("Favorites")
            
            dbPath.updateData([
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
        }
    }
}

public enum userImageType {
    case userProfileImage
    case userBackgroundImage
}

public struct Page: Decodable {
    let pageid: Int
    let ns: Int
    let title: String
}

struct PagesContainer: Decodable {
  let pagesList: [Page]

  private enum CodingKeys: String, CodingKey {
      case pages
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let pagesDict = try container.decode([String: Page].self, forKey: .pages)
    self.pagesList = pagesDict.map { $0.value }
  }
}

public struct Likes : Decodable {
    let likes: [Like]
}

public struct Like: Decodable {
    let id: String
    let title: String
}

