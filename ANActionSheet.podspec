Pod::Spec.new do |s|
  s.name             = 'ANActionSheet'
  s.version          = '1.0.0'
  s.summary          = 'ANActionSheet is a highly customizable UIAlertController replica, looks like built-in action sheet, works on iPad too.'

  s.description      = <<-DESC
ANActionSheet is a highly customizable UIAlertController replica, looks like built-in action sheet, works on iPad too.
It's -almost- all atrributes, buttons etc. are customizable.
                       DESC

  s.homepage         = 'https://github.com/anelad/ANActionSheet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arda Oğul Üçpınar' => 'info@ardaucpinar.com' }
  s.source           = { :git => 'https://github.com/anelad/ANActionSheet.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ArdaUcpinar'

  s.ios.deployment_target = '11.0'
  s.platform = :ios, '11.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }

  s.source_files = 'ANActionSheet/Source/**/*'

end
