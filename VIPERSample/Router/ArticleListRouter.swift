//
//  ArticleListRouter.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import UIKit

protocol ArticleListRouterProtocol: AnyObject {
    func showArticleDetail(article: Article)
}

class ArticleListRouter: ArticleListRouterProtocol {
    weak var view: UIViewController!
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func showArticleDetail(article: Article) {
        guard let vc = UIStoryboard(name: "ArticleDetailViewController", bundle: nil).instantiateInitialViewController() as? ArticleDetailViewController else {
            fatalError()
        }

        vc.article = article
        vc.presenter = ArticleDetailPresenter(
            view: vc,
            inject: ArticleDetailPresenter.Dependency(
                getArticleByIdUseCase: UseCase(GetArticleByIdUseCase())
            )
        )

        view.navigationController?.pushViewController(vc, animated: true)
    }
}
