//
//  DetailViewController.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 14.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var timer = Timer()
    private let shapeLayer = CAShapeLayer()
    var durationTimer: Int = 5
    
    @IBOutlet private weak var taskTitleLabel: UILabel!
    @IBOutlet private weak var taskTagLabel: UILabel!
    @IBOutlet private weak var taskNameLabel: UILabel!
    @IBOutlet private weak var timerAnimationView: UIImageView!
    @IBOutlet private weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(durationTimer)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
    }
    
    @objc func timerAction() {
        durationTimer -= 1
        timerLabel.text = "\(durationTimer)"
        if durationTimer == 0 {
            timer.invalidate()
            let alertController = UIAlertController(title: "Oops", message: "Time's up!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(alertAction)
            present(alertController, animated: true)
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        animationCircular()
        basicAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @IBAction func quitButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func animationCircular() {
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
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
}
