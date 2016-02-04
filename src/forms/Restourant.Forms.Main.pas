unit Restourant.Forms.Main;
interface
uses
  System.SysUtils,  System.IOUtils, System.Types, System.UITypes
 ,System.Classes, System.Variants, System.Actions, System.ImageList
 ,FMX.Types, FMX.Graphics, FMX.Objects, FMX.Controls, FMX.Controls.Presentation
 ,FMX.StdCtrls, FMX.Forms, FMX.Dialogs, FMX.TabControl, FMX.Gestures
 ,FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.DateTimeCtrls
 ,Restourant.Consts.Strings
 ,Restourant.JsonDataObject, Restourant.JsonDatabase
 ;
type
  TFormMain = class(TForm)
  private
    {$REGION 'Main components'}
    FDB                         :TJsonDataBase;
    FUDB                        :TJsonDataBase;
    FTimerUpdate                :FMX.Types.TTimer;
    FTimerOrder                 :FMX.Types.TTimer;
    FGestMan                    :FMX.Gestures.TGestureManager;
    {$ENDREGION 'Main components'}
    {$REGION 'Controls declaration and placement'}
    FTopBar                     :FMX.Objects.TRectangle;
      FTopBtnBack               :FMX.Objects.TRectangle;
        FTopBtnBackImg          :FMX.Objects.TImage;
      FTopBtnMenu               :FMX.Objects.TRectangle;
        FTopBtnMenuImg          :FMX.Objects.TImage;
      FTopBtnOrder              :FMX.Objects.TRectangle;
        FTopBtnOrderImg         :FMX.Objects.TImage;
      FTopBtnUser               :FMX.Objects.TRectangle;
        FTopBtnUserImg          :FMX.Objects.TImage;
      FTopBtnLang               :FMX.Objects.TRectangle;
        FTopBtnLangImg          :FMX.Objects.TImage;
    FRightBar                   :FMX.Objects.TRectangle;
      FLangBtn                  :array[TLang] of FMX.Objects.TRectangle;
    FtcMain                     :FMX.TabControl.TTabControl;
      FtiMainMenu               :FMX.TabControl.TTabItem;
        FtcMenu                 :FMX.TabControl.TTabControl;
          FtiMenuCat            :FMX.TabControl.TTabItem;
            FlbxCategory        :FMX.ListBox.TListBox;
            LlblRestourantName  :FMX.StdCtrls.TLabel;
            LlblRestouarntAddr  :FMX.StdCtrls.TLabel;
          FtiMenuGroup          :FMX.TabControl.TTabItem;
            FlbxGroup           :FMX.ListBox.TListBox;
          FtiMenuList           :FMX.TabControl.TTabItem;
            FlbxList            :FMX.ListBox.TListBox;
          FtiMenuTMC            :FMX.TabControl.TTabItem;
            FtcTMC              :FMX.TabControl.TTabControl;
              FtiTMCH           :FMX.TabControl.TTabItem;
                FVbgrTMC        :FMX.Objects.TRectangle;
                FVimgTMC        :FMX.Objects.TImage;
                FVlblTMC_NAME   :FMX.StdCtrls.TLabel;
                FVlblTMC_COMENT :FMX.StdCtrls.TLabel;
                FVlblTMC_PRICE  :FMX.StdCtrls.TLabel;
                  FVlblTMC_EDIZM:FMX.StdCtrls.TLabel;
                FVLayoutQuant   :FMX.Layouts.TLayout;
                  FVbtnPlus     :FMX.Objects.TRectangle;
                  FVlblQuant    :FMX.StdCtrls.TLabel;
                  FVbtnMinus    :FMX.Objects.TRectangle;
              FtiTMCV           :FMX.TabControl.TTabItem;
                FHbgrTMC        :FMX.Objects.TRectangle;
                FHimgTMC        :FMX.Objects.TImage;
                FHlblTMC_NAME   :FMX.StdCtrls.TLabel;
                FHlblTMC_COMENT :FMX.StdCtrls.TLabel;
                FHlblTMC_PRICE  :FMX.StdCtrls.TLabel;
                FHlblTMC_EDIZM  :FMX.StdCtrls.TLabel;
                FHLayoutQuant   :FMX.Layouts.TLayout;
                  FHbtnPlus     :FMX.Objects.TRectangle;
                  FHlblQuant    :FMX.StdCtrls.TLabel;
                  FHbtnMinus    :FMX.Objects.TRectangle;
      FtiMainOrder              :FMX.TabControl.TTabItem;
        FtcOrder                :FMX.TabControl.TTabControl;
          FtiOrdersList         :FMX.TabControl.TTabItem;
            FlbxOrdersList      :FMX.ListBox.TListBox;
            FbtnOrdersClear     :FMX.StdCtrls.TButton;
          FtiOrder              :FMX.TabControl.TTabItem;
            FbgrOrder           :FMX.Objects.TImage;
              FlblOrderNoCapt   :FMX.StdCtrls.TLabel;
              FlblOrderNo       :FMX.StdCtrls.TLabel;
              FlblOrderDateCapt :FMX.StdCtrls.TLabel;
              FedtOrderDate     :FMX.DateTimeCtrls.TDateEdit;
              FlblOrderHdrImg   :FMX.StdCtrls.TLabel;
              FlblOrderHdrTmc   :FMX.StdCtrls.TLabel;
              FlblOrderHdrPrice :FMX.StdCtrls.TLabel;
              FlblOrderHdrQuant :FMX.StdCtrls.TLabel;
              FlblOrderHdrTotal :FMX.StdCtrls.TLabel;
              FlbxOrder         :FMX.ListBox.TListBox;
              FlblOrderFtrTmc   :FMX.StdCtrls.TLabel;
              FlblOrderFtrTotal :FMX.StdCtrls.TLabel;
              FlblOrderName     :FMX.StdCtrls.TLabel;
              FedtOrderName     :FMX.Edit.TEdit;
              FbtnOrderSend     :FMX.StdCtrls.TButton;
      FtiMainUser               :FMX.TabControl.TTabItem;
        FsbUser                 :FMX.Layouts.TScrollBox;
          FbgrUser              :FMX.Objects.TImage;
            FlblUsrID           :FMX.StdCtrls.TLabel;
            FlblUsrFIRSTNAME    :FMX.StdCtrls.TLabel;
            FlblUsrLASTNAME     :FMX.StdCtrls.TLabel;
            FlblUsrPHONE        :FMX.StdCtrls.TLabel;
            FlblUsrPWD          :FMX.StdCtrls.TLabel;
            FlblUsrPWD2         :FMX.StdCtrls.TLabel;
            FedtUsrID           :FMX.Edit.TEdit;
            FedtUsrFIRSTNAME    :FMX.Edit.TEdit;
            FedtUsrLASTNAME     :FMX.Edit.TEdit;
            FedtUsrPHONE        :FMX.Edit.TEdit;
            FedtUsrPWD          :FMX.Edit.TEdit;
            FedtUsrPWD2         :FMX.Edit.TEdit;
            FbtnUsrRegister     :FMX.StdCtrls.TButton;
    {$ENDREGION 'Controls declaration and placement'}
    procedure   actBackExecute     (Sender :TObject);
    procedure   actMenuExecute     (Sender :TObject);
    procedure   actOrderExecute    (Sender :TObject);
    procedure   actUserExecute     (Sender :TObject);
    procedure   DoEnterEditUser    (Sender :TObject);
    procedure   DoChangeTabControl (Sender :TObject);
    procedure   DoClickLangBtn     (Sender: TObject);
    procedure   DoClickLang        (Sender: TObject);
    procedure   DoClickCategory    (Sender: TObject);
    procedure   DoClickGroup       (Sender: TObject);
    procedure   DoClickList        (Sender: TObject);
    procedure   DoClickOrder       (Sender: TObject);
    procedure   DoClickTmcPlus     (Sender: TObject);
    procedure   DoClickTmcMinus    (Sender: TObject);
    procedure   DoClickUserRegister(Sender: TObject);
    procedure   DoClickOrderSend   (Sender: TObject);
    procedure   DoClickOrdersClear (Sender: TObject);
    procedure   DoChangeOrderName  (Sender :TObject);
    procedure   DoMouseDownListItem(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoMouseUpListItem  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoMouseDownTopBtn  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoMouseUpTopBtn    (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoMouseDownBtn     (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoMouseUpBtn       (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure   DoLangChange;
    procedure   DoOnTimerUpdate    (Sender :TObject);
    procedure   DoOnTimerOrder     (Sender :TObject);
    {$REGION 'Visual style methods'}
    function    ColorMaterial(const ColorIndex:Integer):Integer;
    function    ColorButtonTopBar(const Value:Boolean):TColor;
    function    ColorButtonOrder(const Value:Boolean):TColor;
    procedure   ImageLoadFromResource(Bitmap :TBitmap; const BackgroundResource:string);
    function    ImageFileNameTMC(const TMC_ID:Integer):string;
    {$ENDREGION 'Visual style methods'}
    {$REGION 'Archives and rosources'}
    function    ExtractFileArchive(const ArchiveName, DestinationPath:string):Boolean;
    function    ExtractFileFromResource(const Resource, ToFileName: string): Boolean;
    {$ENDREGION 'Archives and rosources'}
    {$REGION 'Create controls methods'}
    procedure   CreateControlsTopBar;
    procedure   CreateControlsOrd   (aParentObj :TFMXObject);
    procedure   CreateControlsUser  (aParentObj :TFMXObject);
    procedure   CreateControlsTMCHor(aParentObj :TFMXObject);
    procedure   CreateControlsTMCVer(aParentObj :TFMXObject);
    function    CreateListbox(aParentObj :TFMXObject; const BackgroundResource:string):FMX.ListBox.TListBox;
    function    CreateListBoxItem(aListBox: FMX.ListBox.TListBox; const aItemHeight, aItemWidth :Single;
                  const aTag, aColorIndex:Integer; aOnClick, aOnDblClick:TNotifyEvent; var aBackground :FMX.Objects.TRectangle):FMX.ListBox.TListBoxItem;
    function    CreateTopButton(const AnAlign:FMX.Types.TAlignLayout;
                  const ResourceName:string; AnOnClick:TNotifyEvent; var AnImage:FMX.Objects.TImage):FMX.Objects.TRectangle;
    function    CreateRectButton(Parent:TControl; const aWidth:Integer; const AnAlign:FMX.Types.TAlignLayout; const Caption, ResourceName:string; AnOnClick:TNotifyEvent): FMX.Objects.TRectangle;
    {$ENDREGION 'Create controls methods'}
  public
    procedure   Resize;                                                                 override;
    procedure   KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
  public
    FLang       :Restourant.Consts.Strings.TLang;
    FFlagOrder  :Boolean;
    FOrderCurr  :TJsonObject;
    function    DataBaseFilePath(const FileName:string):string;
    procedure   DataBaseCreate;
    procedure   DataBaseFree;
    function    DataBaseConstInteger(const ConstName:string):Integer;
    function    DataBaseConstString(const ConstName:string):string;
    function    DataBaseTMCObject(const TMC_ID:Integer):TJsonObject;
    function    DataBaseTmcCtgrIdByGroup(const TMC_GROUP_ID:Integer):string;
    function    DataBaseGetFieldLocal(Row:TJsonObject; FieldName:string = 'NAME'):string;
    procedure   UserBaseCreate;
    procedure   UserBaseFree;
    function    UserBaseFilePath(const FileName:string):string;
    function    UserBaseOrderNew:TJsonObject;
    function    UserBaseOrderLast:TJsonObject;
    function    UserBaseOrderLastID:Integer;
    function    UserBaseOrderName(const ID :Integer):string;
    function    UserBaseOrderById(const ID :Integer):TJsonObject;
    procedure   UserBaseOrderPlus  (const TMC_ID:Integer);
    procedure   UserBaseOrderMinus (const TMC_ID:Integer);
    function    UserBaseOrderQntGet(const TMC_ID:Integer):Double;
    procedure   UserBaseOrderQntSet(const TMC_ID:Integer; const Value:Double);
    procedure   UserBaseOrderCalcSum;
    procedure   UserBaseUserLoad;
    function    UserDataUserSave:Boolean;
    {$REGION 'Internet'}
    function    HTTPGetString(const Host, URL:string):string;
    function    HTTPGetFile(const Host, URL, FileName:string):Boolean;
    function    HTTPPost(const Host, URL: string; const ParamNames, ParamValues:array of string): string;
    function    HTTPPostJSON(const Host, URL, PostJSON:string):string;
    {$ENDREGION}
  public
    constructor CreateNew(AOwner: TComponent; Dummy: NativeInt = 0); override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    CanBack:Boolean;
    procedure   DoBack;
    function    FolderMyDocuments:string;
    function    FoldersCheck:Boolean;
    procedure   FillCat;
    procedure   FillGroups(const TMC_CTGR_ID:Integer);
    procedure   FillList(const TMC_GROUP_ID:Integer);
    procedure   FillCard(const TMC_ID:Integer; const aColor:TColor);
    procedure   FillUser;
    procedure   FillOrders;
    procedure   FillOrder(anOrder:TJsonObject);
  end;

var
  FormMain: TFormMain;

implementation

uses
  Restourant.Consts.Filenames, Restourant.Consts.Database, Restourant.Consts.UserData
 ,Restourant.Consts.Colors
 ,System.Zip, System.Math
 ,FMX.Helpers.Controls
 ,Network
 ,IdHTTP, IdComponent
 ;

function SafeFloat(const Value: string; DefaultValue :Extended = 0): Extended;
var
  LTempStr :string;
begin
  Result   := DefaultValue;
  LTempStr := Value;
  try
    LTempStr := LTempStr.Replace('.', System.SysUtils.FormatSettings.DecimalSeparator);
    LTempStr := LTempStr.Replace(',', System.SysUtils.FormatSettings.DecimalSeparator);
    Result   := LTempStr.ToExtended();
  except
    Result := DefaultValue;
  end;
end;

function TFormMain.ColorMaterial(const ColorIndex: Integer): Integer;
var
  LIndex :Integer;
begin
  LIndex := ColorIndex;
  if(LIndex >= Length(Restourant.Consts.Colors.Material))then
    LIndex := ColorIndex mod Length(Restourant.Consts.Colors.Material);
  Result := Restourant.Consts.Colors.Material[LIndex];
end;

function TFormMain.ColorButtonOrder(const Value: Boolean): TColor;
begin
  if Value then
    Result := $FFFF0000
  else
    Result := FTopBar.Fill.Color;
end;

function TFormMain.ColorButtonTopBar(const Value: Boolean): TColor;
begin
  if Value then
    Result := $FF000000
  else
    Result := FTopBar.Fill.Color;
end;

function TFormMain.ImageFileNameTMC(const TMC_ID: Integer): string;
var
  LFolder:string;
begin
  LFolder := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Filenames.FolderImages);
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

function TFormMain.ExtractFileArchive(const ArchiveName, DestinationPath: string): Boolean;
begin
  Result := True;
  try
    TZipFile.ExtractZipFile( ArchiveName, DestinationPath );
  except
    Result := False;
  end;
end;

function TFormMain.ExtractFileFromResource(const Resource, ToFileName: string): Boolean;
begin
  Result := False;
  with TResourceStream.Create( hInstance, Resource, RT_RCDATA ) do
  try
    SaveToFile( ToFileName );
  finally
    Free;
  end;
  Result := True;
end;

procedure TFormMain.DataBaseCreate;
begin
  if(FDB <> nil)then
    DataBaseFree;
  FDB := TJsonDataBase.Create(Self);
  with FDB do
  begin
    DataBasePath := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Database.Folder);
    FileExt      := Restourant.Consts.Database.FileExt;
    AddTable( Restourant.Consts.Database.C );
    AddTable( Restourant.Consts.Database.R_TMC_CTGR );
    AddTable( Restourant.Consts.Database.R_TMC_GROUPSHARE );
    AddTable( Restourant.Consts.Database.R_TMC );
  end;
end;

procedure TFormMain.DataBaseFree;
begin
  if(FDB <> nil)then
    FreeAndNil(FDB);
end;

function TFormMain.DataBaseFilePath(const FileName: string): string;
begin
  Result := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Database.Folder);
  Result := System.IOUtils.TPath.Combine(Result, FileName + Restourant.Consts.Database.FileExt);
end;

function TFormMain.DataBaseConstInteger(const ConstName: string): Integer;
var
  LCounter :Integer;
begin
  Result := 0;
  with FDB.Tables[Restourant.Consts.Database.C] do
    for LCounter:=0 to A[Restourant.Consts.Database.Section].Count-1 do
      if(A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstID] = ConstName )then
      begin
        Result := A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstFINT].ToInteger();
        Break;
      end;
