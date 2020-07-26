//
//  ArticleTableViewCell.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDesignation: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleUrl: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
    }
    
    func setData(data: ArticleResponse) {
        userName.text = data.userDetails?.first?.name
        userDesignation.text = data.userDetails?.first?.designation
        articleDescription.text = data.content?.capitalizingFirstLetter()
        articleTitle.text = data.mediaDetails?.first?.title?.capitalizingFirstLetter()
        articleUrl.text = data.mediaDetails?.first?.url
        likeLabel.text = "Like: \(data.likes ?? 0)"
        commentLabel.text = "Comment: \(data.comments ?? 0)"
        setBGImageView()
        setUserImageView(userImageString: data.userDetails?.first?.userAvatar ?? "")
        setArticleImageView(articleImageString: data.mediaDetails?.first?.image ?? "")
    }
    
    func setBGImageView() {
        bgImage.layer.cornerRadius = 10
        bgImage.layer.borderColor = UIColor.darkGray.cgColor
        bgImage.layer.borderWidth = 1.0
    }
    
    func setUserImageView(userImageString: String) {
        userImage.layer.cornerRadius = 40
        userImage.layer.borderColor = UIColor.blue.cgColor
        userImage.layer.borderWidth = 1.0
        userImage.setImage(with: userImageString, placeholder: "article-placeholder", completion: { (_, _, _, _) in
            self.userImage.transform = .identity
            UIView.animate(withDuration: 0.5, animations: {
                self.userImage.transform = self.userImage.transform.scaledBy(x: 1.05, y: 1.05)
            }, completion: { _ in
            })
        })
    }
    
    func setArticleImageView(articleImageString: String) {
        articleImage.setImage(with: articleImageString, placeholder: "article-placeholder", contentMode: .center, completion: { (_, _, _, _) in
            self.articleImage.transform = .identity
            UIView.animate(withDuration: 0.5, animations: {
                self.articleImage.transform = self.articleImage.transform.scaledBy(x: 1.05, y: 1.05)
            }, completion: { _ in
            })
        })
    }
    
}
