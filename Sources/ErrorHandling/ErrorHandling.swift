import Foundation

@main
public struct ErrorHandling {
    
    public static func main() {
        
        let system = System()
        
        let username = "mrodrigues" // Correct = mrodrigues
        let password = "12345" // Correct = 123456
        
        // Using Optional

        let session = system.loginWithOptional(username: username, password: password)
        
        if let session = session {
            print("Using Optional:", session)
        } else {
            print("Using Optional:", session)
        }
        
        // Using Result
        
        let result = system.loginWithResult(username: username, password: password)
        
        switch result {
            case .success(let session):
                print("Using Result:", session)
            case .failure(let error):
                print("Using Result:", error.localizedDescription)
        }
        
        // Using Throws
        
        do {
            let session = try system.loginWithThrows(username: username, password: password)
            print("Using Throws:", session)
        } catch {
            print("Using Throws:", error.localizedDescription)
        }
        
        // Using Async Throws
        
        if #available(iOS 13.0, macOS 10.15, *) {
            Task {
                do {
                    let session = try await system.loginAsyncWithThrows(username: username, password: password)
                    print("Using Async Throws:", session)
                } catch {
                    print("Using Async Throws:", error.localizedDescription)
                }
            }
        }
        
        // Using Completion
        
        system.loginWithCompletion(username: username, password: password) { session, error in
            if let error = error {
                print("Using Completion:", error.localizedDescription)
            } else {
                print("Using Completion:", session!)
            }
        }
        
        // Using Completion & Result
        
        system.loginWithCompletionAndResult(username: username, password: password) { result in
            switch result {
                case .success(let session):
                    print("Using Completion & Result:", session)
                case .failure(let error):
                    print("Using Completion & Result:", error.localizedDescription)
            }
        }
        
        RunLoop.main.run()
        
    }
    
}

// https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
// https://www.swiftbysundell.com/basics/error-handling/
// https://nshipster.com/optional-throws-result-async-await/
// https://nshipster.com/swift-foundation-error-protocols/
