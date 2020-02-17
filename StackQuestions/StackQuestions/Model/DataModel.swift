//
//  questionDataMap.swift
//  StackQuestions
//
//  Created by Decarlo Williams on 2/14/20.
//  Copyright © 2020 Decarlo Williams. All rights reserved.
//


import Foundation

struct Owner: Decodable {
    var reputation: Int
    var profileImage: URL
    var displayName: String

    enum CodingKeys: String, CodingKey {
        case reputation
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
}

struct Question: Decodable {
    var title: String
    var link: URL
    var isAnswered: Bool
    var viewCount: Int
    var answerCount: Int
    var accepted_answer_id: Int?
    var lastActivityDate: Double
    var creationDate: Double
    var lastEditDate: Double?
    var tags: [String]
    var owner: Owner

    enum CodingKeys: String, CodingKey {
        case title
        case link
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case accepted_answer_id = "accepted_answer_id"
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case lastEditDate = "last_edit_date"
        case tags
        case owner
    }

}

struct Response: Decodable {

    var items: [Question]

}


