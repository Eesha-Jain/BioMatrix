//  TurtleRound.swift
//  BioMatrix
//
//  Created by Jain, Eesha on 4/25/21.
//

import SwiftUI

struct TurtleRound: View {
    //Answer Variables
    @State var answer: String = ""
    @State var correct: String = ""
    @State var opacity: Double = 0
    @State var color: String = "White"
    
    //Other Variables
    @State var question = LocalStorage.currentQuestion.question
    @State var list: [Question] = []
   
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    //BioMatrix Text
                    LinearGradient(gradient: Gradient(colors: [Color("Purple"), Color("Blue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(height: 50)
                        .mask(Text("BIOMATRIX"))
                        .foregroundColor(Color("Purple"))
                        .font(Font.custom("Roboto-Bold", size: 60))
                        .padding([.bottom], 10)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                        .animation(.easeOut)
                    
                    //Question
                    VStack {
                        VStack {
                            HStack {
                                Spacer()
                                Text(question.category)
                                    .foregroundColor(Color("Text"))
                                    .font(Font.custom("Roboto-Regular", size: 20))
                                Spacer()
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(question.starred ? "StarYes" : "StarNo"))
                                    .onTapGesture {
                                        changeStarred()
                                        question = LocalStorage.currentQuestion.question
                                    }
                            }
                            
                            Text(question.question)
                                .foregroundColor(Color("Text"))
                                .font(Font.custom("Roboto-Light", size: 20))
                            
                        }.padding(10)
                    }
                    .frame(width: UIScreen.main.bounds.size.width * 0.89)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 12,
                            style: .continuous
                        )
                        .fill(Color("Red"))
                    )
                    .padding([.bottom], 5)
                    .animation(.easeIn)
                    .animation(.easeOut)
                    
                    //Input
                    HStack {
                        TextField("Type your answer...", text: $answer)
                            .autocapitalization(.none)
                            .padding(13)
                            .frame(width: UIScreen.main.bounds.size.width * 0.60)
                            .background(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(Color("Answer"))
                            )
                            .foregroundColor(Color("OppositeText"))
                            .font(Font.custom("Roboto-Light", size: 20))
                        
                        Button(action: {
                            if (correct == "") {
                                opacity = 100
                                var right = false;
                                
                                for ans in question.answer {
                                    if (answer.lowercased() == ans.lowercased()) {
                                        right = true;
                                    }
                                }
                                
                                if (right) {
                                    correct = "Correct"
                                    color = "Correct"
                                } else {
                                    correct = "Incorrect. Answer: \(question.answer[0])"
                                    color = "Incorrect"
                                }
                            }
                        }, label: {
                            Text("Submit")
                        })
                        .padding(13)
                        .frame(width: UIScreen.main.bounds.size.width * 0.25)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color("Submit"))
                        )
                        .foregroundColor(Color("OppositeText"))
                        .font(Font.custom("Roboto-Light", size: 20))
                    }.padding([.bottom], 10)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    .animation(.easeOut)
                    
                    //Next
                    Button(action: {
                        list.insert(question, at: 0)
                        if (list.count > 5) {
                            list.remove(at: 5)
                        }
                        
                        question = newQuestion()
                        opacity = 0
                        answer = ""
                        color = "White"
                        correct = ""
                    }, label: {
                        Text("Next")
                    }).padding(13)
                    .frame(width: UIScreen.main.bounds.size.width * 0.9)
                    .background(
                        RoundedRectangle(cornerRadius: 100, style: .continuous)
                            .fill(Color("Purple"))
                    )
                    .foregroundColor(Color("Text"))
                    .font(Font.custom("Roboto-Light", size: 20))
                    .opacity(opacity)
                    .padding([.bottom], 10)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    .animation(.easeOut)
                    
                    //Make Text go to Top
                    Spacer()
                    
                    //Previous questions
                    PreviousQuestions(list: list)
                }
            }
            
            Spacer()
            
            //Bottom message
            VStack {
                Text("\(correct)")
                    .lineLimit(nil)
                    .font(Font.custom("Roboto-Bold", size:20))
                    .foregroundColor(Color("OppositeText"))
            }
            .padding(10)
            .frame(width: UIScreen.main.bounds.size.width)
            .background(Color(color).edgesIgnoringSafeArea(.bottom))
            .opacity(opacity)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
            .animation(.easeOut)
        }.onAppear(perform: {
            question = LocalStorage.currentQuestion.question
        })
    }
}

struct TurtleRound_Previews: PreviewProvider {
    static var previews: some View {
        TurtleRound()

    }
}
