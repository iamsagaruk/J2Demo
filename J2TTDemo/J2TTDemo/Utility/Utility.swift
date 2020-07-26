//
//  Utility.swift
//  J2TTDemo
//
//  Created by Sagar on 26/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

typealias ImageCompletionHandler = (_ image: UIImage?, _ error: NSError?, _ cacheType: CacheType, _ url: URL?) -> Void

extension UIImageView {
    func setImage(with url: String,
                  placeholder: String = "",
                  backgroundColor: UIColor = .lightGray,
                  contentMode: UIView.ContentMode = .scaleAspectFill,
                  completion: ImageCompletionHandler? = nil) {
        self.backgroundColor = backgroundColor
        self.contentMode = contentMode
        let newUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let imageUrl = URL(string: newUrl)
        let placeholderImage = placeholder == "" ? nil : UIImage(named: placeholder)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imageUrl, placeholder: placeholderImage) { [weak self] (image, error, cacheType, url) in
            if image != nil {
                self?.contentMode = contentMode
                self?.backgroundColor = backgroundColor
            }
            completion?(image, error, cacheType, url)
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

func getNoInternetErrorModel() -> NetworkErrorModel {
    var errorModel = NetworkErrorModel()
    errorModel.networkStatusType = .noInternet
    return errorModel
}

func getDefaultErrorModel() -> NetworkErrorModel {
    var errorModel = NetworkErrorModel()
    errorModel.networkStatusType = .somethingWentWrong
    return errorModel
}

func addProgressHud() {
    ProgressHUD.show("Loading..", interaction: false)
    ProgressHUD.hudColor(UIColor.black)
    let backColor = UIColor.white.withAlphaComponent(0.5)
    ProgressHUD.backgroundColor(backColor)
    ProgressHUD.spinnerColor(.black)
}

func hideProgressHud() {
    ProgressHUD.dismiss()
}
