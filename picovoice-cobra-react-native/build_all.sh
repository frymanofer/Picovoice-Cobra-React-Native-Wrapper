
npm publish --access public
npx expo run:android
npx expo run:ios

# Error No Java compiler found
# echo "org.gradle.java.home=/Applications/Android\ Studio.app/Contents/jbr/Contents/Home/" >> android/gradle.properties

# Error splashscreen
# comment out splashscreen <!-- <item android:drawable="@color/splashscreen_background"/-->
# add in android/build.gradle
#buildscript {
#    ext {
# NOOOO!!!!       minSdkVersion 		= 19	      // Required minimum
#+       minSdkVersion 		= 28	      //  
#+       targetSdkVersion 	= 34          // Or higher.
#+       compileSdkVersion 	= 34          // Or higher.
#+       appCompatVersion 	= "1.4.2"      // Or higher.  Required for new AndroidX compatibility.
#+       googlePlayServicesLocationVersion = "21.0.1"  // Or higher.
#+       googlePlayServicesLocationVersion = "21.0.1"  // Or higher.
#+        .....
#+        buildToolsVersion = '34.0.0' // findProperty('android.buildToolsVersion') ?: '33.0.0'
#    }
#    repositories {
#        ...
#    }
#    ...
#}
#
#allprojects {   // <-- NOTE:  allprojects container -- If you don't see this, create it.
#    repositories {
#        .
#+       // Required for react-native-background-geolocation
#+       maven { url("${project(':react-native-background-geolocation').projectDir}/libs") }
#+       maven { url 'https://developer.huawei.com/repo/' }
#+       // Required for react-native-background-fetch
#+       maven { url("${project(':react-native-background-fetch').projectDir}/libs") }
#}

# checkout:
#   <!-- <meta-data android:name="com.transistorsoft.locationmanager.license" android:value="YOUR_LICENCE_KEY_HERE" /> -->

# must do https://github.com/transistorsoft/react-native-background-geolocation#large_blue_diamond-setup-guides for react-native-background-geolocation to work with android
# important

# Checkout  this
#    }
#    compileOptions {
#        sourceCompatibility JavaVersion.VERSION_17
#        targetCompatibility JavaVersion.VERSION_17
#    }
#    kotlin {
#        jvmToolchain(17)
#    }

# android crazy errors:
# ./gradlew assembleRelease assembleAndroidTest -DtestBuildType=release
# must change to:
#distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-all.zip
# in file gradle-wrapper.properties

