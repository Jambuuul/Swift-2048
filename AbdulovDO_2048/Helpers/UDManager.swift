//
//  UDManager.swift
//  AbdulovDO_2048
//
//  Created by Jam on 13.01.2025.
//
import Foundation

// Структура для работы с UserDefaults, предложенная преподавателем
struct UDmanager
{
    static func UDsave<T: Encodable>(data: T, forkey key: String) -> Data? {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
            UserDefaults.standard.synchronize()
            return encoded
        }
        return nil
    }
    
    static func UDread<T: Decodable>(forkey key: String) -> T? {
        if let data0 = UserDefaults.standard.data(forKey: key),
           let data = try? JSONDecoder().decode(T.self, from: data0) {
            return data
        }
        return nil
    }
}