end;

function TFormMain.DataBaseConstString(const ConstName: string): string;
var
  LCounter :Integer;
  LName    :string;
begin
  Result := System.SysUtils.EmptyStr;
  if(FLang = Restourant.Consts.Strings.TLang.lngRUS)then
  begin
    with FDB.Tables[Restourant.Consts.Database.C] do
      for LCounter:=0 to A[Restourant.Consts.Database.Section].Count-1 do
        if(A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstID] = ConstName )then
        begin
          Result := A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstFSTR];
          Break;
        end;
  end
  else
  begin
    LName := ConstName + TLangToInt(FLang).ToString;
    with FDB.Tables[Restourant.Consts.Database.C] do
      for LCounter:=0 to A[Restourant.Consts.Database.Section].Count-1 do
        if(A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstID] = LName )then
        begin
          Result := A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstFSTR];
          Break;
        end;
    if(Result = System.SysUtils.EmptyStr)then
      with FDB.Tables[Restourant.Consts.Database.C] do
        for LCounter:=0 to A[Restourant.Consts.Database.Section].Count-1 do
          if(A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstID] = ConstName)then
          begin
            Result := A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldConstFSTR];
            Break;
          end;
  end;
end;


function TFormMain.DataBaseTMCObject(const TMC_ID: Integer): TJsonObject;
var
  LCounter :Integer;
begin
  Result := nil;
  with FDB.Tables[Restourant.Consts.Database.R_TMC] do
    for LCounter:=0 to A[Restourant.Consts.Database.Section].Count-1 do
      if(A[Restourant.Consts.Database.Section].O[LCounter].S[Restourant.Consts.Database.FieldRefID] = TMC_ID.ToString())then
      begin
        Result := A[Restourant.Consts.Database.Section].O[LCounter];
        Break;
      end;
end;

function TFormMain.DataBaseGetFieldLocal(Row: TJsonObject; FieldName: string = 'NAME'): string;
var
  LFieldName:string;
begin
  if(FLang = Restourant.Consts.Strings.TLang.lngRUS)then
  begin
    Result := Row.S[FieldName];
  end
  else
  begin
    LFieldName := FieldName + Restourant.Consts.Strings.TLangToInt(FLang).ToString;
    Result := Row.S[LFieldName];
    if( not(Result.Length > 0) )then
      Result := Row.S[FieldName];
  end;
end;

function TFormMain.DataBaseTmcCtgrIdByGroup(const TMC_GROUP_ID:Integer):string;
var
  LCounter  :Integer;
  LCategory :string;
begin
  Result := '1';
  LCategory := System.SysUtils.EmptyStr;
  with FDB[Restourant.Consts.Database.R_TMC_GROUPSHARE].A[Restourant.Consts.Database.Section] do
    for LCounter:=0 to Count-1 do
      if(O[LCounter].S[Restourant.Consts.Database.FieldRefTMC_GROUP_ID] = TMC_GROUP_ID.ToString() )then
      begin
        LCategory := O[LCounter].S[Restourant.Consts.Database.FieldRefGROUPNAME];
        Break;
      end;
  if(LCategory = System.SysUtils.EmptyStr)then exit;
  with FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section] do
    for LCounter:=0 to Count-1 do
      if(O[LCounter].S[Restourant.Consts.Database.FieldRefNAME] = LCategory)then
      begin
        Result := O[LCounter].S[Restourant.Consts.Database.FieldRefID];
        Break;
      end;
end;

procedure TFormMain.UserBaseCreate;
begin
  if(FUDB <> nil)then
    UserBaseFree;
  FUDB := TJsonDataBase.Create(Self);
  with FUDB do
  begin
    DataBasePath := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.UserData.Folder);
    FileExt      := Restourant.Consts.UserData.FileExt;
    if not TFile.Exists( System.IOUtils.TPath.Combine(DataBasePath, Restourant.Consts.UserData.PROFILE + Restourant.Consts.UserData.FileExt) ) then
    begin
      NewTable( Restourant.Consts.UserData.PROFILE );
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserID]        := System.SysUtils.EmptyStr;
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserEMAIL]     := System.SysUtils.EmptyStr;
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserFIRSTNAME] := System.SysUtils.EmptyStr;
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserLASTNAME]  := System.SysUtils.EmptyStr;
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserPHONE]     := Network.PhoneNumberLine1;
      Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserPWD]       := System.SysUtils.EmptyStr;
      Flush(Restourant.Consts.UserData.PROFILE);
    end
    else
    begin
      AddTable( Restourant.Consts.UserData.PROFILE );
      if(Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserLang] = System.SysUtils.EmptyStr)then
        Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserLang] := TLangToInt(Low(Restourant.Consts.Strings.TLang)).ToString;
      FLang := IntToTLang( Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserLang].ToInteger );
    end;

    if not TFile.Exists( System.IOUtils.TPath.Combine(DataBasePath, Restourant.Consts.UserData.ORDERS + Restourant.Consts.UserData.FileExt) ) then
    begin
      NewTable( Restourant.Consts.UserData.ORDERS );
    end
    else
      AddTable( Restourant.Consts.UserData.ORDERS );
  end;
end;

procedure TFormMain.UserBaseFree;
begin
  if(FUDB <> nil)then
  begin
    FUDB.Clear(True);
    FreeAndNil(FUDB);
  end;
end;

function TFormMain.UserBaseFilePath(const FileName: string): string;
begin
  Result := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.UserData.Folder);
  Result := System.IOUtils.TPath.Combine(Result, FileName + Restourant.Consts.UserData.FileExt);
end;

function TFormMain.UserBaseOrderLastID:Integer;
var
  LObj     :TJsonObject;
  LCounter :Integer;
begin
  Result := 0;
  for LCounter:=0 to FUDB.Tables[Restourant.Consts.UserData.ORDERS].Count-1 do
  begin
    LObj := FUDB.Tables[Restourant.Consts.UserData.ORDERS].Items[LCounter]^.ObjectValue;
    Result := System.Math.Max(Result, LObj.I[Restourant.Consts.UserData.FieldOrderID] );
  end;
end;

procedure TFormMain.UserBaseOrderPlus(const TMC_ID: Integer);
begin
  UserBaseOrderQntSet(TMC_ID, UserBaseOrderQntGet(TMC_ID) + 1);
end;

procedure TFormMain.UserBaseOrderMinus(const TMC_ID: Integer);
begin
  UserBaseOrderQntSet(TMC_ID, UserBaseOrderQntGet(TMC_ID) - 1);
end;

function TFormMain.UserBaseOrderQntGet(const TMC_ID: Integer): Double;
var
  LCounter :Integer;
begin
  Result := 0;
  with FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT] do
    for LCounter := 0 to Count-1 do
      if(O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID] = TMC_ID)then
      begin
        Result := O[LCounter].F[Restourant.Consts.UserData.FieldDocQUANT];
        Break;
      end;
end;

procedure TFormMain.UserBaseOrderQntSet(const TMC_ID: Integer; const Value: Double);
var
  LCounter :Integer;
  LTmcItem :TJsonObject;
  LDocItem :TJsonObject;
begin
  LDocItem := nil;
  with FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT] do
    for LCounter := 0 to Count-1 do
      if(O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID] = TMC_ID)then
      begin
        if(Value <= 0)then
        begin
          FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT].Delete(LCounter);
          UserBaseOrderCalcSum;
          Exit;
        end
        else
        begin
          LDocItem := O[LCounter];
          Break;
        end;
      end;
  if( (LDocItem = nil) and (Value <= 0) )then exit;
  LTmcItem := DataBaseTMCObject(TMC_ID);
  if(LDocItem = nil)then
  begin
    LDocItem := FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT].AddObject;
    LDocItem.S[Restourant.Consts.UserData.FieldDocNAME       ] := System.SysUtils.EmptyStr;
    LDocItem.I[Restourant.Consts.UserData.FieldDocTMC_ID     ] := TMC_ID;
  end;
  LDocItem.F[Restourant.Consts.UserData.FieldDocPRICE      ] := SafeFloat(LTmcItem.S[Restourant.Consts.Database.FieldRefPRICE]);
  LDocItem.F[Restourant.Consts.UserData.FieldDocQUANT      ] := Value;
  LDocItem.F[Restourant.Consts.UserData.FieldDocTOTAL      ] := SafeFloat(LTmcItem.S[Restourant.Consts.Database.FieldRefPRICE]) * Value;
  UserBaseOrderCalcSum;
