class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.0/yeoul_0.4.0_darwin_arm64.tar.gz"
      sha256 "1dfff6a9d5f9374d8a45156cc5832aeb596e368f5e09d45b6d36d92fddee3e52"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.0/yeoul_0.4.0_darwin_amd64.tar.gz"
      sha256 "73a9752bd9e166fc15881c38c42849483a823d54cf51107af8f0798d652d1d56"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.0/yeoul_0.4.0_linux_arm64.tar.gz"
      sha256 "1cf5512862058e49eef3fd113dc4db0ad2845544fe71eb1f4e301698238360a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.4.0/yeoul_0.4.0_linux_amd64.tar.gz"
      sha256 "c47081953d9af7bb8c10ac5f1e784f1cca226a56617674b610a4263add7b8fe7"
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
