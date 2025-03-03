//
//  HeartBeatAnimationView.swift
//  tunagu
//
//  Created by Apple on 2025/03/01.
//

import SwiftUI
import Firebase

struct HeartBeatAnimationView: View {
    @State private var hearts: [Heart] = [] // 飛び散るハートのリスト
    @State private var scale: CGFloat = 1.0 // メインハートのスケール
    @State private var isPairingViewPresented = false
    @State private var isEmotionSelectionViewPresented = false
    @State private var isHeartReceived = false
    @State private var heartCount: Int = 0
    @State private var lastReceivedHeartCount: Int = UserDefaults.standard.integer(forKey: "lastReceivedHeartCount1")
    @State private var isPaired = false
    @State private var partnerEmotion: String = "happy"
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isEmotionSelectionVisible = false
    
    @State private var selectedBackground = "背景2" // 選択中の背景
    
    var backgroundOptions = ["背景1", "背景2", "背景3", "背景4", "背景5", "背景6", "背景7", "背景8"]
    
    
    var backgroundColor: Color {
        switch partnerEmotion {
        case "happy": return Color.yellow.opacity(0.3)
        case "sad": return Color.blue.opacity(0.3)
        case "tired": return Color.gray.opacity(0.3)
        case "needy": return Color.pink.opacity(0.3)
        default: return Color.white
        }
    }
    
    
    // ハートのデータモデル
    struct Heart: Identifiable {
        let id = UUID()
        var offset: CGSize
        var scale: CGFloat
        var opacity: Double
    }
    
    var body: some View {
        ZStack {
            Image(selectedBackground) // 選択した背景を適用
                .resizable()
                .edgesIgnoringSafeArea(.all)
            //            backgroundColor.edgesIgnoringSafeArea(.all)
            // メインのハート
            //            Image(systemName: "heart.fill")
            Image("ハート1")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .scaleEffect(scale)
                .scaleEffect(1.0 + CGFloat(heartCount) * 0.01)
                .animation(
                    Animation.easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                    value: scale
                )
                .shadow(radius: 3)
                .onTapGesture {
//                    canSendHeart { canSend in
//                        if canSend {
//                            print("test")
//                            explodeHearts() // ハートアニメーションを実行
//                            sendHeart() // Firebaseにハート送信
//                        } else {
//                            showAlert(title: "送信できません", message: "ハートは3時間に1回しか送れません") // アラートを表示
//                        }
//                    }
                    explodeHearts() // ハートアニメーションを実行
                    sendHeart() // Firebaseにハート送信
                }
            // 飛び散る小さなハートたち
            ForEach(hearts) { heart in
                Image("ハート1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.pink)
                    .offset(heart.offset)
                    .scaleEffect(heart.scale)
                    .opacity(heart.opacity)
            }
            VStack {
                Spacer()
                
                //                Picker("背景を選択", selection: $selectedBackground) {
                //                    ForEach(backgroundOptions, id: \.self) { background in
                //                        Text(background)
                //                    }
                //                }
                //                .pickerStyle(MenuPickerStyle())
                //                .padding()
                if isPaired {
                    Button(action: {
                        isEmotionSelectionVisible = true
                    }) {
                        Image("感情")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                    .cornerRadius(24)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.clear, lineWidth: 1)
                    )
                    .shadow(radius: 5)
                }
                if !isPaired {
                    Button(action: {
                        isPairingViewPresented = true
                    }) {
                        HStack {
                            Image(systemName: "heart.fill")
                            //                                    .font(.system(size: 20))
                            Text("ペアリングする")
                        }
                        .font(.system(size: 24))
                    }
                    .padding()
                    .background(.white)
//                    .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                    .clipShape(Capsule())
                    .padding(.bottom, 40)
                    .shadow(radius: 5)
                }
            }
            if isEmotionSelectionVisible {
                Color.black.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing:-20) {
                    Spacer()
                    HStack{
                        Button(action: { selectEmotion("happy") }) {
                            Text("×")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.white))
                                .padding(.bottom,5)
                        }.padding(.leading,30)
                            .opacity(0)
                        Spacer()
                        Text("いまどんな気持ち？")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.white))
                            .padding()
                        Spacer()
                        Button(action: { selectEmotion("happy") }) {
                            Text("×")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.white))
                                .padding(.bottom,5)
                        }.padding(.trailing,30)
                    }
                    
                    HStack(spacing: 30) {
                        Button(action: { selectEmotion("happy") }) {
                            VStack{
                                Text("😊")
                                    .font(.system(size: 50))
                                Text("楽しい")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.white))
                            }
                        }
                        Button(action: { selectEmotion("love") }) {
                            VStack{
                                Text("🥰")
                                    .font(.system(size: 50))
                                Text("甘えたい")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.white))
                            }
                        }
                        Button(action: { selectEmotion("sad") }) {
                            VStack{
                                Text("😭")
                                    .font(.system(size: 50))
                                Text("悲しい")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.white))
                            }
                        }
                        Button(action: { selectEmotion("tired") }) {
                            VStack{
                                Text("😮‍💨")
                                    .font(.system(size: 50))
                                Text("疲れた")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.white))
                            }
                        }
                    }
                    .padding()
                    //                               .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom))
                }
                .padding(.bottom, 10)
            }
            
            if isHeartReceived {
                HeartReceivedView(count: heartCount - lastReceivedHeartCount, isPresented: $isHeartReceived)
            }
        }
        .animation(.easeInOut, value: isEmotionSelectionVisible)
        
        .onAppear {
            saveUserInfo()
            checkPairingStatus()
            fetchPartnerEmotion()
            scale = 1.2
            signInAnonymously()
            observeHearts()
            fetchTotalHeartCount()
        }
        .fullScreenCover(isPresented:$isPairingViewPresented) {
            PairingView()
        }
        .sheet(isPresented: $isEmotionSelectionViewPresented) {
            EmotionSelectionView()
        }
