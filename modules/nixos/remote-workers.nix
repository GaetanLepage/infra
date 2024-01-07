{ config, ... }:
{
  sops.secrets.id_buildfarm = { };

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "build04.nix-community.org";
      maxJobs = 80;
      protocol = "ssh-ng";
      sshKey = config.sops.secrets.id_buildfarm.path;
      sshUser = "nix";
      system = "aarch64-linux";
      supportedFeatures = [
        "big-parallel"
        "kvm"
        "nixos-test"
        "gccarch-armv8-a"
      ];
    }
    {
      hostName = "darwin02.nix-community.org";
      maxJobs = 8;
      protocol = "ssh-ng";
      sshKey = config.sops.secrets.id_buildfarm.path;
      sshUser = "nix";
      systems = [ "aarch64-darwin" "x86_64-darwin" ];
      supportedFeatures = [ "big-parallel" ];
    }
  ];
}
