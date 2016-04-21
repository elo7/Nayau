import Foundation

public struct Nayau {
    private static var defaultInstance: Nayau = Nayau()
    private var enableFileName = false
    private var enableThreadInformation = false
    private var debugBuild: Bool?

    public static func setup(enableFileName enableFileName: Bool = false, enableThreadInformation: Bool = false, debugBuild: Bool) {
        Nayau.defaultInstance.debugBuild = debugBuild
        Nayau.defaultInstance.enableFileName = enableFileName
        Nayau.defaultInstance.enableThreadInformation = enableThreadInformation
    }

    public static func debug(logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function, closure: () -> (String)) {
        self.debugLog(message: closure(), logType: logType, file: file, line: line, function: function)
    }

    public static func debug(message: CustomStringConvertible, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        self.debugLog(message: message.description, logType: logType, file: file, line: line, function: function)
    }

    public static func debug(message: String, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        self.debugLog(message: message, logType: logType, file: file, line: line, function: function)
    }

    public static func production(message: String, logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function) {
        self.productionLog(message: message, logType: logType, file: file, line: line, function: function)
    }

    public static func production(logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function, closure: () -> (String)) {
        self.productionLog(message: closure(), logType: logType, file: file, line: line, function: function)
    }

    private static func productionLog(message message: String, logType: LogType?, file: String, line: Int, function: String) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if !debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            print("You should call Nayau.setup before use it")
        }
    }

    private static func debugLog(message message: String, logType: LogType?, file: String, line: Int, function: String) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            print("You should call Nayau.setup before use it")
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

                if self.enableThreadInformation {
                    builder.threadInformation = ThreadInformation(enableQoS: true)
                }
            }
            if let message = Message(messageBuilder: messageBuilder)?.description {
                print(message)
            }
        }
    }
}
