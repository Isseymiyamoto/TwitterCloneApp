//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by 宮本一成 on 2020/04/25.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import ActiveLabel

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        // clipsToBounds → UIView及びそれを継承しているComponentのプロパティであり,領域(bounds)内(外)に描画するか否かを決定する.
        // false → 領域外にも描画する true → 領域内のみに記述する
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private lazy var replyLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.mentionColor = .twitterBlue
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return label
    }()
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    init(user: User, config: UploadTweetConfiguration){
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureMentionHandler()
        
//        switch config {
//        case .tweet:
//            print("DEBUG: Config is tweet")
//        case .reply(let tweet):
//            print("DEBUG: Replying to \(tweet.caption)")
//        }
    }
    
    //MARK: - Selectors
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet(){
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption, type: config) { (error, ref) in
            if let error = error{
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(toUser: tweet.user, type: .reply, tweetID: tweet.tweetID)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: - API
    
    fileprivate func uploadMentionNotification(forCaption caption: String, tweetID: String?){
        guard caption.contains("@") else { return }
        let words = caption.components(separatedBy: .whitespacesAndNewlines)
        
        words.forEach { (word) in
            guard word.hasPrefix("@") else { return }
            
            var username = word.trimmingCharacters(in: .symbols)
            username = username.trimmingCharacters(in: .punctuationCharacters)
            
            UserService.shared.fetchUser(withUsername: username) { (user) in
                NotificationService.shared.uploadNotification(toUser: user, type: .mention, tweetID: tweetID)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        configureNavigationBar()
        
        // stackViewでプロフィール画像とツイートテキストを横並びにする
        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLable.text = viewModel.placeholderText
        
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    
    
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = .white
        // isTranslucent → ナビゲーションバーを透過にするかのフラグであり,ビューの開始位置を決めるフラグ
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    func configureMentionHandler(){
        replyLabel.handleMentionTap { (mention) in
            print("DEBUG: Mentioned user is \(mention)")
        }
    }
}
