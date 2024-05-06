# Must in the IOS Podfile:
# use_frameworks! :linkage => :static

# Based on: https://docs.expo.dev/modules/native-module-tutorial/#example-app-1

#npm install --save-dev jest ???

yarn add expo
npx expo install  react-native
npx expo install  @picovoice/rhino-react-native
npx expo install  @picovoice/react-native-voice-processor
npx expo install   @picovoice/picovoice-react-native
npx expo install   @picovoice/porcupine-react-native

npx expo-doctor
npx expo install --check

# run this to get typscript compliler running:
npm run build

# update version in package.json and ->
# npm publish --access public

# Error:
#[!] Invalid `Podfile` file: 767: unexpected token at ''.
#  from /Users/my-user/Documents/Test/my-app/ios/Podfile:12
#  -------------------------------------------
#  
#>    use_native_modules!
#  end
#  -------------------------------------------

#I fixed this issue on my machine by disabling VS Code's debugger Auto Attach feature. The feature was causing Node to spew extra console output, which the native_modules.rb file could not parse.
#This error could be caused from any number of local configuration issues. So my solution may not work for you. If disabling VS Code Auto Attach doesn't solve it for you, here is how you can investigate more:
#unexpected token at '' is a JavaScript error. If you go to the Ruby file where the error originates (usually ../node_modules/@react-native-community/cli-platform-ios/native_modules.rb), you can see that it is trying to open some JS files from your node_modules using Node. In your terminal, cd to the location of the native_modules.rb file and try to execute the Node commands on your terminal - you may get more clues about what is going on on your system. Good luck.



