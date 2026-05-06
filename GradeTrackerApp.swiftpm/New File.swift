import SwiftUI

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var dueDate: String
    var priority: String
    var completed: Bool
}

