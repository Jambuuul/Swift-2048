//
//  ContentView.swift
//  AbdulovDO_2048
//
//  Created by Jam on 27.12.2024.
//

import SwiftUI

struct StartScreenView: View {
    @State private var n: Int = 4
    @State private var m: Int = 4
    
    @State private var isGameStarted = false
    @State private var isViewingLeaderboard = false

    var body: some View {
        NavigationView {
            VStack {
                Text("2048")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Form {
                    Section(header: Text("Выберите размер поля")) {
                        Stepper("Rows: \(n)", value: $n, in: 3...8)
                        Stepper("Columns: \(m)", value: $m, in: 3...8)
                    }
                }
                .frame(height: 200)
                

                NavigationLink(destination: GameBoardView(n: n, m: m), isActive: $isGameStarted) {
                    Button("Начать игру") {
                        isGameStarted = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                NavigationLink(destination: LeaderboardView(), isActive: $isViewingLeaderboard) {
                    Button("Посмотреть таблицу рекордов") {
                        isViewingLeaderboard = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
            }
        }
    }
}
#Preview {
    StartScreenView()
}
