//
//  ArticleDetailPresenter.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import Foundation

protocol ArticleDetailPresenterProtocol: AnyObject {
    func didLoad(article: Article)
}

protocol ArticleDetailViewProtocol: AnyObject {
    func showArticle(_ article: Article)
    func showError(_ error: Error)
}

class ArticleDetailPresenter {
    struct Dependency {
        let getArticleByIdUseCase: UseCase<Int, Article, Error>
    }
    
    weak var view: ArticleDetailViewProtocol!
    private var di: Dependency
    
    init(view: ArticleDetailViewProtocol, inject dependency: Dependency) {
        self.view = view
        self.di = dependency
    }
}

extension ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    func didLoad(article: Article) {
        di.getArticleByIdUseCase.execute(article.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let article):
                self.view.showArticle(article)
            case .failure(let error):
                self.view.showError(error)
            }
            
        }
    }
}
