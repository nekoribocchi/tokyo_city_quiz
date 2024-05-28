// Cell.swift
import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // カスタムセルが初めて使われる際に行いたい初期化や設定を awakeFromNib メソッド内で行う
    override func awakeFromNib() {
        super.awakeFromNib()
        // 例: フォントや色の設定、その他のUIの初期化など
    }
}
