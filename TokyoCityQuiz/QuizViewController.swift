//2023/12/31.
//

import UIKit
import SwiftUI

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizNumberLabel: UILabel!
    //@IBOutlet weak var quizTextView: UITextView!
    
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var quizImageView: UIImageView!
    
    @IBOutlet var choiceButtons: [UIButton]!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var bestScore = 0
    var initialButtonColors: [Int: UIColor] = [:]
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    //画面を表示した時
    override func viewDidLoad() {
        
        self.overrideUserInterfaceStyle = .light
        super.viewDidLoad()
        // ボタンの初期の背景色を保存
        initialButtonColors = [
            1: answerButton1.backgroundColor ?? UIColor.systemPink,
            2: answerButton2.backgroundColor ?? UIColor.systemPink,
            3: answerButton3.backgroundColor ?? UIColor.systemPink,
            4: answerButton4.backgroundColor ?? UIColor.systemPink
        ]
        
        
        
        //BestScoreの初期化
        //UserDefaults.standard.removeObject(forKey: "BestScore")
        
        
        //csvファイルの全部を読み込む
        
        csvArray = loadCSV(fileName: "tama")
        
        //csvArrayの一個めだけを読み込む
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        //タイトル表示
        quizNumberLabel.text = "第\(quizCount+1)問"
        
        
        // 画像表示
        
        let quizImageName = "\(quizArray[6])"
        if let quizImage = UIImage(named: quizImageName) {
            quizImageView.image = quizImage
        } else {
            print("Image not found: \(quizImageName)")
        }
        
        //選択肢表示
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
        
        
        // ユーザーのベストスコアを取得
        //bestScore = UserDefaults.standard.integer(forKey: "BestScore")
        saveBestScore()
        
        
    }
    
    
    
    // ScoreViewControllerに遷移するときQuizViewControllerのデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreVC" {
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.correctCount = correctCount
        }
        
    }
    
    
    //選択肢を押した時
    @IBAction func btnAction(sender: UIButton){
        if sender.tag == Int(quizArray[1]){
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage (named: "correct")
            //sender.layer.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.7).cgColor
            
        }else{
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            sender.layer.backgroundColor = UIColor.mypink.withAlphaComponent(0.5).cgColor
            sender.layer.shadowColor = UIColor.mypink.cgColor
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Revert back to the original color
                if let initialColor = self.initialButtonColors[sender.tag] {
                    sender.layer.backgroundColor = initialColor.cgColor
                    sender.layer.shadowColor =  UIColor.black.cgColor
                }
            }
        }
        
        
        // 不正解の場合、緑になったボタンを1秒後に元の色に戻す
        switch  Int(quizArray[1]){
        case 1:
            if let initialColor = initialButtonColors[1] {
                answerButton1.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton1.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton1.backgroundColor = initialColor
                    self.answerButton1.layer.shadowColor =  UIColor.black.cgColor
                    
                    
                }
            }
        case 2:
            if let initialColor = initialButtonColors[2] {
                answerButton2.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton2.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton2.backgroundColor = initialColor
                    self.answerButton2.layer.shadowColor =  UIColor.black.cgColor
                    
                }
            }
        case 3:
            if let initialColor = initialButtonColors[3] {
                answerButton3.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton3.layer.shadowColor = UIColor.mymint.cgColor
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton3.backgroundColor = initialColor
                    self.answerButton3.layer.shadowColor =  UIColor.black.cgColor
                    
                }
            }
        case 4:
            if let initialColor = initialButtonColors[4] {
                answerButton4.layer.backgroundColor = UIColor.mymint.withAlphaComponent(0.7).cgColor
                self.answerButton4.layer.shadowColor = UIColor.mymint.cgColor
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.answerButton4.backgroundColor = initialColor
                    self.answerButton4.layer.shadowColor =  UIColor.black.cgColor
                    
                    
                }
            }
        default:
            break
        }
        
        
        print("スコア: \(correctCount)")
        
        //○×を表示
        judgeImageView.isHidden = false
        
        //選択ボタンを押せなくする
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        //0.5秒後に○×を隠す
        //選択ボタンを押せるようにする
        //0.5秒後に次のクイズへ遷移
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
            self.saveBestScore()
            
            
        }
        
        
        
    }
    
    
    func nextQuiz(){
        
        quizCount += 1
        if quizCount < 10{
            //csvArrayの一個めだけを読み込む
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            
            quizNumberLabel.text = "第\(quizCount+1)問"
            //quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
            
            
            // 画像表示
            
            let quizImageName = "\(quizArray[6])"
            if let quizImage = UIImage(named: quizImageName) {
                quizImageView.image = quizImage
            } else {
                print("Image not found: \(quizImageName)")
            }
            
        } else {
            
            performSegue(withIdentifier: "toScoreVC", sender: nil)
            print("segue")
            
        }
        
    }
    
    //csvファイルを配列に入れる
    //改行ごとに一つのセンテンスとして配列に格納される
    func loadCSV(fileName: String) -> [String]{
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do{
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast() // 最後の空行を削除
            
            // ランダムにシャッフル
            csvArray.shuffle()
            
            // 最初の10行だけを取得
            csvArray = Array(csvArray.prefix(10))
            print("CSV Array for \(fileName): \(csvArray)")
        }
        catch{
            print("エラー")
        }
        
        return csvArray
        
    }
    
    
    func saveQuizScore(score: Int, date: Date, time: Date) {
        let defaults = UserDefaults.standard
        var quizScores = defaults.array(forKey: "QuizScores") as? [[String: Any]] ?? []
        quizScores.append(["score": score, "date": date, "time": time])
        defaults.set(quizScores, forKey: "QuizScores")
    }
    
    
    // ユーザーのベストスコアをUserDefaultsに保存する
    
    func saveBestScore() {
        
        let defaults = UserDefaults.standard
        let savedBestScore = defaults.integer(forKey: "BestScore")
        
        if correctCount > savedBestScore{
            defaults.set(correctCount, forKey: "BestScore")
            
        }
        saveQuizScore(score: correctCount, date: Date(), time: Date())
    }
    
    @IBAction func reTopBuutonAction(_ sender: Any) {
        //二つ目のviewに戻る
        self.presentingViewController?.dismiss(animated: true)
    }
}

