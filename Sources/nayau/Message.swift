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
            newMessage += " FileInformation: \(fileInformation.description)"
        }

        return newMessage
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
