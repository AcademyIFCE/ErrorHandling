import Foundation

struct User {
    let id = UUID()
    let name: String
    let username: String
    let password: String
}

struct Session {
    let user: User
    let token: String
}

enum LoginError: LocalizedError {
    
    case userNotFound
    case wrongPassword
    
    var errorDescription: String? {
        switch self {
            case .userNotFound:
                return "User Not Found"
            case .wrongPassword:
                return "Wrong Password"
        }
    }
}

class System {
    
    private let users = [
        User(name: "Mateus Rodrigues", username: "mrodrigues", password: "123456"),
    ]
    
    func loginWithOptional(username: String, password: String) -> Session? {
        guard let user = users.first(where: { $0.username == username }) else {
            return nil
        }
        guard user.password == password else {
            return nil
        }
        let session = Session(user: user, token: "TOKEN")
        return session
    }
    
    func loginWithResult(username: String, password: String) -> Result<Session, Error> {
        guard let user = users.first(where: { $0.username == username }) else {
            return .failure(LoginError.userNotFound)
        }
        guard user.password == password else {
            return .failure(LoginError.wrongPassword)
        }
        let session = Session(user: user, token: "TOKEN")
        return .success(session)
    }
    
    func loginWithThrows(username: String, password: String) throws -> Session {
        guard let user = users.first(where: { $0.username == username }) else {
            throw LoginError.userNotFound
        }
        guard user.password == password else {
            throw LoginError.wrongPassword
        }
        let session = Session(user: user, token: "TOKEN")
        return session
    }
    
    @available(iOS 13.0, macOS 10.15, *)
    func loginAsyncWithThrows(username: String, password: String) async throws -> Session {
        guard let user = users.first(where: { $0.username == username }) else {
            throw LoginError.userNotFound
        }
        guard user.password == password else {
            throw LoginError.wrongPassword
        }
        let session = Session(user: user, token: "TOKEN")
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return session
    }
    
    func loginWithCompletion(username: String, password: String, completion: @escaping (Session?, Error?) -> Void) {
        guard let user = users.first(where: { $0.username == username }) else {
            completion(nil, LoginError.userNotFound)
            return
        }
        guard user.password == password else {
            completion(nil, LoginError.wrongPassword)
            return
        }
        let session = Session(user: user, token: "TOKEN")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(session, nil)
        }
    }
    
    func loginWithCompletionAndResult(username: String, password: String, completion: @escaping (Result<Session, Error>) -> Void) {
        guard let user = users.first(where: { $0.username == username }) else {
            completion(.failure(LoginError.userNotFound))
            return
        }
        guard user.password == password else {
            completion(.failure(LoginError.wrongPassword))
            return
        }
        let session = Session(user: user, token: "TOKEN")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(session))
        }
    }
    
}
