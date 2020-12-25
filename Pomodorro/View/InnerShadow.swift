import UIKit

class InnerShadow: UIView {
    
    let progressLayer = CAShapeLayer()
    
    private let gradientStartColor: UIColor = #colorLiteral(red: 0.6059103095, green: 0.1625157377, blue: 1, alpha: 1)
    private let gradientEndColor: UIColor = #colorLiteral(red: 1, green: 0.27654477, blue: 0.1005079097, alpha: 1)

    let lineWidth: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         //createBackgroundCircle()
    }
    override func draw(_ rect: CGRect) {
        //super.draw(rect)
        createBackgroundCircle(rect)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createBackgroundCircle (_ rect: CGRect) {
        
        let deltaY: CGFloat = 40
        
        let newX = rect.origin.x
        let newY = rect.origin.y - deltaY
        let newWidth = rect.width
        let newHeight = rect.height + 2*deltaY
        
        let newRect = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
        
        let width = frame.width
        let height = frame.height
        let radius = (min(width,height) / 2) - lineWidth / 2
        let center = CGPoint(x: newWidth / 2, y: newHeight / 2)
        
        let backgroundPath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: 0 ,
                                          endAngle: 2 * CGFloat.pi,
                                          clockwise: true)
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = backgroundPath.cgPath
        
        let gradientLayer = CAGradientLayer()
        //gradientLayer.mask = backgroundMask
        gradientLayer.frame = newRect
        gradientLayer.type = .radial
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.colors = [UIColor.clear.cgColor ,UIColor.black.withAlphaComponent(1).cgColor]
        //gradientLayer.locations = [0.5, 1.0]
        
//        let backgroundLayer = CAShapeLayer()
//        backgroundLayer.path = backgroundPath.cgPath
//        backgroundLayer.lineCap = .round
//        backgroundLayer.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor
//        backgroundLayer.fillColor = UIColor.clear.cgColor
//        backgroundLayer.lineWidth = lineWidth
    
        layer.addSublayer(gradientLayer)
    }
    

}
