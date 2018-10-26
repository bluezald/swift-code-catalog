# Swift Code Catalog

is a collection of common functionalities in iOS applications, bundle together to form a 'sort-of' catalog for easy viewing and easy copy-pasting to your projects. 

[![GitHub](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.com/bluezald/swift-code-catalog.svg?branch=master)](https://travis-ci.com/bluezald/swift-code-catalog)


# Standard Xcode Project

This will consist an Xcode project with an iPhone Application (primarily and hopefully will add iPad support), categorised into different patterns such as tableview, camera, collection and more. (Will work on how this project is organized).

The goal of this project is to focus purely on the Apple API and to not depend on any third-party.

<mark>Note: Im integrating [swiftlint](https://github.com/realm/SwiftLint) to force a cleaner code</mark>

Directory Structure:
```
Standard Catalog
|- Shared - common helper code, datasources, etc.
|- Fundamentals - Foundation classes, playgrounds and code snippets
|- UIKit - TableViews, CollectionViews, Animations
|- AppServices - Contacts, EventKit, MapKit
|- Networking - URLSession
|- Caching - UserDefaults, NSCache, Core Data
|- Security - Keychain Services?
```


# Reactive Xcode Project

This will consist also a reactive version of the standard catalog

# App Extensions Catalog

An app extension lets you extend custom functionality and content beyond your app and make it available to users while they’re interacting with other apps or the system. Under this repo also, are multiple projects previewing iOS app extensions.

| Extension point                               | Typical app extension functionality                                                                                                                                                                                                                                                                       |
|-----------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Action                                        | Manipulate or view content originating in a host app.                                                                                                                                                                                                                                                     |
| Audio Unit                                    | Generates an audio stream to send to a host app, or modifies an audio stream from a host app and sends it back to the host app.                                                                                                                                                                           |
| Broadcast UI                                  |                                                                                                                                                                                                                                                                                                           |
| Broadcast Upload                              |                                                                                                                                                                                                                                                                                                           |
| Call Directory                                | Identify and block incoming callers by their phone number. To learn more, see CallKit Framework Reference.                                                                                                                                                                                                |
| Content Blocker                               | Indicate to WebKit that your content-blocking app has updated its rules. (This app extension has no user interface.)                                                                                                                                                                                      |
| Custom Keyboard                               | Replace the iOS system keyboard with a custom keyboard for use in all apps.                                                                                                                                                                                                                               |
| Document Provider                             | Provide access to and manage a repository of files.                                                                                                                                                                                                                                                       |
| Game App                                      | Provide a game app for Apple Watch, as described in App Programming Guide for watchOS. (The Game App template is a version of the WatchKit App template, configured for game content.)                                                                                                                    |
| iMessage                                      | Interact with the Messages app. To learn more, see Messages.                                                                                                                                                                                                                                              |
| Intents                                       | Handle tasks related to supporting Siri integration with your app. To learn more, see SiriKit Programming Guide.                                                                                                                                                                                          |
| Intents UI                                    | Customize the Siri or Maps interface after handling a task related to supporting Siri integration with your app. To learn more, see SiriKit Programming Guide.                                                                                                                                            |
| Notification Content and Notification Service |                                                                                                                                                                                                                                                                                                           |
| Photo Editing                                 | Edit a photo or video within the Photos app.                                                                                                                                                                                                                                                              |
| Spotlight Index                               | Index content within your app while it isn’t running. To learn more, see Index App Content.                                                                                                                                                                                                               |
| Share                                         | Post to a sharing website or share content with others.    

See full list [here](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/)

## Code Snippets

For short code snippets, i'll be constructing this one to a more categorized collections. From common design patterns to common table view code, alert controller, etc.

![Code Snippets](https://raw.githubusercontent.com/bluezald/swift-code-catalog/master/Documentation/Resources/snippets-preview.png)

Right now, the code snippets are in random, but I find using this small codes throughout my development. I'll be refining them, and if I see code snippets that can belong to utility classes, then I'll remove it from the snippets and add it accordingly to a class in a standard catalog.

Todo: Design Patterns code snippets will be in the Design Patterns repo

Usage:
Add Snippets to your: ~/Library/Developer/Xcode/UserData/CodeSnippets
