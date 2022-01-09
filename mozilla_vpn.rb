# frozen_string_literal: true

# Mozilla VPN client
cask 'mozilla_vpn' do
  version '2.6.1'
  sha256 '8d5d6124b1dc00cbfc443ab8344a5a458e46b54b7807a7e5c7becd73f6d42bfa'

  url "https://archive.mozilla.org/pub/vpn/releases/#{version.csv.first}/mac/MozillaVPN.pkg"
  name 'MozillaVPN'
  desc 'A Virtual Private Network from the makers of Firefox'
  homepage 'https://www.mozilla.org/en-GB/products/vpn'

  auto_updates true

  pkg 'MozillaVPN.pkg'

  uninstall quit: 'org.mozilla.macos.FirefoxVPN'
end
