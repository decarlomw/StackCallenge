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
    var questionResult = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting image for Navigation View
        let imageView = UIImageView(image: #imageLiteral(resourceName: "TitleImage"))
        imageView.frame = CGRect(x: 0, y: -5, width: 170, height: 45)
        imageView.contentMode = .scaleAspectFit

        let titleView = UIView(frame: CGRect(x: 0, y: -5, width: 170, height: 45))

        titleView.addSubview(imageView)
        titleView.backgroundColor = .clear
        self.navigationItem.titleView = titleView
        
        // Adding Delegate for tableView
        self.configureTable()

    }
    
    //MARK: ConfigureTable
    func configureTable() {
        // setting delegate and datasource for tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // creating connection to custom cell
        let nib = UINib(nibName: QuestionTableViewCell.ID, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: QuestionTableViewCell.ID)
        
        self.loadJson()
        self.tableView.reloadData()
    }
    
    //MARK: LoadJSONFromFile
    func loadJson() {
        
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
            do {
                let questions = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try JSONDecoder().decode(Response.self, from: questions)
                self.questionResult = response.items
                self.questionResult = self.questionResult.filter {
                    $0.answerCount > 1 &&  $0.accepted_answer_id != nil
                      }
            } catch {
              
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if  segue.identifier ==  "detailSegue",
                   let destination = segue.destination as? DetailViewController,
                   let blogIndex = tableView.indexPathForSelectedRow?.row
               {
                destination.link = self.questionResult[blogIndex].link
                self.tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
               }
           }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.ID, for: indexPath) as? QuestionTableViewCell
            else {
                fatalError()
        }
        // Setting Accessoryview to show on table
        cell.accessoryType = .disclosureIndicator
        
        // Setting Cell text from Server Data
        cell.questionAsked.text = self.questionResult[indexPath.row].title
        cell.profileImage.load(url: self.questionResult[indexPath.row].owner.profileImage)
        cell.tagLbl.text = self.questionResult[indexPath.row].tags.joined(separator:", ")
        cell.answerCount.text = "Answers: \(self.questionResult[indexPath.row].answerCount)"

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
            return UITableView.automaticDimension
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }


}
