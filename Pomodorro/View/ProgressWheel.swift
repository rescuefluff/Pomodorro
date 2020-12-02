import UIKit

class ProgressWheel: UIView {
    
    let progressLayer = CAShapeLayer()
    
    
    private let gradientStartColor: UIColor = #colorLiteral(red: 0.6059103095, green: 0.1625157377, blue: 1, alpha: 1)
    private let gradientEndColor: UIColor = #colorLiteral(red: 1, green: 0.27654477, blue: 0.1005079097, alpha: 1)
//    private let gradientStartColor: UIColor = UIColor.black.withAlphaComponent(0.3)
//    private let gradientEndColor: UIColor = UIColor.white.withAlphaComponent(0.3)

    
    let lineWidth: CGFloat = 60
    
    public var progress: Double = 0 {
        didSet {
            progressLayer.strokeEnd = CGFloat(progress)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
         //createBackgroundCircle()
    }
    override func draw(_ rect: CGRect) {
        //super.draw(rect)
        createBackgroundCircle()
        createProgressCircle()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createBackgroundCircle () {
        
        
        let width = frame.width
        let height = frame.height
        let radius = (min(width,height) / 2) - lineWidth / 2
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        let backgroundPath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: -CGFloat.pi / 2,
                                          endAngle: 3 * CGFloat.pi / 2,
                                          clockwise: true)
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.lineCap = .round
        backgroundLayer.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWidth
    
        layer.addSublayer(backgroundLayer)
    }
    func createProgressCircle() {
        
        
        //let lineWidth: CGFloat = lineWidth
        let width = frame.width
        let height = frame.height
        let radius = (min(width,height) / 2) - lineWidth / 2
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        let progressPath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: -CGFloat.pi / 2,
                                          endAngle: 3 * CGFloat.pi / 2,
                                          clockwise: true)
        
        progressLayer.path = progressPath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeColor = UIColor.systemBlue.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = 0.0001
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [ Colors.gradientStartColor.cgColor, Colors.gradientEndColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.mask = progressLayer
        layer.addSublayer(gradientLayer)
        
    }
    
    
}
