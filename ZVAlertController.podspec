#
#  Be sure to run `pod spec lint ZVAlertController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  s.name              = "ZVAlertController"
  s.version           = "0.0.1"
  s.summary           = "A pure swift alert"
  s.swift_version     = '5.0'

  s.description  = <<-DESC
                   ZVAlertController is a custom swift alert controller
                   DESC

  s.homepage     = "https://github.com/zevwings/ZVAlertController"
  s.license      = "Apache"
  s.author       = { "zevwings" => "zevwings@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/zevwings/ZVAlertController.git", :tag => "#{s.version}" }
  s.source_files = "ZVAlertController/**/*.swift", "ZVAlertController/ZVAlertController.h"
  s.resources    = "ZVAlertController/*.xcassets", "ZVAlertController/*.xib"
  s.requires_arc = true

end
