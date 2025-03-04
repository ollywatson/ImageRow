//
//  ContentView.swift
//  ImageRow
//
//  Created by Olly Watson on 04/03/2025.
//

import SwiftUI

struct OverlappingCircles: InsettableShape {
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate the centers based on the specified dimensions and distances
        let mainCircleRadius: CGFloat = 24 - insetAmount
        let subtractCircleRadius: CGFloat = 27 - insetAmount
        let distance: CGFloat = 40
        
        // Center of the main circle
        let mainCircleCenter = CGPoint(x: rect.midX, y: rect.midY)
        
        // Center of the subtracting circle
        let subtractCircleCenter = CGPoint(
                    x: mainCircleCenter.x + mainCircleRadius - subtractCircleRadius - 40,
                    y: mainCircleCenter.y
                )
        
        // Main circle
        path.addEllipse(in: CGRect(x: mainCircleCenter.x - mainCircleRadius, y: mainCircleCenter.y - mainCircleRadius, width: mainCircleRadius * 2, height: mainCircleRadius * 2))
        
        // Subtracting circle
        print("center: \(subtractCircleCenter.x)")
        let subtractPath = Path(ellipseIn: CGRect(x: subtractCircleCenter.x - subtractCircleRadius, y: subtractCircleCenter.y - subtractCircleRadius, width: subtractCircleRadius * 2, height: subtractCircleRadius * 2))
        
        return path.subtracting(subtractPath)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var InsetOverLappingCircles = self
        InsetOverLappingCircles.insetAmount += amount
        return InsetOverLappingCircles
    }
}

struct ContentView: View {
    var body: some View {
        HStack(spacing: -4) {
            Image("cupcakes")
                .resizable()
                .frame(width: 48, height: 48)
                .mask(
                    Circle()
                )
                .overlay(
                    Circle()
                        .strokeBorder(.border, lineWidth: 0.5)
                )
            Image("cupcakes")
                .resizable()
                .frame(width: 48, height: 48)
                .mask(
                    OverlappingCircles()
                )
                .overlay(
                    OverlappingCircles()
                        .strokeBorder(.border, lineWidth: 0.5)
                )
            Image("cupcakes")
                .resizable()
                .frame(width: 48, height: 48)
                .mask(
                    OverlappingCircles()
                )
                .overlay(
                    OverlappingCircles()
                        .strokeBorder(.border, lineWidth: 0.5)
                )
        }
    }
}

#Preview {
    ContentView()
}
