{
  config = {
    virtualisation.docker.enable = true;
    virtualisation.docker.daemon.settings = {
      default-address-pools = [
        {
          base = "172.30.0.0/16";
          size = 24;
        }
      ];
    };
  };
}
