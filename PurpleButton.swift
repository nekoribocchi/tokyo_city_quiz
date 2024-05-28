
import UIKit

class PurpleButton: QBButton {
    
    override func setupButton() {
        super.setupButton() // Call the setupButton() method from the parent class
        
        // Customize the appearance for BlueButton
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
