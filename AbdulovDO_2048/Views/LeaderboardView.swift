//
//  LeaderboardView.swift
//  AbdulovDO_2048
//
//  Created by Jam on 03.01.2025.
//

import SwiftUI

struct LeaderboardView: View {
    
    @ObservedObject var recordsManager: RecordsManager = RecordsManager();
    
    var body: some View {
        VStack {
            Text("Records")
                .font(.largeTitle)
                .padding()
            
            List(recordsManager.records) { record in
                HStack {
                    Text("Score: \(record.score)")
                        .font(.headline)
                    Spacer()
                    Text(record.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
}

#Preview {
    LeaderboardView()
}
