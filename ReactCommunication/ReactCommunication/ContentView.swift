//
//  ContentView.swift
//  ReactCommunication
//
//  Created by Drew Althage on 10/12/23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @State private var messages: [String] = []
    @State private var webViewManager = WebViewManager()
    @State private var isVisible = false

    var body: some View {
        NavigationStack {
            List {
                Button("show", action: { isVisible.toggle() })
                Section {
                    ForEach(messages, id: \.self) { val in
                        Text(val)
                    }
                }
            }.navigationTitle("Messages")
                .sheet(isPresented: $isVisible) {
                    NavigationStack {
                        VStack {
                            WebView(manager: $webViewManager, request: URLRequest(url: URL(string: "http://10.11.211.65:4173")!))
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            isVisible = false
                                        }
                                    }
                                }
                            Button("Send Message") {
                                sendMessageToReactApp()
                            }
                        }
                    }
                }.onAppear {
                    webViewManager.callback = { message in
                        guard let msg = message else { return }
                        self.messages.append(msg)
                    }
                }
        }
    }

    func sendMessageToReactApp() {
        let message = "Hello from SwiftUI!"
        webViewManager.webView?.evaluateJavaScript("window.receiveMessageFromSwift('\(message)')") { _, error in
            if let error = error {
                print("Error sending message to JavaScript: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WebView: UIViewRepresentable {
    @Binding var manager: WebViewManager
    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        manager.webView = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

class WebViewManager: NSObject, ObservableObject, WKScriptMessageHandler {
    var callback: ((String?) -> Void)?

    weak var webView: WKWebView? {
        didSet {
            setupWebView()
        }
    }

    private func setupWebView() {
        guard let webView = webView else { return }
        webView.configuration.userContentController.removeAllUserScripts()
        webView.configuration.userContentController.add(self, name: "fromJS")
    }

    func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "fromJS" {
            if let messageBody = message.body as? String {
                callback?(messageBody)
            }
        }
    }
}
