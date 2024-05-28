
import UIKit

class PurpleButton: QBButton {
    
    override func setupButton() {
        super.setupButton()
        setTitleColor(.systemPurple, for: .normal)
        backgroundColor = UIColor.systemPurple
        layer.borderColor = UIColor.systemPurple.cgColor
        layer.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.05).cgColor
        layer.shadowColor = UIColor.systemPurple.cgColor
    }
}


#Preview {
    PurpleButton()
}
