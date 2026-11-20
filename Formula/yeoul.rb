class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.14.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.2/yeoul_0.14.2_darwin_arm64.tar.gz"
      sha256 "66ba839b76f9c22b87e3cf00ba291281cbd084a2d9e16cabad1fc17787634cc4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.2/yeoul_0.14.2_darwin_amd64.tar.gz"
      sha256 "ab7778df4a4987eb05083cec314d35f4f9efea3d8c523887955aed13ac165f57"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.2/yeoul_0.14.2_linux_arm64.tar.gz"
      sha256 "8466a1fdce47b8736d88cb096ba2996026a4d0339382cb0dbe62f66a546d11f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.14.2/yeoul_0.14.2_linux_amd64.tar.gz"
      sha256 "e343fea08fbace0e33f283d4328b8faec875471ac1a7dde1edd9f1063d369b37"
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
