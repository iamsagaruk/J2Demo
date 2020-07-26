//
//  ArticleViewController.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import UIKit
import Foundation

class ArticleViewController: BaseViewController {
    @IBOutlet weak var articleTableView: UITableView!

    var articleVM: ArticleViewModel {
        return ArticleViewModel.sharedArticleVM
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticleDetails()
    }
    
    override func viewDidLayoutSubviews() {
        articleTableView.layoutIfNeeded()
    }
    
    func getArticleDetails() {
        if InternetManager.isConnectedToInternet {
            addProgressHud()
            articleVM.getArticleDetails { [weak self] (isSuccess, detail, errorModel) in
                DispatchQueue.main.async {
                    hideProgressHud()
                    if isSuccess {
                        self?.setTableView()
                    } else {
                        self?.showErrorAlert(errorModel: errorModel)
                    }
                }
            }
        } else {
            self.showErrorAlert(errorModel: getNoInternetErrorModel())
        }
    }
    
    func setTableView() {
        setErrorLabelText(errorText: "")
        articleTableView.dataSource = self
        articleTableView.delegate = self
        //articleTableView.rowHeight = UITableView.automaticDimension
        //articleTableView.estimatedRowHeight = AppConstant.kArticleTableRowHeight
        articleTableView.reloadData()
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleVM.articleList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppConstant.kArticleTableViewCell)  as? ArticleTableViewCell
            else { return UITableViewCell() }
        if let data = articleVM.articleList?[indexPath.row] {
            cell.setData(data: data)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AppConstant.kArticleTableRowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
