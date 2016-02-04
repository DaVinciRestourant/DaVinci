unit FMX.Helpers.Controls;
interface
uses
  System.SysUtils,  System.IOUtils, System.Types, System.UITypes
 ,System.Classes, System.Variants, System.Actions, System.ImageList
 ,FMX.Types, FMX.Graphics, FMX.Objects, FMX.Controls, FMX.Controls.Presentation
 ,FMX.StdCtrls, FMX.Forms, FMX.Dialogs, FMX.TabControl, FMX.Gestures
 ,FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.DateTimeCtrls
 ;
type
  TRectangleHelper = class helper for TRectangle
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aColor, aBorderColor :System.UITypes.TColor
    ): TRectangle;
    procedure SetCaption(const Value:string);
  end;

  TImageHelper = class helper for TImage
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aWrapMode :FMX.Objects.TImageWrapMode
    ): TImage;
  end;

  TLayoutHelper = class helper for TLayout
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single
    ): TLayout;
  end;

  TLabelHelper = class helper for TLabel
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aText:string; const aTextAlign, aVertTextAlign :FMX.Types.TTextAlign;
      const aFontColor:System.UITypes.TColor;
      const aFontSize:Integer; const aFontStyle:System.UITypes.TFontStyles
    ): TLabel;
    class function NewBG(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aText:string; const aTextAlign, aVertTextAlign :FMX.Types.TTextAlign;
      const aFontColor:System.UITypes.TColor;
      const aFontSize:Integer; const aFontStyle:System.UITypes.TFontStyles;
      const aColor, aBorderColor :System.UITypes.TColor;
      var aBackground :TRectangle
    ): TLabel;
  end;

  TEditHelper = class helper for TEdit
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aText:string; const aTextAlign, aVertTextAlign :FMX.Types.TTextAlign;
      const aFontColor:System.UITypes.TColor;
      const aFontSize:Integer; const aFontStyle:System.UITypes.TFontStyles
    ): TEdit;
  end;

  TDateEditHelper = class helper for TDateEdit
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aDate:TDateTime; const aTextAlign, aVertTextAlign :FMX.Types.TTextAlign;
      const aFontColor:System.UITypes.TColor;
      const aFontSize:Integer; const aFontStyle:System.UITypes.TFontStyles
    ): TDateEdit;
  end;

  TButtonHelper = class helper for TButton
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aText:string; const aTextAlign, aVertTextAlign :FMX.Types.TTextAlign;
      const aFontColor:System.UITypes.TColor;
      const aFontSize:Integer; const aFontStyle:System.UITypes.TFontStyles
    ): TButton;
  end;

  TScrollBoxHelper = class helper for TScrollBox
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single
    ): FMX.Layouts.TScrollBox;
  end;

  TVertScrollBoxHelper = class helper for TVertScrollBox
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single
    ): FMX.Layouts.TVertScrollBox;
  end;

  TListBoxHelper = class helper for TListBox
  public
    class function New(aOwner:TComponent; aParent:TFmxObject;
      const aLeft, aTop, aHeight, aWidth :System.Single;
      const aAlign:FMX.Types.TAlignLayout;
      const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
      const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
      const aListStyle :FMX.ListBox.TListStyle
    ): TListBox;
  end;

implementation

class function TRectangleHelper.New(aOwner:TComponent; aParent:TFmxObject;
           const aLeft, aTop, aHeight, aWidth :System.Single;
           const aAlign:FMX.Types.TAlignLayout;
           const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom:System.Single;
           const aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom:System.Single;
           const aColor, aBorderColor :System.UITypes.TColor
         ): TRectangle;
begin
  Result := TRectangle.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    HitTest        := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    Fill.Color     := aColor;
    Fill.Kind      := FMX.Graphics.TBrushKind.Solid;
    Stroke.Color   := aBorderColor;
    Stroke.Kind    := FMX.Graphics.TBrushKind.Solid;
  end;
end;

class function TImageHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout;
  const aMarginLeft, aMarginTop, aMarginRight, aMarginBottom,
  aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom: System.Single;
  const aWrapMode: FMX.Objects.TImageWrapMode
  ): TImage;
begin
  Result := TImage.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    HitTest        := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    WrapMode       := aWrapMode;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
  end;
end;

class function TLayoutHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single): TLayout;
begin
  Result := TLayout.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    HitTest        := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
  end;
end;

class function TLabelHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single; const aText: string; const aTextAlign,
  aVertTextAlign: FMX.Types.TTextAlign; const aFontColor: System.UITypes.TColor;
  const aFontSize: Integer;
  const aFontStyle: System.UITypes.TFontStyles): TLabel;
begin
  Result := TLabel.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    StyledSettings := [];
    AutoSize       := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    WordWrap       := True;
    Text           := aText;
    TextAlign      := aTextAlign;
    VertTextAlign  := aVertTextAlign;
    FontColor      := aFontColor;
    Font.Size      := aFontSize;
    Font.Style     := aFontStyle;
  end;