//        .sheet(isPresented: $isHeartReceived) {
//            HeartReceivedView(count: heartCount)
//        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func selectEmotion(_ emotion: String) {
        partnerEmotion = emotion
        saveEmotionStatus(emotion: emotion)
        isEmotionSelectionVisible = false
    }
    
    func saveEmotionStatus(emotion: String) {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).updateChildValues(["emotionStatus": emotion]) { error, _ in
            if let error = error {
                print("感情の保存失敗: \(error.localizedDescription)")
            } else {
                print("感情の保存成功: \(emotion)")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    func fetchPartnerEmotion() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("partnerId").observeSingleEvent(of: .value) { snapshot in
            if let partnerID = snapshot.value as? String {
                ref.child("users").child(partnerID).child("emotionStatus").observe(.value) { emotionSnapshot in
                    if let emotion = emotionSnapshot.value as? String {
                        DispatchQueue.main.async {
                            self.partnerEmotion = emotion
                        }
                    }
                }
            }
        }
    }
    
    func checkPairingStatus() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("partnerId").observeSingleEvent(of: .value) { snapshot in
            if let partnerID = snapshot.value as? String, !partnerID.isEmpty {
                isPaired = true
            } else {
                print("checkPairingStatus")
                isPaired = false
            }
        }
    }
    /// メインハートをタップしたときに、小さなハートを飛び散らせるアニメーション
    func explodeHearts() {
        hearts.removeAll() // 既存のハートをクリア
        
        for _ in 0..<20 { // 20個のハートを作成
            let randomX = CGFloat.random(in: -250...250) // ランダムなX座標
            let randomY = CGFloat.random(in: -250...250) // ランダムなY座標
            
            let newHeart = Heart(
                offset: CGSize(width: 0, height: 0),
                scale: 1.0,
                opacity: 1.0
            )
            
            hearts.append(newHeart) // ハートをリストに追加
            
            // アニメーションでハートを飛ばす
            withAnimation(Animation.easeOut(duration: 1.2)) {
                let index = hearts.count - 1
                hearts[index].offset = CGSize(width: randomX, height: randomY)
                hearts[index].scale = 0.5
                hearts[index].opacity = 0.0
            }
        }
    }
    
    func canSendHeart(completion: @escaping (Bool) -> Void) {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let ref = Database.database().reference()
        let heartRef = ref.child("heartSignals").child(myUserID)
        
        heartRef.observeSingleEvent(of: .value) { snapshot in
            if let heartData = snapshot.value as? [String: Any],
               let lastSentTimestamp = heartData["lastSentTimestamp"] as? TimeInterval {
                
                let currentTime = Date().timeIntervalSince1970 * 1000 // 現在の時間（ミリ秒）
                let threeHoursInMillis: TimeInterval = 3 * 60 * 60 * 1000 // 3時間をミリ秒に変換
                
                // 最後の送信から3時間経過していればOK
                completion(currentTime - lastSentTimestamp > threeHoursInMillis)
            } else {
                completion(true) // 初回送信ならOK
            }
        }
    }
    
    func sendHeart() {
        getPartnerID { partnerID in
            guard let partnerID = partnerID else {
                print("ペアリング相手がいません")
                return
            }
            
            let ref = Database.database().reference()
            let senderID = Auth.auth().currentUser?.uid ?? ""
            let heartRef = ref.child("heartSignals").child(senderID)
            
//            canSendHeart { canSend in
//                guard canSend else {
//                    print("3時間以内のため、送信できません")
//                    showAlert(title: "送信できません", message: "ハートは3時間に1回しか送れません")
//                    return
//                }
                
                // ハート送信データを更新
                heartRef.observeSingleEvent(of: .value) { snapshot in
                    var newCount = 1
                    let currentTime = Date().timeIntervalSince1970 * 1000
                    
                    if let heartData = snapshot.value as? [String: Any],
                       let count = heartData["count"] as? Int {
                        newCount = count + 1
                    }
                    
                    let heartData: [String: Any] = [
                        "from": senderID,
                        "count": newCount,
                        "timestamp": ServerValue.timestamp(),
                        "lastSentTimestamp": currentTime // 🔥 最後に送信した時間を記録
                    ]
                    
                    heartRef.setValue(heartData) { error, _ in
                        if let error = error {
                            print("ハート送信失敗: \(error.localizedDescription)")
                        } else {
                            print("ハート送信成功")
                        }
                    }
//                }
            }
        }
    }
    
    
    
    func observeHearts() {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            print("myUserID nil")
            return
        }

        getPartnerID { partnerID in
            guard let partnerID = partnerID else {
                print("ペアリング相手がいません")
                return
            }

            let ref = Database.database().reference()
            ref.child("heartSignals").child(partnerID)
                .observe(.value) { snapshot in
                    if let heartData = snapshot.value as? [String: Any],
                       let count = heartData["count"] as? Int {

                        let savedCount = UserDefaults.standard.integer(forKey: "lastReceivedHeartCount1")
                        print("observeHearts - partnerID: \(partnerID), count: \(count), savedCount: \(savedCount)")

                        // 相手が送った新しいハートがあれば更新
                        if count > savedCount {
                            heartCount = count
                            isHeartReceived = true
                            UserDefaults.standard.set(count, forKey: "lastReceivedHeartCount1")
                        }
                    }
                }
        }
    }

    
    
    func fetchTotalHeartCount() {
        getTotalHeartCount { total in
            DispatchQueue.main.async {
                self.heartCount = total
            }
        }
    }
    
    func getTotalHeartCount(completion: @escaping (Int) -> Void) {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            completion(0)
            return
        }
        
        let ref = Database.database().reference()
        
        // 自分のペアリング相手のIDを取得
        ref.child("users").child(myUserID).child("partnerId").observeSingleEvent(of: .value) { snapshot in
            if let partnerID = snapshot.value as? String {
                let heartRef = ref.child("heartSignals")
                var totalHeartCount = 0
                
                // 自分が送信したハート数を取得
                heartRef.child(myUserID).observeSingleEvent(of: .value) { snapshot in
                    if let heartData = snapshot.value as? [String: Any],
                       let myCount = heartData["count"] as? Int {
                        totalHeartCount += myCount
                    }
                    
                    // ペアリング相手が送信したハート数を取得
                    heartRef.child(partnerID).observeSingleEvent(of: .value) { snapshot in
                        if let heartData = snapshot.value as? [String: Any],
                           let partnerCount = heartData["count"] as? Int {
                            totalHeartCount += partnerCount
                        }
                        print("totalHeartCount      :\(totalHeartCount)")
                        // 2人の合計を返す
                        completion(totalHeartCount)
                    }
                }
            } else {
                completion(0) // ペアがいない場合
            }
        }
    }
    
    
    /// 自分のペアリング相手のIDを取得
    func getPartnerID(completion: @escaping (String?) -> Void) {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("partnerId").observeSingleEvent(of: .value) { snapshot in
            if let partnerID = snapshot.value as? String {
                completion(partnerID) // 相手のIDを返す
            } else {
                completion(nil) // ペアリングされていない場合はnil
            }
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            if let error = error {
                print("匿名ログイン失敗: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                print("匿名ログイン成功: \(user.uid)")
                observeHearts() // ログイン後に Firebase の監視を開始
            }
        }
    }
    
    /// 受信したハートをローカル通知として表示
    func showHeartNotification(from senderID: String) {
        let content = UNMutableNotificationContent()
        content.title = "💖 ハートが届きました！"
        content.body = "あなたにハートが送られました！"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知エラー: \(error.localizedDescription)")
            }
        }
    }
    
    func saveUserInfo() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let pairingCode = getPairingCode() ?? "0000" // 👈 上4桁のIDを取得
        
        let ref = Database.database().reference()
        let userData: [String: Any] = [
            "userID": userID,
            "pairingCode": pairingCode
        ]
        
        // users ノードにユーザーデータを保存
        ref.child("users").child(userID).setValue(userData) { error, _ in
            if let error = error {
                print("ユーザー情報の保存失敗: \(error.localizedDescription)")
            } else {
                print("ユーザー情報の保存成功")
            }
        }
        
        // pairingCodes ノードに pairingCode と userID のマッピングを保存
        ref.child("pairingCodes").child(pairingCode).setValue(userID) { error, _ in
            if let error = error {
                print("pairingCodes の保存失敗: \(error.localizedDescription)")
            } else {
                print("pairingCodes の保存成功")
            }
        }
    }
    
    
    func getPairingCode() -> String? {
        guard let userID = Auth.auth().currentUser?.uid else { return nil }
        return String(userID.prefix(4)) // 👈 UIDの上4桁を取得
    }
    
}

