//
//  ContentView.swift
//  MoviesReviews
//
//  Created by SERGEY KULABUHOV on 05.02.2021.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )//.border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
    
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView: View,  NYTManagerDelegate {
    
    func dataEndloading(_ result: NYTJSONRPCResponse<NYTResultData>) {
        reviews = result.results
        print("dataEndloading ok")
    }
    
    @State private var reviews: [NYTResultData]? = [NYTResultData]()
    
    @State private var nameComponents = ""
    
    func search() {
        
    }

    
    var body: some View {
        

        ZStack(alignment: .top) {
            VStack {
                Text("Reviews")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(minWidth: 0, maxHeight: 40, alignment: .top)
                
                HStack(spacing: 0){
                    Spacer()
                    Button(action: {
                        var manager = NYTManager()
                        manager.delegate = self
                        manager.fetchReviews()
                        
                        
                    }, label: {
                        Text("Reviewes")
                            .foregroundColor(Color.orange)
                            .frame(minWidth: 150, alignment: .center)
                            //.border(Color.white, width: 2)
                            .background(Color.white)
                            .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    })
                    Button(action: {
                        var manager = NYTManager()
                        manager.fetchReviews()
                        manager.delegate = self
                        
                    }, label: {
                        Text("Button")
                            .foregroundColor(.white)
                            .frame(minWidth: 150, alignment: .center)
                            .background(Color.blue)
                            .cornerRadius(5, corners: [.topRight, .bottomRight])
                        //.border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    })
                    Spacer()
                }
                
                
            }
            
            
        }
        
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.orange)
        .ignoresSafeArea()
        HStack{
            let nameFormatter = PersonNameComponentsFormatter()
            Image(systemName: "")
                TextField(
                    "Proper name",
                     value: $nameComponents,
                     formatter: nameFormatter,
                     onCommit: {
                        search()
                     })
                    .disableAutocorrection(true)
                    .padding()
                    //.border(Color(UIColor.separator))
                    
                //Text(nameComponents.debugDescription)

        }

        List{
            ForEach(reviews! , id: \.self){ review in
                HStack{
                    URLImage(url: URL(string: review.multimedia.src)!).frame(width: 90, height: 140)
                        
                        
                    //width: (CGFloat)review.multimedia.width, height: review.multimedia.height
                    //URLImage(review.m).resizable().frame(width: 40)
                    VStack{
                        Text("\(review.display_title)").font(.headline)
                        Spacer()
                        Text("\(review.summary_short)").font(.callout)
                            //.padding(10)
                    }
                    
                        
                }
                
                
            }
        }

        
        //.frame(minWidth: 0, maxHeight: 400, alignment: .topLeading)
        
        //                Button(action: {
        //                    //                    let api = BGBAPITVModel(api: .JSONRPC, package: "ru.bitel.bgbilling.modules.tv.api", interface: "TvAccountService", method: "tvAccountSearch", params: ["tvAccountSpecId" : "1", "strict" : "false"
        //                    //                    ], mid: 16)
        //
        //                    var manager = NYTManager()
        //                    manager.delegate = self
        //                    manager.fetchReviews()
        //                }, label: {
        //                    Text("Find TV accounts")
        //                })
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
            }
        }
    }
}
