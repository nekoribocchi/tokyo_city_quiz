// QuizViewController.swift

import UIKit
import SwiftUI

class QuizViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet var choiceButtons: [UIButton]!
    
    // MARK: - Properties
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var bestScore = 0
    var initialButtonColors: [Int: UIColor] = [:]
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        // ボタンの初期の背景色を保存
        initialButtonColors = [
            1: answerButton1.backgroundColor ?? UIColor.systemPink,
            2: answerButton2.backgroundColor ?? UIColor.systemPink,
            3: answerButton3.backgroundColor ?? UIColor.systemPink,
            4: answerButton4.backgroundColor ?? UIColor.systemPink
        ]
        
        // CSVファイルの読み込み
        csvArray = loadCSV(fileName: "tama")
        
        // 最初のクイズを設定
        setupQuiz()
        
        // ベストスコアを保存
        saveBestScore()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScoreVC" {
            let scoreVC = segue.destination as! ScoreViewController
            scoreVC.correctCount = correctCount
        }
    }
    
    // MARK: - IBActions
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            print("正解")
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
        } else {
            print("不正解")
            judgeImageView.image = UIImage(named: "incorrect")
            updateButtonColor(button: sender, color: UIColor.mypink)
        }
        
        // 正解のボタンを緑色に変更
        highlightCorrectAnswer()
        
        print("スコア: \(correctCount)")
        
        // ○×を表示
        judgeImageView.isHidden = false
        
        // 選択ボタンを押せなくする
        setButtonsEnabled(false)
        
        // 1秒後に次のクイズへ移行
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.judgeImageView.isHidden = true
            self.setButtonsEnabled(true)
            self.nextQuiz()
            self.saveBestScore()
        }
    }
    
    @IBAction func reTopBuutonAction(_ sender: Any) {
        // 2つ目のビューに戻る
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: - Helper Methods
    func setupQuiz() {
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        // タイトル表示
        quizNumberLabel.text = "第\(quizCount + 1)問"
        
        // 画像表示
        let quizImageName = "\(quizArray[6])"
        if let quizImage = UIImage(named: quizImageName) {
            quizImageView.image = quizImage
        } else {
            print("Image not found: \(quizImageName)")
        }
        
        // 選択肢表示
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
    }
    
    func updateButtonColor(button: UIButton, color: UIColor) {
        button.layer.backgroundColor = color.withAlphaComponent(0.5).cgColor
        button.layer.shadowColor = color.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let initialColor = self.initialButtonColors[button.tag] {
                button.layer.backgroundColor = initialColor.cgColor
                button.layer.shadowColor = UIColor.black.cgColor
            }
        }
    }
    
    func highlightCorrectAnswer() {
        switch Int(quizArray[1]) {
        case 1:
            updateButtonColor(button: answerButton1, color: UIColor.mymint)
        case 2:
            updateButtonColor(button: answerButton2, color: UIColor.mymint)
        case 3:
            updateButtonColor(button: answerButton3, color: UIColor.mymint)
        case 4:
            updateButtonColor(button: answerButton4, color: UIColor.mymint)
        default:
            break
        }
    }
    
    func setButtonsEnabled(_ enabled: Bool) {
        answerButton1.isEnabled = enabled
        answerButton2.isEnabled = enabled
        answerButton3.isEnabled = enabled
        answerButton4.isEnabled = enabled
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < 10 {
            setupQuiz()
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
            print("segue")
        }
    }
    
    // CSVファイルを読み込み、配列に変換
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast() // 最後の空行を削除
            
            // ランダムにシャッフル
            csvArray.shuffle()
            
            // 最初の10行だけを取得
            csvArray = Array(csvArray.prefix(10))
            print("CSV Array for \(fileName): \(csvArray)")
        } catch {
            print("エラー")
        }
        return csvArray
    }
    
    // クイズスコアを保存
    func saveQuizScore(score: Int, date: Date, time: Date) {
        let defaults = UserDefaults.standard
        var quizScores = defaults.array(forKey: "QuizScores") as? [[String: Any]] ?? []
        quizScores.append(["score": score, "date": date, "time": time])
        defaults.set(quizScores, forKey: "QuizScores")
    }
    
    // ベストスコアを保存
    func saveBestScore() {
        let defaults = UserDefaults.standard
        let savedBestScore = defaults.integer(forKey: "BestScore")
        
        if correctCount > savedBestScore {
            defaults.set(correctCount, forKey: "BestScore")
        }
        saveQuizScore(score: correctCount, date: Date(), time: Date())
    }
}
