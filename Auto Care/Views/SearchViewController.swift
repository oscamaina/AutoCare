//
//  SearchViewController.swift
//  Auto Care
//
//  Created by Kilz on 07/03/2020.
//  Copyright © 2020 Kilz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchOptionsView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchButtonOutlets: UIButton!
    
    
    //VARS
    
    var searchResults: [Item] = []
    
    var activityIndicator: NVActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 80, height: 80),type: .circleStrokeSpin, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),padding: nil)
        
    }
    
    
    
    @IBAction func showSearchBarButtonPressed(_ sender: Any) {
        
        dismissKeyboard()
        showSearchField()
    }
    
 
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
    
    private func showSearchField() {
        disableSearchButton()
        emptyTextField()
        animateSearchOptionIn()
    }
    
    //Animations
    private func animateSearchOptionIn() {
        UIView.animate(withDuration: 0.5) {
            self.searchOptionsView.isHidden = !self.searchOptionsView.isHidden
        }
    }
    
    private func emptyTextField() {
        searchTextField.text = ""
    }
    
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    
    
    @objc func textFieldDidChange (_ textField: UITextField) {
        
        print("typing")
        searchButtonOutlets.isEnabled = textField.text != ""
        
        if searchButtonOutlets.isEnabled {
            searchButtonOutlets.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        } else {
            disableSearchButton()
        }
    }
    
    private func disableSearchButton() {
        searchButtonOutlets.isEnabled = false
        searchButtonOutlets.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    
    
    //MARK: Activity Indicator
    
    private func showLoadingIndicator() {
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
    
    private func showItemView(withItem: Item) {
        
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
        
        itemVC.item = withItem
        
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
}





extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! ItemTableViewCell
        
        cell.generateItemCell(searchResults[indexPath.row])
        
        return cell
    }
    
    //MARK: TABLEVIEW delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        showItemView(withItem: searchResults[indexPath.row])
        
    }
    
    
}
