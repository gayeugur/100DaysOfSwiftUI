//
//  UsersView.swift
//  Project12
//
//  Created by gayeugur on 22.02.2026.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    
    init(minimumJoinDate: Date, sortOder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOder)
    }
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                
                Spacer()
                
                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .onAppear {
            addSample()
        }
    }
    
    func addSample() {
        let user1 = User(name: "User 1", city: "Istanbul", joinDate: .now)
        let job1 = Job(name: "Work", priority: 3)
        let job2 = Job(name: "Make plan", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}