end;

procedure TFormMain.UserBaseOrderCalcSum;
var
  LCounter :Integer;
  LSum     :Double;
begin
  LSum := 0;
  with FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT] do
    for LCounter := 0 to Count-1 do
      LSum := LSum + O[LCounter].F[Restourant.Consts.UserData.FieldDocTOTAL];
  FOrderCurr.F[Restourant.Consts.UserData.FieldOrderDOCSUM] := LSum;
  FUDB.Flush(Restourant.Consts.UserData.ORDERS);
end;

function TFormMain.UserBaseOrderLast: TJsonObject;
begin
  with FUDB.Tables[Restourant.Consts.UserData.ORDERS] do
    if(Count = 0)then
      Result := UserBaseOrderNew
    else
      Result := Items[Count-1]^.ObjectValue;
end;

function TFormMain.UserBaseOrderName(const ID: Integer): string;
begin
  Result := Restourant.Consts.UserData.ORDERSNAME + FormatFloat('000000', ID);
end;

function TFormMain.UserBaseOrderById(const ID: Integer): TJsonObject;
var
  LCounter :Integer;
begin
  Result := nil;
  with FUDB.Tables[Restourant.Consts.UserData.ORDERS] do
    for LCounter := 0 to Count-1 do
    begin
      Result := Items[LCounter]^.ObjectValue;
      if(Result.I[Restourant.Consts.UserData.FieldOrderID] = ID)then
        exit;
    end;
end;

function TFormMain.UserBaseOrderNew: TJsonObject;
var
  LName :string;
  LID   :Integer;
begin
  LID    := UserBaseOrderLastId + 1;
  LName  := UserBaseOrderName(LID);
  Result := FUDB.Tables[Restourant.Consts.UserData.ORDERS].O[LName];
  Result.I[Restourant.Consts.UserData.FieldOrderID          ] := LID;
  Result.S[Restourant.Consts.UserData.FieldOrderNAME        ] := System.SysUtils.EmptyStr;
  Result.D[Restourant.Consts.UserData.FieldOrderDATE_CREATE ] := System.SysUtils.Now;
  Result.D[Restourant.Consts.UserData.FieldOrderDATE_COMMIT ] := System.SysUtils.Now;
  Result.S[Restourant.Consts.UserData.FieldOrderPLATENO     ] := System.SysUtils.EmptyStr;
  Result.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] := System.SysUtils.EmptyStr;
  Result.F[Restourant.Consts.UserData.FieldOrderDOCSUM      ] := 0;
  FUDB.Flush(Restourant.Consts.UserData.ORDERS);
end;

procedure TFormMain.UserBaseUserLoad;
begin
  with FUDB.Tables[Restourant.Consts.UserData.PROFILE] do
  begin
    if(S[Restourant.Consts.UserData.FieldUserID] = System.SysUtils.EmptyStr)then
    begin
      FedtUsrID.Enabled    := True;
      FbtnUsrRegister.Text := DataBaseConstString('TEXTBTNREGISTER');
    end
    else
    begin
      FedtUsrID.Enabled    := False;
      FbtnUsrRegister.Text := DataBaseConstString('TEXTBTNAPPLY');
    end;
    FedtUsrID.Text       := S[Restourant.Consts.UserData.FieldUserEMAIL    ];
    FedtUsrFIRSTNAME.Text:= S[Restourant.Consts.UserData.FieldUserFIRSTNAME];
    FedtUsrLASTNAME.Text := S[Restourant.Consts.UserData.FieldUserLASTNAME ];
    FedtUsrPHONE.Text    := S[Restourant.Consts.UserData.FieldUserPHONE    ];
    FedtUsrPWD.Text      := System.SysUtils.EmptyStr;
    FedtUsrPWD2.Text     := System.SysUtils.EmptyStr;
  end;
end;

function TFormMain.UserDataUserSave:Boolean;
begin
  Result := False;
  if(FUDB.Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserID] = System.SysUtils.EmptyStr)then
  begin
    if(FedtUsrPWD.Text = System.SysUtils.EmptyStr)then
    begin
      ShowMessage(Restourant.Consts.Strings.ErrorUserPasswordNotEntered);
      exit;
    end;
  end;
  if( (FedtUsrPWD.Text <> System.SysUtils.EmptyStr) or (FedtUsrPWD2.Text <> System.SysUtils.EmptyStr) )then
    if( FedtUsrPWD.Text <> FedtUsrPWD2.Text )then
    begin
      ShowMessage(Restourant.Consts.Strings.ErrorUserPasswordNotConfirmed);
      exit;
    end;
  with FUDB.Tables[Restourant.Consts.UserData.PROFILE] do
  begin
    S[Restourant.Consts.UserData.FieldUserEMAIL]     := FedtUsrID.Text;
    S[Restourant.Consts.UserData.FieldUserFIRSTNAME] := FedtUsrFIRSTNAME.Text;
    S[Restourant.Consts.UserData.FieldUserLASTNAME]  := FedtUsrLASTNAME.Text;
    S[Restourant.Consts.UserData.FieldUserPHONE]     := FedtUsrPHONE.Text;
    if(FedtUsrPWD.Text <> System.SysUtils.EmptyStr)then
    begin
      S[Restourant.Consts.UserData.FieldUserPWDNEW]  := FedtUsrPWD.Text;
      if(S[Restourant.Consts.UserData.FieldUserID] = System.SysUtils.EmptyStr)then
        S[Restourant.Consts.UserData.FieldUserPWD]   := FedtUsrPWD.Text;
    end;
  end;
  FUDB.Flush(Restourant.Consts.UserData.PROFILE);
  Result := True;
end;

{$REGION 'Internet'}
function TFormMain.HTTPGetFile(const Host, URL, FileName: string): Boolean;
var
  LStream :TMemoryStream;
  LHttp   :TIdHTTP;
begin
  Result := False;
  LHttp := TIdHTTP.Create(nil);
  LStream := TMemoryStream.Create;
  try
    LHttp.Request.UserAgent := Restourant.Consts.Filenames.UrlUserAgent; // Important! Some hosters does not allow to working without client browser name.
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
  LHttp :IdHttp.TIdHttp;
begin
  Result := System.SysUtils.EmptyStr;
  LHttp  := IdHttp.TIdHTTP.Create;
  try
    LHttp.Request.UserAgent := Restourant.Consts.Filenames.UrlUserAgent; // Important! Some hosters does not allow to working without client browser name.
    LHttp.Request.Host      := Host;
    Result := LHttp.Get( URL );
  finally
    LHttp.Free;
  end;
end;

function TFormMain.HTTPPost(const Host, URL: string; const ParamNames, ParamValues:array of string): string;
var
  LHttp   :IdHttp.TIdHttp;
  LParams :TStringList;
  LCounter:Integer;
begin
  Result := System.SysUtils.EmptyStr;
  LHttp  := IdHttp.TIdHTTP.Create;
  try
    LHttp.HandleRedirects   := True;
    LHttp.ReadTimeout       := 8000;
    LHttp.Request.UserAgent := Restourant.Consts.Filenames.UrlUserAgent; // Important! Some hosters does not allow to working without client browser name.
    LHttp.Request.Host      := Host;
    LParams := TStringList.Create;
    LParams.Clear;
    for LCounter:=0 to Length(ParamNames)-1 do
      LParams.Add( ParamNames[LCounter] + '=' + ParamValues[LCounter]);
    Result := LHttp.Post( URL, LParams );
  finally
    LParams.Free;
    LHttp.Free;
  end;
end;

function TFormMain.HTTPPostJSON(const Host, URL, PostJSON: string): string;
begin
  Result := HTTPPost(Host, URL, [Restourant.Consts.Filenames.PostVariableJSON], [PostJSON]);
end;
{$ENDREGION 'Internet'}

function TFormMain.FolderMyDocuments: string;
begin
  Result := System.IOUtils.TPath.GetSharedDocumentsPath;
{$IFNDEF ANDROID}
  Result := System.IOUtils.TPath.GetDocumentsPath;
  Result := System.IOUtils.TPath.Combine(Result, Restourant.Consts.Filenames.FolderStore);
{$ENDIF}
end;

function TFormMain.FoldersCheck: Boolean;
var
  LFolder      :string;
  LFileArchive :string;
begin
  Result := False;
  // documents/data
  LFolder := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Database.Folder);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/userdata
  LFolder := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.UserData.Folder);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/images
  LFolder := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Filenames.FolderImages);
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/images/tmc
  LFolder := ExtractFilePath(ImageFileNameTMC(0));
  if not TDirectory.Exists(LFolder) then
    TDirectory.CreateDirectory(LFolder);
  // documents/data/
  if not TFile.Exists( DataBaseFilePath(Restourant.Consts.Database.C) ) then
  begin
    LFileArchive := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Database.PackedFile);
    if not TFile.Exists(LFileArchive) then
      ExtractFileFromResource(Restourant.Consts.Database.Resource,  LFileArchive);
    ExtractFileArchive(LFileArchive, ExtractFilePath( DataBaseFilePath(Restourant.Consts.Database.C) ) );
  end;
  // documents/images/tmc/noimage.jpg
  if not TFile.Exists( ImageFileNameTMC(0) ) then
  begin
    LFileArchive := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Filenames.FileNameImageTMCPacked);
    if not TFile.Exists(LFileArchive) then
      HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlImagesZip, LFileArchive );
    ExtractFileArchive(LFileArchive, ExtractFilePath(ImageFileNameTMC(0)) );
  end;
  Result := True;
end;

constructor TFormMain.Create(AOwner: TComponent);
begin
  CreateNew(aOwner, 0);
end;

constructor TFormMain.CreateNew(AOwner: TComponent; Dummy: NativeInt);
var
  LLayout :TLayout;
  LBgr    :FMX.Objects.TRectangle;
begin
  inherited CreateNew(aOwner, Dummy);
  FLang      := Low(Restourant.Consts.Strings.TLang);
  FoldersCheck;
  UserBaseCreate;
  DataBaseCreate;
  FOrderCurr := UserBaseOrderLast;

  FGestMan := FMX.Gestures.TGestureManager.Create(Self);

  CreateControlsTopBar;

  FtcMain := FMX.TabControl.TTabControl.Create(Self);
  with FtcMain do
  begin
    Parent      := Self;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiMainMenu  := FtcMain.Add(FMX.TabControl.TTabItem);
  FtiMainOrder := FtcMain.Add(FMX.TabControl.TTabItem);
  FtiMainUser  := FtcMain.Add(FMX.TabControl.TTabItem);
  FtcMain.ActiveTab := FtiMainMenu;

  FtcMenu  := FMX.TabControl.TTabControl.Create(Self);
  with FtcMenu do
  begin
    Parent      := FtiMainMenu;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiMenuCat   := FtcMenu.Add(FMX.TabControl.TTabItem);
  FtiMenuGroup := FtcMenu.Add(FMX.TabControl.TTabItem);
  FtiMenuList  := FtcMenu.Add(FMX.TabControl.TTabItem);
  FtiMenuTmc   := FtcMenu.Add(FMX.TabControl.TTabItem);
  FtcMenu.ActiveTab := FtiMenuCat;

  FtcTMC := FMX.TabControl.TTabControl.Create(Self);
  with FtcTMC do
  begin
    Parent      := FtiMenuTmc;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.None;
  end;
  FtiTMCH := FtcTMC.Add(FMX.TabControl.TTabItem); FtiTMCH.Text := 'H';
  FtiTMCV := FtcTMC.Add(FMX.TabControl.TTabItem); FtiTMCV.Text := 'V';
  FtcTMC.ActiveTab := FtiTMCV;

  FtcOrder := FMX.TabControl.TTabControl.Create(Self);
  with FtcOrder do
  begin
    Parent      := FtiMainOrder;
    Align       := FMX.Types.TAlignLayout.Client;
    TabPosition := FMX.TabControl.TTabPosition.Top;
  end;
  FtiOrdersList := FtcOrder.Add(FMX.TabControl.TTabItem);
  FtiOrder      := FtcOrder.Add(FMX.TabControl.TTabItem);
  FtcOrder.ActiveTab := FtiOrder;

  FlbxCategory   := CreateListbox(FtiMenuCat    ,'BACKGROUND');
  FlbxGroup      := CreateListbox(FtiMenuGroup  ,'BACKGROUND01');
  FlbxList       := CreateListbox(FtiMenuList   ,'BACKGROUND02');
  FlbxOrdersList := CreateListbox(FtiOrdersList ,'BACKGROUND03');

  CreateControlsTMCHor(FtiTMCH);
  CreateControlsTMCVer(FtiTMCV);
  CreateControlsOrd ( FtiOrder );
  CreateControlsUser( FtiMainUser  );

  FtcMain.OnChange := DoChangeTabControl;
  FtcMenu.OnChange := DoChangeTabControl;
  DoChangeTabControl(nil);

  LLayout   := TLayout.New(FtiMenuCat,FlbxCategory.Parent,0,1200,80,200,FMX.Types.TAlignLayout.Bottom,8,8,8,8,0,0,0,0);
    LlblRestourantName := FMX.StdCtrls.TLabel.New(FtiMenuCat,LLayout,0,0,32,200,FMX.Types.TAlignLayout.Top,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading,
                       $FF000000, 28, [System.UITypes.TFontStyle.fsBold]);
    LlblRestouarntAddr := FMX.StdCtrls.TLabel.New(FtiMenuCat,LLayout,0,40,LLayout.Height,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 12, [System.UITypes.TFontStyle.fsBold]);
  LlblRestourantName.Font.Family := 'Times New Roman';

  LBgr := FMX.Objects.TRectangle.New(FtiOrdersList, FtiOrdersList,0,1200,32,200,FMX.Types.TAlignLayout.Bottom,16,16,16,16,0,0,0,0, ColorMaterial(0), ColorMaterial(0));
    FbtnOrdersClear := FMX.StdCtrls.TButton.New(FtiOrdersList, LBgr, 0, 0, LLayout.Height, 200, FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, {$IFDEF ANDROID}$FFFFFFFF{$ELSE}$FF000000{$ENDIF}, 18, [System.UITypes.TFontStyle.fsBold]);
    FbtnOrdersClear.OnClick := DoClickOrdersClear;

  DoLangChange;

  FTimerUpdate := FMX.Types.TTimer.Create(Self);
  with FTimerUpdate do
  begin
    Interval := 1000 * 60 * 10;
    OnTimer  := DoOnTimerUpdate;
    Enabled  := True;
  end;

  FFlagOrder := False;
  FTimerOrder := FMX.Types.TTimer.Create(Self);
  with FTimerOrder do
  begin
    Interval := 1000;
    OnTimer  := DoOnTimerOrder;
    Enabled  := True;
  end;
{$IFNDEF ANDROID}
  WindowState := System.UITypes.TWindowState.wsMaximized;
{$ENDIF}
end;

