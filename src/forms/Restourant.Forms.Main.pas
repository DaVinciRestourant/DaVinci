unit Restourant.Forms.Main;
interface
uses
  System.SysUtils,  System.IOUtils, System.Types, System.UITypes
 ,System.Classes, System.Variants, System.Actions, System.ImageList
 ,FMX.Types, FMX.Graphics, FMX.Objects, FMX.Controls, FMX.Controls.Presentation
 ,FMX.StdCtrls, FMX.Forms, FMX.Dialogs, FMX.TabControl, FMX.Gestures
 ,FMX.ListBox, FMX.Layouts
 ,Restourant.JsonDataObject, Restourant.JsonDatabase
 ;
type
  TFormMain = class(TForm)
  private
    FDB             :TJsonDataBase;
    FUDB            :TJsonDataBase;
    FTimerUpdate    :FMX.Types.TTimer;

    FGestMan        :TGestureManager;
    FTopBar         :TRectangle;
    FTopBtnBack     :TRectangle;
    FTopBtnBackImg  :TImage;
    FTopBtnMenu     :TRectangle;
    FTopBtnMenuImg  :TImage;
    FTopBtnOrder    :TRectangle;
    FTopBtnOrderImg :TImage;
    FTopBtnUser     :TRectangle;
    FTopBtnUserImg  :TImage;

    FTopBarLabel    :TLabel;
    FtcMain         :TTabControl;
    FtiMainMenu     :TTabItem;
    FtiMainOrder    :TTabItem;
    FtiMainUser     :TTabItem;
    FtcMenu         :TTabControl;
    FtiMenuCat      :TTabItem;
    FtiMenuGroup    :TTabItem;
    FtiMenuList     :TTabItem;
    FtiMenuTMC      :TTabItem;
    FtcTMC          :TTabControl;
    FtiTMCH         :TTabItem;
    FtiTMCV         :TTabItem;
    FlbxCategory    :TListBox;
    FlbxGroup       :TListBox;
    FlbxTMC         :TListBox;

    FVbgrTMC        :TRectangle;
    FVimgTMC_IMAGE  :TImage;
    FVlblTMC_NAME   :TLabel;
    FVlblTMC_COMENT :TLabel;
    FVlblTMC_PRICE  :TLabel;
    FVlblTMC_EDIZM  :TLabel;
    FHbgrTMC        :TRectangle;
    FHimgTMC_IMAGE  :TImage;
    FHltClient      :TLayout;
    FHlblTMC_NAME   :TLabel;
    FHlblTMC_COMENT :TLabel;
    FHlblTMC_PRICE  :TLabel;
    FHlblTMC_EDIZM  :TLabel;
    procedure   actBackExecute(Sender :TObject);
    procedure   actMenuExecute(Sender :TObject);
    procedure   actOrderExecute(Sender :TObject);
    procedure   actUserExecute(Sender :TObject);
    procedure   DoChangeTabControl(Sender :TObject);
    procedure   DoClick_Category(Sender: TObject);
    procedure   DoClick_Group(Sender: TObject);
    procedure   DoClick_TMC(Sender: TObject);
    procedure   DoListItemMouseDown (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoListItemMouseUp   (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoTopButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoTopButtonMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   CreateControlsTMCHor(aParentObj :TFMXObject);
    procedure   CreateControlsTMCVer(aParentObj :TFMXObject);
    function    CreateListbox(aParentObj :TFMXObject; const BackgroundResource:string):TListBox;
    function    CreateTopButton(const AnAlign:FMX.Types.TAlignLayout;
                  const ResourceName:string; AnOnClick:TNotifyEvent; var AnImage:FMX.Objects.TImage):FMX.Objects.TRectangle;
    procedure   DoOnTimerUpdate(Sender :TObject);
  public
    constructor CreateNew(AOwner: TComponent; Dummy: NativeInt = 0); override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure   Resize; override;
    procedure   KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    function    CanBack:Boolean;
    procedure   DoBack;
    function    CheckFolders:Boolean;
    function    MaterialColor(const anIndex:Integer):Integer;
    function    GetTopBarButtonColor(const Value:Boolean):TColor;
    function    SafeFloat(const Value:string):Extended;
    function    GetTMCImage(const TMC_ID:Integer):string;
    function    GetConstInteger(const ConstName:string):Integer;
    function    GetTMCObject(const TMC_ID:Integer):TJsonObject;
    function    DataFilePath(const FileName:string):string;
    function    UserDataPath(const FileName:string):string;
    function    HTTPGetString(const Host, URL:string):string;
    function    HTTPGetFile(const Host, URL, FileName:string):Boolean;
    function    ExtractFileArchive(const ArchiveName, DestinationPath:string):Boolean;
    function    ExtractFileFromResource(const Resource, ToFileName: string): Boolean;
    procedure   FillCategories;
    procedure   FillGroups(const TMC_CTGR_ID:Integer);
    procedure   FillTMC(const TMC_GROUP_ID:Integer);
    procedure   FillCard(const TMC_ID, aColor:Integer);
  end;

var
  FormMain: TFormMain;

implementation

uses
  Restourant.Consts.Filenames, Restourant.Consts.Database, Restourant.Consts.UserData
 ,Restourant.Consts.Strings, Restourant.Consts.Colors
 ,System.Zip
 ,Network
 ,IdHTTP, IdComponent
 ;

function TFormMain.MaterialColor(const anIndex: Integer): Integer;
var
  LIndex :Integer;
begin
  LIndex := anIndex;
  if(LIndex >= Length(Restourant.Consts.Colors.Material))then
    LIndex := anIndex mod Length(Restourant.Consts.Colors.Material);
  Result := Restourant.Consts.Colors.Material[LIndex];
end;

function TFormMain.GetTopBarButtonColor(const Value: Boolean): TColor;
begin
  if Value then Result := $FF000000 else Result := FTopBar.Fill.Color;
end;

function TFormMain.SafeFloat(const Value: string): Extended;
var
  LStr :string;
begin
  Result := 0;
  LStr := Value;
  try
    LStr := LStr.Replace('.', System.SysUtils.FormatSettings.DecimalSeparator);
    LStr := LStr.Replace(',', System.SysUtils.FormatSettings.DecimalSeparator);
    Result := LStr.ToExtended();
  except
    Result := 0;
  end;
end;

function TFormMain.ExtractFileArchive(const ArchiveName, DestinationPath: string): Boolean;
begin
  Result := False;
  with TZipFile.Create do
  try
    ExtractZipFile(ArchiveName, DestinationPath );
  finally
    Free;
  end;
  Result := True;
end;

function TFormMain.ExtractFileFromResource(const Resource, ToFileName: string): Boolean;
begin
  Result := False;
  with TResourceStream.Create(hInstance, Resource, RT_RCDATA ) do
  try
    SaveToFile( ToFileName );
  finally
    Free;
  end;
  Result := True;
end;

function TFormMain.DataFilePath(const FileName: string): string;
begin
  Result := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Database.Folder);
  Result := System.IOUtils.TPath.Combine(Result, FileName) + Restourant.Consts.Database.FileExt;
end;

function TFormMain.UserDataPath(const FileName: string): string;
begin
  Result := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.UserData.Folder);
  Result := System.IOUtils.TPath.Combine(Result, FileName) + Restourant.Consts.UserData.FileExt;
