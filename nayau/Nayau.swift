import Foundation

public struct Nayau {
    private static let defaultInstance: Nayau = Nayau()
    public var enableFileName = false

    public static func debug(message: String, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
        #endif
    }

    public static func production(message: String, logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function) {
        #if RELEASE
            Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
        #endif
    }

    private func log(message message: String, logType: LogType?, file: String, line: Int, function: String) {
        let messageBuilder = MessageBuilder { builder in
            builder.message = message
            builder.logType = logType
            if self.enableFileName {
                builder.fileInformation = FileInformation(file: file, line: line, function: function)
            }
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print(Message(messageBuilder: messageBuilder)?.description)
        }
    }
}
