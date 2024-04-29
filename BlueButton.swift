//2024/02/15.
//
import UIKit

class BlueButton: QBButton {
    
    override func setupButton() {
        super.setupButton() // Call the setupButton() method from the parent class
        
        // Customize the appearance for BlueButton
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = UIColor.systemBlue
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.05).cgColor
        layer.shadowColor = UIColor.systemBlue.cgColor
    }
}


#Preview {
    BlueButton()
}
