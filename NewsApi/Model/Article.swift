//
//  Articles.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 09.08.2023.
//

import Foundation


// I make optional properties all for now because found some null in response,
// in the API Documentation there is nothing about what field could be null

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    static let previewArticle = Article(author: "Justine Calma",
                                        title: "Can banks push Bitcoin to clean up its act?",
                                        description: "Banks and asset managers have a big stake in Bitcoin, so Greenpeace wants them to crack down on the cryptocurrency’s pollution.",
                                        url: "https://www.theverge.com/2023/7/11/23778688/bitcoin-energy-emissions-climate-change-banks-asset-managers-greenpeace",
                                        urlToImage: "https://cdn.vox-cdn.com/thumbor/ODx_QBV2qCE_dfhHtwtaZ8W6J8I=/0x0:7144x4743/1200x628/filters:focal(3572x2372:3573x2373)/cdn.vox-cdn.com/uploads/chorus_asset/file/24763884/1235926940.jpg",
                                        publishedAt: "2023-07-11T14:00:00Z")
}

