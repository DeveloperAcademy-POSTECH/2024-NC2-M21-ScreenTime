//
//  GoalView.swift
//  Stoplight-NC2
//
//  Created by kyungsoolee on 6/18/24.
//

import SwiftUI

struct GoalView: View {
    @Binding var selectedActivity: AppDeviceActivity?
    @Binding var presentedGoalView: Bool
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    var methods: [String] = ["less", "more"]
    @State private var seletedMethod: String = "less"
    
    var body: some View {
        VStack {
            if var activity = selectedActivity {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text(activity.displayName)
                            HStack {
                                Picker("", selection: $hours){
                                    ForEach(0..<24, id: \.self) { i in
                                        Text("\(i) hours")
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                Picker("", selection: $minutes){
                                    ForEach(0..<60, id: \.self) { i in
                                        Text("\(i) min")
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                Menu {
                                    ForEach(methods, id: \.self) { method in
                                        Button {
                                            seletedMethod = method
                                        } label: {
                                            Text(method)
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(seletedMethod)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                                        Image(systemName: "chevron.down")
                                    }
                                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                }
                                .foregroundColor(.gray)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 1))
                            }
                        }
                    }
                }
                
                Button {
                    presentedGoalView.toggle()
                    activity.updateLimitedTime(newTime: 3)
                    selectedActivity = activity
                } label: {
                    Text("Done")
                }
            }
        }
        .navigationTitle("Your Goal")
    }
}


