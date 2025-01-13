//
//  RecordsManager.swift
//  
//
//  Created by Jam on 13.01.2025.
//

import Foundation

// Класс, хранящий рекорды и сохраняющий их
final class RecordsManager: ObservableObject {
    
    private let key = "Records"
    
    // делаем сет приватным
    @Published private(set) var records: [Record] = [];
    
    init() {
        updateRecords()
    }
    
    func updateRecords() {
        records = UDmanager.UDread(forkey: key) ?? []
    }
    
    func addRecord(_ score: Int) {
        records.append( Record(score) );
        records.sort { $0.score > $1.score }
        
        _ = UDmanager.UDsave(data: records, forkey: key)
        print(records)
    }
}
