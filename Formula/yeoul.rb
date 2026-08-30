class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.0/yeoul_0.5.0_darwin_arm64.tar.gz"
      sha256 "492edd8ff1d661fb79de9af5ff4b381e7bc7087984b68228d6249c4d04cca70e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.0/yeoul_0.5.0_darwin_amd64.tar.gz"
      sha256 "9dc627d506ab4844853a154a5b7ee58184913aa719bfc1ca6d872e78f6cd2108"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.0/yeoul_0.5.0_linux_arm64.tar.gz"
      sha256 "fbdecffe255d8acc0222b4b1ca787bcc009036b61434794c6a9fbf724c48919f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.0/yeoul_0.5.0_linux_amd64.tar.gz"
      sha256 "fcac47202300dcf03eecc806e6107df52652eca012f766da82cd4aa4b2ea8bb1"
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
