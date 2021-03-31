//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Mauro Herrera on 3/9/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswerOneTextField: UITextField!
    @IBOutlet weak var extraAnswerTwoTextField: UITextField!
    @IBOutlet weak var extraAnswerThreeTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any)
    {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any)
    {
        // Get the text in the question text field
        let questionText = questionTextField.text
        
        // Get the text in the answer text field
        let answerText = answerTextField.text
        
        // Get the text in the extra answers text fields
        let extraAnswerOneText = extraAnswerOneTextField.text
        let extraAnswerTwoText = extraAnswerTwoTextField.text
        let extraAnswerThreeText = extraAnswerThreeTextField.text
        
        // Check if empty
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty
        {
            // Show error
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer.", preferredStyle: .alert)
            present(alert,animated: true)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }
        else
        {
            var isExisting = false
            if initialQuestion != nil
            {
                isExisting = true
            }
            // Call the function to update the flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting: isExisting, extraAnswerOne: extraAnswerOneText!, extraAnswerTwo: extraAnswerTwoText!, extraAnswerThree: extraAnswerThreeText!)
            
            // Dismiss
            dismiss(animated: true)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
