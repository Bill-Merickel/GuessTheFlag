//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bill Merickel on 3/23/25.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var showingFinalScore = false
  @State private var scoreTitle = ""
  @State private var scoreMessage = ""
  @State private var score = 0
  @State private var questionsAsked = 0

  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
      .ignoresSafeArea()
      VStack {
        Spacer()
        Text("Guess the Flag")
          .font(.largeTitle.bold())
          .foregroundStyle(.white)
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .font(.subheadline.weight(.heavy))
              .foregroundStyle(.secondary)
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              Image(countries[number])
                .clipShape(.capsule)
                .shadow(radius: 5)
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        Spacer()
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
      Text(scoreMessage)
    }
    .alert("Game Over", isPresented: $showingFinalScore) {
      Button("Play Again", action: reset)
    } message: {
      Text("Your final score was \(score).")
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      scoreMessage = "Nice job!"
      score += 1
    } else {
      scoreTitle = "Wrong"
      scoreMessage = "That's the flag of \(countries[number])."
    }
    questionsAsked += 1
    if questionsAsked == 8 {
      showingFinalScore = true
    } else {
      showingScore = true
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func reset() {
    questionsAsked = 0
    score = 0
    askQuestion()
  }
}

#Preview {
  ContentView()
}
