//
//  ApiResponse.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 09.08.2023.
//

import Foundation

class ApiResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
