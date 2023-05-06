//
//  ContentView.swift
//  DogBreedsImages
//
//  Created by Bhavani Reddy Navure on 5/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dogBreedModel =  DogViewModel()
    var body: some View {
        Home()
            .environmentObject(dogBreedModel)
        //Using it as environmental variable

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
