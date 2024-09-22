//////
//////  Trial.swift
//////  stockapp
//////
//////  Created by Param Desai on 08/04/24.
//////
////
import SwiftUI
import WebKit
//////struct WebView:UIViewRepresentable{
//////    let htmlFileName:String
//////    var data: [Result]
//////    private let webView = WKWebView()
//////    func makeUIView(context: Context) -> WKWebView {
//////        let webView = WKWebView()
//////        webView.navigationDelegate = context.coordinator // Set the delegate
//////        return webView
//////    }
//////
//////    func updateUIView(_ uiView: UIViewType, context: Context) {
//////        webView.load(htmlFileName, with: data)
//////    }
//////}
////struct WebView: UIViewRepresentable {
////    let htmlFileName: String
////    var data: [Result]
////    //
////    func makeUIView(context: Context) -> WKWebView {
////        let webView = WKWebView()
////        //        webView.navigationDelegate = context.coordinator
////        print("Data to be injected: \(data)") // Assign the delegate
////        //        webView.load(htmlFileName, with: data) // Load HTML with data injection
////                return webView
////    }
////    //
////    func updateUIView(_ uiView: WKWebView, context: Context) {
////        print("Updating view - data to be injected: \(data)")
////        uiView.load(htmlFileName, with: data) // Load HTML with data injection
////    }
////}
//
////    func makeCoordinator() -> Coordinator {
////        Coordinator(self)
////    }
////
////    class Coordinator: NSObject, WKNavigationDelegate {
////        var parent: WebView
////
////        init(_ webView: WebView) {
////            self.parent = webView
////        }
////
////        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////            // Ensuring JavaScript is injected only after the HTML content has fully loaded
////            webView.injectData(self.parent.data)
////        }
////    }
////}
//////extension WKWebView{
//////    func load(_ htmlFileName:String){
//////        guard !htmlFileName.isEmpty else{
//////            return print("Empty file name")
//////        }
//////        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html")
//////        else{
//////            return print("Error file path")
//////        }
//////        do{
//////            let htmlString = try String(contentsOfFile: filePath,encoding: .utf8)
//////            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
//////        }catch{
//////            print("error here")
//////        }
//////    }
//////    
//////}
////extension WKWebView {
////    // Load the HTML file from the bundle
////    func load(_ htmlFileName: String, with data: [Result]?) {
////        guard !htmlFileName.isEmpty else {
////            return print("Empty file name")
////        }
////        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
////            return print("Error file path")
////        }
////        do {
////            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
////            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
//////            if let data = data {
//////                print(data)
//////                injectData(data)
//////            }
////        } catch {
////            print("Error loading HTML file: \(error)")
////        }
////    }
////
////    // Inject JSON data into the web view
////    func injectData(_ data: [Result]) {
////        do {
////            print(data)
////            let jsonData = try JSONEncoder().encode(data)
////            let jsonString = String(data: jsonData, encoding: .utf8)?.replacingOccurrences(of: "'", with: "\\'") ?? ""
////            let jsCode = "displayData('\(jsonString)');"
////            print(jsCode)
////            self.evaluateJavaScript(jsCode)
////            { result, error in
////                if let error = error {
////                    print("Error injecting JavaScript: \(error)")
////                }
////            }
////        } catch {
////            print("Error encoding data: \(error)")
////        }
////    }
////}
////extension WKWebView {
////    // Load the HTML file from the bundle
////    func load(_ htmlFileName: String, with data: [Result]?) {
////        guard !htmlFileName.isEmpty else {
////            return print("Empty file name")
////        }
////        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
////            return print("Error file path")
////        }
////        do {
////            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
////            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
////            // The actual data injection will be handled by the navigation delegate when the content has fully loaded
////        } catch {
////            print("Error loading HTML file: \(error)")
////        }
////    }
////
////    // Inject JSON data into the web view
////    func injectData(_ data: [Result]) {
////        do {
////            print("checking if i get data at the start",data)
////            let jsonData = try JSONEncoder().encode(data)
////            let jsonString = String(data: jsonData, encoding: .utf8)?.replacingOccurrences(of: "'", with: "\\'") ?? ""
////            let jsCode = "displayData('\(jsonString)');"
////            print("JavaScript being injected: \(jsCode)") // Check what's being sent
////            self.evaluateJavaScript(jsCode) { result, error in
////                if let error = error {
////                    print("Error injecting JavaScript: \(error)")
////                }
////            }
////        } catch {
////            print("Error encoding data: \(error)")
////        }
////    }
////}
////
//////struct Trial: View {
//////    var body: some View {
//////        WebView(htmlFileName: "index")
//////    }
//////}
////
//////#Preview {
//////    Trial()
//////}
//struct WebView: UIViewRepresentable {
//    let htmlFileName: String
//    var data: [Result]
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        webView.load(htmlFileName, with: data)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: WebView
//
//        init(_ webView: WebView) {
//            self.parent = webView
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webView.injectData(self.parent.data)
//        }
//    }
//}
//
//extension WKWebView {
//    func load(_ htmlFileName: String, with data: [Result]?) {
//        guard !htmlFileName.isEmpty else {
//            return print("Empty file name")
//        }
//        guard let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html") else {
//            return print("Error file path")
//        }
//        do {
//            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
//            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
//            // Data injection handled after load completes
//        } catch {
//            print("Error loading HTML file: \(error)")
//        }
//    }
//
//    func injectData(_ data: [Result]) {
//        do {
//            print(data)
//            let jsonData = try JSONEncoder().encode(data)
//            print("grtting data?",data)
//            let jsonString = String(data: jsonData, encoding: .utf8)?.replacingOccurrences(of: "'", with: "\\'") ?? ""
//            print("Serialized data: \(jsonString)")
//            let jsCode = "displayData('\(jsonString)');"
//            evaluateJavaScript(jsCode) { result, error in
//                if let error = error {
//                    print("Error injecting JavaScript: \(error)")
//                }
//            }
//        } catch {
//            print("Error encoding data: \(error)")
//        }
//    }
//}
//struct WebView: UIViewRepresentable {
//    let htmlString: String
//    func makeUIView(context: Context) -> WKWebView{
//        return WKWebView()
//    }
//   
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        uiView.loadHTMLString(htmlString, baseURL: nil)
//    }
//}
struct Trial: View {
    var stockName:String
    var body: some View {
        VStack{
            Text(stockName)
            Text("AAPL INC")
        }
    }
}
struct Trial_Previews: PreviewProvider {
    static var previews: some View {
        Trial(stockName: "AAPL" )
    }
}