end;

function TFormMain.GetConstInteger(const ConstName: string): Integer;
var
  i :Integer;
begin
  Result := 0;
  for i:=0 to FDB[Restourant.Consts.Database.C].A[Restourant.Consts.Database.Section].Count-1 do
    if(FDB[Restourant.Consts.Database.C].A[Restourant.Consts.Database.Section].O[i].S['ID'] = ConstName )then
    begin
      Result := FDB[Restourant.Consts.Database.C].A[Restourant.Consts.Database.Section].O[i].S['FINT'].ToInteger();
      Break;
    end;
end;

function TFormMain.GetTMCImage(const TMC_ID: Integer): string;
var
  LFolder:string;
begin
  LFolder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Filenames.FolderImages);
  LFolder := System.IOUtils.TPath.Combine(LFolder, Restourant.Consts.Filenames.FolderImagesTMC);
  if(TMC_ID = 0)then
    Result := System.IOUtils.TPath.Combine(LFolder, Restourant.Consts.Filenames.FileNameImageTMCNoImage)
  else
  begin
    Result := System.IOUtils.TPath.Combine(LFolder, TMC_ID.ToString() +'.jpg');
    if not TFile.Exists(Result) then
      Result := System.IOUtils.TPath.Combine(LFolder, Restourant.Consts.Filenames.FileNameImageTMCNoImage);
  end;
end;

function TFormMain.GetTMCObject(const TMC_ID: Integer): TJsonObject;
var
  i :Integer;
begin
  Result := nil;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].Count-1 do
    if(FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].O[i].S['ID'] = TMC_ID.ToString())then
    begin
      Result := FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].O[i];
      Break;
    end;
end;

function TFormMain.HTTPGetFile(const Host, URL, FileName: string): Boolean;
var
  LStream :TMemoryStream;
  LHttp   :TIdHTTP;
begin
  Result := False;
  LHttp := TIdHTTP.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LHttp.Request.UserAgent := Restourant.Consts.Filenames.UrlUserAgent;
    LHttp.Request.Host      := Host;
    LHttp.Get(URL, LStream);
    if System.IOUtils.TFile.Exists(FileName) then
      System.IOUtils.TFile.Delete(FileName);
    LStream.SaveToFile(FileName);
  finally
    LStream.Free;
    LHttp.Free;
  end;
  Result := True;
end;

function TFormMain.HTTPGetString(const Host, URL: string): string;
var
  LHttp   :TIdHttp;
begin
  Result := System.SysUtils.EmptyStr;
  LHttp := TIdHTTP.Create;
  try
    LHttp.Request.UserAgent := Restourant.Consts.Filenames.UrlUserAgent;
    LHttp.Request.Host      := Host;
    Result := LHttp.Get( URL );
  finally
    LHttp.Free;
  end;
end;

function TFormMain.CheckFolders: Boolean;
var
  LFolder      :string;
  LFileArchive :string;
begin
  Result := False;
  // documents/data
  LFolder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Database.Folder);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/userdata
  LFolder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.UserData.Folder);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/images
  LFolder := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Filenames.FolderImages);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/images/tmc
  LFolder := ExtractFilePath(GetTMCImage(0));
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/data/
  if not TFile.Exists( DataFilePath(Restourant.Consts.Database.C) ) then
  begin
    LFileArchive := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Database.PackedFile);
    if not TFile.Exists(LFileArchive) then
      ExtractFileFromResource(Restourant.Consts.Database.Resource,  LFileArchive);
    ExtractFileArchive(LFileArchive, ExtractFilePath( DataFilePath(Restourant.Consts.Database.C) ) );
  end;
  // documents/images/tmc/noimage.jpg
  if not TFile.Exists( GetTMCImage(0) ) then
  begin
    LFileArchive := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Filenames.FileNameImageTMCPacked);
    if not TFile.Exists(LFileArchive) then
      HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlImagesZip, LFileArchive );
    ExtractFileArchive(LFileArchive, ExtractFilePath(GetTMCImage(0)) );
  end;
  Result := True;
end;

constructor TFormMain.Create(AOwner: TComponent);
begin
  CreateNew(aOwner, 0);
end;

constructor TFormMain.CreateNew(AOwner: TComponent; Dummy: NativeInt);
var
  LBgrImage :TImage;
  LStream   :TResourceStream;
  LBtn      :TImage;
