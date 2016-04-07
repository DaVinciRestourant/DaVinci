program Rastipuzzo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Restourant.Consts.Colors in 'const\Restourant.Consts.Colors.pas',
  Restourant.Consts.Database in 'const\Restourant.Consts.Database.pas',
  Restourant.Consts.Filenames in 'const\Restourant.Consts.Filenames.pas',
  Restourant.Consts.Strings in 'const\Restourant.Consts.Strings.pas',
  Restourant.Consts.UserData in 'const\Restourant.Consts.UserData.pas',
  Restourant.Forms.Main in 'forms\Restourant.Forms.Main.pas',
  FMX.Helpers.Controls in 'lib\FMX.Helpers.Controls.pas',
  Network in 'lib\Network.pas',
  Restourant.JsonDatabase in 'lib\Restourant.JsonDatabase.pas',
  Restourant.JsonDataObject in 'lib\Restourant.JsonDataObject.pas';

{$R *.res}
{$R ..\res\images.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
