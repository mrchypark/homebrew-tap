class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.0/yeoul_0.7.0_darwin_arm64.tar.gz"
      sha256 "ab4fe02353383f414f90c1bf48fa6936b510978693f3a30849b5e33c2cd71933"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.0/yeoul_0.7.0_darwin_amd64.tar.gz"
      sha256 "3cb2541ced97e9d6c49f76b91e9d1511c6b49fccd6021277d2edae888b33e6d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.0/yeoul_0.7.0_linux_arm64.tar.gz"
      sha256 "d03e17b06eab3937ee54ae7c81df31375b92dd6d3621d1a8aaadbc4bb8a1ab10"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.7.0/yeoul_0.7.0_linux_amd64.tar.gz"
      sha256 "4e0a21b05b32f36e7e1cb6c3137d0c6ff0458819899dc7db6fdbcc8f85c8f1ee"
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
