import Foundation

public struct Nayau {
    fileprivate static var defaultInstance: Nayau = Nayau()
    fileprivate var enableFileName = false
    fileprivate var debugBuild: Bool?

    public static func setup(enableFileName: Bool = false, debugBuild: Bool) {
        Nayau.defaultInstance.debugBuild = debugBuild
        Nayau.defaultInstance.enableFileName = enableFileName
    }

    public static func debug(_ logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function, closure: () -> (String)) {
        self.debugLog(message: closure(), logType: logType, file: file, line: line, function: function)
    }

    public static func debug(_ message: CustomStringConvertible, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        self.debugLog(message: message.description, logType: logType, file: file, line: line, function: function)
    }

    public static func debug(_ message: String, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) {
        self.debugLog(message: message, logType: logType, file: file, line: line, function: function)
    }

    public static func production(_ message: String, logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function) {
        self.productionLog(message: message, logType: logType, file: file, line: line, function: function)
    }

    public static func production(_ logType: LogType? = .Information, file: String = #file, line: Int = #line, function: String = #function, closure: () -> (String)) {
        self.productionLog(message: closure(), logType: logType, file: file, line: line, function: function)
    }

    fileprivate static func productionLog(message: String, logType: LogType?, file: String, line: Int, function: String) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if !debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            print("You should call Nayau.setup before use it")
        }
    }

    fileprivate static func debugLog(message: String, logType: LogType?, file: String, line: Int, function: String) {
        if let debugBuild = Nayau.defaultInstance.debugBuild {
            if debugBuild {
                Nayau.defaultInstance.log(message: message, logType: logType, file: file, line: line, function: function)
            }
        } else {
            print("You should call Nayau.setup before use it")
        }
    }

    fileprivate func log(message: String, logType: LogType?, file: String, line: Int, function: String) {
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
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
