Pod::Spec.new do |s|
  s.name             = "ReactiveFoundation"
  s.version          = "1.0.4"
  s.summary          = "Reactive extensions for NSFoundation framework."
  s.homepage         = "https://github.com/ReactiveKit/ReactiveFoundation"
  s.license          = 'MIT'
  s.author           = { "Srdan Rasic" => "srdan.rasic@gmail.com" }
  s.source           = { :git => "https://github.com/ReactiveKit/ReactiveFoundation.git", :tag => "v1.0.4" }

  s.ios.deployment_target       = '8.0'
  s.osx.deployment_target       = '10.10'
  s.watchos.deployment_target   = '2.0'
  s.tvos.deployment_target      = '9.0'

  s.source_files      = 'ReactiveFoundation/**/*.{h,swift}'
  s.requires_arc      = true

  s.dependency 'ReactiveKit'
end
