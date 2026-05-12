import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var name: String
    var dueDate: String
    var priority: String
    var completed: Bool
    
    init(id: UUID = UUID(), name: String, dueDate: String, priority: String, completed: Bool) {
        self.id = id
        self.name = name
        self.dueDate = dueDate
        self.priority = priority
        self.completed = completed
    }
}


