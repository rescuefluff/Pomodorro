import UIKit

class ProgressBar: UIView {
    
    let progressLayer = CAShapeLayer()
    let gradientLayer = CAGradientLayer()
    
    public var progress: Double = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        //super.draw(rect)
        //backgroundColor?.setFill()
        let backgroundLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        backgroundLayer.path = backgroundPath
        layer.mask = backgroundLayer
        
       
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * CGFloat(progress), height: rect.height))
        let progressPath = UIBezierPath(roundedRect: progressRect, cornerRadius: progressRect.height / 2)
        
        progressLayer.path = progressPath.cgPath
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [Colors.gradientStartColor.cgColor, Colors.gradientEndColor.cgColor]
        gradientLayer.frame = rect
        gradientLayer.mask = progressLayer
        
        
    }
    func updateProgress()  {
        
    }
}
