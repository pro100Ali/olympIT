//
//  NewsModel.swift
//  OlympIt
//
//  Created by Nariman on 11.05.2024.
//

import Foundation

typealias NewsListModel = [NewsModel]

struct NewsModel {
    let title: String
    let description: String
    let time: String
    let imageUrl: URL
}
