//
//  ViewController.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/7/23.
//

import UIKit
import WebKit
import SideMenu
import FirebaseStorage

// https://stackoverflow.com/questions/42023612/swift-text-to-speech

class ViewController: UIViewController {
    // Delcaration Variables
    private var lastContentOffset: CGFloat = 0
    var chatGTPContentText : String?
    var webURL : String = ""
    var API_LoadTimer: Timer?
    var pageCount = 0
    var searchType : SearchType = .Google
    var controlsRadius : CGFloat = 32
    var selectingImageType : userImageType = .userProfileImage
    var currentLanguage = "en"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = StyleSingleton.s.mainViewBackgroundColor
        BackendSingleton.s.networkRequest()
        BackendSingleton.s.checkIfSignedIn()
        // BackendSingleton.s.getImage(imageType: .userProfileImage, imageView: profileImage)
        //
        startTimer()
        //
        hideKeyboardIfViewTapped()
        //
        self.navigationController?.navigationBar.isHidden = true
        setupWebView()
        webView.scrollView.delegate = self
        setUpButtonTargets()
        setUpControlsView()
        setUpSideMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if currentLanguage != BackendSingleton.s.language {
            currentLanguage = BackendSingleton.s.language
            startTimer()
        }
    }

    func startTimer() {
        API_LoadTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            // code to be executed every 1 second
            if let pages = BackendSingleton.s.pageList {
                self?.webURL = "http://\(BackendSingleton.s.language).m.wikipedia.org/?curid=\(pages[self!.pageCount].pageid)"
                let url = URL(string: self!.webURL)!
                self?.webView.load(URLRequest(url: url))
                self?.webView.allowsBackForwardNavigationGestures = true
                //
//                BackendSingleton.s.getLikeContent()
                //
                self?.API_LoadTimer!.invalidate()
                if BackendSingleton.s.userId != nil {
                    self?.getImage(imageType: .userProfileImage, imageView: self?.profileImage)
                }
            }
        }
    }
    
    func getImage(imageType : userImageType, imageView : UIImageView?) {
        if  BackendSingleton.s.userId != nil {
            let imagePath : String = (imageType == userImageType.userProfileImage) ? AppConstant.s.profileImagePath : AppConstant.s.userbackgroundImagePath
            let storageRef =  BackendSingleton.s.storage.reference().child("\(imagePath)/\( BackendSingleton.s.userId!)")
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                  print(error)
              } else {
                  if imageType == userImageType.userProfileImage {
                      imageView?.image = UIImage(data: data!)
                      BackendSingleton.s.userBackgroundImage = UIImage(data: data!)
                      BackendSingleton.s.userProfileImage = UIImage(data: data!)
                  } else {
                      imageView?.image = UIImage(data: data!)
                      BackendSingleton.s.userBackgroundImage = UIImage(data: data!)
                      BackendSingleton.s.userProfileImage = UIImage(data: data!)
                  }
              }
            }
        }
    }
    
    func hideKeyboardIfViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        hideSearchFeild()
    }
    
    // View Variables
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let stackView = UIStackView()
    var searchFeild : UITextField?
    let pasteButton : UIButton = UIButton()
    let menu = SideMenuNavigationController(rootViewController: SideMenuView())
    var imagePicker = UIImagePickerController()
    
    let topControlsView : UIView = {
        var view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        //
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    let menuButton : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let profileImage : UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nextButton : UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let PreviousButton : UIButton = {
        var button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let SearchGoogle : UIImageView = {
        var imageView = UIImageView()
        let padding : CGFloat = 50
        let googleImage = UIImage(named: "Google")?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        imageView.image = googleImage

        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let SearchChatGTP : UIImageView = {
        var imageView = UIImageView()
        let padding : CGFloat = 30
        imageView.image = UIImage(named: "chatGTP")?.imageWithInsets(insets: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let AddToFavorites : UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    
    func setUpButtonTargets() {
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        PreviousButton.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        // Chat
        let chatGesture = UITapGestureRecognizer(target: self, action: #selector(chatSuperQuery))
        SearchChatGTP.isUserInteractionEnabled = true
        SearchChatGTP.addGestureRecognizer(chatGesture)
        // Chat
        let googleSearchGesture = UITapGestureRecognizer(target: self, action: #selector(googleSearch))
        SearchGoogle.isUserInteractionEnabled = true
        SearchGoogle.addGestureRecognizer(googleSearchGesture)
        // like / add to favorites
        let likeGesture = UITapGestureRecognizer(target: self, action: #selector(likeContent))
        let FavoritesGesture = UILongPressGestureRecognizer(target: self, action: #selector(favoriteContent))
        AddToFavorites.addTarget(self, action: #selector(likeContent), for: .touchUpInside)
        AddToFavorites.addGestureRecognizer(FavoritesGesture)
    }
    
    @objc func likeContent() {
        if let pageData = BackendSingleton.s.pageList {
            BackendSingleton.s.likeContent(
                id: "\(pageData[pageCount].pageid)" ,
                title: pageData[pageCount].title
            )
            BackendSingleton.s.staticLikedPagesList.append("\(pageData[pageCount].pageid)")
            AddToFavorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            AddToFavorites.tintColor = .red
        }
    }
    
    @objc func favoriteContent() {
        if let pageData = BackendSingleton.s.pageList {
            let favsView = FavoriteCategoriesView()
            favsView.wikiID = "\(pageData[pageCount].pageid)"
            favsView.wikiTitle = pageData[pageCount].title
            favsView.purpose = .toAddFavorites
            //
            BackendSingleton.s.staticLikedPagesList.append("\(pageData[pageCount].pageid)")
            AddToFavorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            AddToFavorites.tintColor = .red
            self.present(favsView, animated: true)
        }
    }
    
    @objc func nextPage() {
        if let pages = BackendSingleton.s.pageList {
            print()
            if pageCount < pages.count {
                print(pages[pageCount].pageid)
                pageCount = pageCount + 1
                webURL = "http://\(BackendSingleton.s.language).m.wikipedia.org/?curid=\(pages[pageCount].pageid)"
                reloadWebView()
                AddToFavorites.setImage(UIImage(systemName: "heart"), for: .normal)
                AddToFavorites.tintColor = .white
            }
        }
    }
    
    @objc func prevPage() {
        if let pages = BackendSingleton.s.pageList {
            if pageCount >= 1 {
                pageCount = pageCount - 1
                webURL = "http://\(BackendSingleton.s.language).m.wikipedia.org/?curid=\(pages[pageCount].pageid)"
                reloadWebView()
                AddToFavorites.setImage(UIImage(systemName: "heart"), for: .normal)
                AddToFavorites.tintColor = .white
            }
        }
    }
    
    @objc func chatSuperQuery() {
        searchType = .ChatGTP
        if searchFeild?.isHidden == true || searchFeild == nil {
            showSearchFeild()
        } else {
            hideSearchFeild()
        }
    }
    
    @objc func googleSearch() {
        searchType = .Google
        if searchFeild?.isHidden == true || searchFeild == nil  {
            showSearchFeild()
        } else {
            hideSearchFeild()
        }
    }
    
    func reloadWebView() {
        let url = URL(string: webURL)!
        let urlRequest = URLRequest(url: url)
        UIView.animate(withDuration: 0.15, animations: {
            self.webView.layer.opacity = 0.0
            self.webView.load(urlRequest)
        }, completion: nil)
    }
}


// WebView Setup
// WebView Setup
// WebView Setup
extension ViewController: WKNavigationDelegate, WKUIDelegate {
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
    //
    func setupWebView() {
        webView.navigationDelegate = self
        webView.backgroundColor = .black
        self.view.addSubview(webView)
        //
        webView.layer.cornerRadius = 8
        webView.clipsToBounds = true
        //
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.webView.layer.opacity = 1.0
        })
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        deleteCache()
        self.webView.scrollView.contentOffset = CGPoint(x:0, y: -200) //
        let js = """
                    var Timer = setInterval(function() {
                      const footer = document.querySelector('footer');
                      if (footer) {
                        const link = document.createElement('link');
                        link.setAttribute('href', 'https://rabusmccaleb.github.io/wikiRandomStyles/WikiPageStyles.css');
                        link.setAttribute('rel', 'stylesheet');
                        link.setAttribute('type', 'text/css"');
                        const scriptElem = document.createElement('script');
                        scriptElem.setAttribute('src', 'https://rabusmccaleb.github.io/wikiRandomStyles/index.js');
                        document.querySelector('footer').appendChild(link);
                        document.querySelector('footer').appendChild(scriptElem);
                        clearInterval(Timer);
                      }
                    }, 10)
                    Timer;
                """
        webView.evaluateJavaScript(js, completionHandler: {Status, Error  in
            print(" Error JS Run : \(Error)")
            print(" Status : \(Status)")
            print("JS should have been ran")
        })
        webView.callAsyncJavaScript(js, in: .none, in: .defaultClient)
    }

    private func deleteCache(){
            if #available(iOS 9.0, *) {
              let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
              let date = NSDate(timeIntervalSince1970: 0)
                WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
            } else {
                var libraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, false).first!
                libraryPath += "/Cookies"

                do {
                    try FileManager.default.removeItem(atPath: libraryPath)
                } catch {
                  print("error")
                }
                URLCache.shared.removeAllCachedResponses()
            }
        }
}


// ScrollView Controlls
// ScrollView Controlls
// ScrollView Controlls
// ScrollView Controlls
extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                self?.stackView.alpha = 1.0
                self?.stackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: { _ in
                self.hideSearchFeild()
            })
        } else if lastContentOffset < scrollView.contentOffset.y {
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                self?.stackView.alpha = 0
                self?.stackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.3) //self?.stackView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }, completion: nil)
        }
    }
}


