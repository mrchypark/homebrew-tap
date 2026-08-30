class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.1/yeoul_0.5.1_darwin_arm64.tar.gz"
      sha256 "7a02fb2888128604dcd70b6499bff3d9656da1d3cf6ed618f5ebecf53bb10e51"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.1/yeoul_0.5.1_darwin_amd64.tar.gz"
      sha256 "4774ca0335e814f3999e4d6b408ee1341b36dd4aac469dc0055a804cb62e2716"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.1/yeoul_0.5.1_linux_arm64.tar.gz"
      sha256 "000b67b0e31d7e5ff28504d4017f1b331e03d971a6f5bc618dbe12111af7509b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.5.1/yeoul_0.5.1_linux_amd64.tar.gz"
      sha256 "a0b62041670729ab5c33c9d32a6b7959031df2f9ebadcf72db3ec81b986c162e"
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
