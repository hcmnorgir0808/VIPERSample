//
//  ArticleListViewController.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import UIKit

class ArticleListViewController: UIViewController {

    var presenter: ArticleListPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.didLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didSelect(article: articles[indexPath.row])
    }
}

extension ArticleListViewController: ArticleListViewProtocol {
    func showArticles(_ articles: [Article]) {
        self.articles = articles
        tableView.reloadData()
    }
    
    func showEmpty() {
        showArticles([])
    }
    
    func showError(_ error: Error) {
        // 今回はスキップ
    }
}