begin
  inherited CreateNew(aOwner, Dummy);
  Application.Title := Restourant.Consts.Strings.ApplicationTitle;
  Caption  := Restourant.Consts.Strings.ApplicationTitle;
  CheckFolders;
  FDB := TJsonDataBase.Create(Self);
  with FDB do
  begin
    DataBasePath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Database.Folder);
    FileExt      := Restourant.Consts.Database.FileExt;
    AddTable( Restourant.Consts.Database.C );
    AddTable( Restourant.Consts.Database.R_TMC_CTGR );
    AddTable( Restourant.Consts.Database.R_TMC_GROUPSHARE );
    AddTable( Restourant.Consts.Database.R_TMC );
  end;
  FUDB := TJsonDataBase.Create(Self);
  with FUDB do
  begin
    DataBasePath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.UserData.Folder);
    FileExt      := Restourant.Consts.UserData.FileExt;
    NewTable( Restourant.Consts.UserData.ORDERS );
    NewTable( Restourant.Consts.UserData.DETAIL );
  end;

  FGestMan := TGestureManager.Create(Self);

  FTopBar := TRectangle.Create(Self);
  with FTopBar do
  begin
    Parent       := Self;
    HitTest      := False;
    Position.X   := 0;
    Position.Y   := 0;
    Height       := 64;
    Align        := FMX.Types.TAlignLayout.Top;
    Fill.Color   := Restourant.Consts.Colors.Material[0];
    Fill.Kind    := FMX.Graphics.TBrushKind.Solid;
    Stroke.Color := FTopBar.Fill.Color;
    Stroke.Kind  := FMX.Graphics.TBrushKind.None;
  end;
  FTopBarLabel := TLabel.Create(Self);
  with FTopBarLabel do
  begin
    Parent         := FTopBar;
    StyledSettings := [];
    AutoSize       := False;
    Position.X     := 0;
    Position.Y     := 0;
    Height         := FTopBar.Height;
    Align          := FMX.Types.TAlignLayout.Client;
    WordWrap       := False;
    Text           := Restourant.Consts.Strings.ApplicationTitle;
    Font.Family    := 'Times New Roman';
    Font.Size      := 32;
    Font.Style     := [System.UITypes.TFontStyle.fsBold, System.UITypes.TFontStyle.fsItalic];
    FontColor      := $FFFFFFFF;
    TextSettings.HorzAlign := FMX.Types.TTextAlign.Leading;
  end;
  FTopBtnBack  := CreateTopButton(FMX.Types.TAlignLayout.Left , 'BACK', actBackExecute , FTopBtnBackImg );
  with FTopBtnBackImg do
  begin
    OnMouseDown := DoTopButtonMouseDown;
    OnMouseUp   := DoTopButtonMouseUp;
  end;
  FTopBtnUser  := CreateTopButton(FMX.Types.TAlignLayout.Right, 'USER', actUserExecute , FTopBtnUserImg );
  FTopBtnOrder := CreateTopButton(FMX.Types.TAlignLayout.Right, 'CART', actOrderExecute, FTopBtnOrderImg);
  FTopBtnMenu  := CreateTopButton(FMX.Types.TAlignLayout.Right, 'MENU', actMenuExecute , FTopBtnMenuImg );

  FtcMain := TTabControl.Create(Self);
  with FtcMain do
  begin
    Parent      := Self;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiMainMenu  := FtcMain.Add(TTabItem); FtiMainMenu.Text  := Restourant.Consts.Strings.TabItemMainMenu;
  FtiMainOrder := FtcMain.Add(TTabItem); FtiMainOrder.Text := Restourant.Consts.Strings.TabItemMainOrder;
  FtiMainUser  := FtcMain.Add(TTabItem); FtiMainUser.Text  := Restourant.Consts.Strings.TabItemMainUser;
  FtcMain.ActiveTab := FtiMainMenu;

  FtcMenu  := TTabControl.Create(Self);
  with FtcMenu do
  begin
    Parent      := FtiMainMenu;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiMenuCat   := FtcMenu.Add(TTabItem); FtiMenuCat.Text   := Restourant.Consts.Strings.TabItemMenuCat;
  FtiMenuGroup := FtcMenu.Add(TTabItem); FtiMenuGroup.Text := Restourant.Consts.Strings.TabItemMenuGroup;
  FtiMenuList  := FtcMenu.Add(TTabItem); FtiMenuList.Text  := Restourant.Consts.Strings.TabItemMenuList;
  FtiMenuTmc   := FtcMenu.Add(TTabItem); FtiMenuTmc.Text   := Restourant.Consts.Strings.TabItemMenuTMC;
  FtcMenu.ActiveTab := FtiMenuCat;

  FtcTMC := TTabControl.Create(Self);
  with FtcTMC do
  begin
    Parent      := FtiMenuTmc;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiTMCH := FtcTMC.Add(TTabItem); FtiTMCH.Text := 'H'; CreateControlsTMCHor(FtiTMCH);
  FtiTMCV := FtcTMC.Add(TTabItem); FtiTMCV.Text := 'V'; CreateControlsTMCVer(FtiTMCV);
  FtcTMC.ActiveTab := FtiTMCV;

  FlbxCategory := CreateListbox(FtiMenuCat  ,'BACKGROUND');
  FlbxGroup    := CreateListbox(FtiMenuGroup,'BACKGROUND01');
  FlbxTMC      := CreateListbox(FtiMenuList ,'BACKGROUND02');

  FtcMain.OnChange := DoChangeTabControl;
  FtcMenu.OnChange := DoChangeTabControl;
  DoChangeTabControl(nil);

  FillCategories;

  FTimerUpdate := FMX.Types.TTimer.Create(Self);
  with FTimerUpdate do
  begin
    Interval := 1000 * 60 * 10;
    OnTimer  := DoOnTimerUpdate;
    Enabled  := True;
  end;
  DoOnTimerUpdate(FTimerUpdate);
