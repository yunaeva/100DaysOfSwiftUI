//
//  BacteriaView.swift
//  BioBlitz
//
//  Created by syunaeva on 8/13/24.
// https://www.youtube.com/live/TcGnO5VSJlI?si=uifziWBmeLJwVRSG&t=1330

import SwiftUI

struct BacteriaView: View {
    var bacteria: Bacteria
    var rotationAction: () -> Void
    
    var image: String {
        switch bacteria.color {
        case .red:
            return "chevron.up.square.fill"
        case .green:
            return "chevron.up.circle.fill"
        default:
            return "chevron.up.circle"
        }
    }
    
    var body: some View {
        ZStack {
            Button(action: rotationAction) {
                Image(systemName: image)
                    .resizable()
                    .foregroundColor(bacteria.color)
            }
            .buttonStyle(.plain)
            .frame(width: 32, height: 32)
        }
    }
}

#Preview {
    BacteriaView()
}
