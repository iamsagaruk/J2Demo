//
//  BaseViewController.swift
//  J2TTDemo
//
//  Created by Sagar on 26/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showErrorAlert(errorModel: NetworkErrorModel?) {
        let networkErrorModel = errorModel ?? getDefaultErrorModel()
        let network = networkErrorModel.networkStatusType
        setErrorLabelText(errorText: network.errorDescription())
        let alert = UIAlertController(title: network.errorTitle(), message: network.errorDescription(),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: AppConstant.kOk,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setErrorLabelText(errorText: String) {
        errorLabel.text = errorText
    }
}
