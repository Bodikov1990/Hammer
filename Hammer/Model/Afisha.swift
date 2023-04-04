//
//  Afisha.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import Foundation

struct Afisha: Decodable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?
    let currPageURL: String?
    let nextPageORL: String?
    let prevPageURL: String?
    let urlParams: URLParams?
    let data: [String: Cities]?

    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case currPageURL = "curr_page_url"
        case nextPageORL = "next_page_url"
        case prevPageURL = "prev_page_url"
        case urlParams = "url_params"
        case data
    }
}

struct Cities: Decodable {
    let uuid: String?
    let name: String?
    let cinemas: [String: Cinema]?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case cinemas = "Cinemas"
    }
}

struct Cinema: Decodable {
    let uuid: String?
    let name: String?
    let isActive: Bool
    let images: Images?
    let movies: [String: Movie]?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case isActive = "is_active"
        case images
        case movies = "Movies"
    }
}

struct Movie: Decodable {
    let uuid: String?
    let name: String?
    let isActive: Bool
    let duration: Int?
    let genre: [String]?
    let ageLimit: String?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case isActive = "is_active"
        case duration
        case genre
        case ageLimit = "age_limitation_text"
        case images
    }
}

struct Images: Decodable {
    let vertical, horizontal: String?
}

struct URLParams: Decodable {
    let timezone: String?
    let lang: String?
}
