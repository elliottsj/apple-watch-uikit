def shared_pods
  pod 'React', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTText', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTImage', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTNetwork', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTSettings', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTWebSocket', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'
  pod 'React/RCTLinkingIOS', :git => 'https://github.com/elliottsj/react-native.git', :branch => '0.11-stable'  
end

target 'UIKitWatch' do
  platform :ios, '9.0'
  shared_pods
end

# target 'UIKitWatch WatchKit Extension' do
#   platform :watchos, '2.0'
#   shared_pods
# end

target 'WatchApp' do
  platform :watchos, '2.0'
  shared_pods
end