// StackView Setup
// StackView Setup
// StackView Setup
// StackView Setup
import UIKit
extension ViewController {
    func setUpControlsView() {
        //
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        // Adding Shadow to view
        stackView.layer.shadowColor = UIColor.black.cgColor
        stackView.layer.shadowOpacity = 0.5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowRadius = 5
        stackView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(shareTextButton))
        stackView.addGestureRecognizer(panGesture)
        //
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = stackView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.addSubview(blurView)
        //
        stackView.addArrangedSubview(PreviousButton)
        stackView.addArrangedSubview(SearchChatGTP)
        stackView.addArrangedSubview(AddToFavorites)
        stackView.addArrangedSubview(SearchGoogle)
        stackView.addArrangedSubview(nextButton)
        //
        nextButton.backgroundColor = .clear
        SearchChatGTP.backgroundColor = StyleSingleton.s.ChatGTPGreen
        AddToFavorites.backgroundColor = .clear
        SearchGoogle.backgroundColor = .white
        PreviousButton.backgroundColor = .clear
        //Adding Padding to ImageView buttons
        PreviousButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        nextButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        PreviousButton.tintColor = .white
        nextButton.tintColor = .white
        //
        SearchChatGTP.layer.cornerRadius = controlsRadius
        SearchChatGTP.clipsToBounds = true
        SearchChatGTP.layer.opacity = 0.75
        SearchGoogle.layer.cornerRadius = controlsRadius
        SearchGoogle.clipsToBounds = true
        SearchGoogle.layer.opacity = 0.75
        //
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        stackView.layer.cornerRadius = controlsRadius
        stackView.clipsToBounds = true
        //Constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 65)
        ])
        // Customize the button
        for button in [PreviousButton, SearchChatGTP, AddToFavorites, SearchGoogle, nextButton] {
            button.heightAnchor.constraint(equalToConstant: 65).isActive = true
        }
    }
    
    @objc func shareTextButton() {
            // text to share
        if BackendSingleton.s.pageList != nil {
            let text = "http://en.m.wikipedia.org/?curid=\(BackendSingleton.s.pageList![pageCount])"
            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}



// OpenAI Controls
// OpenAI Controls
// OpenAI Controls
import OpenAISwift
extension ViewController {
    func performOpenAiSearchRequest(query: String) {
        let openAI = OpenAISwift(authToken: AppConstant.s.OPEN_AI_API_KEY)
        openAI.sendCompletion(with: query, model: .gpt3(.davinci), maxTokens: 3999)  { result in
            //https://beta.openai.com/docs/models/gpt-3
            switch result {
            case .success(let success):
                print(success.choices)
                var chatText = success.choices.first?.text ?? ""
                DispatchQueue.main.sync {
                    print(chatText)
                    if self.searchFeild != nil {
                        let chatView = ChatGTPTextView()
                        chatView.questionText = self.searchFeild!.text ?? ""
                        chatView.contentText = chatText
                        self.navigationController?.pushViewController(chatView, animated: true)
                    }
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


// Search Controls
// Search Controls
// Search Controls
extension ViewController: UISearchBarDelegate, UITextFieldDelegate {
    func showSearchFeild() {
        searchFeild = {
            var searchBar = UITextField()
            searchBar.placeholder = "Search"
            return searchBar
        }()
        
        if searchFeild != nil {
            // Hooking Up delegate
            searchFeild!.delegate = self
            //
            searchFeild!.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(searchFeild!)
            searchFeild!.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20).isActive = true
            searchFeild!.heightAnchor.constraint(equalToConstant: 50).isActive = true
            // The leading and trailing contraints have these values in order to stretch the searchFeild pass
            // the stackview/ controlls view
            searchFeild!.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0).isActive = true
            searchFeild!.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20).isActive = true
            // Styles to Search Feild
            searchFeild!.layer.cornerRadius = 10
            searchFeild!.clipsToBounds = true
            searchFeild!.textColor = UIColor.white
            searchFeild!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
            searchFeild!.setLeftPaddingPoints(8)
            // Default hidden :
            searchFeild!.layer.opacity = 0.0
            searchFeild!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            searchFeild!.isHidden = false
            // Adding Blur Affect View
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = searchFeild!.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            searchFeild!.addSubview(blurView)
            //
            UIView.animate(withDuration: 0.3, animations: {
                self.searchFeild!.layer.opacity = 1.0
                self.searchFeild!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: {_ in
                self.searchFeild!.becomeFirstResponder()
            })
            showPasteButton()
        }
    }
    
    func showPasteButton() {
        pasteButton.setTitle("Paste", for: .normal)
        let uiColor = (searchType == SearchType.ChatGTP) ? StyleSingleton.s.ChatGTPGreen : StyleSingleton.s.GoogleBlue
        pasteButton.tintColor = uiColor
        pasteButton.setTitleColor(uiColor, for: .normal)
        pasteButton.layer.cornerRadius = 5
        pasteButton.clipsToBounds = true
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = pasteButton.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pasteButton.addSubview(blurView)
        //
        pasteButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(pasteButton)
        pasteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pasteButton.bottomAnchor.constraint(equalTo: searchFeild!.topAnchor, constant: -8).isActive = true
        pasteButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        //
        pasteButton.addTarget(self, action: #selector(pasteText), for: .touchUpInside)
        //
        pasteButton.layer.opacity = 0.0
        pasteButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        pasteButton.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.pasteButton.layer.opacity = 1.0
            self.pasteButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: {_ in
            self.pasteButton.becomeFirstResponder()
        })
    }
    
    func hideSearchFeild() {
        if searchFeild != nil {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchFeild!.layer.opacity = 0.0
                self.searchFeild!.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
                //
                self.pasteButton.layer.opacity = 0.0
                self.pasteButton.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            }, completion: {_ in
                self.searchFeild!.resignFirstResponder()
                self.searchFeild!.isHidden = true
                self.searchFeild!.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                //
                self.pasteButton.resignFirstResponder()
                self.pasteButton.isHidden = true
                self.pasteButton.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("searchType : \(searchType)")
        if(searchType == SearchType.ChatGTP){
            performChatGTPSearch()
        }
        if (searchType == SearchType.Google) {
            performGoogleSearch()
        }
        dismissKeyboard()
        textField.resignFirstResponder()
        return false
    }
    
    func performChatGTPSearch() {
        let searchText : String? = searchFeild!.text
        if let searchQuery = searchText {
            performOpenAiSearchRequest(query: searchQuery)
        }
    }
    
    func performGoogleSearch() {
        let searchText : String? = searchFeild!.text
        if let searchQuery = searchText {
            let webView = WebQueryView()
            webView.webURL = .google
            webView.QueryParameters = searchQuery
            self.navigationController?.pushViewController(webView, animated: true)
        }
    }
    
    @objc func pasteText() {
        let pb: UIPasteboard? = .general
        guard let text = pb?.string else { return }
        if text != nil {
            searchFeild?.text = text
            if(searchType == SearchType.ChatGTP){
                performChatGTPSearch()
            }
            if (searchType == SearchType.Google) {
                performGoogleSearch()
            }
        }
    }
}


enum SearchType {
    case Google
    case ChatGTP
}



// SideMenu Setup
// SideMenu Setup
// SideMenu Setup
// SideMenu Setup
extension ViewController : SideMenuNavigationControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func setUpSideMenu () {
        //
        topControlsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topControlsView)
        topControlsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topControlsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topControlsView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topControlsView.heightAnchor.constraint(equalToConstant: 108).isActive = true
        //
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        topControlsView.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: topControlsView.leadingAnchor, constant: 20).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        profileImage.backgroundColor = .lightGray
        profileImage.layer.cornerRadius = 17
        profileImage.clipsToBounds = true
        let userProfileGesture = UITapGestureRecognizer(target: self, action: #selector(pullUpImagePicker_profileImage))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(userProfileGesture)
        //
        let AppTitle = UILabel()
        AppTitle.text = AppConstant.s.appName
        AppTitle.translatesAutoresizingMaskIntoConstraints = false
        topControlsView.addSubview(AppTitle)
        AppTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
        AppTitle.centerXAnchor.constraint(equalTo: topControlsView.centerXAnchor).isActive = true
        AppTitle.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
        AppTitle.font = StyleSingleton.s.fontType(fonts: .TimesNewRomanPSBoldItalicMT, fontSize: 20)
        AppTitle.textAlignment = .center
        //
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        topControlsView.addSubview(menuButton)
        menuButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        menuButton.trailingAnchor.constraint(equalTo: topControlsView.trailingAnchor, constant: -20).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        menuButton.addTarget(self, action: #selector(menuPress), for: .touchUpInside)
    }
    
    @objc func menuPress() {
        if true == true {
            present(menu, animated: true, completion: nil)
        } else {}
    }
    
    @objc func pullUpImagePicker_profileImage() {
        selectingImageType = .userProfileImage
        pullupImagePicker()
    }
    
    func pullupImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            BackendSingleton.s.uploadImage(imageType: .userProfileImage, image: image)
            profileImage.image = image
            BackendSingleton.s.userBackgroundImage = image
        }
    }
    
}


