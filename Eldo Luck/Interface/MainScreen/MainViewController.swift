//
//  MainViewController.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var quoteLabel: UILabel!
    @IBOutlet private weak var newRandomButton: UIButton!
    private var quoteObjects: [Quote] = []
    
    @IBOutlet private weak var circleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RealmHelper().addFirstData()
        quoteObjects = RealmHelper().getData()
        firstAnswer()
        newRandomButton.layer.cornerRadius = newRandomButton.frame.height / 2
        circleView.layer.cornerRadius = circleView.frame.height / 2
    }
    
    private func goToChangeVC() {
        let vc = ChangeVariationsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.quoteObjects = self.quoteObjects
        vc.callBack = { [weak self] newData in
            self?.quoteObjects = newData
            self?.firstAnswer()
        }
        present(vc, animated: true)
    }
    
    private func firstAnswer() {
        quoteLabel.text = quoteObjects.first?.text ?? "Add more variants."
    }
    
    
    @IBAction func randomQuote(_ sender: UIButton) {
        if quoteObjects.count <= 1 {
            let alert = UIAlertController(title: "Error", message: "Too few options. Add more.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
                self.goToChangeVC()
            }
            alert.addAction(okButton)
            self.present(alert, animated: true)
        } else {
            let randomNumber = Int.random(in: 0 ..< quoteObjects.count)
            quoteLabel.text = quoteObjects[randomNumber].text
        }
    }
    
    @IBAction func changeVariations(_ sender: Any) {
        goToChangeVC()
    }
}
