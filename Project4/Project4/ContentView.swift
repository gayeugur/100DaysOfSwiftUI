//
//  ContentView.swift
//  Project4
//
//  Created by gayeugur on 4.01.2024.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeup = defaultWakeupTime
    @State private var sleepTime = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                //1.Section
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeup,
                               displayedComponents: .hourAndMinute)
                }
                
                //2.Section
                Section(header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepTime.formatted()) hours",
                            value: $sleepTime,
                            in: 4...12,
                            step: 0.25)
                }
                
                //3.Section
                Section(header: Text("Daily Coffee Intake")) {
                    Picker(selection: $coffeeAmount,
                           label: Text("Daily coffee intake")) {
                        ForEach(1..<21) { cup in
                            Text("\(cup) cup\(cup == 1 ? "" : "s")").tag(cup)
                        }
                    }
                }
                
                //4. Section
                Section(header: Text("Your recommended bedtime")) {
                    Text(calculateBedTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .navigationTitle("BetterRest")
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepTime,
                coffee: Double(coffeeAmount)
            )
            
            let bedtime = wakeup - prediction.actualSleep
            
            return bedtime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong"
            showingAlert = true
            return "Error"
        }
    }

}

#Preview {
    ContentView()
}
