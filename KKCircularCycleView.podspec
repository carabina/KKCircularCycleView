

Pod::Spec.new do |s|

  s.name         = "KKCircularCycleView"

  s.version      = "0.0.1"

  s.summary      = "Three circle rotation animation, like UC."

  s.description  = <<-DESC
 Three circle rotation animation, like UC. 三个圆圈转动动画，类似UC
                   DESC

  s.homepage     = "https://github.com/TieShanWang/KKCircularCycleView"

  s.license      = "MIT"

  s.author       = { "wangtieshan" => "15003836653@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/TieShanWang/KKFingerprintVarify.git", :tag => "0.0.1" }

  s.source_files  = "KKCircularCycleView/KKCircularCycleView.swift

  s.framework  = "UIKit"

 s.requires_arc = true

end
