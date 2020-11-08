//
//  ArticleListPresenter.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import Foundation

protocol ArticleListPresenterProtocol: AnyObject {
    func didLoad()
    func didSelect(article: Article)
}

protocol ArticleListViewProtocol: AnyObject {
    func showArticles(_ articles: [Article])
    func showEmpty()
    func showError(_ error: Error)
}

class ArticleListPresenter {
    
    struct Dependency {
        let router: ArticleListRouterProtocol
        let getArticlesArrayUseCase: UseCase<Void, [Article], Error>
    }
    weak var view: ArticleListViewProtocol!
    private var di: Dependency
    
    init(view: ArticleListViewProtocol, inject dependecy: Dependency) {
        self.view = view
        self.di = dependecy
    }
}

extension ArticleListPresenter: ArticleListPresenterProtocol {
    func didLoad() {
        di.getArticlesArrayUseCase.execute(()) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                guard !articles.isEmpty else {
                    self.view.showEmpty()
                    return
                }
                self.view.showArticles(articles)
            case .failure(let error):
                self.view.showError(error)
            }
            
        }
    }
    
    func didSelect(article: Article) {
        di.router.showArticleDetail(article: article)
    }
}
