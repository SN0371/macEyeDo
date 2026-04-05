import Foundation

struct TodoItem: Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(title: String) {
        id = UUID()
        self.title = title
        isCompleted = false
    }
}

final class TodoStore {
    static let shared = TodoStore()
    private let key = "maceyedo.todos.v1"
    private var data: [String: [TodoItem]] = [:]

    private init() { load() }

    func items(for dateKey: String) -> [TodoItem] {
        data[dateKey] ?? []
    }

    func add(title: String, for dateKey: String) {
        var list = data[dateKey] ?? []
        list.append(TodoItem(title: title))
        data[dateKey] = list
        save()
    }

    func toggleCompleted(id: UUID, for dateKey: String) {
        guard var list = data[dateKey],
              let idx = list.firstIndex(where: { $0.id == id }) else { return }
        list[idx].isCompleted.toggle()
        data[dateKey] = list
        save()
    }

    func delete(id: UUID, for dateKey: String) {
        guard var list = data[dateKey] else { return }
        list.removeAll { $0.id == id }
        data[dateKey] = list.isEmpty ? nil : list
        save()
    }

    /// Returns a value in [0, 1] representing how urgently an open todo is due.
    /// Past/today = 1.0; 1 day away = 0.8; 4 days away = 0.2; 5+ days or none = 0.
    func urgencyLevel() -> CGFloat {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        fmt.dateFormat = "yyyy-MM-dd"

        var minDays = Int.max
        for (key, items) in data where items.contains(where: { !$0.isCompleted }) {
            guard let date = fmt.date(from: key) else { continue }
            let days = cal.dateComponents([.day], from: today, to: date).day ?? 0
            minDays = min(minDays, max(0, days))   // past overdue → 0, future → days
        }
        guard minDays != Int.max else { return 0 }
        return max(0, 1.0 - CGFloat(minDays) / 5.0)
    }

    private func save() {
        guard let encoded = try? JSONEncoder().encode(data) else { return }
        UserDefaults.standard.set(encoded, forKey: key)
    }

    private func load() {
        let ud = UserDefaults.standard
        guard let saved = ud.data(forKey: key),
              let decoded = try? JSONDecoder().decode([String: [TodoItem]].self, from: saved)
        else { return }
        data = decoded
    }
}
