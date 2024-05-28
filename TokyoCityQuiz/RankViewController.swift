// RankViewController.swift
import UIKit

class RankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var quizName: String = ""
    var bestScore = 0
    var topScores = [(score: Int, date: Date, time: Date)]()
    var correctCount = 0
    var scorePer_current: Int = 0
    var scorePer: Int = 0
    var bestScorePer: Int = 0
    let numberOfTopScoresToDisplay = 5
    var topScoresText = "" // topScoresTextを定義
    let quizCount = 10
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        tableView.separatorColor = .systemPurple
        tableView.dataSource = self
        tableView.delegate = self
        
        // 保存されたクイズのスコアと日付を取得
        if let quizScores = UserDefaults.standard.array(forKey: "QuizScores") as? [[String: Any]] {
            for quiz in quizScores {
                if let score = quiz["score"] as? Int, let date = quiz["date"] as? Date, let time = quiz["time"] as? Date {
                    topScores.append((score: score, date: date, time: time))
                }
            }
        }
        
        // スコアを降順にソート
        topScores.sort { $0.score > $1.score }
        
        // 上位5つのスコアのみ保持
        topScores = Array(topScores.prefix(numberOfTopScoresToDisplay))
        
        // テーブルビューをリロード
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topScores.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 各セルの高さを設定
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        // 現在のインデックスのスコアと日付を取得
        let score = topScores[indexPath.row].score
        let date = topScores[indexPath.row].date
        let time = topScores[indexPath.row].time
        
        // セルにスコアと日付を表示
        scorePer = Int(Double(score) / Double(quizCount) * 100)
        cell.scoreLabel.text = "\(indexPath.row + 1).  \(scorePer)点"
        
        print ("\(scorePer)点")
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        cell.dateLabel.text = dateFormatter.string(from: date)
        cell.timeLabel.text = timeFormatter.string(from: time)
        
        return cell
    }
    
    // MARK: - IBActions
    @IBAction func reTopButtonAction(_ sender: Any) {
        // 2つ目のビューに戻る
        self.presentingViewController?.dismiss(animated: true)
    }
}

