import SwiftUI

struct ContentView: View {
    private var options = ["Rock", "Paper", "Scissors"]
    private var beatOptions = ["Paper", "Scissors", "Rock"]
    @State private var typeWinner = Bool.random()
    @State private var randOption = Int.random(in: 0...2)
    @State private var score = 0
    @State private var roundNumber = 1
    @State private var drawAlert = false
    @State private var finalScoreAlert = false
    
    var body: some View {
        ZStack {
            Color.primary
            VStack {
                Spacer()
                Text("Round \(roundNumber) / 10")
                    .font(.headline)
                    .foregroundStyle(.gray)
                Spacer()
                VStack {
                    Text("Program selected")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)
                    Text(options[randOption])
                        .font(.system(size: 50, weight: .bold))
                    Text("You need to")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.gray)
                    Text(typeWinner ? "Win" : "Lose")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundStyle(typeWinner ? .green : .red)
                }
                Spacer()
                VStack {
                    ForEach(options, id: \.self) { option in
                        Button {
                            nextRound(option)
                        } label: {
                            Text(option)
                        }
                        .font(.title2.bold())
                        .padding()
                        .frame(minWidth: 200)
                        .background(Color.secondary)
                        .clipShape(.buttonBorder)
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
            }
        }
        .foregroundStyle(.white)
        .ignoresSafeArea()
        .alert("It's an draw!", isPresented: $drawAlert) {
            Button("OK") {}
        }
        .alert("Final score", isPresented: $finalScoreAlert) {
            Button("Restart", action: reset)
        } message: {
            Text("You get \(score) points!")
        }
        
    }
    
    func nextRound(_ selectedOption: String) {
        if selectedOption == options[randOption] {
            drawAlert.toggle()
            score -= 1
        }
        else if selectedOption == beatOptions[randOption] {
            score += typeWinner ? 1 : -1
        }
        else {
            score += typeWinner ? -1 : 1
        }
        
        if score < 0 {
            score = 0
        }
        
        if roundNumber > 9 {
            finalScoreAlert.toggle()
        }
        else {
            typeWinner.toggle()
            randOption = Int.random(in: 0...2)
            roundNumber += 1
        }
    }
    
    func reset() {
        roundNumber = 1
        score = 0
        typeWinner = false
        randOption = Int.random(in: 0...2)
    }
    
}

#Preview {
    ContentView()
}
