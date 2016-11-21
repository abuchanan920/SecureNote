import LocalAuthentication

protocol AuthenticationManagerType {
    var context: LAContext { get }
    func authenticate(callback: @escaping (Bool, Error?) -> Void)
}

class AuthenticationManager: AuthenticationManagerType {
    static let sharedInstance = AuthenticationManager()

    internal let context: LAContext = LAContext()
    
    func authenticate(callback: @escaping (Bool, Error?) -> Void) {
        var error: NSError?
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            let reason = "Please authenticate"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: callback)
        } else {
            callback(false, AuthenticationError.PolicyNotEvaluatable)
        }
    }

    enum AuthenticationError: Error {
        case PolicyNotEvaluatable
    }
}
