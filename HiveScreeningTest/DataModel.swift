//
//  DataModel.swift
//  HiveScreeningTest
//
//  Created by Manu on 06/06/23.
//

import Foundation
// MARK: - Welcome
struct DataModel: Codable {
    let query: Query

    enum CodingKeys: String, CodingKey {
        case query
    }
}


// MARK: - Query
struct Query: Codable {
    let pages: [String: Page]
}

// MARK: - Page
struct Page: Codable {
    let pageid, ns: Int
    let title: String
    let extract: String
    let index: Int
    let thumbnail: Thumbnail?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
    let width, height: Int
}


