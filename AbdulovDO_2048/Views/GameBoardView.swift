//
//  GameBoardView.swift
//  AbdulovDO_2048
//
//  Created by Jam on 02.01.2025.
//

import SwiftUI

var movesMade: Int = 0
var score: Int = 0

struct GameBoardView: View {
    let n: Int
    let m: Int
    private var tileWidth: CGFloat = 50
    private var tileHeight: CGFloat = 50
    private var tileFont: Font = .subheadline
    
    @State var gameBoard: GameBoard
    @State var gameOver : Bool = false
    
    @StateObject var recordsManager = RecordsManager()
    
    init(n: Int, m: Int) {
        self.n = n
        self.m = m
        self.gameBoard = GameBoard(n, m)
        movesMade = 0
        score = 0
    
        if (n > 6 || m > 6) {
            tileWidth = 40
            tileHeight = 40
            tileFont = .footnote
        }
    }
 
    var body: some View {
        Text("Score: \(gameBoard.score)")
            .font(.largeTitle)
        Text("Moves made: \(movesMade)")
            .font(.largeTitle)
        
        Grid {
            ForEach(0..<n, id: \.self) { i in
                GridRow {
                    ForEach(0..<m, id: \.self) { j in
                        let cell = gameBoard.tiles[i][j]
                        RoundedRectangle(cornerRadius: 5)
                            .fill(cell.color)
                            .frame(width: tileWidth, height: tileHeight)
                            .overlay(
                                cell.num != 0 ?
                                Text("\(cell.num)")
                                    .font(tileFont)
                                    .foregroundColor(.white)
                                :
                                Text("")
                                    .foregroundColor(.gray)
                            )
                    }
                }
                
            }
        }
        .padding()
        .background(.gray)
        .alert(isPresented: $gameOver ) {
            Alert(title: Text("Game ended"), message: Text("Game over! Moves made: \(movesMade), score: \(score)"), dismissButton: .default(Text("Restart"), action: {gameOver = false;
                saveScore(score);
                self.gameBoard = GameBoard(n, m)}))
        }
        
        HStack {
            Button("⬅️") {
                self.handleMove(.left)
            }
            Button("⬆️") {
                self.handleMove(.up)
            }
            Button("⬇️") {
                 self.handleMove(.down)
            }
            Button("➡️") {
                self.handleMove(.right)
            }
        }
        .font(.largeTitle)
        .padding()
    }
    
    /**
     Обертка для обработки хода в зависимости от его направления

     - Parameter direction: Направление хода
     */
    func handleMove(_ direction: MoveDirection) {
        var moveMade = false
        withAnimation(.easeInOut(duration: 0.4)) {
            moveMade = gameBoard.move(direction)
        }
        if !moveMade {
            return
        }
        SoundManager.shared.playTileSound()
        movesMade += 1
        gameOver = gameBoard.isGameOver()
    }
    
    func saveScore(_ score: Int) {
        recordsManager.addRecord(score)
    }
}


#Preview {
    GameBoardView(n: 4, m: 4)
}
