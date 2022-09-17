#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint wannatalkcore.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'wannatalkcore'
  s.version          = '0.0.25'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'https://wannatalk.ai'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Wannatalk' => 'srikanth.ganji@hotmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'WTExternalSDK', '1.8.1'
  s.platform = :ios, '9.0'


  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
