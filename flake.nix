{
  description = "Des templates qui template";

  outputs = {self}: {
    templates = {
      angular = {
        path = ./angular;
        description = "Angular web framework";
        welcomeText = ''
          Angular template | npm start to start the server
        '';
      };
      node = {
        path = ./node;
        description = "Nodejs environment";
        welcomeText = ''
          Nodejs template | pnpm to install packages
        '';
      };
    };
  };
}
