// ScoreViewController.swift
import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizName: String = ""
    var bestScore = 0
    var topScores = [(score: Int, date: Date, time: Date)]()
    var correctCount = 0
    var scorePer_current: Int = 0
    var scorePer: Int = 0
    
    let numberOfTopScoresToDisplay = 5
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
        
        scorePer_current = Int(Double(correctCount) / Double(quizCount) * 100)
        scoreLabel.text = "\(scorePer_current)点"
        
        if let quizScores = UserDefaults.standard.array(forKey: "QuizScores") as? [[String: Any]] {
            for quiz in quizScores {
                if let score = quiz["score"] as? Int, let date = quiz["date"] as? Date, let time = quiz["time"] as? Date {
                    topScores.append((score: score, date: date, time: time))
                }
            }
        }
        
        topScores.sort { $0.score > $1.score }
        topScores = Array(topScores.prefix(numberOfTopScoresToDisplay))
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topScores.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let score = topScores[indexPath.row].score
        let date = topScores[indexPath.row].date
        let time = topScores[indexPath.row].time
        
        scorePer = Int(Double(score) / Double(quizCount) * 100)
        cell.scoreLabel.text = "\(indexPath.row + 1).  \(scorePer)点"
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        cell.dateLabel.text = dateFormatter.string(from: date)
        cell.timeLabel.text = timeFormatter.string(from: time)
        
        return cell
    }
    
    @IBAction func reTopBuutonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}
