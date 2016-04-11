import Foundation

enum LogType: String {
    case Error = "Error"
    case Warning = "Warning"
    case Debug = "Debug"
    case Information = "Information"
}

struct Nayau {
    static let defaultInstance: Nayau = Nayau()
    var enableFileName = false

    func debug(message: String, logType: LogType? = .Debug, file: String = #file, line: Int = #line, function: String = #function) -> String? {
        #if DEBUG
            log(message: message, logType: logType)

            return message
        #endif

        return nil
    }

    func production(message: String, logType: LogType? = .Information) {
        #if RELEASE
            log(message: message, logType: logType)
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

struct FileInformation: CustomStringConvertible {
    var file: String?
    var line: Int?
    var function: String?

    var description: String {
        return "File: \(self.file) Line Number: \(self.line) Function: \(self.function)"
    }
}

struct Message: CustomStringConvertible {
    let message: String
    var logType: LogType?
    var fileInformation: FileInformation?

    init?(messageBuilder: MessageBuilder) {
        guard let message = messageBuilder.message else {
            return nil
        }

        self.message = message
        self.logType = messageBuilder.logType
        self.fileInformation = messageBuilder.fileInformation
    }

    var description: String {
        var newMessage = ""

        if let logType = self.logType {
            newMessage = "[\(logType.rawValue)] : "
        }

        newMessage = "\(newMessage)\(self.message)"

        if let fileInformation = self.fileInformation {
            newMessage += "\n\(fileInformation.description)"
        }

        return newMessage
    }

    static func someFunction(file: String = #file, line: Int = #line, function: String = #function) -> String
    {
        return "\(file):\(line) : \(function)"
    }
}

class MessageBuilder {
    var message: String?
    var logType: LogType?
    var fileInformation: FileInformation?

    init(buildClosure: (MessageBuilder) -> ()) {
        buildClosure(self)
    }
}
