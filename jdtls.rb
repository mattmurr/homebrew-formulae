# frozen_string_literal: true

# Eclipse JDT Language Server
class Jdtls < Formula
  desc 'The Eclipse JDT Language Server is a Java language specific implementation of the Language Server Protocol'
  homepage 'https://github.com/eclipse/eclipse.jdt.ls'

  url 'https://download.eclipse.org/jdtls/milestones/1.7.0/jdt-language-server-1.7.0-202112161541.tar.gz'
  sha256 '2f0c28dfec317a268ec44904420657181b43a7ba2a32f0bf788ea388dacb8552'
  version '1.7.0'

  resource 'lombok' do
    url 'https://projectlombok.org/downloads/lombok.jar'
    sha256 'ecef1581411d7a82cc04281667ee0bac5d7c0a5aae74cfc38430396c91c31831'
    version '1.18.22'
  end

  option 'with-lombok', 'With project lombok'

  def install
    lombok = build.with? 'lombok'
    lombok && resource('lombok').stage { (share / 'lombok').install 'lombok.jar' }

    rm_rf 'config_linux'
    rm_rf 'config_win'
    libexec.install %w[config_mac features plugins]

    (bin / 'jdtls').write <<~SCRIPT
      #!/bin/sh

      if ! command -v java >/dev/null; then
        echo "java executable could not be found"
        exit
      fi

      JDTLS_HOME='#{libexec}'
      JDTLS_LAUNCHER=$(find $JDTLS_HOME -name 'org.eclipse.equinox.launcher_*.jar')
      java \
        -Declipse.application=org.eclipse.jdt.ls.core.id1 \
        -Dosgi.bundles.defaultStartLevel=4 \
        -Declipse.product=org.eclipse.jdt.ls.core.product \
        -Dlog.protocol=true \
        -Dlog.level=ALL \
        -Xms1g \
        -Xmx2G \
        #{lombok && "-javaagent:#{share}/lombok/lombok.jar"} \
        --add-modules=ALL-SYSTEM \
        --add-opens java.base/java.util=ALL-UNNAMED \
        --add-opens java.base/java.lang=ALL-UNNAMED \
        -jar $JDTLS_LAUNCHER \
        -configuration $JDTLS_HOME/config_mac \
        -data $HOME/.workspace$(pwd) \
        $@
    SCRIPT
  end
end