destructor TFormMain.Destroy;
begin
  if FTimerOrder.Enabled then
    FTimerOrder.Enabled := False;
  FreeAndNil(FTimerOrder);
  if FTimerUpdate.Enabled then
    FTimerUpdate.Enabled := False;
  FreeAndNil(FTimerUpdate);
  FreeAndNil(FtcMenu);
  FreeAndNil(FGestMan);
  UserBaseFree;
  DataBaseFree;
  inherited Destroy;
end;

procedure TFormMain.DoOnTimerOrder(Sender: TObject);
begin
  FFlagOrder := not FFlagOrder;
  if(FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT].Count > 0)then
  begin
    if(FtcMain.ActiveTab = FtiMainOrder)then
      FTopBtnOrder.Fill.Color := ColorButtonTopBar( True )
    else
      FTopBtnOrder.Fill.Color := ColorButtonOrder( FFlagOrder );
  end;
end;

procedure TFormMain.DoOnTimerUpdate(Sender: TObject);
var
  LDatabaseVersion :Integer;
begin
  if not Network.IsConnected then exit;

  LDatabaseVersion := DataBaseConstInteger('DBVERSION');

  TThread.CreateAnonymousThread(
    procedure
    var
      LDBVersion   :Integer;
      LWebVersion  :Integer;
      LFileArchive :string;
    begin
      LDBVersion := LDatabaseVersion;
      try
        LWebVersion := HTTPGetString(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlDatabaseVersion).ToInteger();
      except
        LWebVersion := LDBVersion;
      end;
      if(LWebVersion > LDBVersion)then
      begin
        // database
        LFileArchive := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Database.PackedFile);
        if HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlDatabaseZip, LFileArchive ) then
           ExtractFileArchive(LFileArchive, ExtractFilePath( DataBaseFilePath(Restourant.Consts.Database.C) ) );
        // images
        LFileArchive := System.IOUtils.TPath.Combine(FolderMyDocuments, Restourant.Consts.Filenames.FileNameImageTMCPackedTemp);
        if HTTPGetFile(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlImagesZip, LFileArchive ) then
          if ExtractFileArchive(LFileArchive, ExtractFilePath(ImageFileNameTMC(0)) )then
            TFile.Delete(LFileArchive);
        // sync
        TThread.Synchronize(nil,
          procedure
          begin
            DataBaseFree;
            DataBaseCreate;
            DoLangChange;
          end
        );
      end;
    end
  ).Start;
end;

