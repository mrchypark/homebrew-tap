class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.0/yeoul_0.2.0_darwin_arm64.tar.gz"
      sha256 "6d5de5cb933f4b72863965e624338937cbfa83e618d6bd05723435c0b284d124"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.0/yeoul_0.2.0_darwin_amd64.tar.gz"
      sha256 "801a4bc3db1a921fd3a4d699ee4d8ffc65d6af98fd0d09f2ff11a00441e372d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.0/yeoul_0.2.0_linux_arm64.tar.gz"
      sha256 "1b27f566405d86e6ac273981455aad9004ec7423952ef3d3f250efa0d4043013"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.0/yeoul_0.2.0_linux_amd64.tar.gz"
      sha256 "3367e2c06e278d13ae4d7d1bb2634bc0f1412a94dab5cd183065dac9c626bde2"
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
