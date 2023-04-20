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
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
           
        ZStack{
            
            RadialGradient(gradient: Gradient(stops: [.init(color: Color(red: 0.15, green: 0.8, blue: 0.5), location: 0.45), .init(color:Color(red:0.9, green: 0.3, blue: 0.6), location: 0.45)]), center: .top, startRadius: 200, endRadius: 500).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold()).underline()
                    .foregroundColor(.some(.red))
                VStack(spacing: 30){
                    VStack{
                        Text("Select Flag").foregroundStyle(.secondary).font(.system(size:20).weight(.semibold))
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
            Text("Your score is \(score)")
        }
   
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }
        else{
            scoreTitle = "Incorrect"
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
