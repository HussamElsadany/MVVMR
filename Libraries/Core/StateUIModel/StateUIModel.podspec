
Pod::Spec.new do |s|
  s.name             = 'StateUIModel'
  s.version          = '0.1.0'
  s.summary          = 'A short description of StateUIModel.'
  s.description      = "This is our first pod to try breaking our project into smaller modules and reuse it"
  
  s.homepage         = 'https://github.com/elmenus/ios-app.git'
  s.author           = { 'ios-team' => 'ios-team@elmenus.com' }
  s.source           = { :git => 'https://github.com/elmenus/ios-app.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '12.0'
  
  s.source_files = 'StateUIModel/Classes/**/*.*' , 'README.md'
    
  s.dependency 'CoreError'

  
end