end;

function TFormMain.CreateTopButton(const AnAlign:FMX.Types.TAlignLayout;
                  const ResourceName:string; AnOnClick:TNotifyEvent; var AnImage:FMX.Objects.TImage): FMX.Objects.TRectangle;
var
  LStream :TResourceStream;
begin
  Result := TRectangle.Create(FTopBar);
  with Result do
  begin
    Parent            := FTopBar;
    Height            := FTopBar.Height;
    Width             := FTopBar.Height;
    Align             := AnAlign;
    Fill.Color        := FTopBar.Fill.Color;
    Fill.Kind         := FMX.Graphics.TBrushKind.Solid;
    Stroke.Color      := FTopBar.Fill.Color;
    Stroke.Kind       := FMX.Graphics.TBrushKind.None;
    HitTest           := True;
    Margins.Left      := 0;
    Margins.Top       := 0;
    Margins.Right     := 0;
    Margins.Bottom    := 0;
    Padding.Left      := 8;
    Padding.Top       := 8;
    Padding.Right     := 8;
    Padding.Bottom    := 8;
  end;
  AnImage := TImage.Create(Result);
  with AnImage do
  begin
    Parent      := Result;
    Align       := FMX.Types.TAlignLayout.Client;
    WrapMode    := FMX.Objects.TImageWrapMode.Stretch;
    OnClick     := AnOnClick;
    OnMouseDown := DoTopButtonMouseDown;
  end;
  if(ResourceName.Length >0)then
    try
      LStream := TResourceStream.Create(hInstance, ResourceName, RT_RCDATA );
      AnImage.Bitmap.LoadFromStream(LStream);
    finally
      LStream.Free;
    end;
end;

destructor TFormMain.Destroy;
begin
  if FTimerUpdate.Enabled then
    FTimerUpdate.Enabled := False;
  FreeAndNil(FTimerUpdate);
  FreeAndNil(FtcMenu);
  FreeAndNil(FGestMan);
  FUDB.Clear(True);
  FreeAndNil(FUDB);
  FreeAndNil(FDB);
  inherited Destroy;
end;

procedure TFormMain.DoOnTimerUpdate(Sender: TObject);
begin
  if not Network.IsConnected then exit;

  TThread.CreateAnonymousThread(
    procedure
    var
      LDBVersion   :Integer;
      LWebVersion  :Integer;
      LFileArchive :string;
    begin
      LDBVersion := GetConstInteger('DBVERSION');
      try
        LWebVersion := HTTPGetString(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlDatabaseVersion).ToInteger();
      except
        LWebVersion := LDBVersion;
      end;
      if(LWebVersion > LDBVersion)then
      begin // database
        LFileArchive := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Database.PackedFile);
        if HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlDatabaseZip, LFileArchive ) then
          ExtractFileArchive(LFileArchive, ExtractFilePath( DataFilePath(Restourant.Consts.Database.C) ) );

        LFileArchive := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetSharedDocumentsPath, Restourant.Consts.Filenames.FileNameImageTMCPackedTemp);
        if HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlImagesZip, LFileArchive ) then
        begin
          ExtractFileArchive(LFileArchive, ExtractFilePath(GetTMCImage(0)) );
          TFile.Delete(LFileArchive);
        end;

        TThread.Synchronize(nil,
          procedure
          begin
            FDB.ReloadAll;
          end
        );
      end;
    end
  ).Start;
end;

function TFormMain.CreateListbox(aParentObj: TFMXObject; const BackgroundResource:string): TListBox;
var
  LBgrImage :TImage;
  LStream   :TResourceStream;
begin
  LBgrImage := TImage.Create(aParentObj);
  with LBgrImage do
  begin
    Parent   := aParentObj;
    Align    := FMX.Types.TAlignLayout.Client;
    WrapMode := FMX.Objects.TImageWrapMode.Stretch;
  end;
  if(BackgroundResource.Length >0)then
    try
      LStream := TResourceStream.Create(hInstance, BackgroundResource, RT_RCDATA );
      LBgrImage.Bitmap.LoadFromStream(LStream);
    finally
      LStream.Free;
    end;
  Result := TListBox.Create(Self);
  with Result do
  begin
    Parent         := LBgrImage;
    Align          := FMX.Types.TAlignLayout.Client;
    ListStyle      := FMX.ListBox.TListStyle.Vertical;
    ShowCheckboxes := False;
    ShowScrollBars := True;
    ShowSizeGrip   := False;
    StyleLookup    := 'transparentlistboxstyle';
  end;
end;

