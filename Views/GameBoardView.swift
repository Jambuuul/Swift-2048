//
//  GameBoardView.swift
//  AbdulovDO_2048
//
//  Created by Jam on 02.01.2025.
//

import SwiftUI

var movesMade: Int = 0

// TODO: учет количества очков
var score: Int = 0

struct GameBoardView: View {
    let n: Int
    let m: Int
    
    @State var gameBoard: GameBoard
    @State var gameOver : Bool = false
    
    
    init(n: Int, m: Int) {
        self.n = n
        self.m = m
        self.gameBoard = GameBoard(n, m)
    }
 
    
    var body: some View {
        Text("Moves made: \(movesMade)")
            .font(.largeTitle)
        
        Grid {
            ForEach(0..<n, id: \.self) { i in
                GridRow {
                    ForEach(0..<m, id: \.self) { j in
                        let cell = gameBoard.tiles[i][j]
                        RoundedRectangle(cornerRadius: 5)
                            .fill(cell.color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                cell.num != 0 ?
                                Text("\(cell.num)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                :
                                Text("")
                                    .foregroundColor(.gray)
                            )
                            //.transition(.scale)
                    }
                }
                
            }
        }
        .padding()
        .background(.gray)
        .alert(isPresented: $gameOver ) {
            Alert(title: Text("Game ended"), message: Text("Game over! Moves made: \(movesMade)"), dismissButton: .default(Text("Restart"), action: {gameOver = false; self.gameBoard = GameBoard(n, m)}))
        }
        
        HStack {
            // TODO: проверка того, меняет ли ход как-то положение на доске
            Button("⬅️") {
                withAnimation(.easeInOut(duration: 0.4)) {
                    gameBoard.move(.left)
                    
                }
                SoundManager.shared.playTileSound()
                movesMade += 1
                gameOver = gameBoard.isGameOver()
               
            }
            Button("⬆️") {
                withAnimation(.easeInOut(duration: 0.4)) {
                    gameBoard.move(.up)
                }
                SoundManager.shared.playTileSound()
                movesMade += 1
                gameOver = gameBoard.isGameOver()
            }
            Button("⬇️") {
                withAnimation(.easeInOut(duration: 0.4)) {
                    gameBoard.move(.down)
                }
                SoundManager.shared.playTileSound()
                movesMade += 1
                gameOver = gameBoard.isGameOver()
            }
            Button("➡️") {
                withAnimation(.easeInOut(duration: 0.4)) {
                    gameBoard.move(.right)
                }
                SoundManager.shared.playTileSound()
                movesMade += 1
                gameOver = gameBoard.isGameOver()
            }
        }
        .font(.largeTitle)
        .padding()
    }
}

#Preview {
    GameBoardView(n: 4, m: 4)
}
