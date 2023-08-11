//
//  NewsRequestArgumentsTypes.swift
//  NewsApi
//
//  Created by Bogdan Pankevych on 09.08.2023.
//

import Foundation

enum NewsRequestArgumentsTypes: String {
    case sortedBy
    case fromDate = "from"
    case toDate = "to"
    case keyWord = "q"
    case apiKey
}
