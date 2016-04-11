import XCTest
@testable import nayau

class NayauTests: XCTestCase {

    func testSomeDebugLog() {
        Nayau.defaultInstance.debug("teste", logType: LogType.Error)
    }
}

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
}
