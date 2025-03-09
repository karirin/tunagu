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
    @State private var lastReceivedHeartCount: Int = UserDefaults.standard.integer(forKey: "lastReceivedHeartCount13")
    @State private var isPaired = false
    @State private var partnerEmotion: String = "normal"
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isEmotionSelectionVisible = false
    @State private var isPairingRequestReceived = false
    @State private var isPairingFlag = false
    @State private var receivedPartnerID: String = ""
    @State private var checkedPairingRequest = UserDefaults.standard.bool(forKey: "checkedPairingRequest")
    @State private var partnerStatus: String = ""
    @State private var myStatus: String = ""
    @State private var isStatusSelectionVisible = false
    @State private var statusHistory: [String] = []
    @State private var heartImageName: String = "ハート1"
    @State private var receivedHeartCount:Int = 0
    @State private var tutorialNum:Int = 0
    @State private var isStartFlag = false
    
    @State private var buttonRect: CGRect = .zero
    @State private var bubbleHeight: CGFloat = 0.0
    @State private var buttonRect2: CGRect = .zero
    @State private var bubbleHeight2: CGFloat = 0.0
    @State private var buttonRect3: CGRect = .zero
    @State private var bubbleHeight3: CGFloat = 0.0
    @State private var buttonRect4: CGRect = .zero
    @State private var bubbleHeight4: CGFloat = 0.0
    @State private var buttonRect5: CGRect = .zero
    @State private var bubbleHeight5: CGFloat = 0.0
    @State private var buttonRect6: CGRect = .zero
    @State private var bubbleHeight6: CGFloat = 0.0
    @State private var buttonRect7: CGRect = .zero
    @State private var bubbleHeight7: CGFloat = 0.0
    @State private var buttonRect8: CGRect = .zero
    @State private var bubbleHeight8: CGFloat = 0.0
    @State private var isLoading = true

    @State private var selectedBackground = "背景2" // 選択中の背景
    
    var backgroundOptions = ["背景1", "背景2", "背景3", "背景4", "背景5", "背景6", "背景7", "背景8"]
    
    
    var backgroundImage: String {
        switch partnerEmotion {
        case "happy": return "嬉しい"
        case "sad": return "寂しい"
        case "normal": return "普通"
        case "love": return "甘えたい"
        default: return "普通"
        }
    }
    
    var partnerEmotionEmoji: String {
        switch partnerEmotion {
        case "happy": return "😊"
        case "sad": return "😭"
        case "normal": return "😌"
        case "love": return "🥰"
        default: return "😌"
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
            Image("\(backgroundImage)") // 選択した背景を適用
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack(spacing: 30){
                    Button(action: {
                        generateHapticFeedback()
                        tutorialNum = 1
                    }) {
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                                .shadow(radius: 5)
                        }
                    }
                    if isPaired {
                    VStack(spacing:0){
                        Text("パートナーの感情")
                            .font(.system(size: 14))
                        HStack{
                            Text("\(partnerEmotionEmoji)")
                                .font(.system(size: 40))
                                .padding(.trailing,-60)
                                .zIndex(1)
                            Text("\(backgroundImage)")
                                .font(.system(size: 18))
                                .padding(.vertical,8)
                                .padding(.horizontal)
                                .padding(.leading,30)
                                .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                                .cornerRadius(24)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.clear, lineWidth: 1)
                                )
                                .shadow(radius: 5)
                        }
                    }
                    .fontWeight(.bold)
                        VStack {
                            Text("パートナーの状態")
                                .bold()
                                .font(.system(size: 14))
                            Text(partnerStatus == "" ? "-" : "\(partnerStatus)")
                                .font(.system(size: 18))
                                .bold()
                                .padding(.vertical,8)
                                .padding(.horizontal)
                                .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                                .cornerRadius(24)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.clear, lineWidth: 1)
                                )
                                .shadow(radius: 5)
                        }
                    }
                    
                }
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: ViewPositionKey5.self, value: [geometry.frame(in: .global)])
                })
                Spacer()
                ZStack{
                    
                // 飛び散る小さなハートたち
                ForEach(hearts) { heart in
                    Image(heartImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.pink)
                        .offset(heart.offset)
                        .scaleEffect(heart.scale)
                        .opacity(heart.opacity)
                }
                    Image(heartImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .scaleEffect(scale)
                        .scaleEffect(getHeartScale())
                        .animation(
                            Animation.easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true),
                            value: scale
                        )
                        .shadow(radius: 3)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: ViewPositionKey4.self, value: [geometry.frame(in: .global)])
                        })
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
                            if tutorialNum == 6 {
                                tutorialNum = 7
                            }
                            generateHapticFeedback()
                            explodeHearts() // ハートアニメーションを実行
                            sendHeart() // Firebaseにハート送信
                        }
                }
                Spacer()
                VStack {
                    if isPaired {
                        HStack{
                            Button(action: {
                                generateHapticFeedback()
                                isStatusSelectionVisible = true
                            }) {
                                Image(systemName:"figure")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.black)
                                    .padding()
                            }
                            
                            .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                            .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .shadow(radius: 5)
                            .padding(.trailing,40)
                            Button(action: {
                                generateHapticFeedback()
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
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: ViewPositionKey6.self, value: [geometry.frame(in: .global)])
                        })
                        .padding(.bottom)
                    }
                    if !isPaired {
                        Button(action: {
                            generateHapticFeedback()
                            isPairingViewPresented = true
                        }) {
                            HStack {
                                Image(systemName: "heart.fill")
                                Text("ペアリングする")
                            }
                            .font(.system(size: 24))
                        }
                        .padding()
                        .background(.white)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .clipShape(Capsule())
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: ViewPositionKey.self, value: [geometry.frame(in: .global)])
                        })
                        .padding(.bottom, 40)
                        .shadow(radius: 5)
                    }
                }
            }
            
            if isEmotionSelectionVisible {
                EmotionSelectionView(isPresented: $isEmotionSelectionVisible)
            }
            if isHeartReceived {
                HeartReceivedView(count: receivedHeartCount, isPresented: $isHeartReceived)
            }
            
            if isPairingRequestReceived {
                PairingRequestView(partnerID: receivedPartnerID, isPresented: $isPairingRequestReceived, tutorialNum: $tutorialNum)
            }
            
            if isStatusSelectionVisible {
                PairingStatusView(isPresented: $isStatusSelectionVisible)
            }
            
            if isPairingViewPresented {
                PairingView(isPresented: $isPairingViewPresented, buttonRect2: $buttonRect2,
                            bubbleHeight2: $bubbleHeight2,
                            buttonRect3: $buttonRect3,
                            bubbleHeight3: $bubbleHeight3)
            }
        
            TutorialView(
                            tutorialNum: $tutorialNum,
                            buttonRect: $buttonRect,
                            bubbleHeight: $bubbleHeight,
                            buttonRect2: $buttonRect2,
                            bubbleHeight2: $bubbleHeight2,
                            buttonRect3: $buttonRect3,
                            bubbleHeight3: $bubbleHeight3,
                            buttonRect4: $buttonRect4,
                            bubbleHeight4: $bubbleHeight4,
                            buttonRect5: $buttonRect5,
                            bubbleHeight5: $bubbleHeight5,
                            buttonRect6: $buttonRect6,
                            bubbleHeight6: $bubbleHeight6,
                            buttonRect7: $buttonRect7,
                            bubbleHeight7: $bubbleHeight7,
                            buttonRect8: $buttonRect8,
                            bubbleHeight8: $bubbleHeight8
                        )
            
        }
        .animation(.easeInOut, value: isEmotionSelectionVisible)
        .animation(.easeInOut, value: isStatusSelectionVisible)
        .onPreferenceChange(ViewPositionKey.self) { positions in
            self.buttonRect = positions.first ?? .zero
        }
        .onPreferenceChange(ViewPositionKey4.self) { positions in
            self.buttonRect4 = positions.first ?? .zero
        }
        .onPreferenceChange(ViewPositionKey5.self) { positions in
            self.buttonRect5 = positions.first ?? .zero
        }
        .onPreferenceChange(ViewPositionKey6.self) { positions in
            self.buttonRect6 = positions.first ?? .zero
        }
        .onAppear {
            let userDefaults = UserDefaults.standard
            if !userDefaults.bool(forKey: "hasLaunchedTorialFlagOnappear") {
                saveUserInfo()
                tutorialNum = 1
            }
            userDefaults.set(true, forKey: "hasLaunchedTorialFlagOnappear")
            userDefaults.synchronize()
            
            isLoading = true // 🔹 ローディング開始
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            fetchStatusHistory { dispatchGroup.leave() }

            dispatchGroup.enter()
            checkPairingStatus { dispatchGroup.leave() }

            dispatchGroup.enter()
            fetchPartnerEmotion { dispatchGroup.leave() }

            dispatchGroup.enter()
            fetchTotalHeartCount { dispatchGroup.leave() }

            dispatchGroup.enter()
            observePairingRequest { dispatchGroup.leave() }

            dispatchGroup.enter()
            fetchPartnerStatus { dispatchGroup.leave() }

            dispatchGroup.notify(queue: .main) {
                isLoading = false // 🔹 すべてのデータ取得完了
            }
        }

        .onChange(of: isPairingRequestReceived) { isPairingRequestReceived in
            checkPairingStatus()
        }
        .onChange(of: isStatusSelectionVisible) { isStatusSelectionVisible in
            fetchStatusHistory(completion: <#() -> Void#>)
        }

        .fullScreenCover(isPresented:$isStartFlag) {
            StartView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func sendLocalNotification(message: String) {
        let content = UNMutableNotificationContent()
        content.title = "💖 新しいハート"
        content.body = message
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知エラー: \(error.localizedDescription)")
            }
        }
    }
    
    func observeNotifications() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference().child("users").child(myUserID).child("notifications")

        ref.observe(.childAdded) { snapshot in
            if let notificationData = snapshot.value as? [String: Any],
               let message = notificationData["message"] as? String {
                
                // 🔹 ローカル通知を送信
                sendLocalNotification(message: message)

                // 🔹 通知を Firebase から削除（履歴管理する場合は不要）
                snapshot.ref.removeValue()
            }
        }
    }

    
    func saveStatus(status: String) {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        let userRef = ref.child("users").child(myUserID)

        userRef.updateChildValues(["status": status]) { error, _ in
            if let error = error {
                print("ステータスの保存失敗: \(error.localizedDescription)")
            } else {
                print("ステータスの保存成功: \(status)")
                DispatchQueue.main.async {
                    alertTitle = "ステータス変更"
                    alertMessage = "\(status) に変更しました"
                    showAlert = true
                }
            }
        }

        // 過去のステータス履歴を Firebase に追加（重複を避ける）
        userRef.child("statusHistory").observeSingleEvent(of: .value) { snapshot in
            var history = snapshot.value as? [String] ?? []

            if !history.contains(status) {
                history.append(status)
                userRef.child("statusHistory").setValue(history)
            }
        }
    }
    
    func observePairingRequest() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("partnerId").observe(.value) { snapshot in
            if let partnerID = snapshot.value as? String, !partnerID.isEmpty {
                let newPartnerID = String(partnerID.prefix(4)) // 上4桁を取得
                
                // 前回のペアリング相手を取得
                let lastPartnerID = UserDefaults.standard.string(forKey: "lastReceivedPartnerID7") ?? ""

                DispatchQueue.main.async {
                    if newPartnerID != lastPartnerID {
                        // パートナーが変わったら通知を出す
                        isPairingRequestReceived = true
                        receivedPartnerID = newPartnerID
                        
                        // 新しいパートナーIDを保存
                        UserDefaults.standard.set(newPartnerID, forKey: "lastReceivedPartnerID7")
                    }
                }
            }
        }
    }

    func fetchPartnerStatus() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("partnerId").observeSingleEvent(of: .value) { snapshot in
            if let partnerID = snapshot.value as? String {
                ref.child("users").child(partnerID).child("status").observe(.value) { statusSnapshot in
                    if let status = statusSnapshot.value as? String {
                        DispatchQueue.main.async {
                            self.partnerStatus = status
                        }
                    }
                }
            }
        }
    }
    
    func getHeartScale() -> CGFloat {
        let maxScaleIncrease: CGFloat = 2.5 // 1.5倍まで拡大
        let baseScale: CGFloat = 1.0 // 初期スケール

        let progress = CGFloat(heartCount % 100) / 100.0 // 0.0〜1.0の範囲で進行度を計算
        return baseScale + (maxScaleIncrease - baseScale) * progress
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
//                isPaired = false
                isPaired = true
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
                    
                    ref.child("users").child(partnerID).child("notifications").childByAutoId().setValue(heartData)
                    
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

                        let savedCount = UserDefaults.standard.integer(forKey: "lastReceivedHeartCount16")

                        // 相手が送った新しいハートがあれば更新
                        if count > savedCount {
                            receivedHeartCount = count - savedCount
                            isHeartReceived = true
                            UserDefaults.standard.set(count, forKey: "lastReceivedHeartCount16")
                        }
                    }
                }
        }
    }

    func fetchStatusHistory(completion: @escaping () -> Void) {
        guard let myUserID = Auth.auth().currentUser?.uid else {
            completion() // 🔹 ユーザーIDが取得できない場合も完了通知
            return
        }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("statusHistory").observeSingleEvent(of: .value) { snapshot in
            if let history = snapshot.value as? [String] {
                DispatchQueue.main.async {
                    self.statusHistory = history
                }
            }
            completion() // 🔹 データ取得完了時に呼び出し
        }
    }

    
    func getHeartImageName() -> String {
        switch heartCount {
        case 0..<100:
            return "ハート1"
        case 100..<200:
            return "ハート2"
        case 200..<300:
            return "ハート3"
        case 300..<400:
            return "ハート4"
        case 400...:
            return "ハート5"
        default:
            return "ハート1"
        }
    }
    
    func fetchTotalHeartCount() {
        getTotalHeartCount { total in
            DispatchQueue.main.async {
                self.heartCount = total
                self.heartImageName = getHeartImageName()
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

struct PairingRequestView: View {
    var partnerID: String
    @Binding var isPresented: Bool
    @Binding var tutorialNum: Int
    @State private var hearts: [Heart] = [] // 飛び散るハートのリスト
    @State private var timer: Timer?
    struct Heart: Identifiable {
        let id = UUID()
        var offset: CGSize
        var scale: CGFloat
        var opacity: Double
    }

    var body: some View {
        ZStack{
            Image("ハート背景")
                            .resizable()
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.9)
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

                ZStack{
                    Image("ハート1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("ペアリングしました🎉")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                Text(" \(partnerID) さんとペアリングしました！")
                    .font(.system(size: 18))
                    .padding()
                
                Button(action: {
                    generateHapticFeedback()
                    let userDefaults = UserDefaults.standard
                    if !userDefaults.bool(forKey: "hasLaunchedTutorial4Onappear") {
                        tutorialNum = 5
                    }
                    userDefaults.set(true, forKey: "hasLaunchedTutorial4Onappear")
                    userDefaults.synchronize()
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
        }
        .onAppear {
            startHeartExplosionLoop()
        }
        .onDisappear {
            timer?.invalidate() // 画面が閉じられたらタイマーを停止
        }
    }
    
    func startHeartExplosionLoop() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            explodeHearts()
        }
    }
    
    func explodeHearts() {
        hearts.removeAll() // 既存のハートをクリア
        
        for _ in 0..<20 { // 20個のハートを作成
            let randomX = CGFloat.random(in: -400...400) // ランダムなX座標
            let randomY = CGFloat.random(in: -400...400) // ランダムなY座標
            
            let newHeart = Heart(
                offset: CGSize(width: 0, height: 0),
                scale: 1.0,
                opacity: 1.0
            )
            
            hearts.append(newHeart) // ハートをリストに追加
            
            // アニメーションでハートを飛ばす
            withAnimation(Animation.easeOut(duration: 2.2)) {
                let index = hearts.count - 1
                hearts[index].offset = CGSize(width: randomX, height: randomY)
                hearts[index].scale = 0.5
                hearts[index].opacity = 0.0
            }
        }
    }
}

struct PairingStatusView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @State private var selectedEmotion: String = ""
    @State private var statusHistory: [String] = []
    @State private var myStatus: String = ""
    @State private var isStatusSelectionVisible = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var isHistoryFlag = false
    @State private var tutorialFlag: Bool = false
    
    let emotions: [(name: String, label: String)] = [
        ("happy", "嬉しい 😊"),
        ("sad", "寂しい 😢"),
        ("tired", "疲れた 😴"),
        ("needy", "甘えたい 🥺")
    ]
    
    var body: some View {
        Color.black.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
        VStack(spacing:-20) {
            if tutorialFlag {
                Spacer()
                VStack(spacing:20){
                    Image("チュートリアルステータス")
                        .resizable()
                        .scaledToFit()
                    Text("登録したあなたのステータスは\nペアリング相手の画面に表示されます")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(.white))
                        .fontWeight(.bold)
                }
            }
            Spacer()
            HStack{
                Button(action: {
                    generateHapticFeedback()
                    tutorialFlag.toggle() }) {
                        ZStack{
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 20)
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                    }
                }.padding(.leading,30)
                Spacer()
                Text("いま何してる？")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.white))
                    .padding()
                Spacer()
                Button(action: { generateHapticFeedback()
                    isPresented = false }) {
                    Text("×")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.white))
                        .padding(.bottom,5)
                }.padding(.trailing,30)
            }
            
            if isHistoryFlag {
                HStack{
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            ForEach(statusHistory, id: \.self) { status in
                                Button(action: {
                                    generateHapticFeedback()
                                    myStatus = status
                                    saveStatus(status: status)
                                    isStatusSelectionVisible = false
                                }) {
                                    Text(status)
                                        .font(.system(size: 18))
                                        .foregroundStyle(.black)
                                        .padding(5)
                                }
                                .frame(width: 170)
                                .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                .padding(.vertical)
                HStack(spacing:0){
                    Spacer()
                    Button(action: {
                        generateHapticFeedback()
                        isHistoryFlag = false
                    }) {
                        HStack(spacing:5){
                            Text("戻る")
                                .font(.system(size: 18))
                                .foregroundStyle(.black)
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 18))
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.trailing,5)
                .padding(.top)
            } else {
                HStack(spacing: -20) {
                    TextField("例: 仕事中", text: $myStatus)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .cornerRadius(5)
                    Button(action: {
                        generateHapticFeedback()
                        saveStatus(status: myStatus)
                        isStatusSelectionVisible = false
                    }) {
                        HStack(spacing: 5){
                            Image(systemName: "plus")
                        }
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                        .shadow(radius: 5)
                    }
                    .padding()
                    .clipShape(Capsule())
                    Button(action: {
                        generateHapticFeedback()
                        isHistoryFlag = true
                    }) {
                        HStack(spacing: 5){
                            Image(systemName: "clock.arrow.circlepath")
                            Text("登録履歴")
                        }
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                        .shadow(radius: 5)
                    }
                    .padding()
                    .clipShape(Capsule())
                }
                HStack{
                    Text("10文字以内で入力")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top, 5)
                    Spacer()
                }.padding(.leading)
            }
            
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .animation(.easeInOut, value: isHistoryFlag)
        .animation(.easeInOut, value: tutorialFlag)
        .onAppear {
            let userDefaults = UserDefaults.standard
            if !userDefaults.bool(forKey: "hasLaunchedtuStatusTorialFlagOnappear") {
                tutorialFlag = true
            }
            userDefaults.set(true, forKey: "hasLaunchedStatusTutorialFlagOnappear")
            userDefaults.synchronize()
            fetchStatusHistory()
            fetchMyStatus()
        }
    }
    
    func fetchMyStatus() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("status").observe(.value) { snapshot in
            if let status = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.myStatus = status
                }
            }
        }
    }

    
    func fetchStatusHistory() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("statusHistory").observeSingleEvent(of: .value) { snapshot in
            if let history = snapshot.value as? [String] {
                DispatchQueue.main.async {
                    self.statusHistory = history
                }
            }
        }
    }

    func saveStatus(status: String) {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        let userRef = ref.child("users").child(myUserID)

        userRef.updateChildValues(["status": status]) { error, _ in
            if let error = error {
                print("ステータスの保存失敗: \(error.localizedDescription)")
            } else {
                print("ステータスの保存成功: \(status)")
                DispatchQueue.main.async {
                    alertTitle = "ステータス変更"
                    alertMessage = "\(status) に変更しました"
                    showAlert = true
                }
            }
        }

        // 過去のステータス履歴を Firebase に追加（重複を避ける）
        userRef.child("statusHistory").observeSingleEvent(of: .value) { snapshot in
            var history = snapshot.value as? [String] ?? []

            if !history.contains(status) {
                history.append(status)
                userRef.child("statusHistory").setValue(history)
            }
        }
    }
    
    func selectEmotion(_ emotion: String) {
        saveEmotionStatus(emotion: emotion)
        isPresented = false
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
}

