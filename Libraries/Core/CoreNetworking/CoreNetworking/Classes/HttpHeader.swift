//
//  Header.swift
//
//  Created by Hussam Elsadany on 19/06/2022.
//

import Foundation


public enum HeaderKey: String {
  case contentType = "Content-Type"
  case authorization = "Authorization"
  case accept = "accept"
}

public enum Header: String {
  case form = "application/x-www-form-urlencoded"
  case applicationJson = "application/json"
}