function TFormMain.CreateTopButton(const AnAlign:FMX.Types.TAlignLayout; const ResourceName:string; AnOnClick:TNotifyEvent; var AnImage:FMX.Objects.TImage): FMX.Objects.TRectangle;
begin
  Result := FMX.Objects.TRectangle.New(FTopBar,FTopBar,0,0,FTopBar.Height,FTopBar.Height,AnAlign,0,0,0,0,8,8,8,8,FTopBar.Fill.Color, FTopBar.Fill.Color);
  with Result do
  begin
    HitTest     := True;
    OnMouseDown := DoMouseDownTopBtn;
    OnClick     := AnOnClick;
  end;
  AnImage := FMX.Objects.TImage.New(Result,Result,0,0,Result.Height,Result.Width,FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
  ImageLoadFromResource(AnImage.Bitmap, ResourceName);
end;

function TFormMain.CreateRectButton(Parent:TControl; const aWidth:Integer; const AnAlign:FMX.Types.TAlignLayout; const Caption, ResourceName:string; AnOnClick:TNotifyEvent): FMX.Objects.TRectangle;
var
  LLabel :FMX.StdCtrls.TLabel;
  LImage :FMX.Objects.TImage;
begin
  Result := FMX.Objects.TRectangle.New(Parent,Parent,0,0,Parent.Height,aWidth,AnAlign,0,0,0,0,0,0,0,0, $FFFFFFFF, ColorMaterial(0) );
  with Result do
  begin
    HitTest     := True;
    OnClick     := AnOnClick;
    OnMouseDown := DoMouseDownBtn;
    OnMouseUp   := DoMouseUpBtn;
  end;
  LImage := FMX.Objects.TImage.New(Result,Result,0,0,Result.Height,Result.Height,FMX.Types.TAlignLayout.Client, 1,1,1,1,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
  if(ResourceName.Length > 0)then
  begin
    ImageLoadFromResource(LImage.Bitmap, ResourceName);
    LImage.Align := FMX.Types.TAlignLayout.Left;
    LImage.Width := Result.Height;
  end
  else
    LImage.Width := 0;
  if(Caption <> System.SysUtils.EmptyStr)then
  begin
    LLabel := FMX.StdCtrls.TLabel.New(Result,Result,0,0,Result.Height, LImage.Width+1, FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,
                Caption, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, ColorMaterial(0), 10, [System.UITypes.TFontStyle.fsBold]);
  end;
end;

procedure TFormMain.ImageLoadFromResource(Bitmap: TBitmap; const BackgroundResource: string);
var
  LStream   :TResourceStream;
begin
  if(BackgroundResource.Length >0)then
    try
      LStream := TResourceStream.Create( hInstance, BackgroundResource, RT_RCDATA );
      Bitmap.LoadFromStream( LStream );
    finally
      LStream.Free;
    end;
end;

function TFormMain.CreateListbox(aParentObj: TFMXObject; const BackgroundResource:string): FMX.ListBox.TListBox;
var
  LBgrImage :FMX.Objects.TImage;
begin
  LBgrImage := FMX.Objects.TImage.Create(aParentObj);
  with LBgrImage do
  begin
    Parent   := aParentObj;
    Align    := FMX.Types.TAlignLayout.Client;
    WrapMode := FMX.Objects.TImageWrapMode.Stretch;
    ImageLoadFromResource(Bitmap, BackgroundResource);
  end;
  Result := FMX.ListBox.TListBox.Create(Self);
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

function TFormMain.CreateListBoxItem(aListBox: FMX.ListBox.TListBox; const aItemHeight, aItemWidth :Single;
                  const aTag, aColorIndex:Integer; aOnClick, aOnDblClick:TNotifyEvent; var aBackground :FMX.Objects.TRectangle):FMX.ListBox.TListBoxItem;
begin
  Result := FMX.ListBox.TListBoxItem.Create(aListBox);
  with Result do
  begin
    Parent          := aListBox;
    Height          := aItemHeight;
    if(aItemWidth <> 0)then
      Width         := aItemWidth;
    Tag             := aTag;
    TagString       := ColorMaterial(aColorIndex).ToString();
    if Assigned(aOnDblClick)then
    begin
      OnDblClick    := aOnDblClick;
    end
    else
    begin
      OnClick       := aOnClick;
      OnMouseDown   := DoMouseDownListItem;
      OnMouseUp     := DoMouseUpListItem;
    end;
    Margins.Left    := 8;
    Margins.Top     := 8;
    Margins.Right   := 8;
    Margins.Bottom  := 0;
  end;
  aBackground := FMX.Objects.TRectangle.New(Result,Result,0,0,Result.Height, Result.Width, FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,Result.TagString.ToInteger(), Result.TagString.ToInteger());
  Result.TagObject  := aBackground;
end;

procedure TFormMain.CreateControlsUser(aParentObj :TFMXObject);

  function RectItem(aOwner :TComponent; aOwnerParent :TFMXObject;
             const aTop:Integer; var aLabel:FMX.StdCtrls.TLabel; var aEdit:FMX.Edit.TEdit):FMX.Objects.TRectangle;
  begin
    Result := FMX.Objects.TRectangle.New(aOwner, aOwnerParent, 0, aTop, 32,400, FMX.Types.TAlignLayout.Top,0,16,0,0,0,0,0,0, ColorMaterial(0), ColorMaterial(0));

    aLabel := FMX.StdCtrls.TLabel.New (aOwner, Result    , 0, 0, Result.Height, 160, FMX.Types.TAlignLayout.Left,8,0,8,0,0,0,0,0,
                System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Center, $FFFFFFFF, 14, [System.UITypes.TFontStyle.fsBold]);
    aEdit  := FMX.Edit.TEdit.New  (aOwner, Result    ,97, 0, Result.Height, 200, FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                System.SysUtils.EmptyStr , FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Center,
                {$IFDEF ANDROID}$FFFFFFFF{$ELSE}$FF000000{$ENDIF}, 16, [System.UITypes.TFontStyle.fsBold]);
    {$IFDEF ANDROID}
    aEdit.OnEnter := DoEnterEditUser;
    {$ENDIF}
  end;

var
  LItem :FMX.Objects.TRectangle;
begin
  FsbUser  := TScrollBox.New(aParentObj, aParentObj, 0, 0, 400, 400,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0);
  FbgrUser := FMX.Objects.TImage.New(aParentObj, FsbUser, 0,0,600,400, FMX.Types.TAlignLayout.None, 0,0,0,0,16,0,16,4, FMX.Objects.TImageWrapMode.Stretch);
  ImageLoadFromResource(FbgrUser.Bitmap, 'BACKGROUND04');

  LItem := RectItem(aParentObj,FbgrUser,  0*10,FlblUsrID       ,FedtUsrID       );
  LItem := RectItem(aParentObj,FbgrUser, 32*10,FlblUsrFIRSTNAME,FedtUsrFIRSTNAME);
  LItem := RectItem(aParentObj,FbgrUser, 65*10,FlblUsrLASTNAME ,FedtUsrLASTNAME );
  LItem := RectItem(aParentObj,FbgrUser, 97*10,FlblUsrPHONE    ,FedtUsrPHONE    );
  LItem := RectItem(aParentObj,FbgrUser,129*10,FlblUsrPWD      ,FedtUsrPWD      );
  LItem := RectItem(aParentObj,FbgrUser,161*10,FlblUsrPWD2     ,FedtUsrPWD2     );

  LItem := FMX.Objects.TRectangle.New(aParentObj, FbgrUser, 0, 400,32,200,FMX.Types.TAlignLayout.Top,0,16,0,0,0,0,0,0, ColorMaterial(0), ColorMaterial(0));
  FbtnUsrRegister := FMX.StdCtrls.TButton.New(aParentObj, LItem, 0, 0, LItem.Height, 200, FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, {$IFDEF ANDROID}$FFFFFFFF{$ELSE}$FF000000{$ENDIF}, 18, [System.UITypes.TFontStyle.fsBold]);

  FedtUsrPHONE.FilterChar := '+1234567890';
  FedtUsrPWD.Password     := True;
  FedtUsrPWD2.Password    := True;
  FbtnUsrRegister.OnClick := DoClickUserRegister;
end;

procedure TFormMain.CreateControlsTopBar;
var
  LLang :Restourant.Consts.Strings.TLang;
  LImg  :FMX.Objects.TImage;
  LTop  :Single;
begin
  FRightBar := FMX.Objects.TRectangle.New(Self,Self,0,0,200,64, FMX.Types.TAlignLayout.Right,0,0,0,0,0,0,0,0,ColorMaterial(0),ColorMaterial(0));
  FRightBar.Visible := False;

  FTopBar   := FMX.Objects.TRectangle.New(Self,Self,0,0,64,Self.Width, FMX.Types.TAlignLayout.Top,0,0,0,0,0,0,0,0,ColorMaterial(0),ColorMaterial(0));
  FTopBtnBack  := CreateTopButton(FMX.Types.TAlignLayout.Left , 'BACK'  , actBackExecute , FTopBtnBackImg );
  FTopBtnUser  := CreateTopButton(FMX.Types.TAlignLayout.Right, 'USER'  , actUserExecute , FTopBtnUserImg );
  FTopBtnOrder := CreateTopButton(FMX.Types.TAlignLayout.Right, 'CART'  , actOrderExecute, FTopBtnOrderImg);
  FTopBtnMenu  := CreateTopButton(FMX.Types.TAlignLayout.Right, 'MENU'  , actMenuExecute , FTopBtnMenuImg );
  FTopBtnLang  := CreateTopButton(FMX.Types.TAlignLayout.Right, 'FLAGUN', DoClickLangBtn , FTopBtnLangImg );
  with FTopBtnBack do
  begin
    OnMouseDown := DoMouseDownTopBtn;
    OnMouseUp   := DoMouseUpTopBtn;
  end;
  with FTopBtnLang do
  begin
    OnMouseDown := DoMouseDownTopBtn;
    OnMouseUp   := DoMouseUpTopBtn;
  end;
  LTop := 0;
  for LLang := Low(Restourant.Consts.Strings.TLang) to High(Restourant.Consts.Strings.TLang) do
  begin
    FLangBtn[LLang] := FMX.Objects.TRectangle.New(FRightBar,FRightBar,0,LTop,FRightBar.Width,FRightBar.Width,FMX.Types.TAlignLayout.Top,0,0,0,0,8,8,8,8,FRightBar.Fill.Color, FRightBar.Fill.Color);
    with FLangBtn[LLang] do
    begin
      Tag         := Restourant.Consts.Strings.TLangToInt(LLang);
      HitTest     := True;
      OnMouseDown := DoMouseDownTopBtn;
      OnClick     := DoClickLang;
    end;
    LImg := FMX.Objects.TImage.New(FLangBtn[LLang],FLangBtn[LLang],0,0,FLangBtn[LLang].Height,FLangBtn[LLang].Width,FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
    ImageLoadFromResource(LImg.Bitmap, 'FLAG'+Restourant.Consts.Strings.TLangToInt(LLang).ToString );
    LTop := LTop + FRightBar.Width + 2;
  end;
end;

procedure TFormMain.CreateControlsOrd(aParentObj :TFMXObject);
var
  LBgr    :FMX.Objects.TRectangle;
  LLabel  :FMX.StdCtrls.TLabel;
  LLayout :TLayout;
  LBackgr :FMX.Objects.TRectangle;
begin
  FbgrOrder := FMX.Objects.TImage.New(aParentObj,aParentObj,0,0,200,300,FMX.Types.TAlignLayout.Client,0,0,0,0,16,0,16,4, FMX.Objects.TImageWrapMode.Stretch);
  ImageLoadFromResource(FbgrOrder.Bitmap, 'BACKGROUND01');

  LLayout   := TLayout.New(aParentObj,FbgrOrder,0, 0,20,200,FMX.Types.TAlignLayout.Top,0,0,0,0,0,0,0,0);
    FlblOrderNoCapt  := FMX.StdCtrls.TLabel.New(aParentObj,LLayout,0,0,LLayout.Height,104,FMX.Types.TAlignLayout.Left,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 12, []);
    FlblOrderNo := FMX.StdCtrls.TLabel.New(aParentObj,LLayout,LLayout.Height,0,LLayout.Height,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 14, [System.UITypes.TFontStyle.fsBold]);
  LLayout   := TLayout.New(aParentObj,FbgrOrder,0,22,20,200,FMX.Types.TAlignLayout.Top,0,2,0,0,0,0,0,0);
    FlblOrderDateCapt  := FMX.StdCtrls.TLabel.New(aParentObj,LLayout,0,0,LLayout.Height,104,FMX.Types.TAlignLayout.Left,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 12, []);
    FedtOrderDate := TDateEdit.New(aParentObj,LLayout,LLayout.Height,0,LLayout.Height,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                       System.SysUtils.Now, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 14, [System.UITypes.TFontStyle.fsBold]);
  LLayout   := TLayout.New(aParentObj,FbgrOrder,0,42, 20,200,FMX.Types.TAlignLayout.Top,0,2,0,0,0,0,0,0);
    FlblOrderName := FMX.StdCtrls.TLabel.New(aParentObj,LLayout,0,0,LLayout.Height,104,FMX.Types.TAlignLayout.Left,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 12, []);
    FedtOrderName := FMX.Edit.TEdit.New(aParentObj,LLayout,LLayout.Height,0,LLayout.Height,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 14, [System.UITypes.TFontStyle.fsBold]);
    FedtOrderName.OnChange := DoChangeOrderName;

  LLayout   := TLayout.New(aParentObj,FbgrOrder,0,62,18,200,FMX.Types.TAlignLayout.Top,0,2,0,0,0,0,0,0);
    FlblOrderHdrImg   := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,   0,0,LLayout.Height,68,FMX.Types.TAlignLayout.Left,0,0,0,0,0,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, [], ColorMaterial(0), $FFFFFFFF, LBackgr);
    FlblOrderHdrTmc   := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,  66,0,LLayout.Height,64,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, [], ColorMaterial(0), $FFFFFFFF, LBackgr);
    FlblOrderHdrPrice := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout, 800,0,LLayout.Height,48,FMX.Types.TAlignLayout.Right,0,0,0,0,0,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, [], ColorMaterial(0), $FFFFFFFF, LBackgr);
    FlblOrderHdrQuant := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,1200,0,LLayout.Height,32,FMX.Types.TAlignLayout.Right,0,0,0,0,0,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, [], ColorMaterial(0), $FFFFFFFF, LBackgr);
    FlblOrderHdrTotal := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,1600,0,LLayout.Height,72,FMX.Types.TAlignLayout.Right,0,0,24,0,0,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, [], ColorMaterial(0), $FFFFFFFF,LBackgr);

  FlbxOrder := FMX.ListBox.TListBox.New(aParentObj,FbgrOrder,0,82, 32,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0, FMX.ListBox.TListStyle.Vertical);

  LLayout   := TLayout.New(aParentObj,FbgrOrder,0,600, 20,200,FMX.Types.TAlignLayout.Bottom,0,2,0,0,0,0,0,0);
    FlblOrderFtrTmc   := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,0,0,LLayout.Height,64,FMX.Types.TAlignLayout.Client,0,0,0,0,8,0,0,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, [], ColorMaterial(0), $FFFFFFFF, LBackgr);
    FlblOrderFtrTotal := FMX.StdCtrls.TLabel.NewBG(aParentObj,LLayout,160,0,LLayout.Height,96,FMX.Types.TAlignLayout.Right,0,0,24,0,0,0,8,0,
                           System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, [], ColorMaterial(0), $FFFFFFFF, LBackgr);

  LBgr := FMX.Objects.TRectangle.New(aParentObj, FbgrOrder,0,1200,32,200,FMX.Types.TAlignLayout.Bottom,0,2,0,0,0,0,0,0, ColorMaterial(0), ColorMaterial(0));
    FbtnOrderSend := FMX.StdCtrls.TButton.New(aParentObj, LBgr, 0, 0, LLayout.Height, 200, FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, {$IFDEF ANDROID}$FFFFFFFF{$ELSE}$FF000000{$ENDIF}, 18, [System.UITypes.TFontStyle.fsBold]);
    FbtnOrderSend.OnClick := DoClickOrderSend;
end;

procedure TFormMain.CreateControlsTMCVer(aParentObj :TFMXObject);
begin
  FVbgrTMC        := FMX.Objects.TRectangle.New(aParentObj,aParentObj    ,0,  0,  0,  0,FMX.Types.TAlignLayout.Client,0,0,0,0,16,16,16,16, ColorMaterial(0), ColorMaterial(0));
  FVimgTMC        := FMX.Objects.TImage.New    (aParentObj,FVbgrTMC      ,0,  0,220,330,FMX.Types.TAlignLayout.Top   ,0,0,0,0, 0, 0, 0, 0, FMX.Objects.TImageWrapMode.Stretch);
  FVlblTMC_NAME   := FMX.StdCtrls.TLabel.New    (aParentObj,FVbgrTMC      ,0,222, 48,200,FMX.Types.TAlignLayout.Top   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 18, [System.UITypes.TFontStyle.fsBold]);
  FVlblTMC_COMENT := FMX.StdCtrls.TLabel.New    (aParentObj,FVbgrTMC      ,0,272,140,200,FMX.Types.TAlignLayout.Client   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, []);
  FVlblTMC_PRICE  := FMX.StdCtrls.TLabel.New    (aParentObj,FVbgrTMC      ,0,434, 28,200,FMX.Types.TAlignLayout.Bottom,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 24, [System.UITypes.TFontStyle.fsBold]);
  FVlblTMC_EDIZM  := FMX.StdCtrls.TLabel.New    (aParentObj,FVlblTMC_PRICE,0,  0, 20,160,FMX.Types.TAlignLayout.Top   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, [System.UITypes.TFontStyle.fsBold]);

  FVLayoutQuant   := TLayout.New(aParentObj,FVbgrTMC,0,999, 48,200,FMX.Types.TAlignLayout.Bottom,0,0,0,0,0,8,0,8);
  FVbtnPlus  := CreateRectButton(FVLayoutQuant, 96, FMX.Types.TAlignLayout.Left ,'Добавить', 'PLUS' , DoClickTmcPlus);
  FVlblQuant := FMX.StdCtrls.TLabel.New(FVLayoutQuant,FVLayoutQuant,FVbtnPlus.Width,0, FVLayoutQuant.Height,FVLayoutQuant.Height,FMX.Types.TAlignLayout.Client,0,0,8,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Center, $FFFFFFFF, 20, [System.UITypes.TFontStyle.fsBold]);
  FVbtnMinus := CreateRectButton(FVLayoutQuant, 96, FMX.Types.TAlignLayout.Right,'Удалить' , 'MINUS', DoClickTmcMinus);
end;

procedure TFormMain.CreateControlsTMCHor(aParentObj :TFMXObject);
var
  LLayout :TLayout;
