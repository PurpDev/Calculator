//
//  ContentView.swift
//  Calculatrice
//
//  Created by Augustin Diabira on 16/01/2022.
//

import SwiftUI

struct ContentView: View {
    
             @State var grid = [ ["AC", "-/+", "%", "/"],
                         ["7", "8", "9", "X"],
                         ["4", "5", "6", "-"],
                         ["1", "2", "3", "+"],
                         [",", "0", "AC", "="]
                          ]
    @State var test = ""
    @State var result = ""
   
    
    func bgcolor(_ op: String) -> Color {
        if op == "X" || op == "-" || op == "+" || op == "=" || op == "/"{
            return .orange
        }
        return .secondary
    }
    
    func button(op: String)
    {
        
        switch (op)
        {
        case "AC":
            test = "0"
            
        case "-/+":

            test += "-"
        case "=":
            result = calculateResults()
            test = result
          

        default:
            test += op
        }
        
                
    }

    
    func calculateResults() -> String
    {
        
            var calculs = test.replacingOccurrences(of: "%", with: "*0.01")
            calculs = calculs.replacingOccurrences(of: "X", with: "*")
            let expression = NSExpression(format: calculs)
            let resultat = expression.expressionValue(with: nil, context: nil) as! Double
            return formatResult(val: resultat)
        
        

    }
    func formatResult(val : Double) -> String
    {
        if(val.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", val)
        }
        
        return String(format: "%.2f", val)
    }
   
    var body: some View {
        ZStack{
            VStack {
                VStack {
                    Rectangle().foregroundColor(.black).frame(width: 150, height: 250)
                    
                    ForEach(grid, id: \.self)
                                {
                                    row in
                                    HStack
                                    {
                                        ForEach(row, id: \.self)
                                        {
                                            op in
                                            
                                            Button(action: { button(op: op) }, label: {
                                                Text(op)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 22, weight: .heavy))
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(bgcolor(op)).cornerRadius(50)
                                               
                                                
                                            })
                                            
                                        }
                                    }
                                }
                        
                }
                
               
            }
            VStack {
                Text("").padding()
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .heavy))
                Text(test)
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .heavy))
                
                
            }.padding(.bottom, 661)
        }.background(Color.black).ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(Color.black).ignoresSafeArea(.all)
    }
}
