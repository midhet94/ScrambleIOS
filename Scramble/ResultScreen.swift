//
//  ResultScreen.swift
//  Scramble
//
//  Created by Midhet Sulemani on 11/11/25.
//

import SwiftUI

struct ResultScreen: View {
    var onRestart: () -> Void
    @State private var scale: CGFloat = 0.1
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .indigo],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("CORRECTO!")
                    .font(.system(size: 55, weight: .heavy))
                    .foregroundColor(.white)
                    .shadow(radius: 12)
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(stiffness: 120, damping: 8), value: scale)

                Button(action: {
                    dismiss()
                    onRestart()
                }) {
                    Image(systemName: "repeat")
                        .font(.title2.bold())
                        .padding()
                        .padding(.horizontal, 24)
                        .background(.white)
                        .foregroundColor(.indigo)
                        .cornerRadius(14)
                        .shadow(radius: 6)
                }
            }
        }
        .onAppear {
            withAnimation {
                scale = 1.2
            }
        }
    }
}
