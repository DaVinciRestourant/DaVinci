program DaVinci;

uses
  System.StartUpCopy,
  FMX.Forms,
  Restourant.JsonDataObject in 'lib\Restourant.JsonDataObject.pas',
  Restourant.JsonDatabase in 'lib\Restourant.JsonDatabase.pas',
  Network in 'lib\Network.pas',
  Restourant.Consts.Filenames in 'const\Restourant.Consts.Filenames.pas',
  Restourant.Consts.Database in 'const\Restourant.Consts.Database.pas',
  Restourant.Consts.Strings in 'const\Restourant.Consts.Strings.pas',
  Restourant.Consts.Colors in 'const\Restourant.Consts.Colors.pas',
  Restourant.Forms.Main in 'forms\Restourant.Forms.Main.pas' {FormMain},
  Restourant.Consts.UserData in 'const\Restourant.Consts.UserData.pas';

{$R *.res}
{$R data\db.res}
{$R ..\res\images.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
