struct FileInformation: CustomStringConvertible {
    var file: String?
    var line: Int?
    var function: String?

    var description: String {
        return "File: \(self.file) Line Number: \(self.line) Function: \(self.function)"
    }
}
