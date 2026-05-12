import SwiftUI

struct ContentView: View {
    
    @State private var tasks: [Task] = []
    
    @State private var taskName = ""
    @State private var dueDate = ""
    @State private var priority = "Medium"
    
    let priorities = ["Low", "Medium", "High"]
    
    var body: some View {
        NavigationView {
            VStack {
                
                // HEADER
                Text("High School Task Tracker")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                // INPUT SECTION
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
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Task")
                        }
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
                            
                            // COMPLETE TOGGLE
                            Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.completed ? .green : .gray)
                                .onTapGesture {
                                    toggleTask(task)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(task.name)
                                    .font(.headline)
                                    .strikethrough(task.completed)
                                    .foregroundColor(task.completed ? .gray : .primary)
                                
                                Text("Due: \(task.dueDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text(task.priority)
                                .padding(6)
                                .background(priorityColor(task.priority))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .onAppear {
                loadTasks()
            }
        }
    }
    
    // MARK: - FUNCTIONS
    
    func addTask() {
        guard !taskName.isEmpty, !dueDate.isEmpty else { return }
        
        let newTask = Task(
            name: taskName,
            dueDate: dueDate,
            priority: priority,
            completed: false
        )
        
        tasks.append(newTask)
        saveTasks()
        
        taskName = ""
        dueDate = ""
        priority = "Medium"
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
            saveTasks()
        }
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: "tasks")
        }
    }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
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

