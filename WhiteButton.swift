//2024/02/15.
//

import UIKit

class WhiteButton: QBButton {
    
    override func setupButton() {
        super.setupButton() // Call the setupButton() method from the parent class
        
        // Customize the appearance for BlueButton
        layer.cornerRadius = 20
        setTitleColor(.darkGray, for: .normal)
        backgroundColor = UIColor.blue
        layer.borderColor = UIColor.white.cgColor
        layer.backgroundColor = UIColor.blue.withAlphaComponent(0.02).cgColor
        layer.shadowColor = UIColor.black.cgColor
    }
}


#Preview {
    WhiteButton()
}
