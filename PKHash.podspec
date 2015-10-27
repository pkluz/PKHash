Pod::Spec.new do |s|
    s.name                = "PKHash"
    s.version             = "0.0.1"
    s.summary             = "Simple and configurable interface to CommonCrypto's hash mechanics."
    s.description         = "Makes hashing data very easy. Fully configurable with the user being in charge."
    s.homepage            = "http://github.com/pkluz/PKAES"
    s.license             = "MIT"
    s.author              = "Philip Kluz"
    s.source              = { :git => "https://github.com/pkluz/PKHash.git", :tag => "v#{s.version}" }
    s.requires_arc        = true
    s.platform            = :ios, "8.0"
    s.source_files        = "PKHash/**/*.{h,m}"
end
