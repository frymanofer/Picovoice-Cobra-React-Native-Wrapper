# picovoice-cobra-react-native

Cobra for React Native

# API documentation

- [Documentation for the main branch](https://github.com/expo/expo/blob/main/docs/pages/versions/unversioned/sdk/picovoice-cobra-react-native.md)
- [Documentation for the latest stable release](https://docs.expo.dev/versions/latest/sdk/picovoice-cobra-react-native/)

# Installation in managed Expo projects

For [managed](https://docs.expo.dev/archive/managed-vs-bare/) Expo projects, please follow the installation instructions in the [API documentation for the latest stable release](#api-documentation). If you follow the link and there is no documentation available then this library is not yet usable within managed projects &mdash; it is likely to be included in an upcoming Expo SDK release.

# Installation in bare React Native projects

For bare React Native projects, you must ensure that you have [installed and configured the `expo` package](https://docs.expo.dev/bare/installing-expo-modules/) before continuing.

### Add the package to your npm dependencies

```
npm install picovoice-cobra-react-native
```

### Configure for iOS

Run `npx pod-install` after installing the npm package.


### Configure for Android

### Usage 

Install the Latest Version: Ensure you have the latest version by using NPM, Yarn, or another package manager of your choice.

API Usage:
setCobra(timeInSeconds): Accepts a string representing the timeframe in seconds for checking human voice presence. For example, setCobra("60") configures the system to check every minute. Consequently, getCobra() will then return the highest probability of detecting human voice within each minute.
stopCobra(): Stops the detection process and releases all associated resources.

Run the Application:
It is recommended to use Expo, as this SDK was developed with Expo modules.
Begin by preparing your project with the following commands:

npx expo prebuild

To run your application:
npx expo run:ios
npx expo run:android

These commands facilitate the development and testing of your application across different platforms, ensuring that the SDK functions as expected.

# Contributing

Contributions are very welcome! Please refer to guidelines described in the [contributing guide]( https://github.com/expo/expo#contributing).
