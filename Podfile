# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'EnjoeiTest' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    inhibit_all_warnings!
    
    # Pods for EnjoeiTest
    pod 'INSPullToRefresh'
    pod 'Cartography'
    pod 'Kingfisher'
    pod 'RxSwift'
    pod 'RxCocoa'
    
    swift4 = ['Cartography', 'Kingfisher']
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            #https://github.com/fastred/Optimizing-Swift-Build-Times#whole-module-optimization-for-cocoapods
            target.build_configurations.each do |config|
                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
                    config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
                end
                config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
            end
            
            swift_version = nil
            
            if swift4.include?(target.name)
                swift_version = '4.1'
            end
            
            if swift_version
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = swift_version
                end
            end
        end
    end
end

target 'EnjoeiTestUITests' do
    inherit! :search_paths
    # Pods for testing
end
