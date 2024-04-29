// 2024/02/15.
//
import UIKit
class GradientView: UIView {
    func applyGradient(topColor: UIColor, bottomColor: UIColor, alpha: CGFloat) {
        // Colors of the gradient
        let gradientColors: [CGColor] = [topColor.withAlphaComponent(alpha).cgColor, bottomColor.withAlphaComponent(alpha).cgColor]

        // Create the gradient layer
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        // Assign the gradient colors to the layer
        gradientLayer.colors = gradientColors
        // Set the gradient layer's frame to match the view's bounds
        gradientLayer.frame = self.bounds

        // Insert the gradient layer at the bottom of the view's layer stack
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

#Preview {
    GradientView()
       
}

