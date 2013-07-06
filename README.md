Photo Selection Tools v.0.1
=====================

This library was created as an alternative to UIImagePickerController. There are some limitations with that. Specifically, you can't use it in an existing UINavigationController in a UIPopoverController on the iPad. So I had to roll my own. 

_This is a bit of a work in progress._ It has not been thoroughly tested or used in a production environment yet. If you find any issues or problems, please file a github issue or make a pull request and I'll deal with it promptly.

Integration
-----------
First, this requires a deployment target of iOS 6.0 or greater. If your app still targets iOS 5, I'm sorry. You need a better product or project manager. People who still have iOS 5 on their phone don't deserve nice things. 

Apple has far better instructions than I could ever write on how to integrate a static library [here]
(http://developer.apple.com/library/ios/#technotes/iOSStaticLibraries/Articles/configuration.html#//apple_ref/doc/uid/TP40012554-CH3-SW1).

You will also probably need to link against the AssetsLibrary.framework as well. 
Usage
-----
There are three core classes, and they are some what documented in the code. Pretty much everything can be subclassed, and the view controllers can have their default cells set for custom UI. The default UI is very bare-bones.


**MDSAssetsController** This can be used to interact with the ALAssetsLibrary. If you're just creating a basic picker then you probably won't need it, as it will just be used by the other classes.

**MDSAlbumsViewController** This view controller feeds up a table view which allows the user to select a ALAssetsGroup, in other words a photo album. There is no behavior when the user selects a group, other than calling the view controller's delegate. You are responsible for doing something, such as pushing the photo selector on screen. 

**MDSPhotoSelectViewController** This feeds up a UICollectionView which allows the user to select a photo / asset in the provided ALAssetsGroup. The default selection behavior does nothing other than call back to the delegate. You are responsible for handling any subsequent behavior, i.e. popping views off a UINavigationController.

License - MIT
-------------
Copyright © 2013 Mobile Data Solutions, Inc.

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

