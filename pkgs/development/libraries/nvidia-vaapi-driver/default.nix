{ stdenv
, fetchFromGitHub
, lib
, meson
, ninja
, pkg-config
, libdrm
, libGL
, gst_all_1
, nv-codec-headers-11
, libva
, addOpenGLRunpath
}:

stdenv.mkDerivation rec {
  pname = "nvidia-vaapi-driver";
  version = "0.0.9";

  src = fetchFromGitHub {
    owner = "elFarto";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-mQtprgm6QonYiMUPPIcCbWxPQ/b2XuQiOkROZNPYaQk=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    addOpenGLRunpath
  ];

  buildInputs = [
    libdrm
    libGL
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-bad
    nv-codec-headers-11
    libva
  ];

  postFixup = ''
    addOpenGLRunpath "$out/lib/dri/nvidia_drv_video.so"
  '';

  meta = with lib;{
    homepage = "https://github.com/elFarto/nvidia-vaapi-driver";
    description = "A VA-API implemention using NVIDIA's NVDEC";
    changelog = "https://github.com/elFarto/nvidia-vaapi-driver/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers;[ nickcao ];
  };
}
