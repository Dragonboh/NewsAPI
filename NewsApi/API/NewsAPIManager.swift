//
//  NewsAPIManager.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 09.08.2023.
//

import Foundation

enum NewsApiError: Error {
    case invalideURL
    case invalidResponse
    case invalidData
}

class NewsAPIManager {
    static let shared = NewsAPIManager()
    private let apiKey = "7a30db06d4ef46c4acf6b96bcfba71b1"
    private let baseURLString = "https://newsapi.org/v2/everything"
    
    private init(){}
    
    func fetchNews(arguments: Dictionary<NewsRequestArgumentsTypes, String>) async throws -> [Article] {
        guard let url = createURL(arguments: arguments) else {
            throw NewsApiError.invalideURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NewsApiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let apiResponse = try decoder.decode(ApiResponse.self, from: data)
            return apiResponse.articles
        } catch {
            throw NewsApiError.invalidData
        }
    }
    
    private func createURL(arguments: Dictionary<NewsRequestArgumentsTypes, String>) -> URL? {
        var urlComponents = URLComponents(string: baseURLString)
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: NewsRequestArgumentsTypes.apiKey.rawValue, value: apiKey))
        
        for (key, value) in arguments {
            queryItems.append(URLQueryItem(name: key.rawValue, value: value))
        }

        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
}
