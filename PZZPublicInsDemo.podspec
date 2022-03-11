#
# Be sure to run `pod lib lint PZZPublicInsDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PZZPublicInsDemo'
  s.version          = '0.1.3'
  s.summary          = 'VideoSDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  PZZPublicDemo is VideoSDK
                       DESC

  s.homepage         = 'https://github.com/pzz819816/PZZPublicInsDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pzz819816' => '907104252@qq.com' }
  s.source           = { :git => 'https://github.com/pzz819816/PZZPublicInsDemo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.vendored_frameworks = 'PZZPublicInsDemo/Classes/*.framework'
   #自己的framework在工程中的路径
  
 # s.resource_bundles = ['PZZPublicInsDemo/Assets/WWResource.bundle']

 # s.resource_bundles = {
 #   'PZZResources' => ['PZZPublicInsDemo/Assets/WWResource.bundle']
 # }#资源文件的路径，会在pod中创建“Resources”的文件夹


    s.resources = 'PZZPublicInsDemo/Assets/*.bundle'

  #s.source_files = 'PZZPublicInsDemo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PZZPublicInsDemo' => ['PZZPublicInsDemo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 4.0.1'
end
