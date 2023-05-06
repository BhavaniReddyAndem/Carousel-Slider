//
//  DetailView.swift
//  HeroCarousel
//
//  Created by Sree Sai Raghava Dandu on 29/12/20.
//

import SwiftUI
import Kingfisher


struct DetailView: View {
    @EnvironmentObject var dogModel: DogViewModel

    var breed: Breed
    var animation: Namespace.ID
    var body: some View {
        ZStack {
            VStack{
               
                if let imageURL = dogModel.selectedBreed?.image?.url {
                    KFImage.url(URL(string: imageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .animation(.none)
                        .frame(maxWidth: UIScreen.main.bounds.size.width, maxHeight: UIScreen.main.bounds.size.height * 0.4)
                        .clipShape(TopRoundedRectangle(radius: 20))
                        .overlay(
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: 40)
                                .offset(y: 60)
                        )
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                VStack(alignment: .leading) {
                    HStack(){
                        Text(dogModel.selectedBreed?.name ?? "Unknown")
                            .font(.system(size: 18))

                            .fontWeight(.bold)
                            .foregroundColor(.white)
                           
                            .frame(width:300,alignment: .leading)
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)

                            
                           
                        Spacer()
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text("Bred For: \(dogModel.selectedBreed?.bredFor ?? "Unknown")")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .frame(width: 300 ,alignment: .leading)
                        .lineLimit(nil)
                        .padding()
                    
                    Spacer(minLength: 0)
                    
                    Text("Life Span: \(dogModel.selectedBreed?.lifeSpan ?? "Unknown")")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .frame(width:250,alignment: .leading)
                        .padding()
                    
                    Spacer(minLength: 0)
                    
                    Text("Breed Group: \(dogModel.selectedBreed?.breedGroup ?? "Unknown")")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .frame(width:250,alignment: .leading)
                        .padding()
                    
                    Spacer(minLength: 0)
                    
                }
                .padding(.leading, 6)
               

                //Detail View content
                if dogModel.showContent {
                    VStack {
                        
                        
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 4), spacing: 4) {
                                    ForEach(dogModel.selectedBreed?.temperament?.split(separator: ",") ?? [""], id: \.self) { word in
                                        Capsule()
                                            .foregroundColor(Color.white.opacity(0.6))
                                            .overlay(
                                                Text(word.trimmingCharacters(in: .whitespaces))
                                                    .font(.caption)
                                                    .foregroundColor(.black)
                                                    .padding(.horizontal, 2)

                                            
                                            )
                                            .padding(.vertical, 4)
                                            
                                            .frame(minHeight: 30)
                                    }
                                }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(10)
                        Spacer(minLength: 0)
                    }
                }
                Spacer(minLength: 0)
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(dogModel.selectedBreed?.color
                    .cornerRadius(25)
                    .ignoresSafeArea(.all,edges: .bottom )

        )
            
            //Close Button
            VStack{
                Spacer()
                if dogModel.showContent{
                    Button(action: {
                        CloseDetailedView()
                    }, label: {
                        Image(systemName: "arrow.down")
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .background(Color.white.opacity(0.7))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .shadow(radius: 8)
                    })
                    .padding()
                }
            }
        }
    }
    
    
    //function to close the detailedView
    func CloseDetailedView(){
        withAnimation(.spring()){
            dogModel.showCard.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn){
                    dogModel.showContent = false
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
