Pod::Spec.new do |s|
    s.name             = 'picovoice-cobra-react-native'
    s.version          = '1.0.0'
    s.summary          = 'A short description of picovoice-cobra-react-native.'
    s.description      = <<-DESC
                         A longer description of picovoice-cobra-react-native.
                        DESC
    s.homepage         = 'http://EXAMPLE/picovoice-cobra-react-native'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Your Name' => 'you@example.com' }
    s.source           = { :git => 'https://github.com/username/picovoice-cobra-react-native.git', :tag => s.version.to_s }
    s.platform         = :ios, '10.0'
    s.source_files     = 'ios/**/*.{h,m,swift}'
    s.requires_arc     = true
  
    s.dependency 'React'
  end
  