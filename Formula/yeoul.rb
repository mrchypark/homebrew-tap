class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.9.0/yeoul_0.9.0_darwin_arm64.tar.gz"
      sha256 "21fc12003c7ee4ba8f12867eae9f71eb281bce6d4d3712fce1dbc755b10e6e11"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.9.0/yeoul_0.9.0_darwin_amd64.tar.gz"
      sha256 "320ee93d8b032b672a94f4a926b49d97e61f9b89880be1a1d2d8c1b340bafa53"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.9.0/yeoul_0.9.0_linux_arm64.tar.gz"
      sha256 "8831c78133263c1d5cf15d265911aabc85c53b56daa23af90b161cea602f5a36"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.9.0/yeoul_0.9.0_linux_amd64.tar.gz"
      sha256 "af1f5a5fc74f2aec76e16a85c1453f3a4fb99a758c62016eff0a1314cb3a3961"
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
