//
//  DetailViewController.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 14.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskTagLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timerAnimationView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    let shapeLayer = CAShapeLayer()
    var durationTimer: Int = 540
    var endTime = 535

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(durationTimer)"
        animationCircular()
        basicAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    @objc func timerAction() {
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        if durationTimer == endTime {
            timer.invalidate()
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func animationCircular() {
        let center = CGPoint(x: timerAnimationView.frame.width / 2, y: timerAnimationView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.systemBackground.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.systemPurple.cgColor
        timerAnimationView.layer.addSublayer(shapeLayer)
    }
    
    func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
