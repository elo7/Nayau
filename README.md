#Nayau
*A production/debug logger for you Swift Project*

## Requirements
- iOS 11.0+
- Swift 5.0
- Xcode 8.0+

## Instalation
Embedded frameworks require a minimum deployment target of iOS 11.

### Carthage
```
github "elo7/nayau" "master"
```

And add the path to the framework under “Input Files”, e.g.:

```
$(SRCROOT)/Carthage/Build/iOS/nayau.framework
```

### Swift Package Manager (SPM)

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. To integrate using Apple's Swift package manager from xcode :

File -> Add Packages... -> Enter package URL : https://github.com/elo7/Nayau, choose the latest release

## Getting started
First of all, you shall setup your debug/release flags, it's quite simple. "Set it in the Swift Compiler - Custom Flags section, 'Other Swift Flags' line. Just Add `-D DEBUG`. If you are having problems with that, look [that Stack Overflow question](http://stackoverflow.com/questions/24111854/in-absence-of-preprocessor-macros-is-there-a-way-to-define-practical-scheme-spe).

And paste that code block in your setup area, it's the simple way that we found to know if your applications is in debug or release mode.
```swift
func isDebug() -> Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
}
```

Finally you can setup your Nayau:
```swift
import nayau

Nayau.setup(debugBuild: YourClass().isDebug())

Nayau.debug("A debug message")
#=> A debug message 

Nayay.debug("A error message in debug mode", logType: LogType.Error)
#=> [Error] : A error message in debug mode

Nayau.production("A production message")
#=> A production message 

Nayau.production("A error message in production mode", logType: LogType.Error) {
#=> [Error] : A error message in production mode
```

### Enable file information
If you want to see file that logging information, just enable that in the Nayau setup method:
```swift
import nayau

Nayau.setup(enableFileName: true, debugBuild: YourClass().isDebug())

Nayau.debug("A debug message")
#=> A debug message FileInformation: File: yourPath/YourFile.swift Line Number: 61 Function: xablau()

Nayau.production("A production message")
#=> A production message FileInformation: File: yourPath/YourFile.swift Line Number: 61 Function: xablau()
```

### Compute information in Debug
If you want to compute something heavy to process, you can use Nayau with trailing closure, and that heavy compute will execute just in debug:
```swift
Nayau.debug {
    let xablau = [ "this" , "message" , "concat" , "is" , "just" , "necessary" , "in" , "debug" , "mode" ]

    return xablau.map {
        $0.uppercaseString
    }
}
```

## Why Nayau?
Sometimes, we (developers) need to debug our developing applications, with that in mind, we built a simple tool that can help you with your debug/production log. When you need to print some information/data just for test/follow flow of your application, use `debug` instance method from Nayau, when you need to print something in released apps, use `production` instance method from Nayau. Quite simple :)

## Contribute
- If you **found a bug**, open an issue.
- If you ***have a feature request***, open an issue.
- If you ***want to contribute***, submit a pull request

## License
Nayau is released under the MIT license. See LICENSE for details.
