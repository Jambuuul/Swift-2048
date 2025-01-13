//
//  Record.swift
//  AbdulovDO_2048
//
//  Created by Jam on 10.01.2025.
//

import Foundation


// Структура рекорда для отображения в таблице
struct Record: Codable, Identifiable {
    var date: Date
    var score: Int
    var id: UUID = UUID()
    
    init(_ score: Int) {
        date = Date()
        self.score = score
    }
}
