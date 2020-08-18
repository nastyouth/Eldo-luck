//
//  CustomButton.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit



class CustomButton: UITableViewCell, NibLoadable {

    @IBOutlet weak var quoteTextField: UITextField!
    @IBOutlet private weak var addNewVariationButton: UIButton!
    @IBOutlet weak var checkmarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextField()
    }
    
    private func setupTextField() {
        if let placeholderFont = UIFont(name: "NoirPro-Regular", size: 17) {
            quoteTextField.attributedPlaceholder = NSAttributedString(string: "Start typing...", attributes: [NSAttributedString.Key.font : placeholderFont, NSAttributedString.Key.foregroundColor : UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)])
        }
        quoteTextField.returnKeyType = .done
    }
    
    func showButton() {
        quoteTextField.isHidden = true
        quoteTextField.text = ""
        checkmarkButton.isHidden = true
        addNewVariationButton.isHidden = false
        quoteTextField.resignFirstResponder()
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        quoteTextField.isHidden = false
        checkmarkButton.isHidden = false
        addNewVariationButton.isHidden = true
        quoteTextField.becomeFirstResponder()
    }
    
}
