//
//  ViewController.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/14/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Adding Delegate for tableView
        self.loadTable()
        
    }
    //MARK: LoadTable
    func loadTable() {
        // setting delegate and datasource for tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // creating connection to custom cell
        let nib = UINib(nibName: QuestionTableViewCell.ID, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: QuestionTableViewCell.ID)
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell: QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.ID, for: indexPath) as? QuestionTableViewCell
            else {
                fatalError()
        }
        cell.questionAsked.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
            return UITableView.automaticDimension
      
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
 
            return UITableView.automaticDimension
        }
    
}
