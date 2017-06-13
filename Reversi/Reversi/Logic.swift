//
//  Logic.swift
//  Reversi
//
//  Created by Александр Лебедев on 20/02/2017.
//  Copyright © 2017 HSE. All rights reserved.
//

import Foundation

class ReversiLogic {
    enum State {
        case Empty
        case Player1
        case Player2
    }
    
    func enemyPlayer(_ player: State) -> State {
        if player == .Player1 {
            return .Player2
        } else {
            return .Player1
        }
    }
    
    var field: [[State]]
    private(set) var currentPlayer: State = .Player1
    private(set) var isWinState: Bool = false
    private(set) var isDrawState: Bool = false
    private(set) var player1Score = 2
    private(set) var player2Score = 2
    private(set) var availableCells : [Vec2i] = []
    private(set) var capturedCells : [Vec2i] = []
    
    init(width: Int, height: Int) {
        field = Array(repeating: Array(repeating: .Empty, count: height), count: width)
        
        let halfWidth = width / 2
        let halfHeight = height / 2
        field[halfWidth - 1][halfHeight - 1] = .Player1
        field[halfWidth][halfHeight] = .Player1
        
        field[halfWidth - 1][halfHeight] = .Player2
        field[halfWidth][halfHeight - 1] = .Player2
        updateAvailableCells()
    }
    
    func canStep(at: Vec2i) -> Bool {
        if let _ = availableCells.index(of: at) {
            return true
        }
        return false
    }
    
    func fieldAt(_ at: Vec2i) -> State {
        return field[at.x][at.y]
    }
    
    func onStep(at: Vec2i) -> State {
        field[at.x][at.y] = currentPlayer
        print("Current player: \(currentPlayer)")
        let score = captureCells(start: at)
        if currentPlayer == .Player1 {
            player1Score += 1 + score
            player2Score -= score
        } else {
            player2Score += 1 + score
            player1Score -= score
        }
        currentPlayer = enemyPlayer(currentPlayer)
        
        print("Scores: \(player1Score) \(player2Score)")
        
        if player1Score + player2Score == field.count * field.first!.count {
            if player1Score == player2Score {
                isDrawState = true
            } else {
                isWinState = true
            }
        } else {
            updateAvailableCells()
        }
        
        return field[at.x][at.y]
    }
    
    func captureCells(start: Vec2i) -> Int {
        capturedCells = []
        var sum = 0
        for dir in Vec2i.offsets {
            print("Processing direction: \(dir)")
            sum += captureDirection(start: start, offset: dir)
        }
        return sum
    }
    
    func captureDirection(start: Vec2i, offset: Vec2i) -> Int {
        var sum = 0
        var pos = start + offset
        while isValid(pos: pos) && fieldAt(pos) == enemyPlayer(currentPlayer) {
            pos = pos + offset
        }
        if isValid(pos: pos) && fieldAt(pos) == currentPlayer {
            pos = pos - offset
            while pos != start {
                capturedCells.append(pos)
                field[pos.x][pos.y] = currentPlayer
                sum += 1
                pos = pos - offset
            }
        }
        return sum
    }
    
    func previousPlayerName() -> String {
        if currentPlayer == .Player1 {
            return "Player1"
        } else {
            return "Player2"
        }
    }
    
    func updateAvailableCells() {
        availableCells = []
        
        for i in 0..<field.count {
            let row = field[i]
            for j in 0..<row.count {
                let pos = Vec2i(x: i, y: j)
                if fieldAt(pos) == .Empty && cellIsAvailable(pos) {
                    availableCells.append(pos)
                }
            }
        }
    }
    
    func cellIsAvailable(_ pos: Vec2i) -> Bool {
        for dir in Vec2i.offsets {
            if isValid(pos: pos + dir) && fieldAt(pos + dir) == enemyPlayer(currentPlayer) {
                if checkAvailableDirection(pos: pos, dir: dir) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func checkAvailableDirection(pos: Vec2i, dir: Vec2i) -> Bool {
        var curPos = pos + dir;
        while isValid(pos: curPos) {
            if fieldAt(curPos) != enemyPlayer(currentPlayer) {
                break;
            }
            curPos = curPos + dir
        }
        
        return isValid(pos: curPos) && fieldAt(curPos) == currentPlayer
    }
    
    func isValid(pos: Vec2i) -> Bool {
        return pos.x >= 0 && pos.y >= 0 && pos.x < field.count && pos.y < field[0].count
    }
}
