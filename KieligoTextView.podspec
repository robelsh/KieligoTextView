Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "KieligoTextView"
s.summary = "KieligoTextView is a custom textview for Kieligo iOS App"
s.requires_arc = true

s.version = "0.1.1"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Etienne Jézéquel" => "etienne.jezequel@gmail.com" }

s.homepage = "https://github.com/robelsh/KieligoTextView"

s.source = { :git => "https://github.com/robelsh/KieligoTextView.git",
             :tag => "#{s.version}" }

s.framework = "UIKit"
s.dependency 'RxSwift'
s.dependency 'RxCocoa'

s.source_files = "KieligoTextView/**/*.{swift}"

s.swift_version = "5"

end
