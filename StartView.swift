//
//  TutorialView.swift
//  tunagu
//
//  Created by Apple on 2025/03/07.
//

import SwiftUI

struct StartView: View {
    @State private var currentPage = 0
    @Environment(\.presentationMode) var presentationMode
    
    var tutorialSteps: [TutorialStep] = [
        TutorialStep(title: "恋人・パートナーとペアリングできる", subtitle: "“ペアリング“しよう", description: "繋がりを感じていたい恋人・パートナーとアプリを通じてペアリングしましょう", imageName: "tutorial1"),
        TutorialStep(title: "想いを“ハート“に乗せて送りましょう", subtitle: "“ハート“を送ろう", description: "恋人・パートナーのことを想っていることをハートを送って伝えましょう", imageName: "tutorial2"),
        TutorialStep(title: "恋人・パートナーに自分の感情を伝えよう", subtitle: "“気持ち“をシェア", description: "“甘えたい““寂しい“など普段伝えづらいことをこのアプリで伝えよう", imageName: "tutorial3"),
        TutorialStep(title: "恋人・パートナーとの関係をより良く", subtitle: "さあ、はじめよう！", description: "このアプリを通じて恋人・パートナーとの関係をいままで以上に素敵なものにしよう", imageName: "tutorial4")
    ]
    
    init() {
        // Color(hue: 1.0, saturation: 0.098, brightness: 0.992) を UIColor に変換
        let customColor = UIColor(hue: 1.0, saturation: 0.498, brightness: 0.992, alpha: 1.0)
        
        UIPageControl.appearance().currentPageIndicatorTintColor = customColor  // 現在のページの色
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray  // 他のページの色
    }
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("スキップ")
                        .foregroundStyle(.white)
                        .padding(5)
                        .padding(.horizontal,10)
                        .bold()
                        .font(.system(size: 18))
                        .background(Color(hue: 1.0, saturation: 0.398, brightness: 0.992))
                        .cornerRadius(30)
                }
                Spacer()
            }.padding(.leading)
            TabView(selection: $currentPage) {
                ForEach(0..<tutorialSteps.count, id: \.self) { index in
                    TutorialStepView(step: tutorialSteps[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Button(action: {
                if currentPage < tutorialSteps.count - 1 {
                    currentPage += 1
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text(currentPage < tutorialSteps.count - 1 ? "次へ" : "完了")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.398, brightness: 0.992))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
        .padding(.top)
//        .padding(.bottom)
//        .edgesIgnoringSafeArea(.all)
    }
}

struct ShareTutorialView: View {
    @State private var currentPage = 0
    @Binding var isPresented: Bool
    @Binding var showTutorial: Bool
    
    var tutorialSteps: [TutorialStep] = [
        TutorialStep(title: "LINEに簡単操作でアプリを共有", subtitle: "“LINE“に簡単アプリ共有", description: "画面内の“LINE“アイコンをタップします", imageName: "sharetutorial1"),
        TutorialStep(title: "ペアリングしたい相手にアプリを共有", subtitle: "送信先から選択", description: "送信先からペアリングしたい相手のアイコンを選択して「転送」をタップします", imageName: "sharetutorial2")
    ]
    
    init(isPresented: Binding<Bool>,showTutorial: Binding<Bool>) {
        self._isPresented = isPresented
        self._showTutorial = showTutorial
        // Color(hue: 1.0, saturation: 0.098, brightness: 0.992) を UIColor に変換
        let customColor = UIColor(hue: 1.0, saturation: 0.498, brightness: 0.992, alpha: 1.0)
        
        UIPageControl.appearance().currentPageIndicatorTintColor = customColor  // 現在のページの色
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray  // 他のページの色
    }
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    isPresented = false
                    showTutorial = true
                }) {
                    Text("スキップ")
                        .foregroundStyle(.white)
                        .padding(5)
                        .padding(.horizontal,10)
                        .bold()
                        .font(.system(size: 18))
                        .background(Color(hue: 1.0, saturation: 0.398, brightness: 0.992))
                        .cornerRadius(30)
                }
                Spacer()
            }.padding(.leading)
            TabView(selection: $currentPage) {
                ForEach(0..<tutorialSteps.count, id: \.self) { index in
                    TutorialStepView(step: tutorialSteps[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Button(action: {
                if currentPage < tutorialSteps.count - 1 {
                    currentPage += 1
                } else {
                    showTutorial = true
                    isPresented = false
                }
            }) {
                Text(currentPage < tutorialSteps.count - 1 ? "次へ" : "完了")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.398, brightness: 0.992))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
        .padding(.top)
        .background(.white)
    }
}

struct TutorialStepView: View {
    var step: TutorialStep
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text(step.title)
                .font(.headline)
                .foregroundColor(.gray)
            Text(step.subtitle)
                .font(.title)
                .fontWeight(.bold)
            Image(step.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 280)
            Text(step.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            Spacer()
        }
    }
}

struct TutorialStep {
    var title: String
    var subtitle: String
    var description: String
    var imageName: String
}

#Preview {
//    StartView()
    ShareTutorialView(isPresented: .constant(false), showTutorial: .constant(false))
}

