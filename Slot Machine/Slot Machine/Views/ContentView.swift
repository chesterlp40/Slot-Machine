//
//  ContentView.swift
//  Slot Machine
//
//  Created by Ezequiel Rasgido on 19/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    let symbols = [
        "gfx-bell",
        "gfx-cherry",
        "gfx-coin",
        "gfx-grape",
        "gfx-seven",
        "gfx-strawberry"
    ]
    
    @State private var highScore: Int = 0
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView = false
    
    // MARK: - FUNCTIONS
    
    // SPIN THE REELS
    private func spinReels() {
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
    }
    
    // CHECK THE WINNING
    private func checkWinning() {
        if
            reels[0] == reels[1] &&
            reels[1] == reels[2] &&
            reels[0] == reels[2]
        {
            // PLAYER WINS
            self.playerWins()
            
            // NEW HIGHSCORE
            if coins > highScore {
                self.newHighScore()
            }
        } else {
            // PLAYER LOSES
            self.playerLoses()
        }
    }
    
    private func playerWins() {
        coins += betAmount * 10
    }
    
    private func newHighScore() {
        highScore = coins
    }
    
    private func playerLoses() {
        coins -= betAmount
    }
    
    // GAME IS OVER
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color("ColorPink"),
                        Color("ColorPurple")
                    ]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            // MARK: - INTERFACE
            
            VStack(alignment: .center, spacing: 5) {
                // MARK: - HEADER
                
                LogoView()
                
                Spacer()
                
                // MARK: - SCORE
                
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                // MARK: - SLOT MACHINE
                
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - SPIN BUTTON
                    
                    Button {
                        // SPIN THE REELS
                        self.spinReels()
                        
                        // CHECK THE WINNING
                        self.checkWinning()
                    } label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }

                    
                } // SLOT MACHINE
                .layoutPriority(2)
                
                // MARK: - FOOTER
                
                Spacer()
                
                HStack {
                    // MARK: - BET 20
                    
                    HStack(alignment: .center, spacing: 10) {
                        Button {
                            print("Bet 20 coins")
                        } label: {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                        
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .scaledToFit()
                            .modifier(CasinoChipsModifier())
                    }
                    
                    // MARK: - BET 10
                    
                    HStack(alignment: .center, spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .scaledToFit()
                            .modifier(CasinoChipsModifier())
                        
                        Button {
                            print("Bet 10 coins")
                        } label: {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                                .modifier(BetNumberModifier())
                        }
                        .modifier(BetCapsuleModifier())
                    }
                }
            }
            // MARK: - BUTTONS
            
            .overlay(
                // RESET
                Button(action: {
                    print("Reset Game")
                })  {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                // INFO
                Button(action: {
                    print("Info View")
                    self.showingInfoView.toggle()
                })  {
                    Image(systemName: "info.circle")
                }
                .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            
            // MARK: - POP UP
        } //: ZSTACK
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
