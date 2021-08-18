//
//  MovieGenreModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct MovieGenreWelcome: Codable {
    let genres: [MovieGenre]
}

// MARK: - Genre
struct MovieGenre: Codable {
    let id: Int
    let name: String
}
