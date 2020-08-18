//
//  ViewController.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import UIKit

class ChangeVariationsViewController: UIViewController {
    
    @IBOutlet weak var qoutesTableView: UITableView!
    
    private let realmHelper = RealmHelper()
    var quoteObjects: [Quote] = []
    private var newVariant = ""
    var callBack: ((_ quoteObjects: [Quote])->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        addGesture()
    }
    
    private func setupTableView() {
        self.qoutesTableView.delegate = self
        self.qoutesTableView.dataSource = self
        self.qoutesTableView.rowHeight = UITableView.automaticDimension
        self.qoutesTableView.estimatedRowHeight = 75
        
        self.qoutesTableView.register(QuoteCustomCell.nib, forCellReuseIdentifier: QuoteCustomCell.name)
        self.qoutesTableView.register(CustomButton.nib, forCellReuseIdentifier: CustomButton.name)
        self.qoutesTableView.tableFooterView = UIView()
    }
    
    private func addGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.qoutesTableView.reloadData()
        view.endEditing(true)
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        callBack?(quoteObjects)
        dismiss(animated: true, completion: nil)
    }
    
    private func removeItemAt(index: Int) {
        realmHelper.removeDataAt(id: quoteObjects[index].id)
        self.quoteObjects.remove(at: index)
    }
    
    private func saveToDataBase() {
        if newVariant.count > 0 {
            realmHelper.writeData(data: newVariant)
            quoteObjects = realmHelper.getData()
        }
        qoutesTableView.reloadData()
    }
    
    @objc private func checkmarkButtonDidTapped(_ sender: UIButton) {
        saveToDataBase()
    }
}

extension ChangeVariationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteObjects.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomButton.name, for: indexPath) as? CustomButton else { return UITableViewCell() }
            cell.showButton()
            cell.checkmarkButton.addTarget(self, action: #selector(checkmarkButtonDidTapped(_:)), for: .touchUpInside)
            cell.quoteTextField.delegate = self
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCustomCell.name, for: indexPath) as? QuoteCustomCell else { return UITableViewCell() }
            
            cell.quoteLabel.text = quoteObjects[indexPath.row - 1].text
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row == 0 ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            removeItemAt(index: indexPath.row - 1)
            
            DispatchQueue.main.async {
                self.qoutesTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, complete in
            self.removeItemAt(index: indexPath.row - 1)
            self.qoutesTableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        let color = UIColor(red: 253/255, green: 173/255, blue: 2/255, alpha: 1)
        let trashImage = UIImage(named: "trashIcon")?.colored(in: color)
        deleteAction.image = trashImage
        deleteAction.backgroundColor = #colorLiteral(red: 0.06273568422, green: 0.06275131553, blue: 0.06273080409, alpha: 1)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
}

extension ChangeVariationsViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.newVariant = textField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveToDataBase()
        textField.resignFirstResponder()
        return true
    }
}
