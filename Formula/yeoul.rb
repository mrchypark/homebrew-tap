class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.6.0/yeoul_0.6.0_darwin_arm64.tar.gz"
      sha256 "a6fdc746507604d9384651e007ca2f05e2ce84605b2cff0e82340829a67a2621"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.6.0/yeoul_0.6.0_darwin_amd64.tar.gz"
      sha256 "170c17857174551b236633bb3bca8c46eab086729b0d7cd7f95c83193aabdab6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.6.0/yeoul_0.6.0_linux_arm64.tar.gz"
      sha256 "013d52315ec1d9e7e2f3d8025e088ef15951ba772403765257186fb1bf8f2082"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.6.0/yeoul_0.6.0_linux_amd64.tar.gz"
      sha256 "dd76cbc9470154574793e3a2042c82892159c586a318144481a7f554d85a1db3"
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
