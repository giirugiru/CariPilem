//
//  MovieGenreModel.swift
//  CariPilem
//
//  Created by Gilang Sinawang on 18/08/21.
//

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
