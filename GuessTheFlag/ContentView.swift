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
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0

    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.1, green: 0.2, blue: 0.3),
                        location: 0.3
                    ),
                    .init(
                        color: Color(red: 0.76, green: 0.15, blue: 0.26),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 700
            )
            .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
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
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()

                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your Score Is: \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }

        showingScore = true
    }

    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }

}

#Preview {
    ContentView()
}
