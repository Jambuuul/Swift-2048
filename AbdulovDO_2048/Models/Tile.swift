//
//  Tile.swift
//  AbdulovDO_2048
//
//  Created by Jam on 02.01.2025.
//

import Foundation
import SwiftUI


// Клетка игрового поля
struct Tile: Hashable, Equatable {
    var num: Int = 0
    var color: Color = .black
    
    init(_ num: Int = 0) {
        self.num = num
        self.color = getColor(num);
    }
}

/**
 Возвращает корректный цвет для номера плитки

 - Parameter value:  Номер на плитке
 - Returns: Корректный цвет
 */
private func getColor(_ value: Int) -> Color {
    
    var color: Color;
    switch value {
    case 2:
        color = .yellow;
    case 4:
        color = .orange
    case 8:
        color = .teal
    case 16:
        color = .blue
    case 32:
        color = .indigo
    case 64:
        color = .brown
    case 128:
        color = .purple
    case 256:
        color = .cyan
    case 512:
        color = .mint
    case 1024:
        color = .pink
    case 2048:
        color = .red
    
    default:
        color = .black
    }
    color = color.opacity(0.4)
    return color
}
