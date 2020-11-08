//
//  Article.swift
//  VIPERSample
//
//  Created by yaiwamoto on 08/11/2020.
//

import Foundation

struct Article: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