end;

class function TVertScrollBoxHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single): FMX.Layouts.TVertScrollBox;
begin
  Result := FMX.Layouts.TVertScrollBox.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    HitTest        := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    ShowScrollBars := True;
  end;
end;

class function TEditHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single; const aText: string; const aTextAlign,
  aVertTextAlign: FMX.Types.TTextAlign; const aFontColor: System.UITypes.TColor;
  const aFontSize: Integer;
  const aFontStyle: System.UITypes.TFontStyles): TEdit;
begin
  Result := TEdit.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    StyledSettings := [];
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    Text           := aText;
    TextAlign      := aTextAlign;
    VertTextAlign  := aVertTextAlign;
    FontColor      := aFontColor;
    Font.Size      := aFontSize;
    Font.Style     := aFontStyle;
  end;
end;

class function TButtonHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single; const aText: string; const aTextAlign,
  aVertTextAlign: FMX.Types.TTextAlign; const aFontColor: System.UITypes.TColor;
  const aFontSize: Integer;
  const aFontStyle: System.UITypes.TFontStyles): TButton;
begin
  Result := TButton.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    StyledSettings := [];
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    Text           := aText;
    TextAlign      := aTextAlign;
    VertTextAlign  := aVertTextAlign;
    FontColor      := aFontColor;
    Font.Size      := aFontSize;
    Font.Style     := aFontStyle;
  end;
end;

{ TScrollBoxHelper }

class function TScrollBoxHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single): FMX.Layouts.TScrollBox;
begin
  Result := FMX.Layouts.TScrollBox.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    HitTest        := False;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    ShowScrollBars := True;
  end;
end;

class function TListBoxHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single;
  const aListStyle: FMX.ListBox.TListStyle): TListBox;
begin
  Result := TListBox.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    ListStyle      := aListStyle;
    ShowCheckboxes := False;
    ShowScrollBars := True;
    ShowSizeGrip   := False;
    StyleLookup    := 'transparentlistboxstyle';
  end;
end;

class function TDateEditHelper.New(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single; const aDate: TDateTime; const aTextAlign,
  aVertTextAlign: FMX.Types.TTextAlign; const aFontColor: System.UITypes.TColor;
  const aFontSize: Integer;
  const aFontStyle: System.UITypes.TFontStyles): TDateEdit;
begin
  Result := TDateEdit.Create(aOwner);
  with Result do
  begin
    Parent         := aParent;
    StyledSettings := [];
    Position.X     := aLeft;
    Position.Y     := aTop;
    Height         := aHeight;
    Width          := aWidth;
    Align          := aAlign;
    Padding.Left   := aPaddingLeft;
    Padding.Top    := aPaddingTop;
    Padding.Right  := aPaddingRight;
    Padding.Bottom := aPaddingBottom;
    Margins.Left   := aMarginLeft;
    Margins.Top    := aMarginTop;
    Margins.Right  := aMarginRight;
    Margins.Bottom := aMarginBottom;
    Date           := aDate;
    TextAlign      := aTextAlign;
    VertTextAlign  := aVertTextAlign;
    FontColor      := aFontColor;
    Font.Size      := aFontSize;
    Font.Style     := aFontStyle;
  end;
end;

class function TLabelHelper.NewBG(aOwner: TComponent; aParent: TFmxObject;
  const aLeft, aTop, aHeight, aWidth: System.Single;
  const aAlign: FMX.Types.TAlignLayout; const aMarginLeft, aMarginTop,
  aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight,
  aPaddingBottom: System.Single; const aText: string; const aTextAlign,
  aVertTextAlign: FMX.Types.TTextAlign; const aFontColor: System.UITypes.TColor;
  const aFontSize: Integer; const aFontStyle: System.UITypes.TFontStyles;
  const aColor, aBorderColor: System.UITypes.TColor;
  var aBackground: TRectangle): TLabel;
begin
  aBackground := TRectangle.New(aOwner, aParent, aLeft, aTop, aHeight, aWidth, aAlign,
    aMarginLeft, aMarginTop, aMarginRight, aMarginBottom, aPaddingLeft, aPaddingTop, aPaddingRight, aPaddingBottom, aColor, aBorderColor);
  Result := TLabel.New(aOwner, aBackground, 0,0,aBackground.Height,aBackground.Width, FMX.Types.TAlignLayout.Client, 1,1,1,1,0,0,0,0,
    aText, aTextAlign, aVertTextAlign, aFontColor, aFontSize, aFontStyle);
end;

procedure TRectangleHelper.SetCaption(const Value: string);
var
  i :Integer;
begin
  for i:=0 to ControlsCount-1 do
    if(Controls[i] is TLabel)then
    begin
      TLabel(Controls[i]).Text := Value;
      Break;
    end;
end;

end.
