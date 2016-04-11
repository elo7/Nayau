import Foundation

struct Nayau {
    static let sharedInstance: Nayau = Nayau()

    func debug(message: String) {
        #if DEBUG
            log(message: message)
        #endif
    }

    func production(message: String) {
        #if RELEASE
            log(message: message)
        #endif
    }

    private func log(message message: String) {
        print(message)
    }
}