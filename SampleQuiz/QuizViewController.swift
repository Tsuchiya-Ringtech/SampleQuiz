//
//  QuizViewController.swift
//  SampleQuiz
//
//  Created by Kazunori Tsuchiya on 2023/06/09.
//

import UIKit

class QuizViewController: UIViewController {
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0

    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvArray = loadCSV(fileName: "quiz")
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
    }
    
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            Image.image = UIImage(named: "correct")
            print("正解")
        } else {
            Image.image = UIImage(named: "incorrect")
            print("不正解")
        }
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        Image.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.Image.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            quizTextView.text = quizArray[0]
            answerButton1.setTitle(quizArray[2], for: .normal)
            answerButton2.setTitle(quizArray[3], for: .normal)
            answerButton3.setTitle(quizArray[4], for: .normal)
            answerButton4.setTitle(quizArray[5], for: .normal)
        } else {
            performSegue(withIdentifier: "toNext", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
}
