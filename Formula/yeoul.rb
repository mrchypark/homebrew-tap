class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.3/yeoul_0.2.3_darwin_arm64.tar.gz"
      sha256 "4213c2b9b148a1b068f85470722d428343c669eaf21dbf3425022d8d742e1dfe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.3/yeoul_0.2.3_darwin_amd64.tar.gz"
      sha256 "9a69bae8e9b5e17d833eebe818d215075d2bd0eef6f722c415af1079505b5017"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.3/yeoul_0.2.3_linux_arm64.tar.gz"
      sha256 "2f3f1ba3a5616af56cba560b85e02023c92ee96c89c2d02eb276c9b3ac3f88ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.3/yeoul_0.2.3_linux_amd64.tar.gz"
      sha256 "073a5c333bcf758ec2dee312f0a9b14c9fff4e215e82a53f441217ba33b4234c"
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
