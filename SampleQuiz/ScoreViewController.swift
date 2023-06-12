//
//  ScoreViewController.swift
//  SampleQuiz
//
//  Created by Kazunori Tsuchiya on 2023/06/09.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreText: UILabel!
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreText.text = "\(correct)問正解!"
    }

    
    @IBAction func toTop(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
}
