# ReactiveKit

__ReactiveKit__ is a collection of Swift frameworks for reactive and functional reactive programming.

* [ReactiveKit](https://github.com/ReactiveKit/ReactiveKit) - A core framework that provides cold Stream and hot ActiveStream types and their derivatives -  Operation, Observable and ObservableCollection types.
* [ReactiveFoundation](https://github.com/ReactiveKit/ReactiveFoundation) - Foundation framework extensions like type-safe KVO.
* [ReactiveUIKit](https://github.com/ReactiveKit/ReactiveUIKit) - UIKit extensions (bindings).

## ReactiveFoundation
### KVO

```swift
let user = ObjCUserClass()

user.rValueForKeyPath("name").observe { (name: String?) in
  print(name)
}

user.rValueForKeyPath("name").bindTo(nameLabel.rText)
```

### NSNotificationCenter


```swift
NSNotificationCenter.defaultCenter().rNotification("MyNotification").observe { notification in
  print("Did receive notificaton \(notification).")
}.disposeIn(rBag)

```

### rBag

Dispose bag is provided by any NSObject subclass and it is disposed when the object is deallocated. Use it to cleanup your observers.


## Installation

### Carthage

```
github "ReactiveKit/ReactiveKit" 
github "ReactiveKit/ReactiveFoundation"
```


## License

The MIT License (MIT)

Copyright (c) 2015 Srdan Rasic (@srdanrasic)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.