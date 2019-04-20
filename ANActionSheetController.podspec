Pod::Spec.new do |s|
  s.name             = 'ANActionSheetController'
  s.version          = '1.1.0'
  s.summary          = 'ANActionSheetController is a highly customizable UIAlertController replica, looks like built-in action sheet, works on iPad too.'
  s.swift_version = '5.0'

  s.description      = <<-DESC
ANActionSheetController is a highly customizable UIAlertController replica, looks like built-in action sheet, works on iPad too. It's -almost- all atrributes, buttons etc. are customizable.
                       DESC

  s.homepage         = 'https://github.com/anelad/ANActionSheetController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arda Oğul Üçpınar' => 'info@ardaucpinar.com' }
  s.source           = { :git => 'https://github.com/anelad/ANActionSheetController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ArdaUcpinar'

  s.ios.deployment_target = '9.0'
  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }

  s.source_files = 'ANActionSheetController/Source/**/*'
end
