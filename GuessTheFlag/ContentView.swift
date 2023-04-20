//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by George on 4/13/23.
// RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
// AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)

import SwiftUI


struct ContentView: View {

    @State private var scoreTitle: String = ""
    @State private var showingScore = false
    @State private var showingEndMessage = false
    @State private var isCorrect = false
    @State private var score = 0
    @State private var round = 1
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
           
        ZStack{
            
            RadialGradient(gradient: Gradient(stops: [.init(color: Color(red: 0.9, green: 0.8, blue: 0.9), location: 0.45), .init(color:Color(red:0.6, green: 0.1, blue: 0.9), location: 0.9)]), center: .bottom, startRadius: 200, endRadius: 500).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                VStack(spacing: 30){
                    VStack{
                        Text("ROUND \(round)").foregroundStyle(.secondary).font(.system(size:20).weight(.semibold))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.bold)).foregroundColor(.accentColor)
                            .padding()
                            .background(.red)
                            .clipShape(Capsule())
                        
                    }
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        } label:{
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 50)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                Spacer()
                Spacer()
                
                Text("SCORE: \(score)").font(.title.bold())
                    .foregroundStyle(.primary)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    
                Spacer()
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
    
            if isCorrect == false{
                Text("The correct answer is flag number \(correctAnswer + 1)")
                
            }
            else{
                Text("Correct, your score is \(score)")
            }
        }
        .alert(scoreTitle, isPresented: $showingEndMessage){
            Button("Restart", action: restart)
        }message:{
            Text("You got \(score)/10 correct!")
        }
        
   
    }
    
    func flagTapped(_ number: Int){
        if round == 10{
            scoreTitle = "FINAL SCORE"
            score += 1
            showingEndMessage = true
        
        }
        else if number == correctAnswer{
            scoreTitle = "Correct"
            isCorrect = true
            score += 1
            showingScore = true
        }
        else if number != correctAnswer{
            scoreTitle = "Incorrect"
            isCorrect = false
            showingScore = true
            
        }

    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        round += 1
    }
    
    func restart(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        round = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
