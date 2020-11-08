//
//  GetArticleByIdUseCase.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import Foundation

class GetArticleByIdUseCase: UseCaseProtocol {
    func execute(_ parameter: Int, completion: ((Result<Article, Error>) -> ())?) {
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(parameter)")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            guard
                let data = data,
                let decoded = try? JSONDecoder().decode(Article.self, from: data) else {
                let error = NSError(domain: "parse-error", code: 1, userInfo: nil)
                
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(.success(decoded))
            }
        }
        task.resume()
    }
}
