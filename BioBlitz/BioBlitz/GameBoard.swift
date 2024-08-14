//
//  GameBoard.swift
//  BioBlitz
//
//  Created by syunaeva on 8/13/24.
//

import SwiftUI

class GameBoard: ObservableObject {
    let rowCount = 11
    let columnCount = 22
    
    @Published var grid = [[Bacteria]]()
    
    @Published var currentPlayer = Color.green
    
    
    init() {
        reset()
    }
    
    func reset() {
        grid.removeAll()
        
        // make all bacteria
        for row in 0..<rowCount {
            var newRow = [Bacteria]()
            
            for col in 0..<columnCount {
                let bacteria = Bacteria(row: row, col: col)
                
                if row <= rowCount / 2 {
                    if row == 0 && col == 0 {
                        // make sure the palyer starts pointing away from anything
                        bacteria.direction = .north
                    } else if row == 0 && col == 1 {
                        bacteria.direction = .east
                    } else if row == 1 && col == 0 {
                        bacteria.direction = .south
                    } else {
                        bacteria.direction = Bacteria.Direction.allCases.randomElement()!
                    }
                } else {
                    // mirror
                    if let counterpart = getBacteria(atRow: rowCount - 1 - row, col: columnCount - 1 - col) {
                        bacteria.direction = counterpart.direction.opposite
                    }
                    
                }
                newRow.append(bacteria)
            }
            
            grid.append(newRow)
        }
        
        grid[0][0].color = .green
        grid[rowCount - 1][columnCount - 1].color = .red
    }
    
    func getBacteria(atRow row: Int, col: Int) -> Bacteria? {
        guard row >= 0 else { return nil }
        guard row < grid.count else { return nil }
        
        guard col >= 0 else { return nil }
        guard col < grid[0].count  else { return nil }
        
        return grid[row][col]
        
    }
    
    func infect(from: Bacteria) {
        objectWillChange.send()
        
        var bacteriaToInfect = [Bacteria?]()
        // direct infection
        switch from.direction {
        case .north:
            bacteriaToInfect.append(getBacteria(atRow: from.row - 1, col: from.col))
        case .south:
            bacteriaToInfect.append(getBacteria(atRow: from.row + 1, col: from.col))
        case .east:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col + 1))
        case .west:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col - 1))
        }
        
        // indirect infection above
        if let indirect = getBacteria(atRow: from.row - 1, col: from.col) {
            if indirect.direction == .south {
                bacteriaToInfect.append(indirect)
            }
        }
        
        // below
        if let indirect = getBacteria(atRow: from.row + 1, col: from.col) {
            if indirect.direction == .north {
                bacteriaToInfect.append(indirect)
            }
        }
        
        // left
        if let indirect = getBacteria(atRow: from.row, col: from.col - 1) {
            if indirect.direction == .east {
                bacteriaToInfect.append(indirect)
            }
        }
        
        // rigth
        
        if let indirect = getBacteria(atRow: from.row, col: from.col + 1) {
            if indirect.direction == .west {
                bacteriaToInfect.append(indirect)
            }
        }
        
        
        
        for case let bacteria? in bacteriaToInfect {
            if bacteria.color != from.color {
                bacteria.color = from.color
                Task { @MainActor in
                    try await Task.sleep(for: .milliseconds(50))
                    infect(from: bacteria)
                }
            }
        }
        
    }
    
    func rotate(bacteria: Bacteria) {
        objectWillChange.send()
        
        bacteria.direction = bacteria.direction.next
        
        infect(from: bacteria)
    }
}
