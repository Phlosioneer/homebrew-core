class Activemq < Formula
  desc "Apache ActiveMQ: powerful open source messaging server"
  homepage "https://activemq.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=/activemq/5.14.3/apache-activemq-5.14.3-bin.tar.gz"
  sha256 "27fe9c00512a29a047f51c3ac4bae3d2c1374e72973aa900083ea05f1c655db8"

  bottle :unneeded

  depends_on :java => "1.6+"

  def install
    rm_rf Dir["bin/linux-x86-*"] unless OS.linux?
    libexec.install Dir["*"]
    (bin/"activemq").write_env_script libexec/"bin/activemq", Language::Java.java_home_env("1.6+")
  end

  plist_options :manual => "activemq start"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>AbandonProcessGroup</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{opt_libexec}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/activemq</string>
          <string>start</string>
        </array>
      </dict>
    </plist>
    EOS
  end

  test do
    system "#{bin}/activemq", "browse", "-h"
  end
end
