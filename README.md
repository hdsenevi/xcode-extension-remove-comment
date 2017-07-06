# xcode-extension-remove-comment
Xcode Source Editor Extension to remove the comments of a file

## Installation

1. Enable target signing for both the Application and the Source Code Extension using your own developer ID
* Product > Archive
* Right click archive > Show in Finder
* Right click archive > Show Package Contents
* Open Products, Applications
* Drag Swift Initializer Generator.app to your Applications folder
* Run Swift Initializer Generator.app and exit again.
* Go to System Preferences -> Extensions -> Xcode Source Editor and enable the extension
* The menu-item should now be available from Xcode's Editor menu.

## Known limitations

* It will only parse comments that starts with '//' only
* Comments starting with '/*' and ending with '*/' is not parsed at the moment
