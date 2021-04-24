# chmod +x generate-ios.sh
# ./generate-ios.sh
flutter clean

flutter build ios --release -t lib/main.dart

mkdir -p Payload

mv ./build/ios/iphoneos/Runner.app Payload

zip -r -y Payload.zip Payload/Runner.app

mv Payload.zip Payload.ipa

rm -Rf Payload

# Open Xcode
# Go to windows tab 
# Select device and simulator
# Connect real device
# Click on + button
# Wait fot installation.


#env setups
#flutter run -t lib/dev_main.dart
#flutter build -t lib/dev_main.dart



# flutter run -d macos