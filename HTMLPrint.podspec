Pod::Spec.new do |s|

    s.name                    = "TMEmailHelpers"
    s.version                 = "0.0.4"
    s.summary                 = "Email creation helpers"

    s.homepage                = "http://github.com/hiimtmac/HTMLPrint"
    s.license                 = { :type => "MIT", :file => "LICENSE" }

    s.author                  = "Taylor McIntyre"
    s.social_media_url        = "http://twitter.com/hiimtmac"
    s.ios.deployment_target   = '11.0'
    s.swift_version           = '4.2'

    s.source                  = { :git => "https://github.com/hiimtmac/HTMLPrint", :tag => s.version }
    s.source_files            = "HTMLPrint/**/*.swift"
    s.requires_arc            = true

    s.dependency 'SwiftyMimes'

end
