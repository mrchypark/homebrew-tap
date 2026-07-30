class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.4/yeoul_0.2.4_darwin_arm64.tar.gz"
      sha256 "d74ce7dd39feefcd9347a08de21b73495baf7c62d2f5efd8df0d312810e4636a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.4/yeoul_0.2.4_darwin_amd64.tar.gz"
      sha256 "12faff602a4e1107b52d9cf63403122a4c892caf698bd1a0b9d47992cfcee488"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.4/yeoul_0.2.4_linux_arm64.tar.gz"
      sha256 "e971bec184f1d45678fc496ef441a8b421b146c4d68223393384be0c1afbe193"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.4/yeoul_0.2.4_linux_amd64.tar.gz"
      sha256 "61cd5f80f8491cfa0e062ea18ec27a455556dad1a3887fd941225aa948db8296"
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
