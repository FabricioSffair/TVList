//
//  ToastMessage.swift
//  TVList
//
//  Created by Fabrício Sperotto Sffair on 2022-05-25.
//

import SwiftUI

struct ToastMessage: ViewModifier {
    
    let message: String
    @Binding var isShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            if isShowing {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.system(size: Dimensions.ToastView.fontSize))
                    .padding()
                    .frame(
                        maxWidth: Dimensions.ToastView.maxWidth,
                        maxHeight: Dimensions.ToastView.maxHeight
                    )
                    .background(.ultraThinMaterial)
                    .cornerRadius(Dimensions.ToastView.cornerRadius)
                    .onTapGesture {
                        isShowing = false
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            isShowing = false
                        }
                    }
            }
        }
        .animation(.linear(duration: 0.3), value: isShowing)
        .transition(.opacity)
    }
}

extension View {
    func toast(message: String, isShowing: Binding<Bool>) -> some View {
        self.modifier(ToastMessage(message: message, isShowing: isShowing))
    }
}
