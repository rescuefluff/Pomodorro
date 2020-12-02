import UIKit

class StartStopButton: UIButton {
    let ourShadowRadius: CGFloat = 10
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "START"
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        return label
    }()
    
 
    override func draw(_ rect: CGRect) {

        let cornerRadius = min(rect.width, rect.height) / 2
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.darkShadow.cgColor, Colors.lightShadow.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        gradientLayer.mask = maskLayer
        
        let darkShadow = CALayer()
        darkShadow.frame = bounds
        darkShadow.backgroundColor  = backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor.white.withAlphaComponent(0.7).cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: -ourShadowRadius, height: -ourShadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = ourShadowRadius
        layer.addSublayer(darkShadow)
        
        let lightShadow = CALayer()
        lightShadow.frame = bounds
        lightShadow.backgroundColor = backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: ourShadowRadius/2, height: ourShadowRadius/2)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = ourShadowRadius
        layer.addSublayer(lightShadow)
        
        layer.addSublayer(gradientLayer)
        //TODO:- Убрать этот костыль
        configureLabel()
    }
    

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel() {
        
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stateLabel)
        stateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
    }
}
