

Pod::Spec.new do |s|
  s.name             = 'KFXLocation'
  s.version          = '0.2.0.0'
  s.summary          = 'KFXLocation pod'


  s.description      = <<-DESC
Location Tracker (manager), helper methods
                       DESC

  s.homepage         = 'https://kfxtech@bitbucket.org/kfx_pods/kfxlocationmanager.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ChristianFox' => 'christianfox890@icloud.com' }
  s.source           = { :git => 'https://kfxtech@bitbucket.org/kfx_pods/kfxlocationmanager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'KFXLocation/Classes/**/*'
  s.dependency 'KFXAdditions'
  s.dependency 'KFXUtilities'

end
