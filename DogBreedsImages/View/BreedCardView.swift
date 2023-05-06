//
//  BreedCardView.swift
//  Dog Breeds
//
//  Created by Bhavani Reddy Navure on 4/28/23.
//
import SwiftUI
import Kingfisher


struct BreedCardView: View {
    
    @EnvironmentObject var dogModel: DogViewModel

    @State private var selectedBreedIndex: Int?
   

     var breed: Breed
    var animation: Namespace.ID
    var body: some View {
        VStack{
            HStack {
                Text("Hi")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(alignment: .leading)
                    .padding(.top,20)
                    .padding(.leading, 20)

                    .matchedGeometryEffect(id: "Date-\(breed.id)", in: animation)
                Image(systemName: "pawprint.fill")
                    .foregroundColor(Color.white.opacity(0.85))
                    .padding(.top,17)
                    .frame(alignment: .leading)
                    .padding(.leading, -5)
                Spacer()
            }
            
            
            if let imageURL = breed.image?.url {
                KFImage.url(URL(string: imageURL))
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle()
                                .stroke(Color.white, lineWidth: 3))
                            .shadow(radius: 10)
                   
            }
            HStack {
                Text(breed.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width:250,alignment: .leading)
                    .padding()
                    .matchedGeometryEffect(id: "Title-\(breed.id)", in: animation)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            Spacer(minLength: 0)
            HStack{
                Spacer(minLength: 0)
                Text("To Know More")
                Image(systemName: "arrow.right")
            }
            .foregroundColor(Color.white.opacity(0.9))
            .padding(30)
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(breed.color
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "bgColor-\(breed.id)", in: animation)
        )
        .onTapGesture {
            withAnimation(.spring()){
                dogModel.showCard.toggle()
                dogModel.selectBreed(breed)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeIn){
                        dogModel.showContent = true
                        

                    }
                }
            }
        }
        
    }
}

struct BreedCardView_Previews: PreviewProvider {
    static var previews: some View {
        let dogModel = DogViewModel()
        dogModel.breeds = [
            Breed(id: 1, name: "Alph", countryCode: "US", bredFor: "Work", breedGroup: "worker", lifeSpan: "10 years", temperament: "happy", origin: ""),
            Breed(id: 2, name: "Beta", countryCode: "US", bredFor: "Play", breedGroup: "sporting", lifeSpan: "12 years", temperament: "strong willed", origin: "")
        ]
        
        return BreedCardView(breed: dogModel.breeds[0], animation: Namespace().wrappedValue)
            .environmentObject(dogModel)
    }
}