begin
  FHbgrTMC        := FMX.Objects.TRectangle.New(aParentObj,aParentObj    ,0,  0,  0,  0,FMX.Types.TAlignLayout.Client,0,0,0,0,16,16,16,16, ColorMaterial(0), ColorMaterial(0));
  FHimgTMC        := FMX.Objects.TImage.New    (aParentObj,FHbgrTMC      ,0,  0,220,330,FMX.Types.TAlignLayout.Left  ,0,0,0,0, 0, 0, 0, 0, FMX.Objects.TImageWrapMode.Stretch);
  LLayout         := TLayout.New   (aParentObj,FHbgrTMC      ,0,  0,220,200,FMX.Types.TAlignLayout.Client,0,0,0,0,16, 0, 0, 0);
  FHlblTMC_NAME   := FMX.StdCtrls.TLabel.New    (aParentObj,LLayout       ,0,  0, 48,200,FMX.Types.TAlignLayout.Top   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 18, [System.UITypes.TFontStyle.fsBold]);
  FHlblTMC_COMENT := FMX.StdCtrls.TLabel.New    (aParentObj,LLayout       ,0, 50,192,200,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 12, []);
  FHlblTMC_PRICE  := FMX.StdCtrls.TLabel.New    (aParentObj,LLayout       ,0,144, 28,200,FMX.Types.TAlignLayout.Bottom   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 24, [System.UITypes.TFontStyle.fsBold]);
  FHlblTMC_EDIZM  := FMX.StdCtrls.TLabel.New    (aParentObj,FHlblTMC_PRICE,0,  0, 20,160,FMX.Types.TAlignLayout.Top   ,0,0,0,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, [System.UITypes.TFontStyle.fsBold]);
  FHLayoutQuant   := TLayout.New(aParentObj,LLayout,0,999, 32,200,FMX.Types.TAlignLayout.Bottom,0,0,0,0,0,0,0,0);
  FHbtnPlus  := CreateRectButton(FHLayoutQuant, 96, FMX.Types.TAlignLayout.Left ,'Добавить', 'PLUS' , DoClickTmcPlus);
  FHlblQuant := FMX.StdCtrls.TLabel.New(FHLayoutQuant,FHLayoutQuant,FHbtnPlus.Width,0, FHLayoutQuant.Height,FHLayoutQuant.Height,FMX.Types.TAlignLayout.Client,0,0,8,0,0,0,0,0,
                       System.SysUtils.EmptyStr, FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Center, $FFFFFFFF, 20, [System.UITypes.TFontStyle.fsBold]);
  FHbtnMinus := CreateRectButton(FHLayoutQuant, 96, FMX.Types.TAlignLayout.Right,'Удалить' , 'MINUS', DoClickTmcMinus);
end;

function TFormMain.CanBack: Boolean;
begin
  Result := True;
  if(FtcMain.ActiveTab = FtiMainMenu)then
    Result := (FtcMenu.ActiveTab <> FtiMenuCat);
end;

procedure TFormMain.DoBack;
begin
  if(FtcMain.ActiveTab = FtiMainMenu)then
  begin
    if(FtcMenu.ActiveTab = FtiMenuTMC  )then FillList  (FtiMenuList.HelpKeyword.ToInteger);
    if(FtcMenu.ActiveTab = FtiMenuList )then FillGroups(FtiMenuGroup.HelpKeyword.ToInteger);
    FtcMenu.Previous;
  end
  else
  begin
    FtcMain.ActiveTab := FtiMainMenu;
  end;
end;

procedure TFormMain.KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited KeyUp(Key, KeyChar, Shift);
  if( Key = vkHardwareBack )then
  begin
    if CanBack then
    begin
      DoBack;
      Key := 0;
    end;
  end;
end;

procedure TFormMain.Resize;
var
  LWidth   :Single;
  LCounter :Integer;
begin
  inherited Resize;
  FbgrUser.Width          := FsbUser.Width - 28;
  FbgrUser.Height         := System.Math.Max(FsbUser.Height * 2, 400);
  FlbxCategory.Columns    := Trunc(Width / 240);
  FlbxGroup.Columns       := Trunc(Width / 240);
  FlbxList.Columns        := Trunc(Width / 330);
  FlbxList.ItemHeight     := 344;
  FlbxList.ItemWidth      := System.Math.Min(332, Self.Width - 32);
  if(Height > Width)then
  begin
    FVimgTMC.Height  := Width * 2 / 3;
    FtcTMC.ActiveTab := FtiTMCV;
    LWidth           := Width;
  end
  else
  begin
    FHimgTMC.Width   := ( Height - (FTopBar.Height + 16)*2 ) * 3 / 2;
    FtcTMC.ActiveTab := FtiTMCH;
    LWidth           := Height;
  end;
  if(LWidth < 400)then
  begin
    FTopBar.Height          := 48;
    FlbxCategory.ItemHeight := 48;
    FlbxGroup.ItemHeight    := 32;
    FHbgrTMC.Padding.Rect   := TRectF.Create(6,6,6,6);
    FVbgrTMC.Padding.Rect   := TRectF.Create(6,6,6,6);
    FHlblTMC_NAME.Height    := 24;
    FVlblTMC_NAME.Height    := 24;
  end
  else
  begin
    FTopBar.Height          := 64;
    FlbxCategory.ItemHeight := 80;
    FlbxGroup.ItemHeight    := 48;
    FHbgrTMC.Padding.Rect   := TRectF.Create(16,16,16,16);
    FVbgrTMC.Padding.Rect   := TRectF.Create(16,16,16,16);
    FHlblTMC_NAME.Height    := 48;
    FVlblTMC_NAME.Height    := 48;
  end;
  for LCounter := 0 to FTopBar.ControlsCount-1 do
    if(FTopBar.Controls[LCounter] is TRectangle)then
      TRectangle(FTopBar.Controls[LCounter]).Width := FTopBar.Height;
end;

procedure TFormMain.DoChangeOrderName(Sender: TObject);
begin
  FOrderCurr.S[Restourant.Consts.UserData.FieldOrderNAME] := FMX.Edit.TEdit(Sender).Text;
end;

procedure TFormMain.DoChangeTabControl(Sender: TObject);
begin
  FTopBtnBack.Visible     := CanBack;
  FTopBtnMenu.Fill.Color  := ColorButtonTopBar(FtcMain.ActiveTab = FtiMainMenu );
  FTopBtnOrder.Fill.Color := ColorButtonTopBar(FtcMain.ActiveTab = FtiMainOrder);
  FTopBtnUser.Fill.Color  := ColorButtonTopBar(FtcMain.ActiveTab = FtiMainUser );
end;

procedure TFormMain.DoClickCategory(Sender: TObject);
begin
  FillGroups( TComponent(Sender).Tag );
  FtcMenu.ActiveTab := FtiMenuGroup;
end;

procedure TFormMain.DoClickGroup(Sender: TObject);
begin
  FillList( TComponent(Sender).Tag );
  FtcMenu.ActiveTab := FtiMenuList;
end;

procedure TFormMain.DoClickLang(Sender: TObject);
var
  LLang :Restourant.Consts.Strings.TLang;
begin
  FLang := IntToTLang( TComponent(Sender).Tag );
  for LLang := High(Restourant.Consts.Strings.TLang) downto Low(Restourant.Consts.Strings.TLang) do
    FLangBtn[LLang].Fill.Color := ColorButtonTopBar(LLang = FLang);
  FUDB.Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserLang] := TLangToInt(FLang).ToString;
  FUDB.Flush( Restourant.Consts.UserData.PROFILE );
  DoLangChange;
  FRightBar.Visible := False;
end;

procedure TFormMain.DoClickLangBtn(Sender: TObject);
begin
  FRightBar.Visible := True;
end;

procedure TFormMain.DoClickList(Sender: TObject);
begin
  FillCard( TComponent(Sender).Tag, TFMXObject(Sender).TagString.ToInteger() );
  FtcMain.ActiveTab := FtiMainMenu;
  FtcMenu.ActiveTab := FtiMenuTMC;
end;

procedure TFormMain.DoClickOrder(Sender: TObject);
begin
  FillOrder( UserBaseOrderById(TComponent(Sender).Tag) );
  FtcOrder.ActiveTab := FtiOrder;
end;

procedure TFormMain.DoClickTmcMinus(Sender: TObject);
begin
  UserBaseOrderMinus(TComponent(Sender).Tag);
  FHlblQuant.Text := UserBaseOrderQntGet(TComponent(Sender).Tag).ToString;
  FVlblQuant.Text := FHlblQuant.Text;
end;

procedure TFormMain.DoClickTmcPlus(Sender: TObject);
begin
  UserBaseOrderPlus(TComponent(Sender).Tag);
  FHlblQuant.Text := UserBaseOrderQntGet(TComponent(Sender).Tag).ToString;
  FVlblQuant.Text := FHlblQuant.Text;
end;

procedure TFormMain.DoMouseDownListItem(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  with FMX.Objects.TRectangle(TFMXObject(Sender).TagObject)do
    Fill.Color := Fill.Color - $A0000000;
end;

procedure TFormMain.DoMouseUpListItem(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  with FMX.Objects.TRectangle(TFMXObject(Sender).TagObject)do
    Fill.Color := Fill.Color + $A0000000;
end;

procedure TFormMain.DoMouseDownTopBtn(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMX.Objects.TRectangle(Sender).Fill.Color := $FF000000;
end;

procedure TFormMain.DoMouseUpTopBtn(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMX.Objects.TRectangle(Sender).Fill.Color := FTopBar.Fill.Color;
end;

procedure TFormMain.DoMouseDownBtn(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMX.Objects.TRectangle(Sender).Fill.Color := $FF000000;
end;

procedure TFormMain.DoMouseUpBtn(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FMX.Objects.TRectangle(Sender).Fill.Color := $FFFFFFFF;
end;

procedure TFormMain.FillCat;
var
  LRow     :TJsonObject;
  LItem    :FMX.ListBox.TListBoxItem;
  LBackgr  :FMX.Objects.TRectangle;
  LLblName :FMX.StdCtrls.TLabel;
  i, j     :Integer;
begin
  FlbxCategory.Clear;
  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].O[i];
    if(LRow.S[Restourant.Consts.Database.FieldRefFLAG_DELETE] = '0')then
    begin
      LItem    := CreateListBoxItem(FlbxCategory, FlbxCategory.ItemHeight, 0, LRow.S[Restourant.Consts.Database.FieldRefID].ToInteger(), j, DoClickCategory, nil, LBackgr);
      LLblName := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,0,LItem.Height,200,FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,
                    DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefNAME), FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, $FFFFFFFF, 24, [System.UITypes.TFontStyle.fsBold]);
      j := j + 1;
    end;
  end;
end;

procedure TFormMain.FillGroups(const TMC_CTGR_ID: Integer);
var
  LRow     :TJsonObject;
  LItem    :FMX.ListBox.TListBoxItem;
  LBackgr  :FMX.Objects.TRectangle;
  LLblName :FMX.StdCtrls.TLabel;
  LCategory:string;
  i, j     :Integer;
begin
  FtiMenuGroup.HelpKeyword := TMC_CTGR_ID.ToString;

  FlbxGroup.Clear;

  LCategory := System.SysUtils.EmptyStr;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_CTGR].A[Restourant.Consts.Database.Section].O[i];
    if(LRow.S[Restourant.Consts.Database.FieldRefID] = TMC_CTGR_ID.ToString() )then
    begin
      LCategory := LRow.S[Restourant.Consts.Database.FieldRefNAME];
      Break;
    end;
  end;
  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC_GROUPSHARE].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC_GROUPSHARE].A[Restourant.Consts.Database.Section].O[i];
    if( (LRow.S[Restourant.Consts.Database.FieldRefGROUPNAME] = LCategory) and (LRow.S[Restourant.Consts.Database.FieldRefFLAG_DELETE] = '0') )then
    begin
      LItem    := CreateListBoxItem(FlbxGroup, FlbxGroup.ItemHeight, 0, LRow.S[Restourant.Consts.Database.FieldRefTMC_GROUP_ID].ToInteger(), j, DoClickGroup, nil, LBackgr);
      LLblName := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,0,LItem.Height,200,FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,
                    DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefNAME),
                    FMX.Types.TTextAlign.Center, FMX.Types.TTextAlign.Center, $FFFFFFFF, 18, [System.UITypes.TFontStyle.fsBold]);
      j := j + 1;
    end;
  end
end;

procedure TFormMain.FillList(const TMC_GROUP_ID:Integer);
var
  LRow         :TJsonObject;
  LItem        :FMX.ListBox.TListBoxItem;
  LBackgr      :FMX.Objects.TRectangle;
  LImage       :FMX.Objects.TImage;
  LImagePlus   :FMX.Objects.TImage;
  LLblName     :FMX.StdCtrls.TLabel;
  LLblComent   :FMX.StdCtrls.TLabel;
  LLblEdzim    :FMX.StdCtrls.TLabel;
  LLblPrice    :FMX.StdCtrls.TLabel;
  LComent      :string;
  i, j         :Integer;
