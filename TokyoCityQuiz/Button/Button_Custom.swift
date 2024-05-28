import UIKit
@IBDesignable
class QBButton: UIButton {
    
    // カスタムな初期化メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    // ボタンのカスタマイズコード
    internal func setupButton() {
        setTitleColor(.systemPink, for: .normal)
        setTitleColor(.darkGray, for: .disabled)
        backgroundColor = UIColor.systemPink // 背景色をピンクに設定
        layer.cornerRadius = 25
        //layer.borderWidth = 1
        layer.borderColor = UIColor.systemPink.cgColor // 枠線の色をピンクに設定
        layer.backgroundColor = UIColor.systemPink.withAlphaComponent(0.05).cgColor
        layer.shadowColor = UIColor.systemPink.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 5)
        layer.shadowRadius = 5
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) // ボタンがタップされたときのアクションを追加
    }
    
    // ボタンがタップされたときの処理
    @objc private func buttonTapped() {
        print("Button tapped!")
    }
    
    // ボタンのサイズを変更するためのメソッド
    override var intrinsicContentSize: CGSize {
        let defaultSize = super.intrinsicContentSize
        return CGSize(width: defaultSize.width + 40, height: defaultSize.height) 
    }
}
#Preview(){
    QBButton()
}
