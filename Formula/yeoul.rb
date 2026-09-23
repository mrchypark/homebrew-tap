class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.8.0/yeoul_0.8.0_darwin_arm64.tar.gz"
      sha256 "b317ff5abb0873faa34a255653d6cfce5f0ad72cfbab8698086b1327291ea4fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.8.0/yeoul_0.8.0_darwin_amd64.tar.gz"
      sha256 "5c863ebda74c8ed105b9b016a5ec00478701518cf6e988b79387da19d594ba69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.8.0/yeoul_0.8.0_linux_arm64.tar.gz"
      sha256 "243388af1cef11dfa46ae8b1343893bb61e98df66a6f44def6f6740e6c81a44b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.8.0/yeoul_0.8.0_linux_amd64.tar.gz"
      sha256 "348d2c82e1f01bd3c06121ea118ed459bf147fc9c22a4c414a8e1a6a73c28c2c"
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