struct EmotionSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @State private var selectedEmotion: String = ""
    @State private var tutorialFlag: Bool = false
    @State private var myEmotion: String = "normal"
    
    let emotions: [(name: String, label: String)] = [
        ("happy", "嬉しい 😊"),
        ("sad", "寂しい 😢"),
        ("tired", "疲れた 😴"),
        ("needy", "甘えたい 🥺")
    ]
    
    var body: some View {
        Color.black.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
        VStack(spacing:-20) {
            if tutorialFlag {
                VStack(spacing:-10){
                    Image("チュートリアル感情")
                        .resizable()
                        .scaledToFit()
                        .frame(height: isSmallDevice() ? 380 : 480)
                    Text("選んだ感情によって\nペアリング相手の背景が変わります")
                        .font(.system(size: 20))
                        .foregroundStyle(Color(.white))
                        .fontWeight(.bold)
                }
            }
            Spacer()
            HStack{
                Button(action: { 
                    generateHapticFeedback()
                    tutorialFlag.toggle() }) {
                        ZStack{
                            Circle()
                                .foregroundColor(.gray)
                                .frame(width: 20)
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                    }
                }.padding(.leading,30)
                Spacer()
                Text("いまどんな気持ち？")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.white))
                    .padding()
                Spacer()
                Button(action: { 
                    generateHapticFeedback()
                    isPresented = false }) {
                    Text("×")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(.white))
                        .padding(.bottom,5)
                }.padding(.trailing,30)
            }
            HStack{
                Text("↓ タップしてね ↓")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.white))
                    .padding(.top)
                VStack(spacing:-15){
                    Text("あなたの感情")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .padding()
                    HStack{
                        Text(getEmotionEmoji(emotion: myEmotion)) // 🔹 自分の感情の絵文字
                            .font(.system(size: 34))
                            .padding(.trailing,-60)
                            .zIndex(1)
                        Text(getEmotionText(emotion: myEmotion)) // 🔹 自分の感情のテキスト
                            .font(.system(size: 14))
                            .padding(.vertical,8)
                            .padding(.horizontal)
                            .padding(.leading,20)
                            .background(Color(hue: 1.0, saturation: 0.098, brightness: 0.992))
                            .cornerRadius(24)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.clear, lineWidth: 1)
                            )
                            .shadow(radius: 5)
                    }
                }
                .fontWeight(.bold)
            }

            HStack(spacing: 30) {
                
                Button(action: { generateHapticFeedback()
                    selectEmotion("normal") }) {
                    VStack{
                        Text("😌")
                            .font(.system(size: 50))
                        Text("普通")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.white))
                    }
                }
                Button(action: { generateHapticFeedback()
                    selectEmotion("happy") }) {
                    VStack{
                        Text("😊")
                            .font(.system(size: 50))
                        Text("嬉しい")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.white))
                    }
                }
                Button(action: { generateHapticFeedback()
                    selectEmotion("love") }) {
                    VStack{
                        Text("🥰")
                            .font(.system(size: 50))
                        Text("甘えたい")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.white))
                    }
                }
                Button(action: { generateHapticFeedback()
                    selectEmotion("sad") }) {
                    VStack{
                        Text("😭")
                            .font(.system(size: 50))
                        Text("悲しい")
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
        .animation(.easeInOut, value: tutorialFlag)
            .onAppear {
                let userDefaults = UserDefaults.standard
                if !userDefaults.bool(forKey: "hasLaunchedEmotionTorialFlagOnappear") {
                    tutorialFlag = true
                }
                userDefaults.set(true, forKey: "hasLaunchedEmotionTorialFlagOnappear")
                userDefaults.synchronize()
                fetchMyEmotion()
            }
    }
    
    func fetchMyEmotion() {
        guard let myUserID = Auth.auth().currentUser?.uid else { return }

        let ref = Database.database().reference()
        ref.child("users").child(myUserID).child("emotionStatus").observe(.value) { snapshot in
            if let emotion = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.myEmotion = emotion
                }
            }
        }
    }
    
    func selectEmotion(_ emotion: String) {
        saveEmotionStatus(emotion: emotion)
        isPresented = false
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
    
    func getEmotionEmoji(emotion: String) -> String {
        switch emotion {
        case "happy": return "😊"
        case "sad": return "😭"
        case "normal": return "😌"
        case "love": return "🥰"
        default: return "😌"
        }
    }

    func getEmotionText(emotion: String) -> String {
        switch emotion {
        case "happy": return "嬉しい"
        case "sad": return "寂しい"
        case "normal": return "普通"
        case "love": return "甘えたい"
        default: return "普通"
        }
    }

}

