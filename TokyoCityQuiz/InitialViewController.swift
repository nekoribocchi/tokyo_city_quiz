// InitialViewController.swift

import UIKit
import SwiftUI

class InitialViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var button1: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    }
    
    // MARK: - IBActions
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            loadQuiz(fileName: "tama")
        }
    }
    
    // MARK: - Helper Methods
    func loadQuiz(fileName: String) {
        // QuizViewControllerをインスタンス化し、CSVデータを渡して表示する
        if let quizViewController = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
            quizViewController.csvArray = loadCSV(fileName: fileName)
            present(quizViewController, animated: true, completion: nil)
        }
        
        // ScoreViewControllerをインスタンス化して表示する
        if let scoreViewController = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController {
            present(scoreViewController, animated: true, completion: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        // CSVファイルを読み込み、配列に変換して返す
        var csvArray: [String] = []
        if let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv") {
            do {
                let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
                let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
                csvArray = lineChange.components(separatedBy: "\n")
                csvArray.removeLast() // 最後の空行を削除
                csvArray.shuffle()    // ランダムにシャッフル
            } catch {
                print("Error loading CSV file.")
            }
        }
        return csvArray
    }
}
