import Foundation

public struct Nayau {
    private static var defaultInstance: Nayau = Nayau()
    private var enableFileName = false
    private var debugBuild: Bool?

    public static func setup(enableFileName enableFileName: Bool = false, debugBuild: Bool) {
        Nayau.defaultInstance.debugBuild = debugBuild
        Nayau.defaultInstance.enableFileName = enableFileName
    }

    public static func debug(message: String, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            preconditionFailure("You should call Nayau.setup before use it")
        }
    }

    public static func production(message: String, logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if !debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            preconditionFailure("You should call Nayau.setup before use it")
        }
    }

    private func log(message message: String, logType: LogType?, file: String, line: Int, function: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let messageBuilder = MessageBuilder { builder in
                builder.message = message
                builder.logType = logType
                if self.enableFileName {
                    builder.fileInformation = FileInformation(file: file, line: line, function: function)
                }
            }
            if let message = Message(messageBuilder: messageBuilder)?.description {
                print(message)
            }
        }
    }
}
