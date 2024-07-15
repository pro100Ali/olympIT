//
//  LessonListOutput.swift
//  OlympIt
//
//  Created by Nariman on 09.05.2024.
//

import Foundation

enum Hardness: Int {
    case low = 1
    case medium = 2
    case hard = 3
}

typealias LessonsListOutput = [LessonOutput]

struct LessonOutput {
    let documentId: String
    let hardness: Hardness
    let name: String
    let description: String
    let pdf: URL
    let iconUrl: String?
}
