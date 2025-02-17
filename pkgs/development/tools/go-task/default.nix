{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "go-task";
  version = "3.16.0";

  src = fetchFromGitHub {
    owner = pname;
    repo = "task";
    rev = "v${version}";
    sha256 = "sha256-CHltaS2OJJTwsX6kvgyeQwR1bus03XnMOWSpJ0EDCJ0=";
  };

  vendorSha256 = "sha256-xp1s1aixPyXq9oVD8IZYSlUiL8UkIx5c8gYJRpIRD7I=";

  doCheck = false;

  nativeBuildInputs = [ installShellFiles ];

  subPackages = [ "cmd/task" ];

  ldflags = [
    "-s" "-w" "-X main.version=${version}"
  ];

  postInstall = ''
    ln -s $out/bin/task $out/bin/go-task

    installShellCompletion completion/{bash,fish,zsh}/*
  '';

  meta = with lib; {
    homepage = "https://taskfile.dev/";
    description = "A task runner / simpler Make alternative written in Go";
    license = licenses.mit;
    maintainers = with maintainers; [ parasrah ];
  };
}
