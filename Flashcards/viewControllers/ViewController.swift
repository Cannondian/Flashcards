//
//  ViewController.swift
//  Flashcards
//
//  Created by Mauro Herrera on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
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
        
    }
    
    func updateFlashcard(question: String, answer: String)
    {
        frontLabel.text = question
        backLabel.text = answer
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
    


