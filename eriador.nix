{
  config = {
    
    networking.hostName = "eriador";

    swapDevices = [ {
      device = "/var/lib/swapfile";
      size = 16*1024;
    } ];
  };
}