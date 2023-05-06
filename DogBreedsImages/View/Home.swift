//
//  Home.swift
//  HeroCarousel
//
//  Created by Sree Sai Raghava Dandu on 28/12/20.
//

import SwiftUI
//width...
var width = UIScreen.main.bounds.width
struct Home: View {
    @EnvironmentObject var dogViewModel: DogViewModel

    @Namespace var animation
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Button(action: {
                        print("Button-1 pressed")
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.gray)
                    })
                    Text("Dog Breeds")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading)
                    Spacer()
                }//:HSTACK
                .padding()
                .onAppear() {
                        dogViewModel.fetchBreeds()
                }
                //Carousel...
                ZStack{
                    ForEach(dogViewModel.breeds.indices.reversed(), id: \.self) { index in       HStack {
                        BreedCardView(breed: dogViewModel.breeds[index],  animation: animation)
                            .frame(width: getCardWidth(index: index), height: getCardHeight(index: index))
                            .offset(x: getCardOffset(index: index))
                            .rotationEffect(.init(degrees: getCardRotation(index: index)))
                           

                        Spacer(minLength: 0)
                    }
                    .frame(height:400)
                    .contentShape(Rectangle())
                    .offset(x: dogViewModel.breeds[index].offset)
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({value in
                            onChanged(value: value, index: index)
                        })
                            .onEnded({value in
                                onEnded(value: value, index: index)
                            })
                    )
                        
                    }
                }//:ZSTACK
                .padding(.top,25)
                .padding(.horizontal,30)
                
                                    
                Button(action: {
                   ResetViews()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding()
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 3)
                })
                .padding(.top,35)
                
                Spacer()
            }
            //Detailed View
            if dogViewModel.showCard {
                DetailView(breed: dogViewModel.breeds[dogViewModel.currentBreedIndex], animation:  animation)
            }
            

        }//:VSTACK
        .background(Color.white)

        
    }//:ZSTACKsting views...

    
    func ResetViews(){
        for index in dogViewModel.breeds.indices{
            withAnimation(.spring()){
                dogViewModel.breeds[index].offset = 0
                dogViewModel.swipeCard = 0
            }
        }
    }
    
    //Getting rotation when card is being swiped
    func getCardRotation(index: Int) -> Double {
        if index == dogViewModel.swipeCard {
            let boxWidth = Double(width/3)
            let offset = Double(dogViewModel.breeds[index].offset)
            let angle : Double = 5
            return (offset / boxWidth) * angle
        }
        return 0
    }
    
    func onChanged(value:DragGesture.Value,index:Int) {
        //only left swipe
        if value.translation.width < 0{
            dogViewModel.breeds[index].offset = value.translation.width
        }
    }
    func onEnded(value:DragGesture.Value,index:Int) {
        withAnimation{
            if -value.translation.width > width / 3{
                dogViewModel.breeds[index].offset = -width
                dogViewModel.swipeCard += 1
            }
            else{
                dogViewModel.breeds[index].offset = 0
            }
        }
       
    }
    //Getting offest for the cards
    func getCardOffset(index:Int) -> CGFloat {
        return (index - dogViewModel.swipeCard) <= 2 ? CGFloat(index - dogViewModel.swipeCard) * 30 : 60
    }
    
    //Getting Height and width of the card
    func getCardHeight(index: Int) -> CGFloat {
        let height: CGFloat = 400
        let cardHeight = (index - dogViewModel.swipeCard) <= 2 ? CGFloat(index - dogViewModel.swipeCard ) * 35 : 70
        return height - cardHeight
    }
    
    func getCardWidth(index: Int) -> CGFloat {
        let boxWidth = UIScreen.main.bounds.width - 60 - 60
        //For Frist three cards
       // let cardWidth = index <= 2 ? CGFloat(index) * 30 : 60
        return boxWidth
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
