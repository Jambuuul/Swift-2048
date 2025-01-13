//
//  SoundManager.swift
//  AbdulovDO_2048
//
//  Created by Jam on 02.01.2025.
//

import AVFoundation
import Foundation


final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    func playTileSound() {
        if let url = Bundle.main.url(forResource: "tileSound", withExtension: "mp3") {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.play()
        } else {
            print("error")
        }
    }
}
