{
  description = "Flutter";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      lib = nixpkgs.lib;
    in {
      devShell = with pkgs;
        mkShell {
          buildInputs = [
            flutter
            jdk17
            gtk3
            pkg-config
          ];
        };

      shellHook = ''
        flutter pub get
      '';

      packages = rec {
        #TODO: Rename project with your actual project name
        project = pkgs.flutter.buildFlutterApplication rec {
          pname = "project";
          version = "0.0.1";

          desktopItem = pkgs.makeDesktopItem {
            name = "project";
            exec = "project";
            desktopName = "Project";
          };

          src = lib.cleanSource ./.;

          autoPubspecLock = src + "/pubspec.lock";

          preInstall = ''
            echo "Desktop items"
            install -Dm644 ${desktopItem}/share/applications/${desktopItem.name} -t $out/share/applications
          '';
        };
        default = project;
      };
    });
}
