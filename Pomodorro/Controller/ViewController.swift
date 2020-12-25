import UIKit

class ViewController: UIViewController {
    
    let data = Task(intervals: [work, shortBreak, work, longBreak]) // 10 5 10 20
    
    private var totalProgress: Double = 0
    private var totalTime: Double = 0
    
    var timerIsRunning: Bool = false {
        didSet {
           debugLabel1.text = "progress = \((data.intervals[currentTaskIndex].time - seconds ) / data.intervals[currentTaskIndex].time)"
        }
    }
    var currentTaskIndex: Int = 0 {
        didSet {
            debugLabel2.text = "currentTaskIndex = \(currentTaskIndex)"
            debugLabel3.text = "taskType = \(data.intervals[currentTaskIndex].type)"
        }
    }
    var timer: Timer?
    var seconds: Double = 0 {
        didSet {
            progressWheel.progress = (data.intervals[currentTaskIndex].time - seconds ) / data.intervals[currentTaskIndex].time
            progressBar.progress = totalProgress / totalTime
            
            debugLabel2.text = "seconds = \(seconds)"
            debugLabel3.text = "totalTime = \(totalTime)"
            debugLabel4.text = "totalProgress = \(totalProgress)"
            debugLabel1.text = "currentProgress = \((data.intervals[currentTaskIndex].time - seconds ) / data.intervals[currentTaskIndex].time)"
        }
    }
    let progressWheel = ProgressWheel()
    let progressBar = ProgressBar()
    let startStopButton = StartStopButton()
    
    let timerLabel = UILabel()
    let debugLabel1 = UILabel()
    let debugLabel2 = UILabel()
    let debugLabel3 = UILabel()
    let debugLabel4 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateTotalTime()
        view.backgroundColor = Colors.offWhite
        timerLabel.text = "Timer label"
        
        debugLabel1.text = "debug"
        debugLabel2.text = "debug"
        debugLabel3.text = "debug"
        debugLabel4.text = "debug"
        
        
        configureProgressWheel()
        configureProgressBar()
        configureStartStopButton()
        
        configureLayout()
        
        progressWheel.backgroundColor = .clear
        progressBar.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        startStopButton.backgroundColor = Colors.offWhite
        
        seconds = data.intervals[0].time
    }
    
    func configureProgressWheel () {
       
    }
    func configureProgressBar () {
        
    }
    func configureStartStopButton() {
        startStopButton.addTarget(self, action: #selector(startStopTapped), for: UIControl.Event.touchUpInside)
    }
    @objc func startStopTapped() {
        //Если таймер работает
        if timerIsRunning {
            //Ставим таймер на паузу
            timer?.invalidate()
            timerIsRunning = false
            //Меняем label на кнопке
            startStopButton.stateLabel.text = "PLAY"
            
        //Если таймер не работает
        } else {
                //Запускаем таймер дальше
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                timerIsRunning = true
                //Меняем label на кнопке
            startStopButton.stateLabel.text = "PAUSE"
        }
    }
    @objc func timerAction() {
        //Если таймер закончился
        if seconds == 0 {
            //totalProgress += 1
            timerLabel.text = "\(seconds)"
            timer?.invalidate()
            timerIsRunning = false
            //проверяем есть ли еще задание в очереди и переключаемся на него
            if currentTaskIndex < data.intervals.count - 1 {
                currentTaskIndex += 1
                seconds = data.intervals[currentTaskIndex].time
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                timerIsRunning = true
              //Если задание было последним, переходим в состояние окончания работы
            } else if currentTaskIndex == data.intervals.count - 1 {
                timerLabel.text = "Завершено"
            }
            
        //Если таймер продолжает работать
        } else {
            timerLabel.text = "\(seconds)"
            seconds -= 1
            totalProgress += 1
        }
    }
    func calculateTotalTime() {
        for index in 0..<data.intervals.count {
            totalTime += data.intervals[index].time
        }
    }
    
    func configureLayout() {
        
        let debugStackView = UIStackView(arrangedSubviews: [debugLabel1, debugLabel2, debugLabel3, debugLabel4])
        debugStackView.axis = .vertical
        debugStackView.alignment = .leading
        
        view.addSubview(debugStackView)
        
        view.addSubview(progressWheel)
        view.addSubview(progressBar)
        view.addSubview(startStopButton)
        view.addSubview(timerLabel)
        
        
        progressWheel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        startStopButton.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        debugStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            debugStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            debugStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            timerLabel.topAnchor.constraint(equalTo: debugStackView.bottomAnchor, constant: 50),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressWheel.heightAnchor.constraint(equalToConstant: 300),
            progressWheel.widthAnchor.constraint(equalToConstant: 300),
            progressWheel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressWheel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.widthAnchor.constraint(equalToConstant: 300),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.topAnchor.constraint(equalTo: progressWheel.bottomAnchor, constant: 50),
            
            startStopButton.heightAnchor.constraint(equalToConstant: 100),
            startStopButton.widthAnchor.constraint(equalToConstant: 100),
            startStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startStopButton.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 50)
            
        ])
    }
}

