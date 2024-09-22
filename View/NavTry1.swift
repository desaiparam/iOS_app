////
////  NavTry1.swift
////  NewFinalStockApp
////
////  Created by Param Desai on 02/05/24.
////
//
//import SwiftUI
//
//struct NavTry1: View {
//    
//    var body: some View {
//        NavigationView {
//            NavigationLink(destination: NavTry2()) {
//                Text("Go to NavTry2")
//            }
//            .navigationBarTitle("Navigation Example")
//        }
//    }
//}
//
//struct NavTry2: View {
//    @State private var isSheetPresentedCongrtatulation = false
//    var body: some View {
//        Text("This is NavTry2")
//            .navigationBarTitle("NavTry2")
//        Button(action: {
//            print("Trade button tapped")
//            self.isSheetPresentedCongrtatulation.toggle()
//        }) {
//            Text("Sell")
//        }.sheet(isPresented: $isSheetPresentedCongrtatulation){
//            NewNavTrySheet()
//        }
//    }
//}
//struct NewNavTrySheet : View {
//    @Environment(\.presentationMode) var presentationMode
//    var body: some View {
//        Button(action: {
//            presentationMode.wrappedValue.dismiss()
////            NavigationLink(destination: NewNavTry1()) {
////                            Text("Go to NavTry2")
////                        }
//        }) 
//        {
//            Text("Done")
//                .font(.headline)
//                .foregroundColor(.green)
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 30).fill(Color.white))
//                .padding(.horizontal)
//        }
//        if presentationMode==false{
//            NavigationLink(destination: NewNavTry1()) {
//            //                            Text("Go to NavTry2")
//            //                        }
//        }
//    }
//}
//
//struct NewNavTry1 : View{
//    var body: some View {
//        NavigationView {
//            NavigationLink(destination: NavTry2()) {
//                Text("Go to NavTry2")
//            }
//            .navigationBarTitle("Navigation Example")
//        }
//    }
//}
import SwiftUI

struct NavTry1: View {
    @State var isActive : Bool = false

    var body: some View {
        NavigationView {
            NavigationLink(
                destination: ContentView2(rootIsActive: self.$isActive),
                isActive: self.$isActive
            ) {
                Text("Hello, World!")
            }
//            .isDetailLink(false)
            .navigationBarTitle("Root")
        }
    }
}

struct ContentView2: View {
    @Binding var rootIsActive : Bool

    var body: some View {
        NavigationLink(destination: ContentView3(shouldPopToRootView: self.$rootIsActive)) {
            Text("Hello, World #2!")
        }
//        .isDetailLink(false)
        .navigationBarTitle("Two")
    }
}

struct ContentView3: View {
    @Binding var shouldPopToRootView : Bool

    var body: some View {
        VStack {
            Text("Hello, World #3!")
            Button (action: { self.shouldPopToRootView = false } ){
                Text("Pop to root")
            }
        }.navigationBarTitle("Three")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavTry1()
    }
}
