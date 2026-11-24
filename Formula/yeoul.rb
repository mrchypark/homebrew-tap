class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.14.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.3/yeoul_0.14.3_darwin_arm64.tar.gz"
      sha256 "308c6cf74f7cecdaf1959dd60896b586a7a757a818214f171262599d04e3ed6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.3/yeoul_0.14.3_darwin_amd64.tar.gz"
      sha256 "17db1171deed4863adc00e5370fca2f7e293ba091548a1b6accf44959df49669"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.3/yeoul_0.14.3_linux_arm64.tar.gz"
      sha256 "34891743a4040dbf89d8deadba3ffdbd89806362c68da07a25b96e5b2022a62d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.3/yeoul_0.14.3_linux_amd64.tar.gz"
      sha256 "c51257886ad105a097942caaee491f235fc170c4ecd9883766f220f00c21c1ca"
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
