# frozen_string_literal: true

# LTEX
class Ltex < Formula
  desc 'LTEX provides offline grammar checking of various markup languages using LanguageTool (LT)'
  homepage 'https://valentjn.github.io/ltex/index.html'

  url 'https://github.com/valentjn/ltex-ls/releases/download/15.2.0/ltex-ls-15.2.0-mac-x64.tar.gz'
  sha256 'd89b547722f165ca2343962065cbe7ee4a832316825b04266d1d2db3e46487b3'
  version '15.2.0'

  def install
    libexec.install Dir['*']
    bin.install_symlink libexec / 'bin/ltex-cli', libexec / 'bin/ltex-ls'
  end

  test do
    system "#{bin}/ltex-ls -v"
  end
end
