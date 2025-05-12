//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adnan Bakaev  on 11/05/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "Ukraine", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Spain", "UK", "US",
    ]

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))

                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))

                }

                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)

                    } label: {
                        Image(countries[number])
                            .resizable()
                            .shadow(radius: 10)
                            .cornerRadius(20)
                            .frame(width: 150, height: 100)
                    }
                }

            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score Is: ???")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