struct EmotionSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedEmotion: String = "happy"
    
    let emotions: [(name: String, label: String)] = [
        ("happy", "嬉しい 😊"),
        ("sad", "寂しい 😢"),
        ("tired", "疲れた 😴"),
        ("needy", "甘えたい 🥺")
    ]
    
    var body: some View {
        VStack {
            Text("今の気持ちを選んでね")
                .font(.headline)
                .padding()
            
            VStack {
                ForEach(emotions, id: \.name) { emotion in
                    Button(action: {
                        selectedEmotion = emotion.name
                    }) {
                        Text(emotion.label)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedEmotion == emotion.name ? Color.gray.opacity(0.3) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding()
            
            Button("保存") {
                saveEmotionStatus(emotion: selectedEmotion)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .padding()
    }
    
    /// Firebase に `emotionStatus` を保存
    func saveEmotionStatus(emotion: String) {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).updateChildValues(["emotionStatus": emotion]) { error, _ in
            if let error = error {
                print("感情の保存失敗: \(error.localizedDescription)")
            } else {
                print("感情の保存成功: \(emotion)")
            }
        }
    }
}

import UIKit
import CoreImage.CIFilterBuiltins

struct PairingView: View {
    @State private var myPairingCode: String = ""
    @State private var showCopyAlert = false
    @State private var isSharing = false
    @State private var searchCode = ""
    @State private var searchResults: [String: String] = [:]
    @State private var selectedUserID: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var showSearchNotFoundAlert = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var pairingCodeDigits: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?

    var body: some View {
        ZStack{
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("戻る")
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.leading)
                    Spacer()
                    Image("ハート1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    Spacer()
                    // レイアウトの対称性を保つために非表示のボタン
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("fontGray"))
                        Text("戻る")
                            .foregroundColor(Color("fontGray"))
                    }
                    .padding(.leading)
                    .opacity(0)
                }
                .padding(.top,60)
                Spacer()
                // タイトル
                Text("アプリを共有 🎉")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("ペアリングしたい相手にアプリを共有しよう！")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // 共有ボタン
                Button(action: {
                    isSharing = true
                }) {
                    Label("アプリを共有", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.pink]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 3)
                }
                .padding(.horizontal, 20)
                Spacer()
                Text("相手がすでにアプリを持っている方は👇")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text("ペアリング相手のIDを入力してください")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                VStack(spacing: 20) {
//                    TextField("XXXX", text: $searchCode)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.leading, 10)
//                        .font(.system(size: 24))
                    HStack(spacing: 20) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("", text: $pairingCodeDigits[index])
                                .font(.system(size: 28, weight: .bold))
                                .frame(width: 50, height: 60)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: pairingCodeDigits[index]) { newValue in
                                    // 🔹 入力は1文字のみ
                                    if newValue.count > 1 {
                                        pairingCodeDigits[index] = String(newValue.prefix(1))
                                    }
                                    
                                    // 🔹 次のボックスへ自動移動
                                    if !newValue.isEmpty && index < 3 {
                                        focusedIndex = index + 1
                                    }
                                    
                                    // 🔹 4文字揃ったら検索を実行
                                    let completeCode = pairingCodeDigits.joined()
                                    if completeCode.count == 4 {
                                        searchUserByPairingCode(code: completeCode) { results in
                                            searchResults = results
                                            if results.isEmpty {
                                                showAlert(title: "検索結果なし", message: "このペアリングIDは存在しません")
                                            }
                                        }
                                    }
                                }
                        }
                    }
                    
                    Button(action: {
                        searchUserByPairingCode(code: searchCode) { results in
                            self.searchResults = results
                            print("self.searchResults   :\(self.searchResults)")
                        }
                    }) {
                        HStack{
                            Image(systemName: "magnifyingglass")
                            Text("検索する")
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal,10)
                        .padding(.vertical,8)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                }
                .padding(.horizontal, 40)
                Text("あなたのペアリングID")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                // ペアリングID表示
                HStack {
                    Text(myPairingCode)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                    
                    Button(action: {
                        copyToClipboard(myPairingCode)
                        showCopyAlert = true
                    }) {
                        Image(systemName: "doc.on.doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                    }
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                Button(action: {
                    sharePairingID()
                }) {
                    Label("ペアリングIDを共有", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.pink]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 3)
                        .padding(.horizontal, 20)
                }
                Spacer()
                Spacer()
            }
            if !searchResults.isEmpty {
                    Color.black.opacity(0.2)
                        .edgesIgnoringSafeArea(.all)
                    
                    ForEach(searchResults.keys.sorted(), id: \.self) { userID in
                        VStack{
                            Text("検索がヒットしました🎊")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("ペアコード：\(searchResults[userID]!)さん")
                                .font(.system(size: 24))
                                .padding(.top, 10)
                            VStack{
                                Button(action: {
                                    pairWithPartner(partnerID: userID)
                                }) {
                                    HStack{
                                        Image(systemName: "heart.fill")
                                        Text("ペアリングする")
                                    }
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.vertical,10)
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(
                                        gradient: Gradient(colors: [Color.orange, Color.pink]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    .cornerRadius(10)
                                }
                                .padding(.top, 10)
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(20)
                    .overlay(
                        Button(action: {
                            searchResults = [:]
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.white).frame(width: 30, height: 30))
                                .foregroundColor(.black)
                        }.padding(-15),
                        alignment: .topTrailing // ✅ ここでバツボタンを右上に配置
                    )
                    .frame(width:300,height:300)
            }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            fetchMyPairingCode()
        }
        .sheet(isPresented: $isSharing) {
            ActivityViewController(activityItems: ["一緒にもっと楽しい時間を過ごしたい！\nこのアプリなら実現できます👬\nペアリングID: \(myPairingCode)\nダウンロードはこちら: https://apps.apple.com/app/yourapp-id"])
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    func fetchMyPairingCode() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("pairingCode").observeSingleEvent(of: .value) { snapshot in
            if let code = snapshot.value as? String {
                myPairingCode = code
            } else {
                myPairingCode = "未設定"
            }
        }
    }

    func sharePairingID() {
        let pairingMessage = "私のペアリングIDはこちら： \(myPairingCode)\nアプリからペアリングしてね☺️\n\nhttps://apps.apple.com/app/yourapp-id"
        
        let activityVC = UIActivityViewController(activityItems: [pairingMessage], applicationActivities: nil)
        
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            topVC.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func pairWithPartner(partnerID: String) {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()

        // 自分の情報に相手の userID を保存
        ref.child("users").child(myUserID).updateChildValues(["partnerId": partnerID])

        // 相手の情報にも自分の userID を保存
        ref.child("users").child(partnerID).updateChildValues(["partnerId": myUserID]) { error, _ in
            if let error = error {
                print("ペアリング失敗: \(error.localizedDescription)")
            } else {
                print("ペアリング成功")
            }
        }
    }

    func copyToClipboard(_ text: String) {
        UIPasteboard.general.string = text
    }
    
    func searchUserByPairingCode(code: String, completion: @escaping ([String: String]) -> Void) {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            print("ユーザーがログインしていません")
            showAlert(title: "エラー", message: "ログインしていません")
            completion([:])
            return
        }

        let ref = Database.database().reference()

        ref.child("pairingCodes").child(code).observeSingleEvent(of: .value) { snapshot in
            var results: [String: String] = [:]

            if let userID = snapshot.value as? String {
                // 自分自身のペアリングIDを検索した場合はエラー
                if userID == myUserID {
                    print("自分のペアリングIDは検索できません")
                    showAlert(title: "検索エラー", message: "自分のペアリングIDは検索できません")
                    completion([:])
                    return
                }

                ref.child("users").child(userID).observeSingleEvent(of: .value) { userSnapshot in
                    if let userData = userSnapshot.value as? [String: Any],
                       let userName = userData["pairingCode"] as? String {
                        results[userID] = userName
                    }
                    
                    if results.isEmpty {
                        DispatchQueue.main.async {
                            showAlert(title: "検索結果なし", message: "このペアリングIDは存在しません")
                        }
                    }
                    completion(results)
                }
            } else {
                print("検索結果なし")
                DispatchQueue.main.async {
                    showAlert(title: "検索結果なし", message: "このペアリングIDは存在しません")
                }
                completion([:])
            }
        }
    }

    
    func showSearchAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showSearchNotFoundAlert = true
    }

}

//struct PairingView: View {
//    @State private var searchCode = ""
//    @State private var searchResults: [String: String] = [:] // userID : name
//    @State private var selectedUserID: String?
//    @State private var myPairingCode: String = ""
//    @State private var showCopyAlert = false
//    @State private var isSharing = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("ペアリング設定")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.top, 10)
//            
//            VStack(spacing: 10) {
//                Text("あなたのペアリングID")
//                    .font(.headline)
//                    .foregroundColor(.gray)
//                
//                HStack {
//                    Text(myPairingCode)
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
//                        .padding(.horizontal, 10)
//                        .background(Color.white)
//                        .cornerRadius(10)
//                    
//                    Button(action: {
//                        copyToClipboard(myPairingCode)
//                        showCopyAlert = true
//                    }) {
//                        Image(systemName: "doc.on.doc")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            
//            HStack {
//                TextField("相手のペアリングIDを入力", text: $searchCode)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.leading, 10)
//                
//                Button(action: {
//                    searchUserByPairingCode(code: searchCode) { results in
//                        self.searchResults = results
//                    }
//                }) {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                }
//            }
//            .padding(.horizontal, 10)
//            
//            if !searchResults.isEmpty {
//                Text("検索結果")
//                    .font(.headline)
//                    .padding(.top, 10)
//                
//                List(searchResults.keys.sorted(), id: \.self) { userID in
//                    Button(action: {
//                        selectedUserID = userID
//                    }) {
//                        HStack {
//                            Text(searchResults[userID] ?? "不明")
//                                .foregroundColor(.primary)
//                            Spacer()
//                            if selectedUserID == userID {
//                                Image(systemName: "checkmark.circle.fill")
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//            
//            if let partnerID = selectedUserID {
//                Button(action: {
//                    pairWithPartner(partnerID: partnerID)
//                }) {
//                    Text("ペアリングする")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.green)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 10)
//            }
//            
//            Button(action: {
//                isSharing = true
//            }) {
//                HStack {
//                    Image(systemName: "square.and.arrow.up")
//                    Text("アプリを共有")
//                }
//                .font(.title2)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(Color.orange)
//                .foregroundColor(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
//            .padding(.horizontal, 20)
//            
//            Spacer()
//        }
//        .padding()
//        .background(Color(.systemGroupedBackground))
//        .cornerRadius(15)
//        .sheet(isPresented: $isSharing) {
//            ActivityViewController(activityItems: ["一緒にアプリを使おう！\nペアリングID: \(myPairingCode)\nダウンロードはこちら: https://apps.apple.com/app/yourapp-id"])
//        }
//        .alert(isPresented: $showCopyAlert) {
//            Alert(title: Text("コピーしました"), message: Text("ペアリングIDがコピーされました"), dismissButton: .default(Text("OK")))
//        }
//        .onAppear {
//            fetchMyPairingCode()
//        }
//    }
//    
//    func fetchMyPairingCode() {
//        guard let myUserID = Auth.auth().currentUser?.uid else { return }
//        
//        let ref = Database.database().reference()
//        ref.child("users").child(myUserID).child("pairingCode").observeSingleEvent(of: .value) { snapshot in
//            if let code = snapshot.value as? String {
//                myPairingCode = code
//            } else {
//                myPairingCode = "未設定"
//            }
//        }
//    }
//    
//    func copyToClipboard(_ text: String) {
//        UIPasteboard.general.string = text
//    }
//    
//    func searchUserByPairingCode(code: String, completion: @escaping ([String: String]) -> Void) {
//        let ref = Database.database().reference()
//        
//        ref.child("pairingCodes").child(code).observeSingleEvent(of: .value) { snapshot in
//            var results: [String: String] = [:]
//            
//            if let userID = snapshot.value as? String {
//                ref.child("users").child(userID).observeSingleEvent(of: .value) { userSnapshot in
//                    if let userData = userSnapshot.value as? [String: Any],
//                       let userName = userData["pairingCode"] as? String {
//                        results[userID] = userName
//                    }
//                    completion(results)
//                }
//            } else {
//                completion(results) // 検索結果なし
//            }
//        }
//    }
//    
//    func pairWithPartner(partnerID: String) {
//        guard let myUserID = Auth.auth().currentUser?.uid else { return }
//        
//        let ref = Database.database().reference()
//        
//        // 自分の情報に相手の userID を保存
//        ref.child("users").child(myUserID).updateChildValues(["partnerId": partnerID])
//        
//        // 相手の情報にも自分の userID を保存
//        ref.child("users").child(partnerID).updateChildValues(["partnerId": myUserID]) { error, _ in
//            if let error = error {
//                print("ペアリング失敗: \(error.localizedDescription)")
//            } else {
//                print("ペアリング成功")
//            }
//        }
//    }
//}


struct HeartReceivedView: View {
    var count: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var animateHeart = false
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            // 🔹 ふんわりピンクのグラデーション背景
//            LinearGradient(gradient: Gradient(colors: [Color.white,Color.pink.opacity(0.6)]),
//                           startPoint: .topLeading,
//                           endPoint: .bottomTrailing)
            Image("ハート背景")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            VStack(spacing: 20) {
                Image("ハート1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .scaleEffect(animateHeart ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateHeart)

                Text("パートナーからハートが届きました！")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("あなたのことを想っています")
                    .font(.system(size: 18))

                // 🔹 受信回数を強調
                Text("合計 \(count) 回受信されています")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.white.opacity(0.2))
                    )

                // 🔹 閉じるボタンをスタイリッシュに
                Button(action: {
                    isPresented = false
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("閉じる")
                    }
                    .font(.headline)
                    .padding()
                    .frame(width: 150)
                    .background(Color.white.opacity(0.9))
                    .foregroundColor(.red)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .onAppear {
            animateHeart = true
        }
    }
}


import UIKit
import SwiftUI

// **UIActivityViewController を SwiftUI で使えるようにする**
struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        controller.completionWithItemsHandler = { _, _, _, _ in
            presentationMode.wrappedValue.dismiss()
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


#Preview {
//    HeartBeatAnimationView()
    PairingView()
//    HeartReceivedView(count: 1)
}
