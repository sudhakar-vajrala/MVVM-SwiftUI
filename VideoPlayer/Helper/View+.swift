//
//  View+.swift
//  VideoPlayer
//
//  Created by Venkata Sudhakar Reddy on 12/04/25.
//

import SwiftUI

extension View {
  @ViewBuilder
  func showIf(_ shouldShow: Bool) -> some View {
    if shouldShow {
      self
    }
  }
}
