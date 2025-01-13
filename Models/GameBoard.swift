

import Foundation

enum MoveDirection {
    case up, down, left, right
}


// Структура игрового поля
struct GameBoard {
    // Клетки поля
    var tiles: [[Tile]]
    let rows: Int
    let columns: Int
    
    init(_ n: Int, _ m: Int) {
        self.rows = n
        self.columns = m
        self.tiles = Array(repeating: Array(repeating: Tile(0), count: m), count: n)
        generateTile()
        generateTile()
    }
    
    
    /**
     Делает движение по правилам игры в зависимости от направления

     - Parameter direction:  Направление хода игрока
     */
    mutating func move(_ direction: MoveDirection) {
        switch direction {
        case .up:
            moveUp()
        case .down:
            moveDown()
        case .left:
            moveLeft()
        case .right:
            moveRight()
        }
        generateTile() // Генерируем новую плитку после движения
    }
    
    
    mutating private func moveLeft() {
        for i in 0..<rows {
            tiles[i] = mergeRow(tiles[i])
        }
    }
    
    mutating private func moveRight() {
        for i in 0..<rows {
            tiles[i] = mergeRow(tiles[i].reversed()).reversed()
        }
    }
    
    mutating private func moveUp() {
        for j in 0..<columns {
            let column = tiles.map { $0[j] }
            let mergedColumn = mergeRow(column)
            for i in 0..<rows {
                tiles[i][j] = mergedColumn[i]
            }
        }
    }
    
    mutating private func moveDown() {
        for j in 0..<columns {
            let column = tiles.map { $0[j] }
            let mergedColumn: [Tile] = mergeRow(column.reversed()).reversed()
            for i in 0..<rows {
                tiles[i][j] = mergedColumn[i]
            }
        }
    }
    
    /**
     Объединяет плитки в одном ряду по правилу игры 2048

     - Parameter row:  Ряд, который необходимо обработать
     - Returns: Обработанный ряд
     */
    private func mergeRow(_ row: [Tile]) -> [Tile] {
        let filtered = row.filter { $0.num != 0 } // Убираем пустые плитки
        var merged: [Tile] = []
        var skip = false
        
        for i in 0..<filtered.count {
            if skip {
                skip = false
                continue
            }
            if i < filtered.count - 1 && filtered[i] == filtered[i + 1] {
                merged.append(Tile(filtered[i].num * 2))
                skip = true
            } else {
                merged.append(filtered[i])
            }
        }
        
        while merged.count < row.count {
            merged.append(Tile(0))
        }
        
        return merged
    }
    
    // для удобного рассчета новой клетки
    private let variants = [2, 2, 2, 2, 2, 2, 2, 2, 2, 4]
    
    /**
     Генерирует новую плитку на игровом поле

     - Parameter row:  Ряд, который необходимо обработать
     - Returns: Обработанный ряд
     */
    mutating private func generateTile() {
        let emptyPositions = tiles.enumerated().flatMap { (i, row) in
            row.enumerated().compactMap { (j, tile) in
                tile.num == 0 ? (i, j) : nil
            }
        }
        
        guard let randomPosition = emptyPositions.randomElement() else {
            return
        }
        
        let (i, j) = randomPosition
        tiles[i][j] = Tile(variants.randomElement()!)// 90% шанса на 2, 10% на 4
    }
    
    /**
     Проверяет, окончена ли игра.
     
     - Returns: true, если завершена.
     */
    func isGameOver() -> Bool {
        // при наличии пустых ячеек не окончена
        if tiles.flatMap({ $0 }).contains(where: { $0.num == 0 }) {
            return false
        }
        
        // Если можно сделать движение, игра продолжается
        for i in 0..<rows {
            for j in 0..<columns {
                if (j < columns - 1 && tiles[i][j] == tiles[i][j + 1]) ||
                   (i < rows - 1 && tiles[i][j] == tiles[i + 1][j]) {
                    return false
                }
            }
        }
        return true
    }
}




