#Nayau
*A production/debug logger for you Swift Project*

## Requirements
- iOS 8+
- Xcode 7.1+

## Instalation
Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).

## Getting started
#### Intitialization
```swift
import nayau

Nayau.sharedInstance.debug("A debug message")

Nayau.sharedInstance.production("A production message")
```

## Why Nayau?
Sometimes, we (developers) need to debug our developing applications, with that in mind, we build a simple tool that can help you with your debug/production log. When you need to print some information/data just for test/follow flow of your application, use `debug` instance method from Nayau, when you need to print something in released apps, use `production` instance method from Nayau. Quite simple :)
