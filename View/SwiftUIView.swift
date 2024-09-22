////
////  SwiftUIView.swift
////  NewFinalStockApp
////
////  Created by Param Desai on 29/04/24.
////
//
//
//import SwiftUI
//
//extension View {
//
//    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
//        Toast(isShowing: isShowing,
//              presenting: { self },
//              text: text)
//    }
//
//}
//
//
//struct Toast<Presenting>: View where Presenting: View {
//    
//    /// The binding that decides the appropriate drawing in the body.
//    @Binding var isShowing: Bool
//    /// The view that will be "presenting" this toast
//    let presenting: () -> Presenting
//    /// The text to show
//    let text: Text
//    
//    var body: some View {
//        
//        GeometryReader { geometry in
//                   
//                   ZStack(alignment: .bottom) {
//                       
//                       self.presenting()
//                           .onAppear {
//                               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                   self.isShowing = false
//                               }
//                           }
//                       // You can uncomment the next line if you want to blur the background view when the toast is showing
//                       // .blur(radius: self.isShowing ? 1 : 0)
//                       
//                       VStack {
//                           self.text
//                       }
//                       .frame(width: geometry.size.width / 1,  // Decreased width from 1/2 to 1/3 of parent width
//                                             height: geometry.size.height / 8)
//                       .background(Color.gray)
//                       .foregroundColor(Color.white)
//                       .cornerRadius(30) // Changed from 30 to 0 to make the corners rectangular
//                       .transition(.slide)
//                       .opacity(self.isShowing ? 1 : 0)
//                       
//                   }.onAppear {
//                       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                           self.isShowing = false
//                       }
//                   }
//                   
//               }
//        
//    }
//}
//
//struct Toastsss: View {
//
//    @State var showToast: Bool = false
//
//    var body: some View {
//        NavigationView {
//            List(0..<100) { item in
//                Text("\(item)")
//            }
//            .navigationBarTitle(Text("A List"), displayMode: .large)
//            .navigationBarItems(trailing: Button(action: {
//                withAnimation {
//                    self.showToast.toggle()
//                }
//            }){
//                Text("Toggle toast")
//            })
//        }
//        .toast(isShowing: $showToast, text: Text("Hello toast!"))
//    }
//
//}
//struct Toastsss_Previews: PreviewProvider {
//    static var previews: some View {
//        Toastsss()
//    }
//}
////Taken from stackoverflow given in description 
import SwiftUI
extension View {
    func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
        Toast(
            isPresented: isPresented,
            presenter: { self },
            content: content
        )
    }
}
struct Toast<Presenting, Content>: View where Presenting: View, Content: View {
    @Binding var isPresented: Bool
    let presenter: () -> Presenting
    let content: () -> Content
    let delay: TimeInterval = 2
    
    var body: some View {
        if self.isPresented {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                withAnimation {
                    self.isPresented = false
                }
            }
        }
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.presenter()
                
                ZStack {
                    Capsule()
                        .fill(Color.gray)
                    
                    self.content()
                        .foregroundColor(.white)
                } //ZStack (inner)
                .frame(width: geometry.size.width / 1.25, height: geometry.size.height / 10)
                .opacity(self.isPresented ? 1 : 0)
            } //ZStack (outer)
            .padding(.bottom)
        } //GeometryReader
    } //body
} //Toast