procedure TFormMain.CreateControlsTMCVer(aParentObj :TFMXObject);
begin
  FVbgrTMC := TRectangle.Create(aParentObj);
  with FVbgrTMC do
  begin
    Parent         := aParentObj;
    HitTest        := False;
    Position.X     := 0;
    Position.Y     := 0;
    Align          := FMX.Types.TAlignLayout.Client;
    Fill.Color     := MaterialColor( Random( Length(Restourant.Consts.Colors.Material) - 1 ) );
    Fill.Kind      := FMX.Graphics.TBrushKind.Solid;
    Stroke.Color   := Fill.Color;
    Stroke.Kind    := FMX.Graphics.TBrushKind.None;
    Padding.Left   := 16;
    Padding.Top    := 16;
    Padding.Right  := 16;
    Padding.Bottom := 16;
  end;
  FVimgTMC_IMAGE := TImage.Create(aParentObj);
  with FVimgTMC_IMAGE do
  begin
    Parent         := FVbgrTMC;
    Height         := 220;
    Width          := 330;
    Align          := FMX.Types.TAlignLayout.Top;
    WrapMode       := FMX.Objects.TImageWrapMode.Stretch;
  end;
  FVlblTMC_NAME := TLabel.Create(aParentObj);
  with FVlblTMC_NAME do
  begin
    Parent         := FVbgrTMC;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := FVimgTMC_IMAGE.Height + 2;
    Height         := 48;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := False;
    Text           := ' ';
    Font.Size      := 20;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FVlblTMC_COMENT := TLabel.Create(aParentObj);
  with FVlblTMC_COMENT do
  begin
    Parent         := FVbgrTMC;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := FVlblTMC_NAME.Position.Y + FVlblTMC_NAME.Height + 2;
    Height         := 160;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := True;
    Text           := System.SysUtils.EmptyStr;
    Font.Size      := 12;
    Font.Style     := [];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FVlblTMC_PRICE := TLabel.Create(aParentObj);
  with FVlblTMC_PRICE do
  begin
    Parent         := FVbgrTMC;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := FVlblTMC_COMENT.Position.Y + FVlblTMC_COMENT.Height;
    Height         := 48;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := True;
    Text           := Restourant.Consts.Strings.TmcPrice;
    Font.Size      := 24;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Trailing;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FVlblTMC_EDIZM := TLabel.Create(aParentObj);
  with FVlblTMC_EDIZM do
  begin
    Parent         := FVlblTMC_PRICE;
    StyledSettings := [];
    AutoSize       := False;
    Position.X     := 0;
    Position.Y     := 0;
    Height         := 20;
    Width          := 160;
    Align          := FMX.Types.TAlignLayout.Left;
    Text           := Restourant.Consts.Strings.TmcEdizm;
    Font.Size      := 14;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
end;

procedure TFormMain.CreateControlsTMCHor(aParentObj :TFMXObject);
begin
  FHbgrTMC := TRectangle.Create(aParentObj);
  with FHbgrTMC do
  begin
    Parent         := aParentObj;
    HitTest        := False;
    Position.X     := 0;
    Position.Y     := 0;
    Align          := FMX.Types.TAlignLayout.Client;
    Fill.Color     := MaterialColor( Random( Length(Restourant.Consts.Colors.Material) - 1 ) );
    Fill.Kind      := FMX.Graphics.TBrushKind.Solid;
    Stroke.Color   := Fill.Color;
    Stroke.Kind    := FMX.Graphics.TBrushKind.None;
    Padding.Left   := 16;
    Padding.Top    := 16;
    Padding.Right  := 16;
    Padding.Bottom := 16;
  end;
  FHimgTMC_IMAGE := TImage.Create(aParentObj);
  with FHimgTMC_IMAGE do
  begin
    Parent         := FHbgrTMC;
    Height         := 220;
    Width          := 330;
    Align          := FMX.Types.TAlignLayout.Left;
    WrapMode       := FMX.Objects.TImageWrapMode.Stretch;
  end;
  FHltClient := TLayout.Create(aParentObj);
  with FHltClient do
  begin
    Parent         := FHbgrTMC;
    Height         := 220;
    Width          := Self.Width - FHimgTMC_IMAGE.Width;
    Align          := FMX.Types.TAlignLayout.Client;
    Padding.Left   := 16;
    Padding.Top    := 0;
    Padding.Right  := 16;
    Padding.Bottom := 0;
  end;
  FHlblTMC_NAME := TLabel.Create(aParentObj);
  with FHlblTMC_NAME do
  begin
    Parent         := FHltClient;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := 0;
    Height         := 48;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := False;
    Text           := ' ';
    Font.Size      := 20;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FHlblTMC_COMENT := TLabel.Create(aParentObj);
  with FHlblTMC_COMENT do
  begin
    Parent         := FHltClient;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := FHlblTMC_NAME.Position.Y + FHlblTMC_NAME.Height + 2;
    Height         := 192;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := True;
    Text           := ' ';
    Font.Size      := 12;
    Font.Style     := [];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FHlblTMC_PRICE := TLabel.Create(aParentObj);
  with FHlblTMC_PRICE do
  begin
    Parent         := FHltClient;
    StyledSettings := [];
    AutoSize       := False;
    Position.Y     := FHlblTMC_COMENT.Position.Y + FHlblTMC_COMENT.Height;
    Height         := 48;
    Align          := FMX.Types.TAlignLayout.Top;
    WordWrap       := True;
    Text           := Restourant.Consts.Strings.TmcPrice;
    Font.Size      := 24;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Trailing;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
  FHlblTMC_EDIZM := TLabel.Create(aParentObj);
  with FHlblTMC_EDIZM do
  begin
    Parent         := FHlblTMC_PRICE;
    StyledSettings := [];
    AutoSize       := False;
    Position.X     := 0;
    Position.Y     := 0;
    Height         := 20;
    Width          := 160;
    Align          := FMX.Types.TAlignLayout.Left;
    Text           := Restourant.Consts.Strings.TmcEdizm;
    Font.Size      := 14;
    Font.Style     := [System.UITypes.TFontStyle.fsBold];
    FontColor      := $FFFFFFFF;
    TextAlign      := FMX.Types.TTextAlign.Leading;
    VertTextAlign  := FMX.Types.TTextAlign.Leading;
  end;
end;

function TFormMain.CanBack: Boolean;
begin
  Result := False;
  if(FtcMain.ActiveTab = FtiMainMenu)then
    Result := (FtcMenu.ActiveTab <> FtiMenuCat);
end;

procedure TFormMain.DoBack;
begin
  if(FtcMain.ActiveTab = FtiMainMenu)then
    FtcMenu.Previous;
end;

procedure TFormMain.KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited KeyUp(Key, KeyChar, Shift);
  if(Key = vkHardwareBack)then
  begin
    if CanBack then
    begin
      DoBack;
      Key := 0;
    end;
  end;
end;

