{
  description = ''Library for shell scripting in nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimshell-v0_0_1.flake = false;
  inputs.src-nimshell-v0_0_1.ref   = "refs/tags/v0.0.1";
  inputs.src-nimshell-v0_0_1.owner = "vegansk";
  inputs.src-nimshell-v0_0_1.repo  = "nimshell";
  inputs.src-nimshell-v0_0_1.type  = "github";
  
  inputs."maybe".owner = "nim-nix-pkgs";
  inputs."maybe".ref   = "master";
  inputs."maybe".repo  = "maybe";
  inputs."maybe".dir   = "2_2";
  inputs."maybe".type  = "github";
  inputs."maybe".inputs.nixpkgs.follows = "nixpkgs";
  inputs."maybe".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimshell-v0_0_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-nimshell-v0_0_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}