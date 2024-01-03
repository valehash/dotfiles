{
	description = "my first flake";
	inputs = {
		
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

		home-manager.url  = "github:nix-community/home-manager/release-23.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";	

		};

	outputs = {self, nixpkgs, home-manager, ...}:
	let	
		lib = 	nixpkgs.lib;
		systarc = "x86_64-linux";
		pkgs =	nixpkgs.legacyPackages.${systarc};
		
	in
	{
		nixosConfigurations = 
		{
			vale-hash =  lib.nixosSystem 
			{
				
				system = "x86_64-linux";
				modules = [./configuration.nix];
			};	
	

		};
		homeConfigurations = 
		{	
			vale =  home-manager.lib.homeManagerConfiguration 
			{
				inherit pkgs;
				modules = [./home.nix];
			};	
		};
	};
}
