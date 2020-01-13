#
# Be sure to run `pod lib lint DYBadgeButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DYModalNavigationController'
  s.version          = '1.2.1'
  s.summary          = 'UINavigationController subclass with support for custom size and present and dismiss animations.'
  s.swift_version = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    UINavigationController subclass that supports setting a custom size and slide in/out and fade in/out animations.
    Presented over the "current context".
                       DESC

  s.homepage         = 'https://github.com/DominikButz/DYModalNavigationController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dominikbutz' => 'dominikbutz@gmail.com' }
  s.source           = { :git => 'https://github.com/DominikButz/DYModalNavigationController.git', :tag => s.version.to_s }


  s.ios.deployment_target = '11.0'

  s.source_files = 'DYModalNavigationController/**/*'
  s.exclude_files = 'DYModalNavigationController/**/*.plist'


  s.public_header_files = 'DYModalNavigationController/**/*.h'

end
