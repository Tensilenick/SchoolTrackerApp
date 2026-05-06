import SwiftUI

struct Week1View: View {
    
    var tasks = [
        Task(name: "Math Homework", dueDate: "April 28", priority: "High", completed: false),
        Task(name: "Science Project", dueDate: "May 1", priority: "Medium", completed: true),
        Task(name: "English Essay", dueDate: "May 3", priority: "Low", completed: false)
    ]
    
    var body: some View {
        VStack {
            Text("Week 1: Static Task List")
                .font(.title)
                .bold()
                .padding()
            
            List {
                ForEach(tasks) { task in
                    HStack {
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.completed ? .green : .gray)
                        
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .font(.headline)
                                .strikethrough(task.completed)
                            
                            Text("Due: \(task.dueDate)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text(task.priority)
                            .padding(6)
                            .background(priorityColor(task.priority))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    func priorityColor(_ priority: String) -> Color {
        switch priority {
        case "High": return .red
        case "Medium": return .orange
        default: return .blue
        }
    }
}