procedure TFormMain.Resize;
begin
  inherited Resize;
  FlbxCategory.Columns := Trunc(Width / 240);
  FlbxGroup.Columns    := Trunc(Width / 240);
  FlbxTMC.Columns      := Trunc(Width / 330);
  if(Height > Width)then
  begin
    FVimgTMC_IMAGE.Height := Trunc(Width * 2 / 3);
    FtcTMC.ActiveTab := FtiTMCV;
  end
  else
  begin
    FHimgTMC_IMAGE.Width  := Trunc( ( Height - (FTopBar.Height + 16)*2 ) * 3 / 2);
    FtcTMC.ActiveTab := FtiTMCH;
  end;
end;

procedure TFormMain.DoChangeTabControl(Sender: TObject);
begin
  FTopBtnBack.Visible     := CanBack;
  FTopBtnMenu.Fill.Color  := GetTopBarButtonColor(FtcMain.ActiveTab = FtiMainMenu );
  FTopBtnOrder.Fill.Color := GetTopBarButtonColor(FtcMain.ActiveTab = FtiMainOrder);
  FTopBtnUser.Fill.Color  := GetTopBarButtonColor(FtcMain.ActiveTab = FtiMainUser );
end;

procedure TFormMain.DoClick_Category(Sender: TObject);
begin
  FillGroups( TFMXObject(Sender).Tag );
  FtcMenu.ActiveTab := FtiMenuGroup;
end;

procedure TFormMain.DoClick_Group(Sender: TObject);
begin
  FillTMC( TFMXObject(Sender).Tag );
  FtcMenu.ActiveTab := FtiMenuList;
end;

procedure TFormMain.DoClick_TMC(Sender: TObject);
begin
  FillCard( TFMXObject(Sender).Tag, TFMXObject(Sender).TagString.ToInteger() );
  FtcMenu.ActiveTab := FtiMenuTMC;
end;

procedure TFormMain.DoListItemMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  with TRectangle(TFMXObject(Sender).TagObject)do
    Fill.Color := Fill.Color - $A0000000;
end;

procedure TFormMain.DoListItemMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  with TRectangle(TFMXObject(Sender).TagObject)do
    Fill.Color := Fill.Color + $A0000000;
end;

procedure TFormMain.DoTopButtonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(TComponent(Sender).Owner).Fill.Color := $FF000000;
end;

procedure TFormMain.DoTopButtonMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  TRectangle(TComponent(Sender).Owner).Fill.Color := FTopBar.Fill.Color;
end;

procedure TFormMain.FillCategories;
var
  LRow     :TJsonObject;
  LItem    :TListBoxItem;
  LBackgr  :TRectangle;
  LLblName :TLabel;
  i, j     :Integer;
begin
  FlbxCategory.Clear;
  FlbxCategory.ItemHeight := 96;
  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].O[i];
    if(LRow.S['FLAG_DELETE'] = '0')then
    begin
      LItem := TListBoxItem.Create(FlbxCategory);
      with LItem do
      begin
        Parent          := FlbxCategory;
        Height          := FlbxCategory.ItemHeight;
        Tag             := LRow.S['ID'].ToInteger();
        TagString       := MaterialColor(j).ToString();
        OnClick         := DoClick_Category;
        OnMouseDown     := DoListItemMouseDown;
        OnMouseUp       := DoListItemMouseUp;
      end;
      LBackgr := TRectangle.Create(LItem);
      with LBackgr do
      begin
        Parent          := LItem;
        HitTest         := False;
        Position.X      := 0;
        Position.Y      := 0;
        Height          := LItem.Height;
        Align           := FMX.Types.TAlignLayout.Client;
        Fill.Color      := LItem.TagString.ToInteger();
        Fill.Kind       := FMX.Graphics.TBrushKind.Solid;
        Stroke.Color    := LBackgr.Fill.Color;
        Stroke.Kind     := FMX.Graphics.TBrushKind.None;
        Margins.Left    := 8;
        Margins.Top     := 8;
        Margins.Right   := 8;
        Margins.Bottom  := 0;
      end;
      LItem.TagObject := LBackgr;
      LLblName := TLabel.Create(LItem);
      with LLblName do
      begin
        Parent          := LBackgr;
        StyledSettings  := [];
        AutoSize        := False;
        Position.Y      := 0;
        Height          := LItem.Height;
        Align           := FMX.Types.TAlignLayout.Client;
        WordWrap        := False;
        Text            := LRow.S['NAME'];
        Font.Size       := 28;
        Font.Style      := [System.UITypes.TFontStyle.fsBold];
        FontColor       := $FFFFFFFF;
        TextSettings.HorzAlign := FMX.Types.TTextAlign.Center;
      end;
      j := j + 1;
    end;
  end;
end;

procedure TFormMain.FillGroups(const TMC_CTGR_ID: Integer);
var
  LRow     :TJsonObject;
  LItem    :TListBoxItem;
  LBackgr  :TRectangle;
  LLblName :TLabel;
  LCategory:string;
  i, j     :Integer;
