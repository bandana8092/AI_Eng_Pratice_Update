//
//  Constants.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation

let base_url = "https://hn.algolia.com/api/v1/search_by_date?tags=story&page="
struct ServerKeys {
    static let titleKey = "title"
    static let createdDate = "created_at"
}
enum ResponseStatus {
    case succes
    case badResponse
    case error
}
enum Destination {
  case bottom
  case center
}