import UIKit
import CoreImage.CIFilterBuiltins

struct PairingView: View {
    @Binding var isPresented: Bool
    @State private var myPairingCode: String = ""
    @State private var showCopyAlert = false
    @State private var isSharing = false
    @State private var searchCode = ""
    @State private var searchResults: [String: String] = [:]
    @State private var selectedUserID: String?
    @Environment(\.presentationMode) var presentationMode
    @State private var showSearchNotFoundAlert = false
    @State private var showAlert = false
    @State private var isPairingViewPresented = false
    @State private var isPairingRequestReceived = false
    @State private var receivedPartnerID: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var pairingCodeDigits: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @State private var showTutorial = false
    @Binding var buttonRect2: CGRect
    @Binding var bubbleHeight2: CGFloat
    @Binding var buttonRect3: CGRect
    @Binding var bubbleHeight3: CGFloat

    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Button(action: {
                        isPresented = false
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
                        generateHapticFeedback()
                        isPresented = false
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("fontGray"))
                        Text("戻る")
                            .foregroundColor(Color("fontGray"))
                    }
                    .padding(.leading)
                    .opacity(0)
                }
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
                    generateHapticFeedback()
                    let userDefaults = UserDefaults.standard
                    if !userDefaults.bool(forKey: "hasLaunchedTutorialOnappear") {
                        showTutorial = true
                    } else {
                        isSharing = true
                    }
                    userDefaults.set(true, forKey: "hasLaunchedTutorialOnappear")
                    userDefaults.synchronize()
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
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: ViewPositionKey2.self, value: [geometry.frame(in: .global)])
                })
                .padding(.horizontal, 20)
                Button(action: {
                    showTutorial = true
                }) {
                    Text("LINEで簡単にアプリを共有する方法")
                        .foregroundStyle(.blue)
                }
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
                                .frame(width: 50, height: 60)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                .font(.system(size: 28, weight: .bold))
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
//                                            if results.isEmpty {
//                                                showAlert(title: "検索結果なし", message: "このペアリングIDは存在しません")
//                                            }
                                        }
                                    }
                                }
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: ViewPositionKey3.self, value: [geometry.frame(in: .global)])
                    })
                    HStack(spacing: 20){
                        Button(action: {
                            //                        searchUserByPairingCode(code: searchCode) { results in
                            //                            self.searchResults = results
                            //                            print("self.searchResults   :\(self.searchResults)")
                            //                        }
                            generateHapticFeedback()
                            // 🔹 クリップボードからペーストできるようにする
                            if let pastedText = UIPasteboard.general.string {
                                handlePaste(pastedText)
                            }
                        }) {
                            HStack{
                                Image(systemName: "doc.on.clipboard")
                                Text("ペースト")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal,10)
                            .padding(.vertical,8)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        
                        Button(action: {
                            generateHapticFeedback()
                            pairingCodeDigits = ["", "", "", ""]
                            focusedIndex = 0
                        }) {
                            HStack{
                                Image(systemName: "trash")
                                Text("削除")
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal,10)
                            .padding(.vertical,8)
                            .background(Color.gray)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                    }
                }
                .padding(.horizontal, 40)
                HStack(spacing: 15){
                    Text("あなたのペアリングID")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    // ペアリングID表示
                    HStack {
                        Text(myPairingCode)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Button(action: {
                            generateHapticFeedback()
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
                    .padding(5)
                    .padding(.horizontal,8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
                Button(action: {
                    generateHapticFeedback()
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
            }
            if showTutorial {
                ShareTutorialView(isPresented: $showTutorial, showTutorial: $isSharing)
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
                                    generateHapticFeedback()
                                    pairWithPartner(partnerID: userID)
                                    isPresented = false
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
                            generateHapticFeedback()
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
        .onPreferenceChange(ViewPositionKey2.self) { positions in
            self.buttonRect2 = positions.first ?? .zero
        }
        .onPreferenceChange(ViewPositionKey3.self) { positions in
            self.buttonRect3 = positions.first ?? .zero
        }
        .onAppear{
            fetchMyPairingCode()
//            observePairingRequest()
        }
        .sheet(isPresented: $isSharing) {
            ActivityViewController(activityItems: ["一緒にもっと楽しい時間を過ごしたい！\nこのアプリなら実現できます👬\nペアリングID: \(myPairingCode)\nダウンロードはこちら: https://apps.apple.com/app/yourapp-id"])
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func handlePaste(_ text: String) {
        let pastedText = text.trimmingCharacters(in: .whitespacesAndNewlines) // 空白を除去
        
        // 🔹 4文字なら分割して適用
        if pastedText.count == 4 {
            pairingCodeDigits = Array(pastedText).map { String($0) }
            focusedIndex = nil // 最後の入力ボックスにフォーカスを外す
        } else {
            showAlert(title: "ペーストエラー", message: "ペアリングIDは4文字である必要があります")
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
                print("searchUserByPairingCode1")

                ref.child("users").child(userID).observeSingleEvent(of: .value) { userSnapshot in
                    if let userData = userSnapshot.value as? [String: Any],
                       let userName = userData["pairingCode"] as? String {
                        results[userID] = userName
                    }
                    
                    if results.isEmpty {
                        print("検索結果なし　アラート")
                        DispatchQueue.main.async {
                            showAlert(title: "検索結果なし", message: "このペアリングIDは存在しません")
                        }
                    }
                    
                    // 自分自身のペアリングIDを検索した場合はエラー
                    if userID == myUserID {
                        print("自分のペアリングIDは検索できません")
                        showAlert(title: "検索エラー", message: "自分のペアリングIDは検索できません")
                        completion([:])
                        return
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

struct HeartReceivedView: View {
    var count: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var animateHeart = false
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
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
                Text("合計 \(count) 回送られています")
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
                    generateHapticFeedback()
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

func isSmallDevice() -> Bool {
    return UIScreen.main.bounds.width < 390
}

func generateHapticFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
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
    HeartBeatAnimationView()
//    PairingView(tutorialNum: .constant(3))
//    HeartReceivedView(count: 1)
//    PairingRequestView(partnerID: "test", isPresented: .constant(false))
}
