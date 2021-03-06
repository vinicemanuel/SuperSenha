//
//  ViewController.swift
//  SuperSenha
//
//  Created by Vinicius Emanuel on 26/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    let segueID = "FromViewControllerToPasswordViewController"
    
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swUseLetters: UISwitch!
    @IBOutlet weak var btGenerate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.checkSwitchs()
    }
    
    @IBAction func generate() {
        if !self.checkPassworkdCount() {
            let alert = UIAlertController(title: "Erro", message: "Quantidade de senhas: zero ou maior que 99", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertButton)
            self.present(alert, animated: true, completion: nil)
        } else if !self.checkPassworkdSize() {
            let alert = UIAlertController(title: "Erro", message: "Total de caracteres: zero ou maior que 16", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertButton)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: segueID, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passwordsViewController = segue.destination as! PasswordViewController

        // forma mais segura (usar if let)
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            // se conseguir obter o valor do campo e converter para inteiro
            passwordsViewController.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            passwordsViewController.numberOfCharacters = numberOfCharacters
        }
        passwordsViewController.useNumbers = swNumbers.isOn
        passwordsViewController.useCapitalLetters = swCaptitalLetters.isOn
        passwordsViewController.useLetters = swUseLetters.isOn
        passwordsViewController.useSpecialCharacters = swSpecialCharacters.isOn

        // forcar encerrar o modo de edicao // remove o foco e libera teclado
        view.endEditing(true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func changeSwitch() {
        self.checkSwitchs()
    }
    
    private func checkPassworkdSize() -> Bool {
        guard let size = Int(self.tfNumberOfCharacters.text ?? "") else { return false }
        return size < 16 && size > 0
    }
    
    private func checkPassworkdCount() -> Bool {
        guard let count = Int(self.tfNumberOfCharacters.text ?? "") else { return false }
        return count < 99 && count > 0
    }
    
    private func checkSwitchs() {
        if !swNumbers.isOn && !swCaptitalLetters.isOn && !swUseLetters.isOn && !swSpecialCharacters.isOn {
            self.btGenerate.isEnabled = false
            self.btGenerate.alpha = 0.3
        } else {
            self.btGenerate.isEnabled = true
            self.btGenerate.alpha = 1
        }
    }
}

