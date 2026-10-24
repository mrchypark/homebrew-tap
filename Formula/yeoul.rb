class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.0/yeoul_0.11.0_darwin_arm64.tar.gz"
      sha256 "7bb924937447a1f19437ec8dc164ee9a24eb6435610d25e6932ed92b062b2e02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.0/yeoul_0.11.0_darwin_amd64.tar.gz"
      sha256 "a83e835f967f35db1d8ae290b0d81bdddfc614a9eea0dc897029441cb12a3e23"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.0/yeoul_0.11.0_linux_arm64.tar.gz"
      sha256 "59515a59b04cc36946754768c110421cde597b35e86b21e0b7291bae8ff843ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.11.0/yeoul_0.11.0_linux_amd64.tar.gz"
      sha256 "8bb3853214d7de9a0e42f8624c4a1f2d721638c38d7a91fe58b2720a66b8471f"
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
