//
//  TaskTableViewCell.swift
//  TimeTrackerApp
//
//  Created by Ensar Batuhan Ünverdi on 14.09.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    static let identifier = String(describing: TaskTableViewCell.self)

    @IBOutlet weak var taskImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taskTagLabel: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }

    @IBAction func timerButtonClicked(_ sender: Any) {
        if timerButton.tag == 0 {
            timerButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timerButton.tag = 1
        } else {
            timerButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timerButton.tag = 0
        }
    }
}
