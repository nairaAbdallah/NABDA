platform :ios, '12.0'

target 'GraduationProj' do
  use_frameworks!

  # Pods for GraduationProj
  
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
 
  pod 'IQKeyboardManagerSwift'
  
  
  # ignore all warnings from all pods
  inhibit_all_warnings!

  # ignore warnings from a specific pod


  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
     config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
     config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
   end
  end

 
end
