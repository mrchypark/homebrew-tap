class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.1/yeoul_0.7.1_darwin_arm64.tar.gz"
      sha256 "b89b4262a8a943650aef5d5c02ea584377dc61b9f82fd625f013e60576e29bd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.1/yeoul_0.7.1_darwin_amd64.tar.gz"
      sha256 "ce62d8d2071238438a9a42f872e6d35e2c678cef8cb059ff9e20b26acd652e75"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.1/yeoul_0.7.1_linux_arm64.tar.gz"
      sha256 "3984951626b0dd826d35c3ff4e0c2154d83cec3cfb4786140102895d15d38458"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.1/yeoul_0.7.1_linux_amd64.tar.gz"
      sha256 "6e2a091a4b1160a6b94700f861f78dda23b7f4f07ff55e71b0bb4da5f3e1edf3"
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
