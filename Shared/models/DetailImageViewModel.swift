//
//  DetailImageViewModel.swift
//  NewsFeedSwiftUI
//
//  Created by 李其炜 on 3/12/21.
//

import Foundation
import SwiftUI
import Combine


class DetailImageViewModel: ObservableObject{
    @Published var imageStr: String = ""
    @Published var show = false
}
