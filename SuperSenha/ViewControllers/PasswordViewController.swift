//
//  PasswordViewController.swift
//  SuperSenha
//
//  Created by Vinicius Emanuel on 26/03/21.
//

import UIKit

class PasswordViewController: UIViewController {
    
    let segueID = "FromPasswordViewControllerToSecurityTipsViewController"
    
    @IBOutlet weak var tvPasswords: UITextView!
    
    var numberOfCharacters = 10 // default se usuario nao enviar
    var numberOfPasswords = 1
    var useLetters = false
    var useNumbers = false
    var useCapitalLetters = false
    var useSpecialCharacters = false
    
    var passwordGenerator: PasswordGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordGenerator = PasswordGenerator(
            numberOfCharacters: numberOfCharacters,
            useLetters: useLetters,
            useNumbers: useNumbers,
            useCapitalLetters: useCapitalLetters,
            useSpecialLetters: useSpecialCharacters
        )
        
        self.generatePasswords()
    }
    
    @IBAction func generatePasswords() {
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0)) // posiciona a scroll no topo da view
        tvPasswords.text = "" // limpa a view
        
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }
    }
    
    @IBAction func showTips() {
        self.performSegue(withIdentifier: self.segueID, sender: nil)
    }
    
}
