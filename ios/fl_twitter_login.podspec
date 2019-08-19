#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'fl_twitter_login'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin foir login with Twitter.'
  s.description      = <<-DESC
Authh users using twitter
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'couch' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'TwitterKit'
  s.dependency 'TwitterCore'
  s.ios.deployment_target = '10.1'
  s.swift_version = '4.0'
end

