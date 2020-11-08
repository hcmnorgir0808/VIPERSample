//
//  ArticleDetailViewController.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    enum Row: String {
        case title
        case body
        
        static var rows: [Row] {
            return [.title, .body]
        }
    }
    
    var article: Article!
    var presenter: ArticleDetailPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.didLoad(article: article)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ArticleDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = Row.rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.rawValue, for: indexPath)
        
        if case .title = row {
            cell.textLabel?.text = "タイトル"
            cell.detailTextLabel?.text = article.title
        }
        if case .body = row {
            cell.textLabel?.text = article.body
            cell.detailTextLabel?.text = nil
        }
        return cell
    }
}

extension ArticleDetailViewController: UITableViewDelegate {
    
}

extension ArticleDetailViewController: ArticleDetailViewProtocol {
    func showArticle(_ article: Article) {
        self.article = article
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        // 今回はスキップ
    }
}
