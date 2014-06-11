Pod::Spec.new do |s|
  s.name                    = "TinyMapper"
  s.version                 = "0.0.1"
  s.summary                 = "Simple lightweight mapper class for ios"
  s.homepage                = "http://2tickets2dublin.com"
  s.author                  = { "Segey Maletin" => "in.disee@gmail.com" }
  s.source                  = { :git => "https://github.com/indisee/iOSTinyMapper.git", :tag => "v0.0.1" }
  s.platform                = :ios, '5.0'
  s.requires_arc            = true

  s.license      = { :type => 'WTFPL', :text => <<-LICENSE
    DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
                    Version 2, December 2004 

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO.
    LICENSE
  }
      
  s.source_files            = 'src/TinyMappingModel/*.{h,m}'
  s.public_header_files     = 'src/TinyMappingModel/*.h'
  s.frameworks              = 'Foundation'
end