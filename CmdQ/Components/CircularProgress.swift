//
//  CircularProgress.swift
//  CmdQ
//
//  Created by Alumno on 12/05/25.
//

import SwiftUI

struct CircularProgress: View {
    var progress: CGFloat
    var lineWidth: CGFloat
    var gradient: LinearGradient
    var backgroundColor: Color = .clear
    var fillAxis: Axis = .horizontal // o .vertical

    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
        .animation(.easeInOut(duration: 0.3), value: progress)
    }
}
