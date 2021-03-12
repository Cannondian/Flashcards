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
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        // Dismiss
        dismiss(animated: true)
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
