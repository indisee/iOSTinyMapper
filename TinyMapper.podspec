Pod::Spec.new do |s|
  s.name                    = "TinyDictMapper"
  s.version                 = "0.0.1"
  s.summary                 = "Simple lightweight mapper class for ios"
  s.homepage                = "http://2tickets2dublin.com"
  s.license                 = 'MIT'
  s.author                  = { "Segey Maletin" => "in.disee@gmail.com" }
  s.source                  = { :git => "https://github.com/indisee/iOSTinyMapper", :tag => 'v..1'}
  s.platform                = :ios, '5.0'
  s.requires_arc            = true
      
  s.source_files            = 'scr/TinyMappingModel/*.{h,m}'
  s.public_header_files     = 'scr/TinyMappingModel/*.h'
  s.frameworks              = 'Foundation'
end