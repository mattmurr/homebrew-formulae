# frozen_string_literal: true

# Zig language server
class Zls < Formula
  desc 'Zig LSP implementation + Zig Language Server'
  homepage 'https://github.com/zigtools/zls'

  url 'https://github.com/zigtools/zls.git', using: :git, tag: '0.2.0'

  depends_on 'zig'
  depends_on 'xz'

  def install
    system 'zig', 'build', '-Drelease-fast'
    bin.install 'zig-out/bin/zls'
  end
end
