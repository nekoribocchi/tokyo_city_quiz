//2024/02/15.
//

import UIKit

// ボタンのカスタマイズコード
class Square: QBButton {
    
    override func setupButton() {
        super.setupButton() // Call the setupButton() method from the parent class
        
        setTitleColor(.systemPink, for: .normal)
        backgroundColor = UIColor.white // 背景色をピンクに設定
            layer.cornerRadius = 10 // 四角形の角を丸める半径を設定
            //layer.borderWidth = 1 // 枠線の幅を設定
            //layer.borderColor = UIColor.systemGray.cgColor // 枠線の色をピンクに設定
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor // ボタンの背景色を設定
            layer.shadowColor = UIColor.black.cgColor // ドロップシャドウの色を設定
            layer.shadowOpacity = 0.5 // ドロップシャドウの不透明度を設定
            layer.shadowOffset = CGSize(width: 0, height: 5) // ドロップシャドウのオフセットを設定
            layer.shadowRadius = 5 // ドロップシャドウのぼかし半径を設定
    }
    // ボタンのサイズを変更するためのメソッド
    override var intrinsicContentSize: CGSize {
        
        let defaultSize = super.intrinsicContentSize
        return CGSize(width: defaultSize.width + 200, height: defaultSize.height+250) // 幅を広げる（+40）
    }
}



#Preview {
    Square()
}