begin
  FtiMenuList.HelpKeyword := TMC_GROUP_ID.ToString;

  FlbxList.Clear;
  j := 1;
  for i:=0 to FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].Count-1 do
  begin
    LRow := FDB[Restourant.Consts.Database.R_TMC].A[Restourant.Consts.Database.Section].O[i];
    if( LRow.S[Restourant.Consts.Database.FieldRefTMC_GROUP_ID] = TMC_GROUP_ID.ToString ) then
    begin
      LComent := DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefCOMENT);
      if(LComent.Length > 80)then
        LComent := Copy(LComent, 0, 80) + '...';
      LItem  := CreateListBoxItem(FlbxList, FlbxList.ItemHeight, FlbxList.ItemWidth, LRow.S[Restourant.Consts.Database.FieldRefID].ToInteger(), j, nil, DoClickList, LBackgr);
      LBackgr.Padding.Left   := 8;
      LBackgr.Padding.Top    := 8;
      LBackgr.Padding.Right  := 8;
      LBackgr.Padding.Bottom := 8;
      LImage := FMX.Objects.TImage.New(LItem,LBackgr,0,0,220,200,FMX.Types.TAlignLayout.Top,0,0,0,0,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
      LImage.HitTest   := True;
      LImage.Tag       := LItem.Tag;
      LImage.TagString := LItem.TagString;
      LImage.OnClick   := DoClickList;
      try
        LImage.Bitmap.LoadFromFile( ImageFileNameTMC(LRow.S[Restourant.Consts.Database.FieldRefID].ToInteger()) );
      except
        LImage.Bitmap.LoadFromFile( ImageFileNameTMC(0) );
      end;
      LImagePlus := FMX.Objects.TImage.New(LImage,LImage,0,0,32,32,FMX.Types.TAlignLayout.None,0,0,0,0,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
      ImageLoadFromResource(LImagePlus.Bitmap, 'PLUSCORNER');
      LLblName   := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,221,36,200,FMX.Types.TAlignLayout.Top, 0,0,0,0,0,0,0,0,
                      DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefNAME), FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 16, [System.UITypes.TFontStyle.fsBold]);
      LLblComent := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,261,32,200,FMX.Types.TAlignLayout.Top, 0,0,0,0,0,0,0,0,
                      LComent, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 10, []);
      LLblPrice  := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,293,48,200,FMX.Types.TAlignLayout.Top, 0,0,0,0,0,0,0,0,
                      DataBaseConstString('TEXTTMCPRICE') + ' ' + FormatFloat(Restourant.Consts.Database.FormatPRICE, SafeFloat(LRow.S[Restourant.Consts.Database.FieldRefPRICE]) ), FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 24, [System.UITypes.TFontStyle.fsBold]);
      LLblEdzim  := FMX.StdCtrls.TLabel.New(LItem,LLblPrice,0,0,20,160,FMX.Types.TAlignLayout.Left, 0,0,0,0,0,0,0,0,
                      DataBaseConstString('TEXTTMCPART' ) + ' ' + LRow.S[Restourant.Consts.Database.FieldRefEDIZM_SNAME], FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, [System.UITypes.TFontStyle.fsBold]);
      j := j + 1;
    end;
  end;
  if(FlbxList.Count > 0)then
    FlbxList.ItemIndex := 0;
end;

procedure TFormMain.FillOrder(anOrder:TJsonObject);
var
  LCounter :Integer;
  LItem    :FMX.ListBox.TListBoxItem;
  LImage   :FMX.Objects.TImage;
  LLabel   :FMX.StdCtrls.TLabel;
  LLabelH  :FMX.StdCtrls.TLabel;
  LBackgr  :FMX.Objects.TRectangle;
  LRow     :TJsonObject;
  LName    :string;
begin
  FtiOrdersList.Text      := DataBaseConstString('TEXTORDERHISTORY');
  FtiOrder.Text           := DataBaseConstString('PAGE03NAME');

  FlblOrderNoCapt.Text    := DataBaseConstString('TEXTORDERNUMBER');
  FlblOrderDateCapt.Text  := DataBaseConstString('TEXTORDERDATE');
  FlblOrderHdrImg.Text    := DataBaseConstString('PAGE05NAME');
  FlblOrderHdrTmc.Text    := DataBaseConstString('TEXTTMCNAME');
  FlblOrderHdrPrice.Text  := DataBaseConstString('TEXTTMCPRICE');
  FlblOrderHdrQuant.Text  := DataBaseConstString('TEXTTMCQUANT');
  FlblOrderHdrTotal.Text  := DataBaseConstString('TEXTTMCSUM');
  FlblOrderFtrTmc.Text    := DataBaseConstString('TEXTORDERTOTAL');
  FlblOrderName.Text      := DataBaseConstString('TEXTORDERCOMENT');
  FbtnOrderSend.Text      := DataBaseConstString('TEXTORDERSEND');

  FedtOrderName.OnChange := nil;
  FedtOrderName.Text     := anOrder.S[Restourant.Consts.UserData.FieldOrderNAME];
  FedtOrderDate.Date     := anOrder.D[Restourant.Consts.UserData.FieldOrderDATE_CREATE];
  FlblOrderFtrTotal.Text := FormatFloat(Restourant.Consts.Database.FormatPRICE, anOrder.F[Restourant.Consts.UserData.FieldOrderDOCSUM]);
  if(anOrder.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] = System.SysUtils.EmptyStr)then
  begin
    FlblOrderNo.Text       := DataBaseConstString('TEXTORDERSENDNO');
    FbtnOrderSend.Text     := DataBaseConstString('TEXTORDERSEND');
    FbtnOrderSend.Enabled  := True;
    FedtOrderDate.Enabled  := True;
    FedtOrderName.Enabled  := True;
    FedtOrderName.OnChange := DoChangeOrderName;
  end
  else
  begin
    FlblOrderNo.Text      := anOrder.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] +
                               #$20#$20 + DataBaseConstString('TEXTORDERDATEFROM') + #$20#$20 +
                               FormatDateTime(Restourant.Consts.Database.FormatDATE, anOrder.D[Restourant.Consts.UserData.FieldOrderDATE_COMMIT]);
    FbtnOrderSend.Text    := DataBaseConstString('TEXTORDERSENDDONE');
    FbtnOrderSend.Enabled := False;
    FedtOrderDate.Enabled := False;
    FedtOrderName.Enabled := False;
  end;

  FlbxOrder.Clear;
  FlbxOrder.ItemHeight := 44;
  with anOrder.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT] do
    for LCounter := 0 to Count-1 do
    begin
      LRow  := DataBaseTMCObject( O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID] );
      LName := DataBaseGetFieldLocal( LRow, Restourant.Consts.Database.FieldRefNAME );

      LItem := FMX.ListBox.TListBoxItem.Create(FlbxOrder);
      with LItem do
      begin
        Parent          := FlbxOrder;
        Height          := FlbxOrder.ItemHeight;
        Tag             := O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID];
        TagString       := Integer($FF60606F).ToString;
        Margins.Left    := 0;
        Margins.Top     := 1;
        Margins.Right   := 0;
        Margins.Bottom  := 1;
      end;
      LImage := FMX.Objects.TImage.New(LItem,LItem,0,0,LItem.Height,66, FMX.Types.TAlignLayout.Left, 2,0,2,0,0,0,0,0,FMX.Objects.TImageWrapMode.Stretch);
      LImage.Bitmap.LoadFromFile( ImageFileNameTMC( O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID] ) );
      LLabel := FMX.StdCtrls.TLabel.New(LItem,LItem,  66,0,LItem.Height,64,FMX.Types.TAlignLayout.Client,0,0,0,0,0,0,0,0,
                  LName + ' ['+ LRow.S[Restourant.Consts.Database.FieldRefEDIZM_SNAME] + ']', FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF000000, 12, [System.UITypes.TFontStyle.fsBold]);

      LLabelH:= FMX.StdCtrls.TLabel.New(LLabel,LLabel,0,200,14,200,FMX.Types.TAlignLayout.Bottom,0,0,0,0,0,0,0,0,
                             DataBaseConstString('TEXTBTNCHANGEHINT'), FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FF60606F, 11, []);
      LLabelH.Font.Family := 'Arial';

      if(anOrder.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] = System.SysUtils.EmptyStr)then
      begin
        LImage.Tag       := O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID];
        LImage.TagString := Integer($FF60606F).ToString;
        LImage.OnClick   := DoClickList;
        LImage.HitTest   := True;
        LLabel.Tag       := O[LCounter].I[Restourant.Consts.UserData.FieldDocTMC_ID];
        LLabel.TagString := Integer($FF60606F).ToString;
        LLabel.OnClick   := DoClickList;
        LLabel.HitTest   := True;
      end;
      LLabel := FMX.StdCtrls.TLabel.New(LItem,LItem, 800,0,LItem.Height,48,FMX.Types.TAlignLayout.Right,0,0,0,0,0,0,0,0,
                             FormatFloat(Restourant.Consts.Database.FormatPRICE, O[LCounter].F[Restourant.Consts.UserData.FieldDocPRICE]), FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FF000000, 12, [System.UITypes.TFontStyle.fsBold]);
      LLabel := FMX.StdCtrls.TLabel.New(LItem,LItem,2000,0,LItem.Height,32,FMX.Types.TAlignLayout.Right,0,0,0,0,0,0,0,0,
                             FormatFloat(Restourant.Consts.Database.FormatQUANT, O[LCounter].F[Restourant.Consts.UserData.FieldDocQUANT]), FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FF000000, 12, [System.UITypes.TFontStyle.fsBold]);
      LLabel := FMX.StdCtrls.TLabel.New(LItem,LItem,5000,0,LItem.Height,72,FMX.Types.TAlignLayout.Right,0,0,24,0,0,0,0,0,
                             FormatFloat(Restourant.Consts.Database.FormatPRICE, O[LCounter].F[Restourant.Consts.UserData.FieldDocTOTAL]), FMX.Types.TTextAlign.Trailing, FMX.Types.TTextAlign.Leading, $FF000000, 12, [System.UITypes.TFontStyle.fsBold]);
    end;
end;

procedure TFormMain.FillOrders;
var
  LRow     :TJsonObject;
  LItem    :FMX.ListBox.TListBoxItem;
  LBackgr  :FMX.Objects.TRectangle;
  LLblName :FMX.StdCtrls.TLabel;
  LText    :string;
  i        :Integer;
begin
  FtiOrdersList.Text   := DataBaseConstString('TEXTORDERHISTORY');
  FtiOrder.Text        := DataBaseConstString('PAGE03NAME');
  FbtnOrdersClear.Text := DataBaseConstString('TEXTORDERHISTORYCLEAR');

  FlbxOrdersList.Clear;
  FlbxOrdersList.ItemHeight := 48;

  for i:=FUDB.Tables[Restourant.Consts.UserData.ORDERS].Count-1 downto 0 do
  begin
    LRow := FUDB.Tables[Restourant.Consts.UserData.ORDERS].Items[i]^.ObjectValue;

    if(LRow.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] = System.SysUtils.EmptyStr)then
      LText := DataBaseConstString('TEXTORDERCURRENT')
    else
      LText := LRow.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] +
        #$20#$20 + DataBaseConstString('TEXTORDERDATEFROM') + #$20#$20 + FormatDateTime(Restourant.Consts.Database.FormatDATE, LRow.D[Restourant.Consts.UserData.FieldOrderDATE_COMMIT]) + #13#10+
        '"' + LRow.S[Restourant.Consts.UserData.FieldOrderNAME] + '"';

    LItem    := CreateListBoxItem(FlbxOrdersList, FlbxOrdersList.ItemHeight, 0, LRow.I[Restourant.Consts.UserData.FieldOrderID], 0, DoClickOrder, nil, LBackgr);
    LLblName := FMX.StdCtrls.TLabel.New(LItem,LBackgr,0,0,LItem.Height,200,FMX.Types.TAlignLayout.Client, 0,0,0,0,0,0,0,0,
                    LText, FMX.Types.TTextAlign.Leading, FMX.Types.TTextAlign.Leading, $FFFFFFFF, 14, []);
  end;
end;

procedure TFormMain.FillUser;
begin
  FlblUsrID.Text        := DataBaseConstString('TEXTUSERID');
  FlblUsrFIRSTNAME.Text := DataBaseConstString('TEXTUSERFIRSTNAME');
  FlblUsrLASTNAME.Text  := DataBaseConstString('TEXTUSERLASTNAME');
  FlblUsrPHONE.Text     := DataBaseConstString('TEXTUSERPHONE');
  FlblUsrPWD.Text       := DataBaseConstString('TEXTUSERPASSWORD');
  FlblUsrPWD2.Text      := DataBaseConstString('TEXTUSERPASSWORD2');

  UserBaseUserLoad;
end;

procedure TFormMain.DoClickUserRegister(Sender: TObject);
var
  LJSON   :TJsonObject;
  LStream :TStringStream;
  LAnswer :string;
