class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.14.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.0/yeoul_0.14.0_darwin_arm64.tar.gz"
      sha256 "fc3a2cc0df21a78242eb660f51fabbf1c3c6b089658030f2d9005594bb2e71ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.0/yeoul_0.14.0_darwin_amd64.tar.gz"
      sha256 "b590d366fb459f175c361fc7d13cc581f5b9c743685a09a734dd5e0876fdd9f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.0/yeoul_0.14.0_linux_arm64.tar.gz"
      sha256 "f93739c0bc7252085c77e50a9c8d3d22dc5c74912fb1a1d4471d9de9253dcb6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.0/yeoul_0.14.0_linux_amd64.tar.gz"
      sha256 "9160853b256505fe968a440cf4765ef139197c12db091f439c8493d13cbe0adc"
    end
  end

  def install
    libexec.install Dir["*"]

    runtime_env = {}
    if OS.mac?
      runtime_env["DYLD_LIBRARY_PATH"] = libexec/"lib"
    elsif OS.linux?
      runtime_env["LD_LIBRARY_PATH"] = libexec/"lib"
    end

    (bin/"yeoul").write_env_script libexec/"bin/yeoul", runtime_env
    (bin/"yeould").write_env_script libexec/"bin/yeould", runtime_env
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/yeoul help")
  end
end
