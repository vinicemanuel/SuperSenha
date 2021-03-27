//
//  SecurityTipsViewController.swift
//  SuperSenha
//
//  Created by Vinicius Emanuel on 26/03/21.
//

import UIKit

class SecurityTipsViewController: UIViewController {
    
    @IBOutlet weak var tvTips: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        
        let tips = self.loadTips()
        self.tvTips.text = tips
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadTips() -> String {
        guard let urlPath = Bundle.main.url(forResource: "DicasSenha", withExtension: "txt") else { return "" }
        guard let content = try? String(contentsOfFile: urlPath.path, encoding: .utf8) else { return "" }
        return content
    }

}
