

Pod::Spec.new do |s|
  s.name             = 'KFXLocation'
  s.version          = '0.7.0'
  s.summary          = 'KFXLocation pod'
  s.description      = <<-DESC
CoreLocation wrapper / helpers.
                       DESC

  s.homepage         = 'https://github.com/ChristianFox/KFXLocation.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ChristianFox' => 'christianfox890@icloud.com' }
  s.source           = { :git => 'https://github.com/ChristianFox/KFXLocation.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'KFXLocation/Classes/**/*'
  s.dependency 'KFXAdditions'
  s.dependency 'KFXCore'

end
