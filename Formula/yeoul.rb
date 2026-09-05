class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.3/yeoul_0.5.3_darwin_arm64.tar.gz"
      sha256 "9d69be91227c4a6d5e246ac83c32afb80d45d92573da96f4a870073298be74ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.3/yeoul_0.5.3_darwin_amd64.tar.gz"
      sha256 "24edf8905ad096ac795c48755731b318af87608f9e58d1fa5dcd53cdc37125be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.3/yeoul_0.5.3_linux_arm64.tar.gz"
      sha256 "62b6e91f96bf9df6523f12bf1a9f38d511b4713ca14f4ea80ce99fe0fb1dfecb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.3/yeoul_0.5.3_linux_amd64.tar.gz"
      sha256 "38b6286c82de274a84dcd20e3ffaf1d91b185d6e6a02e850159378cee49e340e"
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
