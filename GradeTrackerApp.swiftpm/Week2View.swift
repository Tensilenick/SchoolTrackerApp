import SwiftUI

struct Week2View: View {
    
    @State private var tasks: [Task] = []
    
    @State private var taskName = ""
    @State private var dueDate = ""
    @State private var priority = "Medium"
    
    let priorities = ["Low", "Medium", "High"]
    
    var body: some View {
        VStack {
            
            Text("Week 2: Add Tasks")
                .font(.title)
                .bold()
                .padding()
            
            // INPUT FORM
            VStack(spacing: 10) {
                
                TextField("Task Name", text: $taskName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Due Date (e.g. May 10)", text: $dueDate)
                    .textFieldStyle(.roundedBorder)
                
                Picker("Priority", selection: $priority) {
                    ForEach(priorities, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Button(action: addTask) {
                    Text("Add Task")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding()
            
            // TASK LIST
            List {
                ForEach(tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .font(.headline)
                            
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
    
    func addTask() {
        guard !taskName.isEmpty, !dueDate.isEmpty else { return }
        
        let newTask = Task(
            name: taskName,
            dueDate: dueDate,
            priority: priority,
            completed: false
        )
        
        tasks.append(newTask)
        
        // Reset inputs
        taskName = ""
        dueDate = ""
        priority = "Medium"
    }
    
    func priorityColor(_ priority: String) -> Color {
        switch priority {
        case "High": return .red
        case "Medium": return .orange
        default: return .blue
        }
    }
}
