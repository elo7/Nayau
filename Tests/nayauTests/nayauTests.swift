import XCTest
@testable import nayau

class MessageTests: XCTestCase {
    func testShouldValidateDebugMessage() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Debug Message"
            builder.logType = LogType.Debug
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "[Debug] : A Debug Message")
    }

    func testShouldValidateWarningMessage() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Warning Message"
            builder.logType = LogType.Warning
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "[Warning] : A Warning Message")
    }

    func testShouldValidateErrorMessage() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Error Message"
            builder.logType = LogType.Error
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "[Error] : A Error Message")
    }

    func testShouldValidateInformationMessage() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Information Message"
            builder.logType = LogType.Information
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "[Information] : A Information Message")
    }

    func testShouldValidateMessageWithoutLogType() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Message without LogType"
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "A Message without LogType")
    }

    func testShouldValidateMessageWithFileInformation() {
        let messageBuilder = MessageBuilder { builder in
            builder.message = "A Message without LogType"
            builder.fileInformation = FileInformation(file: "Test.swift", line: 55, function: "xablau()")
        }

        let description = Message(messageBuilder: messageBuilder)?.description
        XCTAssertEqual(description, "A Message without LogType FileInformation: File: Test.swift Line Number: 55 Function: xablau()")
    }
}
