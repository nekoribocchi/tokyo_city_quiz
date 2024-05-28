//2024/01/07.
//
import UIKit
import SwiftUI

class InitialViewController: UIViewController {
    
    @IBOutlet  var button1: UIButton!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            loadQuiz(fileName: "tama") // Pass quizName here
        }
        
        
        func loadQuiz(fileName: String) {
            if let quizViewController = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
                
                quizViewController.csvArray = loadCSV(fileName: fileName)
                present(quizViewController, animated: true, completion: nil)
                
            }
            
            if let scoreViewController = storyboard?.instantiateViewController(withIdentifier:"ScoreViewController") as? ScoreViewController {
                present(scoreViewController, animated: true, completion: nil) // Present ScoreViewController
                
            }
        }
        
        
        
        func loadCSV(fileName: String) -> [String] {
            var csvArray: [String] = []
            if let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv") {
                do {
                    let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
                    let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
                    csvArray = lineChange.components(separatedBy: "\n")
                    csvArray.removeLast()
                    csvArray = csvArray.shuffled()
                } catch {
                    print("Error")
                }
            }
            return csvArray
        }
        
        
        
        
        
    }
}
