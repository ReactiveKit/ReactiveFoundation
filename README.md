# ReactiveFoundation

ReactiveFoundation is a framework from ReactiveKit collection of frameworks that extends NSObject objects with type-safe KVO support and NSNotificationCentar with reactive observing mechanism. Consult ReactiveKit documentation to learn how to work with the Observables it provides.

## Key-Value Observing

```swift
let user = ObjCUserClass()

user.rValueForKeyPath("name").observe { (name: String?) in
  print(name)
}.disposeIn(rBag)

user.rValueForKeyPath("name").bindTo(nameLabel.rText)
```

> Observing KVO-observable will be active as long as the returned disposable is alive. Make sure you store the disposable when using `observe` method on KVO-observable. You don't need to store the disposable when using `bindTo` method. Binding will be automatically disposed when the bindable target (i.e. view) is deallocated.

### NSNotificationCenter

```swift
NSNotificationCenter.defaultCenter().rNotification("MyNotification").observe { notification in
  print("Did receive notificaton \(notification).")
}.disposeIn(rBag)

```

> Make sure you always dispose observation when it's no longer necessary. Simples way it to put the disposable into the disposable bag on the object that has initiated observation.

### rBag

Dispose bag is provided by NSObject and all its subclasses and it is disposed when the object is deallocated. Use this to cleanup your observations.

## Installation

### CocoaPods

```
pod 'ReactiveKit', '~> 1.0'
pod 'ReactiveFoundation', '~> 1.0'
```

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
