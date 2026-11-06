class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.14.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.1/yeoul_0.14.1_darwin_arm64.tar.gz"
      sha256 "0ad660a0460c503b23a73603b56de6bfe3778a2b52194eff6e23b431759303bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.1/yeoul_0.14.1_darwin_amd64.tar.gz"
      sha256 "ac9d4da3ad1609d58b93c5f8a0397b6e80d9d95b2aba59927d4f8ab5eca556ad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.1/yeoul_0.14.1_linux_arm64.tar.gz"
      sha256 "095ee833d517dec7e4f1d29e459021005957b89f011eed813ac106a8bab19617"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.1/yeoul_0.14.1_linux_amd64.tar.gz"
      sha256 "a76f09fcdf97621840e4f6f6731f0eeb210be9c8ecffe982f70f602556aabcc6"
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
