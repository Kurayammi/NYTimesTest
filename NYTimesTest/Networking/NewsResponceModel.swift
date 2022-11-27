//
//  NewsResponceModel.swift
//  NYTimesTest
//
//  Created by Kito on 11/27/22.
//

import Foundation

struct NewsResponceModel: Decodable {
    var num_results: Int
    var results: [DataResponceModel]
}

struct DataResponceModel: Decodable {
    var url: URL
    var source: String
    var section: String
    var published_date: String
    var title: String
    var abstract: String
}
