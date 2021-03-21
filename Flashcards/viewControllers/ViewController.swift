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
            updateFlashcard(question: "Question", answer: "Answer")
        }
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    func updateFlashcard(question: String, answer: String)
    {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        // Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        // Logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
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
        }
    }
    
    func saveAllFlashcardsToDisk()
    {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer]
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
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Pull all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any)
    {
        if (frontLabel.isHidden == true) {
            frontLabel.isHidden = false
        }
        else
        {
            frontLabel.isHidden = true
        }
        
        updateFlashcard(question: frontLabel.text!, answer: backLabel.text!)
        
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
        
        // Update Labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrev(_ sender: Any)
    {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update Labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
       // print(flashcards[])
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // We know the destination of the segue is the Navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        //We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self

    }
}
    


