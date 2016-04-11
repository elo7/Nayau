struct FileInformation: CustomStringConvertible {
    var file: String?
    var line: Int?
    var function: String?

    var description: String {
        if let file = self.file, let line = self.line, let function = self.function {
            return "File: \(file) Line Number: \(line) Function: \(function)"
        }

        return ""
    }
}