begin
  if not UserDataUserSave then exit;
  if not Network.IsConnected then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorInternerNotConnected + #13#10 + Restourant.Consts.Strings.ErrorUserYouShouldToConnect);
    exit;
  end;
  LAnswer := HTTPPostJSON(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlUserRegister, FUDB.Tables[Restourant.Consts.UserData.PROFILE].ToJSON(True) );
  if(not(LAnswer.Length > 0))then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorUserNotRegistered + #13#10 + Restourant.Consts.Strings.ErrorInternetAnswerInvalid);
    exit;
  end;
  LJSON   := TJsonObject.Create;
  LStream := TStringStream.Create(LAnswer);
  try
    try
      LJSON.LoadFromStream(LStream);
    except
      ShowMessage(Restourant.Consts.Strings.ErrorUserNotRegistered + #13#10 + Restourant.Consts.Strings.ErrorInternetAnswerInvalid);
    end;
    if(LJSON.Count > 0)then
    begin
      if LJSON.Contains( UpperCase('ERROR') ) then
        ShowMessage(Restourant.Consts.Strings.ErrorUserNotRegistered + #13#10 +
                    Restourant.Consts.Strings.ErrorInternetAnswer    + #13#10 + LJSON.S['ERROR'] )
      else
        if LJSON.Contains( UpperCase('OK') ) then
        begin
          with FUDB.Tables[Restourant.Consts.UserData.PROFILE] do
          begin
            S[Restourant.Consts.UserData.FieldUserID ] := S[Restourant.Consts.UserData.FieldUserEMAIL ];
            S[Restourant.Consts.UserData.FieldUserPWD] := S[Restourant.Consts.UserData.FieldUserPWDNEW];
          end;
          FUDB.Flush(Restourant.Consts.UserData.PROFILE);
          FedtUsrID.Enabled := False;
          ShowMessage(Restourant.Consts.Strings.ErrorUserRegisteredSuccesfully + #13#10 +
                      Restourant.Consts.Strings.ErrorInternetAnswer            + #13#10 + LJSON.S['OK']);
        end;
    end
    else
      ShowMessage(Restourant.Consts.Strings.ErrorUserNotRegistered + #13#10 + Restourant.Consts.Strings.ErrorInternetNoAnswer);
  finally
    LStream.Free;
    LJSON.Free;
  end;
end;

procedure TFormMain.DoEnterEditUser(Sender: TObject);
begin
  FbgrUser.Position.Y := ( (-1) * TControl(TControl(Sender).Parent).Position.Y ) + (FbgrUser.Padding.Top * 2);
end;

procedure TFormMain.DoClickOrdersClear(Sender: TObject);
var
  LCounter :Integer;
begin
  with FUDB.Tables[Restourant.Consts.UserData.ORDERS] do
  begin
    LCounter := 0;
    while(LCounter < Count)do
    begin
      if(Items[LCounter]^.ObjectValue.I[Restourant.Consts.UserData.FieldOrderID] <> FOrderCurr.I[Restourant.Consts.UserData.FieldOrderID])then
        Delete(LCounter)
      else
        LCounter := LCounter + 1;
    end;
  end;
  FUDB.Flush(Restourant.Consts.UserData.ORDERS);
  FillOrders;
end;

procedure TFormMain.DoClickOrderSend(Sender: TObject);
var
  LJSON   :TJsonObject;
  LStream :TStringStream;
  LAnswer :string;
  LOldID  :Integer;
begin
  if not Network.IsConnected then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorInternerNotConnected + #13#10 + Restourant.Consts.Strings.ErrorUserYouShouldToConnect);
    exit;
  end;
  with FUDB.Tables[Restourant.Consts.UserData.PROFILE] do
    if(S[Restourant.Consts.UserData.FieldUserID] = System.SysUtils.EmptyStr)then
    begin
      actUserExecute(nil);
      ShowMessage(Restourant.Consts.Strings.ErrorUserNotRegisteredToOrder);
      exit;
    end;
  if(FOrderCurr.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] <> System.SysUtils.EmptyStr)then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorOrderWasSend);
    exit;
  end;
  if(FOrderCurr.A[Restourant.Consts.UserData.FieldOrder_DOCUMENT].Count = 0)then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorOrderWasSendNoQuant);
    exit;
  end;
  FOrderCurr.S[Restourant.Consts.UserData.FieldOrderUSER_ID] := FUDB.Tables[Restourant.Consts.UserData.PROFILE].S[Restourant.Consts.UserData.FieldUserID];

  LAnswer := HTTPPostJSON(Restourant.Consts.Filenames.UrlHost, Restourant.Consts.Filenames.UrlOrderSend, FOrderCurr.ToJSON(True) );

  if(not(LAnswer.Length > 0))then
  begin
    ShowMessage(Restourant.Consts.Strings.ErrorOrderNotSended + #13#10 + Restourant.Consts.Strings.ErrorInternetAnswerInvalid);
    exit;
  end;

  LJSON   := TJsonObject.Create;
  LStream := TStringStream.Create(LAnswer);
  try
    try
      LJSON.LoadFromStream(LStream);
    except
      ShowMessage(Restourant.Consts.Strings.ErrorOrderNotSended + #13#10 + Restourant.Consts.Strings.ErrorInternetAnswerInvalid + #13#10 + #13#10 + LAnswer);
    end;
    if(LJSON.Count > 0)then
    begin
      if LJSON.Contains( UpperCase('ERROR') ) then
        ShowMessage(Restourant.Consts.Strings.ErrorOrderNotSended + #13#10 +
                    Restourant.Consts.Strings.ErrorInternetAnswer + #13#10 + LJSON.S['ERROR'] )
      else
        if LJSON.Contains( UpperCase('OK') ) then
        begin
          FOrderCurr.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] := LJSON.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR];
          FOrderCurr.D[Restourant.Consts.UserData.FieldOrderDATE_COMMIT ] := StrToDate( LJSON.S[Restourant.Consts.UserData.FieldOrderDATE_COMMIT] );

          LOldID := FOrderCurr.I[Restourant.Consts.UserData.FieldOrderID];

          FOrderCurr := UserBaseOrderNew;
          FUDB.Flush(Restourant.Consts.UserData.ORDERS);

          FillOrders;
          FillOrder( UserBaseOrderById(LOldID) );
          ShowMessage(Restourant.Consts.Strings.ErrorOrderSendedSuccesfully + #13#10 +
                      ErrorOrderNewNumber + ' "' + LJSON.S[Restourant.Consts.UserData.FieldOrderDOCNUMBERSTR] + '".' + #13#10 +
                      Restourant.Consts.Strings.ErrorInternetAnswer         + #13#10 + LJSON.S['OK']);
        end;
    end
    else
      ShowMessage(Restourant.Consts.Strings.ErrorOrderNotSended + #13#10 + Restourant.Consts.Strings.ErrorInternetNoAnswer);
  finally
    LStream.Free;
    LJSON.Free;
  end;
end;

procedure TFormMain.DoLangChange;
begin
  FTopBtnLang.Tag         := Restourant.Consts.Strings.TLangToInt(FLang);
  ImageLoadFromResource(FTopBtnLangImg.Bitmap, 'FLAG'+Restourant.Consts.Strings.TLangToInt(FLang).ToString);

  LlblRestourantName.Text := DataBaseConstString('ENTNAMETYPE') + ' ' + DataBaseConstString('ENTNAME');
  LlblRestouarntAddr.Text := DataBaseConstString('ENTADDR')+#13#10+DataBaseConstString('ENTPHONES')+#13#10+'E-mail: '+DataBaseConstString('ENTEMAIL');
  Application.Title       := LlblRestourantName.Text;
  Caption                 := LlblRestourantName.Text;

  FillCat;
  if(FtcMain.ActiveTab = FtiMainMenu)then
  begin
    if( (FtcMenu.ActiveTab = FtiMenuGroup) and (FtiMenuGroup.HelpKeyword.Length > 0) )then FillGroups(FtiMenuGroup.HelpKeyword.ToInteger);
    if( (FtcMenu.ActiveTab = FtiMenuList ) and (FtiMenuList.HelpKeyword.Length  > 0) )then FillList  (FtiMenuList.HelpKeyword.ToInteger);
    if( (FtcMenu.ActiveTab = FtiMenuTMC  ) and (FtiMenuTMC.HelpKeyword.Length   > 0) )then FillCard  (FtiMenuTMC.HelpKeyword.ToInteger, FtiMenuTMC.Tag);
  end
  else if(FtcMain.ActiveTab = FtiMainOrder)then
  begin
    if(FtcOrder.ActiveTab = FtiOrdersList)then FillOrders;
    if(FtcOrder.ActiveTab = FtiOrder     )then FillOrder(FOrderCurr);
  end
  else if(FtcMain.ActiveTab = FtiMainUser)then
    FillUser;
end;

procedure TFormMain.FillCard(const TMC_ID:Integer; const aColor:TColor);
var
  LRow :TJsonObject;
begin
  LRow := DataBaseTMCObject(TMC_ID);
  if(LRow = nil)then exit;

  FtiMenuTMC.HelpKeyword   := TMC_ID.ToString();
  FtiMenuTMC.Tag           := Integer(aColor);
  FtiMenuList.HelpKeyword  := LRow.S[Restourant.Consts.Database.FieldRefTMC_GROUP_ID];
  FtiMenuGroup.HelpKeyword := DataBaseTmcCtgrIdByGroup( LRow.S[Restourant.Consts.Database.FieldRefTMC_GROUP_ID].ToInteger );

  FHbtnPlus.SetCaption ( DataBaseConstString('TEXTBTNADD') );
  FHbtnMinus.SetCaption( DataBaseConstString('TEXTBTNDEL') );
  FVbtnPlus.SetCaption ( DataBaseConstString('TEXTBTNADD') );
  FVbtnMinus.SetCaption( DataBaseConstString('TEXTBTNDEL') );

  FVbgrTMC.Fill.Color    := aColor;
  FVimgTMC.Bitmap.Clear( FVbgrTMC.Fill.Color );
  FVimgTMC.Bitmap.LoadFromFile( ImageFileNameTMC(TMC_ID) );
  FVimgTMC.Height  := 220;
  FVimgTMC.Tag     := TMC_ID;

  FVlblTMC_NAME.Text   := DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefNAME);
  FVlblTMC_COMENT.Text := DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefCOMENT);
  FVlblTMC_PRICE.Text  := DataBaseConstString('TEXTTMCPRICE') + ' ' + FormatFloat(Restourant.Consts.Database.FormatPRICE, SafeFloat(LRow.S[Restourant.Consts.Database.FieldRefPRICE]));
  FVlblTMC_EDIZM.Text  := DataBaseConstString('TEXTTMCPART' ) + ' ' + LRow.S[Restourant.Consts.Database.FieldRefEDIZM_SNAME];
  FVbtnPlus.Tag        := TMC_ID;
  FVlblQuant.Text      := UserBaseOrderQntGet(TMC_ID).ToString;
  FVbtnMinus.Tag       := TMC_ID;

  FHbgrTMC.Fill.Color    := aColor;
  FHimgTMC.Bitmap.Clear( FVbgrTMC.Fill.Color );
  FHimgTMC.Bitmap.LoadFromFile( ImageFileNameTMC(TMC_ID) );
  FHimgTMC.Width   := 330;
  FHimgTMC.Tag     := TMC_ID;

  FHlblTMC_NAME.Text   := DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefNAME);
  FHlblTMC_COMENT.Text := DataBaseGetFieldLocal(LRow, Restourant.Consts.Database.FieldRefCOMENT);
  FHlblTMC_PRICE.Text  := DataBaseConstString('TEXTTMCPRICE') + ' ' + FormatFloat(Restourant.Consts.Database.FormatPRICE, SafeFloat(LRow.S[Restourant.Consts.Database.FieldRefPRICE]));
  FHlblTMC_EDIZM.Text  := DataBaseConstString('TEXTTMCPART' ) + ' ' + LRow.S[Restourant.Consts.Database.FieldRefEDIZM_SNAME];
  FHbtnPlus.Tag        := TMC_ID;
  FHlblQuant.Text      := UserBaseOrderQntGet(TMC_ID).ToString;
  FHbtnMinus.Tag       := TMC_ID;

  if(Height > Width)then
  begin
    FVimgTMC.Height  := Trunc(Width * 2 / 3);
    FtcTMC.ActiveTab := FtiTMCV;
  end
  else
  begin
    FHimgTMC.Width   := Trunc( ( Height - (FTopBar.Height + 16)*2 ) * 3 / 2);
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
  FillOrders;
  FillOrder(FOrderCurr);
  FtcMain.ActiveTab  := FtiMainOrder;
  FtcOrder.ActiveTab := FtiOrder;
end;

procedure TFormMain.actUserExecute(Sender: TObject);
begin
  FillUser;
  FtcMain.ActiveTab := FtiMainUser;
end;

end.

