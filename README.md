#Nayau
*A production/debug logger for you Swift Project*

## Requirements
- iOS 8+
- Xcode 7.1+

## Instalation
Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).

### Carthage
```
github "elo7/nayau" "master"
```

And add the path to the framework under “Input Files”, e.g.:

```
$(SRCROOT)/Carthage/Build/iOS/nayau.framework
```


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
#=> [Debug] : A debug message 

Nayau.production("A production message")
#=> [Production] : A production message 
```

### Enable file information
If you want to see file that logging information, just enable that in the Nayau setup method:
```swift
import nayau

Nayau.setup(enableFileName: true, debugBuild: YourClass().isDebug())

Nayau.debug("A debug message")
#=> [Debug] : A debug message FileInformation: File: yourPath/YourFile.swift Line Number: 61 Function: xablau()

```

## Why Nayau?
Sometimes, we (developers) need to debug our developing applications, with that in mind, we build a simple tool that can help you with your debug/production log. When you need to print some information/data just for test/follow flow of your application, use `debug` instance method from Nayau, when you need to print something in released apps, use `production` instance method from Nayau. Quite simple :)

## Contribute
- If you **found a bug**, open an issue.
- If you ***have a feature request***, open an issue.
- If you ***want to contribute***, submit a pull request

## License
Nayau is released under the MIT license. See LICENSE for details.
