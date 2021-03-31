//
//  ViewController.swift
//  Flashcards
//
//  Created by Mauro Herrera on 2/20/21.
//

import UIKit

struct Flashcard
{
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
    var extraAnswerThree: String

}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Rounded Corners
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        
        // Button Properties
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        btnOptionThree.layer.borderWidth = 3.0
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        // Card Properties
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        // Clips to Bounds
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding our initial flashcards if needed
        if flashcards.count == 0
        {
            updateFlashcard(question: "Question", answer: "Answer",isExisting: false, extraAnswerOne: "", extraAnswerTwo: "", extraAnswerThree: "")
        }
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool, extraAnswerOne: String?, extraAnswerTwo: String?, extraAnswerThree: String?)
    {
        let flashcard = Flashcard(question: question, answer: answer,extraAnswerOne: extraAnswerOne!, extraAnswerTwo: extraAnswerTwo!, extraAnswerThree: extraAnswerThree!)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(extraAnswerThree, for: .normal)
        
        if isExisting
        {
            // Replace existing flashcard
            flashcards[currentIndex] = flashcard
        }
        else
        {
            // Adding flashcard in the flashcards array
            flashcards.append(flashcard)
            
            // Logging to the console
            print("Added new flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        
       
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Save to disk
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons()
    {
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if currentIndex == 0
        {
            prevButton.isEnabled = false
        }
        else
        {
            prevButton.isEnabled = true
        }
        
    }
    
    func updateLabels()
    {
        // Get current flashcard
        if currentIndex >= 0 && currentIndex < flashcards.count
        {
            let currentFlashcard = flashcards[currentIndex]
            
            // Update labels
            frontLabel.text =  currentFlashcard.question
            backLabel.text = currentFlashcard.answer
            
            if currentFlashcard.extraAnswerOne == "" {
                btnOptionOne.isHidden = true
            } else {
                btnOptionOne.isHidden = false
                btnOptionOne.setTitle(currentFlashcard.extraAnswerOne, for: .normal)
            }
            
            if currentFlashcard.extraAnswerTwo == "" {
                btnOptionTwo.isHidden = true
            } else {
                btnOptionTwo.isHidden = false
                btnOptionTwo.setTitle(currentFlashcard.extraAnswerTwo, for: .normal)
            }
            
            if currentFlashcard.extraAnswerThree == "" {
                btnOptionThree.isHidden = true
            } else {
                btnOptionThree.isHidden = false
                btnOptionThree.setTitle(currentFlashcard.extraAnswerThree, for: .normal)
            }
        }
    }
    
    func saveAllFlashcardsToDisk()
    {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer, "extraanswer1": card.extraAnswerOne, "extraanswer2": card.extraAnswerTwo, "extraanswer3": card.extraAnswerThree]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards()
    {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]
        {
            // In here we know for sure  we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraanswer1"] ?? "", extraAnswerTwo: dictionary["extraanswer2"] ?? "", extraAnswerThree: dictionary["extraanswer3"] ?? "")
            }
            
            // Pull all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any)
    {
        flipFlashcard()
    }
    
    func flipFlashcard()
    {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations:  {
            if (self.frontLabel.isHidden == true) {
                self.frontLabel.isHidden = false
            }
            else
            {
                self.frontLabel.isHidden = true
            }
        })
        
        updateFlashcard(question: frontLabel.text!, answer: backLabel.text!, isExisting: true, extraAnswerOne: "", extraAnswerTwo: "", extraAnswerThree: "")
    }
    
    func animateCardOutNext()
    {
        UIView.animate(withDuration: 0.3, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: -350.0, y: 0.0)}, completion: { finished in
            
            //Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardInNext()
        })
    }
    
    func animateCardInNext()
    {
        // Start on the right side (don't animate this)
        self.card.transform = CGAffineTransform.identity.translatedBy(x: 350.0, y: 0.0)
        
        // Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrev()
    {
        UIView.animate(withDuration: 0.3, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: 350.0, y: 0.0)}, completion: { finished in
            
            //Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardInPrev()
        })
    }
    
    func animateCardInPrev()
    {
        // Start on the right side (don't animate this)
        self.card.transform = CGAffineTransform.identity.translatedBy(x: -350.0, y: 0.0)
        
        // Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    // Multiple choice button actions
    @IBAction func didTapOptionOne(_ sender: Any)
    {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any)
    {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionThree(_ sender: Any)
    {
        btnOptionThree.isHidden = true
    }
    
    // Next and Previous Buttons
    @IBAction func didTapOnNext(_ sender: Any)
    {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate Card Out
        animateCardOutNext()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any)
    {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate Card Out
        animateCardOutPrev()
        
    }
    
    @IBAction func didTapOnDelete(_ sender: Any)
    {
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcard?", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        present(alert,animated: true)
        alert.addAction(deleteAction);
        alert.addAction(cancelAction);

    }
    
    func deleteCurrentFlashcard()
    {
        // Delete current
        flashcards.remove(at: currentIndex)
        
        // Special case: Check if the last card was deleted
        if currentIndex > flashcards.count - 1
        {
            currentIndex = flashcards.count - 1
        }
        
        // Special case: If deleting last flashcard
        if flashcards.count == 0
        {
            updateFlashcard(question: "", answer: "", isExisting: true, extraAnswerOne: "", extraAnswerTwo: "", extraAnswerThree: "")
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // We know the destination of the segue is the Navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"
        {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
}
    


