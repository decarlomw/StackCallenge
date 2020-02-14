//
//  QuestionTableViewCell.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/14/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//


import UIKit

//MARK: QuestionTableViewCellValues
class QuestionTableViewCell: UITableViewCell {

    static let ID = "QuestionTableViewCell"
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var questionAsked: UILabel!
    @IBOutlet weak var stackedTagsView: UIStackView!
    @IBOutlet weak var tagLbl: UILabel!

}
