//
//  TutorialView.swift
//  tunagu
//
//  Created by Apple on 2025/03/08.
//

import SwiftUI

struct ViewPositionKey: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey2: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey3: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey4: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey5: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey6: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey7: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey8: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey9: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey10: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey11: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey12: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey13: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey14: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey15: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey16: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct ViewPositionKey17: PreferenceKey {
    static var defaultValue: [CGRect] = []
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}

struct TutorialView: View {
    @Binding var tutorialNum: Int
    @Binding var buttonRect: CGRect
    @Binding var bubbleHeight: CGFloat
    @Binding var buttonRect2: CGRect
    @Binding var bubbleHeight2: CGFloat
    @Binding var buttonRect3: CGRect
    @Binding var bubbleHeight3: CGFloat
    @Binding var buttonRect4: CGRect
    @Binding var bubbleHeight4: CGFloat
    @Binding var buttonRect5: CGRect
    @Binding var bubbleHeight5: CGFloat
    @Binding var buttonRect6: CGRect
    @Binding var bubbleHeight6: CGFloat
    @Binding var buttonRect7: CGRect
    @Binding var bubbleHeight7: CGFloat
    @Binding var buttonRect8: CGRect
    @Binding var bubbleHeight8: CGFloat
    var body: some View {
        if tutorialNum == 1 {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    generateHapticFeedback()
                    tutorialNum = 2
                }
            VStack {
                Spacer()
                //.frame(height: buttonRect.minY - bubbleHeight + 150)
                VStack(alignment: .trailing, spacing: 15) {
                    VStack{
                        Image("ロゴ")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .frame(height:80)
                            .padding(.bottom)
                        Text("インストールありがとうございます！\n\nこのアプリは自分好みにToDoアプリをカスタマイズできます\n早速カスタマイズ方法について紹介します")
                    }
                    .font(.callout)
                    .padding(5)
                    .font(.system(size: 24.0))
                    .padding(.all, 16.0)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 4)
                    .foregroundColor(Color.black)
                    .shadow(radius: 10)
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 2
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .onTapGesture {
                generateHapticFeedback()
                tutorialNum = 2
            }
            .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        if tutorialNum == 2 {
            
                GeometryReader { geometry in
                    Color.black.opacity(0.5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40, style: .continuous)
                                .padding(-20)
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: buttonRect.width, height: buttonRect.height)
                                .position(x: buttonRect.midX, y: buttonRect.midY)
                                .blendMode(.destinationOut)
                        )
                        .ignoresSafeArea()
                        .compositingGroup()
                        .background(.clear)
                        .onTapGesture {
                            generateHapticFeedback()
                            tutorialNum = 3
                        }
                }
            VStack {
                Spacer()
                    .frame(height: buttonRect.minY - bubbleHeight - 230)
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("【ペアリングする】をタップしてください")
                            .font(.callout)
                            .padding(5)
                            .font(.system(size: 24.0))
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 3
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .font(.callout)
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight = geometry.size.height
                        }
                    }
                })
            }
            .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        if tutorialNum == 3 {
            GeometryReader { geometry in
                Color.black.opacity(0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .padding(-10)
                            .frame(width: buttonRect2.width, height: buttonRect2.height)
                            .position(x: buttonRect2.midX, y: buttonRect2.midY)
                            .blendMode(.destinationOut)
                    )
                    .ignoresSafeArea()
                    .compositingGroup()
                    .background(.clear)
                    .onTapGesture {
                        generateHapticFeedback()
                        tutorialNum = 4
                    }
            }
            VStack {
                Spacer()
                    .frame(height: buttonRect2.minY - bubbleHeight2 + 210)
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("【アプリを共有】をタップして\nペアリングしたい相手にアプリを共有します")
                            .font(.callout)
                            .padding(5)
                            .font(.system(size: 24.0))
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 4
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .font(.callout)
                        .padding(5)
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight2 = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        if tutorialNum == 4 {
            GeometryReader { geometry in
                Color.black.opacity(0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .padding(-10)
                            .frame(width: buttonRect3.width, height: buttonRect3.height)
                            .position(x: buttonRect3.midX, y: buttonRect3.midY)
                            .blendMode(.destinationOut)
                    )
                    .ignoresSafeArea()
                    .compositingGroup()
                    .background(.clear)
                    .onTapGesture {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }
            }
            VStack {
                Spacer()
                    .frame(height: buttonRect3.minY - bubbleHeight3 - 30)
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("相手がすでにアプリを持っている場合は\nペアリングIDで検索しましょう")
                            .font(.callout)
                            .padding(5)
                            .font(.system(size: 24.0))
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.callout)
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight3 = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        if tutorialNum == 5 {
            GeometryReader { geometry in
                Color.black.opacity(0.5)
                    .overlay(
                        Circle()
                            .padding(-30)
                            .frame(width: buttonRect4.width, height: buttonRect4.height)
                            .position(x: buttonRect4.midX, y: buttonRect4.midY - 5)
                            .blendMode(.destinationOut)
                    )
                    .ignoresSafeArea()
                    .compositingGroup()
                    .background(.clear)
                    .onTapGesture {
                        generateHapticFeedback()
                        tutorialNum = 6
                    }
            }
            VStack {
                Spacer()
                    .frame(height: buttonRect4.minY - bubbleHeight4 - 30)
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("ハートをタップしてペアリング相手に送ろう")
                            .font(.callout)
                            .padding(5)
                            .font(.system(size: 24.0))
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 6
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.callout)
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight4 = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        if tutorialNum == 7 {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    generateHapticFeedback()
                    tutorialNum = 8
                }
            VStack {
                Spacer()
                //.frame(height: buttonRect.minY - bubbleHeight + 150)
                VStack(alignment: .trailing, spacing: 15) {
                    VStack{
                        Image("チュートリアルハート")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .frame(height:250)
                            .padding(.bottom)
                        Text("ハートは送ると相手に届きます\n恋人・パートナーのことを想っていることを伝えましょう\nまた、ハートは送ると徐々に大きくなり次のハートに成長します")
                    }
                    .font(.callout)
                    .padding(5)
                    .font(.system(size: 24.0))
                    .padding(.all, 16.0)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 4)
                    .foregroundColor(Color.black)
                    .shadow(radius: 10)
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 8
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.callout)
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .onTapGesture {
                generateHapticFeedback()
                tutorialNum = 8
            }
            .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        if tutorialNum == 8 {
            GeometryReader { geometry in
                Color.black.opacity(0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .padding(-5)
                            .padding(.top, 10)
                            .frame(width: buttonRect5.width, height: buttonRect5.height)
                            .position(x: buttonRect5.midX, y: buttonRect5.midY)
                            .blendMode(.destinationOut)
                    )
                    .ignoresSafeArea()
                    .compositingGroup()
                    .background(.clear)
                    .onTapGesture {
                        generateHapticFeedback()
                        tutorialNum = 9
                    }
            }
            VStack {
                Spacer()
                    .frame(height: buttonRect5.minY - bubbleHeight5 + 250)
                VStack(alignment: .trailing, spacing: 10) {
                    HStack {
                        Spacer()
                        Text("その他にも、パートナー・恋人の【感情】や【何しているか】を確認できたり")
                            .font(.callout)
                            .padding(5)
                            .font(.system(size: 24.0))
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                    }
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 9
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight5 = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .ignoresSafeArea()
            VStack{
                Spacer()
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        if tutorialNum == 9 {
            GeometryReader { geometry in
                Color.black.opacity(0.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                            .edgesIgnoringSafeArea(.all)
                            .padding(-10)
                            .frame(width: buttonRect6.width, height: buttonRect6.height)
                            .position(x: buttonRect6.midX, y: buttonRect6.midY)
                            .blendMode(.destinationOut)
                    )
                    .ignoresSafeArea()
                    .compositingGroup()
                    .background(.clear)
                    .onTapGesture {
                        generateHapticFeedback()
                        tutorialNum = 12
                    }
            }
            
            VStack{
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
                VStack {
                    Spacer()
                        .frame(height: buttonRect6.minY - bubbleHeight6 - 30)
                    VStack(alignment: .trailing, spacing: 10) {
                        HStack {
                            Text("パートナー・恋人に自分のステータスを確認してもらいたい時は\n下のボタンをタップして編集することができます")
                                .font(.callout)
                                .padding(5)
                                .font(.system(size: 24.0))
                                .padding(.all, 8.0)
                                .background(Color.white)
                                .cornerRadius(20)
                                .padding(.horizontal, 16)
                                .foregroundColor(Color.black)
                                .shadow(radius: 10)
                        }
                        Button(action: {
                            generateHapticFeedback()
                            tutorialNum = 12
                        }) {
                            HStack {
                                Text("次へ")
                                Image(systemName: "chevron.forward.circle")
                            }
                            .padding(5)
                            .font(.callout)
                            .padding(.all, 8.0)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.black)
                            .shadow(radius: 10)
                        }
                    }
                    .background(GeometryReader { geometry in
                        Path { _ in
                            DispatchQueue.main.async {
                                self.bubbleHeight6 = geometry.size.height
                            }
                        }
                    })
                    Spacer()
                }
                .ignoresSafeArea()
        }
        if tutorialNum == 10 {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    generateHapticFeedback()
                    tutorialNum = 8
                }
            VStack {
                Spacer()
                //.frame(height: buttonRect.minY - bubbleHeight + 150)
                VStack(alignment: .trailing, spacing: 15) {
                    VStack{
                        Image("チュートリアルエンド")
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height:250)
                            .padding(.bottom)
                        Text("さあ、このアプリを通じて\nパートナー・恋人との仲をより良くしましょう！")
                    }
                    .font(.callout)
                    .padding(5)
                    .font(.system(size: 24.0))
                    .padding(.all, 16.0)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 4)
                    .foregroundColor(Color.black)
                    .shadow(radius: 10)
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Text("次へ")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding(5)
                        .font(.callout)
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                }
                .background(GeometryReader { geometry in
                    Path { _ in
                        DispatchQueue.main.async {
                            self.bubbleHeight = geometry.size.height
                        }
                    }
                })
                Spacer()
            }
            .onTapGesture {
                generateHapticFeedback()
                tutorialNum = 0
            }
            .ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 0
                    }) {
                        HStack {
                            Image(systemName: "chevron.left.2")
                            Text("スキップ")
                        }
                        .padding(5)
                        .font(.system(size: 20.0))
                        .padding(.all, 8.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal, 8)
                        .foregroundColor(Color.black)
                        .shadow(radius: 10)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

#Preview {
//    TutorialView(tutorialNum: .constant(1))
    HeartBeatAnimationView()
}