begin
  FlbxGroup.Clear;
  FlbxGroup.ItemHeight := 60;

  LCategory := '';
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].O[i];
    if(LRow.S['ID'] = TMC_CTGR_ID.ToString() )then
    begin
      LCategory := LRow.S['NAME'];
      Break;
    end;
  end;

  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_GROUPSHARE].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_GROUPSHARE].A[Restourant.Consts.Database.Section].O[i];
    if( (LRow.S['GROUPNAME'] = LCategory) and (LRow.S['FLAG_DELETE'] = '0') )then
    begin
      LItem                   := TListBoxItem.Create(FlbxGroup);
      LItem.Parent            := FlbxGroup;
      LItem.Height            := FlbxGroup.ItemHeight;
      LItem.Tag               := LRow.S['TMC_GROUP_ID'].ToInteger();
      LItem.TagString         := MaterialColor(j).ToString();
      LItem.OnClick           := DoClick_Group;
      LItem.OnMouseDown       := DoListItemMouseDown;
      LItem.OnMouseUp         := DoListItemMouseUp;
      LBackgr                 := TRectangle.Create(LItem);
      LBackgr.Parent          := LItem;
      LBackgr.HitTest         := False;
      LBackgr.Position.X      := 0;
      LBackgr.Position.Y      := 0;
      LBackgr.Height          := LItem.Height;
      LBackgr.Align           := FMX.Types.TAlignLayout.Client;
      LBackgr.Fill.Color      := LItem.TagString.ToInteger();
      LBackgr.Fill.Kind       := FMX.Graphics.TBrushKind.Solid;
      LBackgr.Stroke.Color    := LBackgr.Fill.Color;
      LBackgr.Stroke.Kind     := FMX.Graphics.TBrushKind.None;
      LBackgr.Margins.Left    := 8;
      LBackgr.Margins.Top     := 8;
      LBackgr.Margins.Right   := 8;
      LBackgr.Margins.Bottom  := 0;
      LItem.TagObject         := LBackgr;
      LLblName                := TLabel.Create(LItem);
      LLblName.Parent         := LBackgr;
      LLblName.StyledSettings := [];
      LLblName.AutoSize       := False;
      LLblName.Position.Y     := 0;
      LLblName.Height         := LItem.Height;
      LLblName.Align          := FMX.Types.TAlignLayout.Client;
      LLblName.WordWrap       := False;
      LLblName.Text           := LRow.S['NAME'];
      LLblName.Font.Size      := 20;
      LLblName.Font.Style     := [System.UITypes.TFontStyle.fsBold];
      LLblName.FontColor      := $FFFFFFFF;
      LLblName.TextSettings.HorzAlign := FMX.Types.TTextAlign.Center;
      j := j + 1;
    end;
  end
end;

procedure TFormMain.FillTMC(const TMC_GROUP_ID:Integer);
var
  LRow         :TJsonObject;
  LItem        :TListBoxItem;
  LBackgr      :TRectangle;
  LImage       :TImage;
  LLblName     :TLabel;
  LLblComent   :TLabel;
  LLblEdzim    :TLabel;
  LLblPrice    :TLabel;
  LComent      :string;
  i, j         :Integer;
begin
  FlbxTMC.Clear;
  FlbxTMC.Columns    := Trunc(Width / 330);
  FlbxTMC.ItemHeight := 344;
  FlbxTMC.ItemWidth  := 332;
  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].O[i];
    if( (LRow.S['TMC_GROUP_ID'] = TMC_GROUP_ID.ToString()) and (LRow.S['FLAG_DELETE']='0') and (LRow.S['FLAG_LOCKED']='0') )then
    begin
      LComent := LRow.S['COMENT'];
      if(LComent.Length > 80)then
        LComent := Copy(LComent, 0, 80) + '...';
      LItem                     := TListBoxItem.Create(Self);
      LItem.Parent              := FlbxTMC;
      LItem.Height              := FlbxTMC.ItemHeight;
      LItem.Width               := FlbxTMC.ItemWidth;
      LItem.Tag                 := LRow.S['ID'].ToInteger();
      LItem.TagString           := MaterialColor(j).ToString();
      LItem.OnClick             := DoClick_TMC;
      LItem.OnMouseDown         := DoListItemMouseDown;
      LItem.OnMouseUp           := DoListItemMouseUp;
      LBackgr                   := TRectangle.Create(LItem);
      LBackgr.Parent            := LItem;
      LBackgr.HitTest           := False;
      LBackgr.Position.X        := 0;
      LBackgr.Position.Y        := 0;
      LBackgr.Height            := LItem.Height;
      LBackgr.Width             := LItem.Width;
      LBackgr.Align             := FMX.Types.TAlignLayout.Client;
      LBackgr.Fill.Color        := LItem.TagString.ToInteger();
      LBackgr.Fill.Kind         := FMX.Graphics.TBrushKind.Solid;
      LBackgr.Stroke.Color      := LBackgr.Fill.Color;
      LBackgr.Stroke.Kind       := FMX.Graphics.TBrushKind.None;
      LBackgr.Margins.Left      := 8;
      LBackgr.Margins.Top       := 8;
      LBackgr.Margins.Right     := 8;
      LBackgr.Margins.Bottom    := 8;
      LBackgr.Padding.Left      := 16;
      LBackgr.Padding.Top       := 16;
      LBackgr.Padding.Right     := 16;
      LBackgr.Padding.Bottom    := 16;
      LItem.TagObject           := LBackgr;

      LImage                    := TImage.Create(LItem);
      LImage.Parent             := LBackgr;
      LImage.Height             := 220;
      LImage.Align              := FMX.Types.TAlignLayout.Top;
      LImage.WrapMode           := FMX.Objects.TImageWrapMode.Stretch;
      LImage.Tag                := LItem.Tag;
      LImage.TagString          := LItem.TagString;
      LImage.OnClick            := DoClick_TMC;
      try
        LImage.Bitmap.LoadFromFile( GetTMCImage(LRow.S['ID'].ToInteger()) );
      except
        LImage.Bitmap.LoadFromFile( GetTMCImage(0) );
      end;
      LLblName                  := TLabel.Create(LItem);
      LLblName.Parent           := LBackgr;
      LLblName.StyledSettings   := [];
      LLblName.AutoSize         := False;
      LLblName.Position.Y       := LImage.Height + 2;
      LLblName.Height           := 20;
      LLblName.Align            := FMX.Types.TAlignLayout.Top;
      LLblName.WordWrap         := False;
      LLblName.Text             := LRow.S['NAME'];
      LLblName.Font.Size        := 16;
      LLblName.Font.Style       := [System.UITypes.TFontStyle.fsBold];
      LLblName.FontColor        := $FFFFFFFF;
      LLblName.TextAlign        := FMX.Types.TTextAlign.Leading;
      LLblName.VertTextAlign    := FMX.Types.TTextAlign.Leading;

      LLblComent                := TLabel.Create(LItem);
      LLblComent.Parent         := LBackgr;
      LLblComent.StyledSettings := [];
      LLblComent.AutoSize       := False;
      LLblComent.Position.Y     := LLblName.Position.Y + LLblName.Height + 2;
      LLblComent.Height         := 32;
      LLblComent.Align          := FMX.Types.TAlignLayout.Top;
      LLblComent.WordWrap       := True;
      LLblComent.Text           := LComent;
      LLblComent.Font.Size      := 10;
      LLblComent.Font.Style     := [];
      LLblComent.FontColor      := $FFFFFFFF;
      LLblComent.TextAlign      := FMX.Types.TTextAlign.Leading;
      LLblComent.VertTextAlign  := FMX.Types.TTextAlign.Leading;

      LLblPrice                 := TLabel.Create(LItem);
      LLblPrice.Parent          := LBackgr;
      LLblPrice.StyledSettings  := [];
      LLblPrice.AutoSize        := False;
      LLblPrice.Position.Y      := LLblComent.Position.Y + LLblComent.Height;
      LLblPrice.Height          := 48;
      LLblPrice.Align           := FMX.Types.TAlignLayout.Top;
      LLblPrice.WordWrap        := True;
      LLblPrice.Text            := Restourant.Consts.Strings.TmcPrice + ' ' + FormatFloat('# ### ##0.00', SafeFloat(LRow.S['PRICE']) );
      LLblPrice.Font.Size       := 24;
      LLblPrice.Font.Style      := [System.UITypes.TFontStyle.fsBold];
      LLblPrice.FontColor       := $FFFFFFFF;
      LLblPrice.TextAlign       := FMX.Types.TTextAlign.Trailing;
      LLblPrice.VertTextAlign   := FMX.Types.TTextAlign.Leading;

      LLblEdzim                 := TLabel.Create(LItem);
      LLblEdzim.Parent          := LLblPrice;
      LLblEdzim.StyledSettings  := [];
      LLblEdzim.AutoSize        := False;
      LLblEdzim.Position.X      := 0;
      LLblEdzim.Position.Y      := 0;
      LLblEdzim.Height          := 20;
      LLblEdzim.Width           := 160;
      LLblEdzim.Align           := FMX.Types.TAlignLayout.Left;
      LLblEdzim.Text            := Restourant.Consts.Strings.TmcEdizm + ' ' + LRow.S['EDIZM_SNAME'];
      LLblEdzim.Font.Size       := 14;
      LLblEdzim.Font.Style      := [System.UITypes.TFontStyle.fsBold];
      LLblEdzim.FontColor       := $FFFFFFFF;
      LLblEdzim.TextAlign       := FMX.Types.TTextAlign.Leading;
      LLblEdzim.VertTextAlign   := FMX.Types.TTextAlign.Leading;
      j := j + 1;
    end;
  end;
  if(FlbxTMC.Count > 0)then
    FlbxTMC.ItemIndex := 0;
