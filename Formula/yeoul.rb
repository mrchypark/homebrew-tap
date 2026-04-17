class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.1.0/yeoul_0.1.0_darwin_arm64.tar.gz"
      sha256 "da87f1bdad3e83fd9be5b24125c4ed2108e1cc10a140e2619798e25da662c326"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.1.0/yeoul_0.1.0_darwin_amd64.tar.gz"
      sha256 "998c274c9bfb0a77fbee62b95e83ad9a6380be87c6a840c5c9f2482f8d6e8e33"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.1.0/yeoul_0.1.0_linux_arm64.tar.gz"
      sha256 "214b93d190a8af7ae53bd0daaa709021ba15554efa29e2fe172f5c1230e78fec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.1.0/yeoul_0.1.0_linux_amd64.tar.gz"
      sha256 "9d329392847177b7ebb16f73a7676a28d1ea1218467e2b853514dcf8a2654c2a"
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
