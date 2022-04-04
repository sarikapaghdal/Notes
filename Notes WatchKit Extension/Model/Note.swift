//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Sarika on 04.04.22.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
