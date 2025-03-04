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
        VStack {
            
//          Approach 1: using a custom shape as a mask
            HStack {
                Text("With custom shape")
                Spacer()
            }.padding(.top)
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
                
                Spacer()
            }
            
            
//          Approach 2: using layers of circles to "fake" the effect
            HStack {
                Text("With masked circles")
                Spacer()
            }.padding(.top)
            HStack(spacing: -4) {
                ZStack {
                    Circle()
                        .fill(.background)
                        .frame(width: 54, height: 54)
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
                }
                .frame(width: 48, height: 48)
                .zIndex(3)
                
                ZStack {
//                  Start by drawing a larger background circle that occludes the next image
                    Circle()
                        .fill(.background)
                        .frame(width: 54, height: 54)
//                  Draw the image
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
//                  Draw a larger circle that adds the outline on the left hand edge of the shape
                    Circle()
                        .strokeBorder(.border, lineWidth: 0.5)
                        .frame(width: 54, height: 54)
//                      Offset the circle to the left hand edge
                        .offset(x: -43)
//                      Mask the circle to keep the outline within the main shape
                        .mask(Circle().frame(width: 47, height: 47))
                }
                .frame(width: 48, height: 48)
//              Add zIndex to place the image above the next images in the sequence
                .zIndex(2)
                
                ZStack {
//                  Start by drawing a larger background circle that occludes the next image
                    Circle()
                        .fill(.background)
                        .frame(width: 54, height: 54)
//                  Draw the image
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
//                  Draw a larger circle that adds the outline on the left hand edge of the shape
                    Circle()
                        .strokeBorder(.border, lineWidth: 0.5)
                        .frame(width: 54, height: 54)
//                      Offset the circle to the left hand edge
                        .offset(x: -43)
//                      Mask the circle to keep the outline within the main shape
                        .mask(Circle().frame(width: 47, height: 47))
                }
                .frame(width: 48, height: 48)
//              Add zIndex to place the image above the next images in the sequence
                .zIndex(1)
                
                Spacer()
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
