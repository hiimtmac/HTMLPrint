Pod::Spec.new do |s|

    s.name                    = 'HTMLPrint'
    s.version                 = '0.1.0'
    s.summary                 = 'Email creation helpers'

    s.homepage                = 'http://github.com/hiimtmac/HTMLPrint'
    s.license                 = { :type => 'MIT', :file => 'LICENSE' }

    s.author                  = 'Taylor McIntyre'
    s.social_media_url        = 'http://twitter.com/hiimtmac'
    s.ios.deployment_target   = '13.1'
    s.swift_version           = '5.2'

    s.source                  = { :git => 'https://github.com/hiimtmac/HTMLPrint.git', :tag => s.version }
    s.source_files            = 'Sources/HTMLPrint/**/*.swift'
    s.framework               = 'UIKit'
    s.requires_arc            = true

end
