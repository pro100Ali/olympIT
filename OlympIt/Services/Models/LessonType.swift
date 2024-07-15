//
//  LessonType.swift
//  OlympIt
//
//  Created by Nariman on 08.05.2024.
//

import Foundation

enum LessonType: String {
    case theory
    case practice
    case theory10
    case practice10
    
    var collectionName: String {
        switch self {
        case .practice:
            return "Practices"
        case .theory:
            return "Theories"
        case .practice10:
            return "Practices 10 class"
        case .theory10:
            return "Theories 10 class"
        }
    }
}