end;

procedure TFormMain.FillCard(const TMC_ID, aColor: Integer);
var
  LRow :TJsonObject;
  i    :Integer;
begin
  LRow := GetTMCObject(TMC_ID);
  if(LRow = nil)then exit;

  FVbgrTMC.Fill.Color    := aColor;
  FVimgTMC_IMAGE.Bitmap.Clear( FVbgrTMC.Fill.Color );
  FVimgTMC_IMAGE.Bitmap.LoadFromFile( GetTMCImage(TMC_ID) );
  FVimgTMC_IMAGE.Height  := 220;
  FVimgTMC_IMAGE.Tag     := TMC_ID;

  FVlblTMC_NAME.Text   := LRow.S['NAME'];
  FVlblTMC_COMENT.Text := LRow.S['COMENT'];
  FVlblTMC_PRICE.Text  := Restourant.Consts.Strings.TmcPrice + ' ' + FormatFloat('# ### ##0.00', SafeFloat(LRow.S['PRICE']));
  FVlblTMC_EDIZM.Text  := Restourant.Consts.Strings.TmcEdizm + ' ' + LRow.S['EDIZM_SNAME'];

  FHbgrTMC.Fill.Color    := aColor;
  FHimgTMC_IMAGE.Bitmap.Clear( FVbgrTMC.Fill.Color );
  FHimgTMC_IMAGE.Bitmap.LoadFromFile( GetTMCImage(TMC_ID) );
  FHimgTMC_IMAGE.Width   := 330;
  FHimgTMC_IMAGE.Tag     := TMC_ID;

  FHlblTMC_NAME.Text   := LRow.S['NAME'];
  FHlblTMC_COMENT.Text := LRow.S['COMENT'];
  FHlblTMC_PRICE.Text  := Restourant.Consts.Strings.TmcPrice + ' ' + FormatFloat('# ### ##0.00', SafeFloat(LRow.S['PRICE']));
  FHlblTMC_EDIZM.Text  := Restourant.Consts.Strings.TmcEdizm + ' ' + LRow.S['EDIZM_SNAME'];

  if(Height > Width)then
  begin
    FVimgTMC_IMAGE.Height := Trunc(Width * 2 / 3);
    FtcTMC.ActiveTab := FtiTMCV;
  end
  else
  begin
    FHimgTMC_IMAGE.Width  := Trunc( ( Height - (FTopBar.Height + 16)*2 ) * 3 / 2);
    FtcTMC.ActiveTab := FtiTMCH;
  end;
end;

procedure TFormMain.actBackExecute(Sender: TObject);
begin
  if CanBack then
    DoBack;
end;

procedure TFormMain.actMenuExecute(Sender: TObject);
begin
  FtcMain.ActiveTab := FtiMainMenu;
end;

procedure TFormMain.actOrderExecute(Sender: TObject);
begin
  FtcMain.ActiveTab := FtiMainOrder;
end;

procedure TFormMain.actUserExecute(Sender: TObject);
begin
  FtcMain.ActiveTab := FtiMainUser;
end;

end.

