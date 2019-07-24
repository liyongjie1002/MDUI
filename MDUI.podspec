# 官网 https://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name             = 'MDUI'
  s.version          = '0.0.1'
  s.summary          = 'MDUI for iOS'
  s.description      = <<-DESC
                        致力于提高项目 UI 开发效率的解决方案
                       DESC

  s.homepage         = 'https://github.com/Iyongjie/MDUI.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iyongjie@yeah.net' => 'yj.li@muheda.com' }
  s.source           = { :git => 'https://github.com/Iyongjie/MDUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.source_files = 'MDUI/Test/*.{h,m}'

end
