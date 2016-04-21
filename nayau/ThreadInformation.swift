import Foundation

struct ThreadInformation: CustomStringConvertible {
    var enableQoS = false

    var description: String {
        var result = "Current Thread: \(NSThread.currentThread().description)"

        if enableQoS {
            result += " Quality Of Service : \(String(NSThread.currentThread().qualityOfService))"
        }

        return result
    }
}
