class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.10.0/yeoul_0.10.0_darwin_arm64.tar.gz"
      sha256 "e50657d2f3ab6f352191b8d81ddaabe29ed2304c7f3cfe2297b24299c56de8b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.10.0/yeoul_0.10.0_darwin_amd64.tar.gz"
      sha256 "9f6741f18f0e238622b3be5d04ab999d4c9569f107f504d98cd5547d0ef04d7f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.10.0/yeoul_0.10.0_linux_arm64.tar.gz"
      sha256 "48eb23741a35803283098d189066b364f99d142053882945fcaaf26d1aa22334"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.10.0/yeoul_0.10.0_linux_amd64.tar.gz"
      sha256 "985d54cc6809e58bf676c8d318d1df1a585759a0ff779328ad53a3ff9f576178"
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
