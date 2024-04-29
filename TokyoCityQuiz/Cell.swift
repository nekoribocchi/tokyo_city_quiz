//2024/02/23.
//

import UIKit

class Cell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!//！＝強制アンラップ　→ nilでないことが前提
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   //カスタムセルが初めて使われる際に行いたい初期化や設定を awakeFromNib メソッド内で行うことができます。
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 例えば、フォントや色の設定、その他のUIの初期化などを設定できる
    }

}
