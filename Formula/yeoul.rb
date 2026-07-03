class Yeoul < Formula
  desc "Local-first temporal graph memory engine"
  homepage "https://github.com/mrchypark/yeoul"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.2/yeoul_0.2.2_darwin_arm64.tar.gz"
      sha256 "01493b234f0ea05f10852d496692d3c243d881b703b344759196347ad68231e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.2/yeoul_0.2.2_darwin_amd64.tar.gz"
      sha256 "03dd504df14b4846189a6265247dd20de1594a3a070fe7f1b16093a9ba2cdc52"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.2/yeoul_0.2.2_linux_arm64.tar.gz"
      sha256 "d63cf7238c02f79238bca3e4dd6b691960a744ed5baabc200fa440047a253608"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrchypark/yeoul/releases/download/v0.2.2/yeoul_0.2.2_linux_amd64.tar.gz"
      sha256 "ff5f6b6b08862021ec499fa1f8a713e3967e75e6c655fe118cc02398aafe126e"
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
