import UIKit

class StartStopButton: UIButton {
    let ourShadowRadius: CGFloat = 10
    
    
    
    override var isHighlighted: Bool {
        didSet {
            print("Is Highlighted = \(isHighlighted)")
            if isHighlighted {
                self.backgroundColor = UIColor.red
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            print("isSelected = \(isSelected)")
        }
    }
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "START"
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        return label
    }()
    
 
    override func draw(_ rect: CGRect) {

        let cornerRadius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.darkGradient.cgColor, Colors.lightGradient.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        gradientLayer.mask = maskLayer
        
        let darkShadow = CALayer()
        darkShadow.frame = bounds
        darkShadow.backgroundColor  = UIColor.red.cgColor
        darkShadow.shadowColor = UIColor.red.cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: -ourShadowRadius, height: -ourShadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = ourShadowRadius
        
        layer.addSublayer(darkShadow)
        
        let lightShadow = CALayer()
        lightShadow.frame = bounds
        lightShadow.backgroundColor =  UIColor.green.cgColor
        lightShadow.shadowColor = UIColor.green.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: ourShadowRadius/2, height: ourShadowRadius/2)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = ourShadowRadius
        layer.addSublayer(lightShadow)
        
//        let animatedStroke: CAShapeLayer = {
//
//            let layer = CAShapeLayer()
//            let strokeWidth: CGFloat = 4
//
//            let animatedStrokePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//            layer.path = animatedStrokePath.cgPath
//            layer.strokeColor = UIColor.white.withAlphaComponent(0.2).cgColor
//            layer.lineWidth = strokeWidth
//            layer.fillColor = UIColor.clear.cgColor
//
//
//            return layer
//        }()

        layer.addSublayer(gradientLayer)
        //layer.addSublayer(animatedStroke)
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
