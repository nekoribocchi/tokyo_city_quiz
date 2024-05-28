//2023/12/31.
//


import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var quizName: String = ""
    var bestScore = 0
    var topScores = [(score: Int, date:Date , time: Date)]()
    var correctCount = 0
    var scorePer_current : Int = 0
    var scorePer: Int = 0
    
    var bestScorePer: Int = 0
    let numberOfTopScoresToDisplay = 5
    var topScoresText = "" // topScoresTextを定義
    let quizCount = 10
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        tableView.separatorColor = .systemPurple
        tableView.dataSource = self
        tableView.delegate = self
        
        print("correctCount\(correctCount)")
        scorePer_current = Int(Double(correctCount) / Double(quizCount) * 100)
        scoreLabel.text = "\(scorePer_current)点"
        print(scorePer_current)
        // Retrieve saved quiz scores and dates
        if let quizScores = UserDefaults.standard.array(forKey: "QuizScores") as? [[String: Any]] {
            for quiz in quizScores {
                if let score = quiz["score"] as? Int, let date = quiz["date"] as? Date ,let time = quiz["time"] as? Date {
                    topScores.append((score: score, date: date, time: time))
                }
            }
        }
        
        // Sort topScores by score in descending order
        topScores.sort { $0.score > $1.score }
        
        // Keep only the top five scores
        topScores = Array(topScores.prefix(numberOfTopScoresToDisplay))
        
        // Reload table view
        tableView.reloadData()
    }
    
    // UITableViewのセクション数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // UITableViewの行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topScores.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ここで各セルの高さを設定します
        return 60// 例として高さを100に設定しています
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        
        // Get score and date for the current index
        let score = topScores[indexPath.row].score
        let date = topScores[indexPath.row].date
        let time = topScores[indexPath.row].time
        // Display score and date in the cell
        scorePer = Int(Double(score) / Double(quizCount) * 100)
        cell.scoreLabel.text = "\(indexPath.row + 1).  \(scorePer)点"
        
        
        print ("\(scorePer)点")
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        let timeString = timeFormatter.string(from: time)
        cell.dateLabel.text = dateString
        cell.timeLabel.text = timeString
        return cell
    }
    
    @IBAction func reTopBuutonAction(_ sender: Any) {
        //二つ目のviewに戻る
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}

