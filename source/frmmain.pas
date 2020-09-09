{ +--------------------------------------------------------------------------+ }
{ | MM8DRead v0.1 * Status reader program for MM8D/RPI device                | }
{ | Copyright (C) 2020 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>          | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit frmmain;

{$mode objfpc}{$H+}
interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, untcommonproc;

type
  { TForm1 }
  TForm1 = class(TForm)
    Bevel1: TBevel;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel2: TBevel;
    Bevel20: TBevel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Bevel23: TBevel;
    Bevel24: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PageControl1: TPageControl;
    Shape1: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  inifile: string;

resourcestring
  MESSAGE01 = 'Cannot read configuration file!';
  MESSAGE02 = 'Cannot write configuration file!';
  MESSAGE03 = 'Cannot read data from this URL!';
  MESSAGE04 = 'Not compatible controller!';
  MESSAGE05 = 'Bad data!';

implementation

{$R *.lfm}
{ TForm1 }

// read data from device
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  format: TFormatSettings;
  good: boolean;
  ledoff, ledon: TColor;
  t, rh: single;
begin
  good := getdatafromdevice(ComboBox1.Text, Edit1.Text, ComboBox2.ItemIndex + 1);
  if not good then
    ShowMessage(MESSAGE03);
  if good then
    if (value0.Count < 2) or (value1.Count < 9) then
    begin
      good := False;
      ShowMessage(MESSAGE05);
    end;
  if good then
    if (value0.Strings[0] <> 'MM8D/RPI') or (value0.Strings[1] <> 'v0.1') then
    begin
      good := False;
      ShowMessage(MESSAGE04);
    end;
  if not good then
  begin
    // Channel #0
    Label19.Caption := '';
    ledoff := clMaroon;
    Shape15.Brush.Color := ledoff;
    Shape16.Brush.Color := ledoff;
    Shape17.Brush.Color := ledoff;
    Shape18.Brush.Color := ledoff;
    Shape19.Brush.Color := ledoff;
    Shape20.Brush.Color := ledoff;
    // Other channels

    {    // displays

távoli mért értékek
  a. MM7D  hőmérséklet
  b. MM7D  relatív páratartalom
  c. MM7D  relatív gázkoncentráció

távoli állapotok
  d. MM6D  működési mód           0/1     átszövetés/termesztés
  e. MM6D  kézi üzem              0/1     sárga LED
  f. MM6D  túláramvédelem         0/1     piros LED
  g. MM6D  riasztó                0/1     piros LED

távoli kimenetek
  h. MM6D  világłtás              0/1     zöld LED
  i. MM6D  szellőztetés           0/1     zöld LED
  j. MM6D  fűtés                  0/1     zöld LED
  k. MM7D  zöld állapotjelző      0/1     zöld LED
  l. MM7D  sárga állapotjelző     0/1     sárga LED
  n. MM7D  piros állapotjelző     0/1     piros LED

log: date time a b c d e f g h i j k l m n


    Label3.Caption := '0 °C';
    Label4.Caption := '0 %';
    // LEDs
    ledoff := clGreen;
    Shape3.Brush.Color := ledoff;
    Shape4.Brush.Color := ledoff;
    Shape5.Brush.Color := ledoff;
    Shape6.Brush.Color := ledoff;
    ledoff := clMaroon;
    Shape7.Brush.Color := ledoff;
    Shape8.Brush.Color := ledoff;
    Shape9.Brush.Color := ledoff;
    Shape10.Brush.Color := ledoff;
    ledoff := clOlive;
    Shape11.Brush.Color := ledoff;
    Shape12.Brush.Color := ledoff;
    Shape13.Brush.Color := ledoff;
    Shape14.Brush.Color := ledoff; }
    // Status bar
    StatusBar1.Panels.Items[0].Text := '';
    Form1.Caption := APPNAME + ' v' + VERSION;
  end
  else
  begin
    // Channel #0
    Label26.Caption := value1.Strings[0];
    Label19.Caption := value1.Strings[1] + ' ' + value1.Strings[2];
    ledoff := clMaroon;
    ledon := clred;
    if value1.Strings[3] = '1' then
      Shape15.Brush.Color := ledon
    else
      Shape15.Brush.Color := ledoff;
    if value1.Strings[4] = '1' then
      Shape16.Brush.Color := ledon
    else
      Shape16.Brush.Color := ledoff;
    if value1.Strings[5] = '1' then
      Shape17.Brush.Color := ledon
    else
      Shape17.Brush.Color := ledoff;
    if value1.Strings[6] = '1' then
      Shape18.Brush.Color := ledon
    else
      Shape18.Brush.Color := ledoff;
    if value1.Strings[7] = '1' then
      Shape19.Brush.Color := ledon
    else
      Shape19.Brush.Color := ledoff;
    if value1.Strings[8] = '1' then
      Shape20.Brush.Color := ledon
    else
      Shape20.Brush.Color := ledoff;
    // Other channels


    {






    format.DecimalSeparator:='.';
    trystrtofloat(value3.Strings[2], t, format);
    trystrtofloat(value3.Strings[3], rh, format);
    // displays
    t := round(t);
    if (t >= 0) and (t < 100) then
      Label3.Caption := floattostr(t) + ' °C'
    else
      Label3.Caption := '0 °C';
    rh := round(rh);
    if (rh >= 0) and (rh < 101) then
      Label4.Caption := floattostr(rh) + ' %'
    else
      Label4.Caption := '0 %';
    // LEDs
    ledoff := clGreen;
    ledon := clLime;
    if value3.Strings[4] = '1' then
      Shape3.Brush.Color := ledon
    else
      Shape3.Brush.Color := ledoff;
    if value3.Strings[5] = '1' then
      Shape4.Brush.Color := ledon
    else
      Shape4.Brush.Color := ledoff;
    if value3.Strings[6] = '1' then
      Shape5.Brush.Color := ledon
    else
      Shape5.Brush.Color := ledoff;
    if value3.Strings[7] = '1' then
      Shape6.Brush.Color := ledon
    else
      Shape6.Brush.Color := ledoff;
    ledoff := clMaroon;
    ledon := clred;
    if value3.Strings[12] = '1' then
      Shape7.Brush.Color := ledon
    else
      Shape7.Brush.Color := ledoff;
    if value3.Strings[13] = '1' then
      Shape8.Brush.Color := ledon
    else
      Shape8.Brush.Color := ledoff;
    if value3.Strings[14] = '1' then
      Shape9.Brush.Color := ledon
    else
      Shape9.Brush.Color := ledoff;
    if value3.Strings[15] = '1' then
      Shape10.Brush.Color := ledon
    else
      Shape10.Brush.Color := ledoff;
    ledoff := clOlive;
    ledon := clYellow;
    if value3.Strings[8] = '1' then
      Shape11.Brush.Color := ledon
    else
      Shape11.Brush.Color := ledoff;
    if value3.Strings[9] = '1' then
      Shape12.Brush.Color := ledon
    else
      Shape12.Brush.Color := ledoff;
    if value3.Strings[10] = '1' then
      Shape13.Brush.Color := ledon
    else
      Shape13.Brush.Color := ledoff;
    if value3.Strings[11] = '1' then
      Shape14.Brush.Color := ledon
    else
      Shape14.Brush.Color := ledoff;  }
    // Status bar
    StatusBar1.Panels.Items[0].Text := value0.Strings[0] + ' ' + value0.Strings[1];
    Form1.Caption := APPNAME + ' v' + VERSION + ' | ' + value0.Strings[2];
  end;
end;

// add URL to list
procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  line: byte;
  thereis: boolean;
begin
  thereis := False;
  if ComboBox1.Items.Count > 0 then
    for line := 0 to ComboBox1.Items.Count - 1 do
      if ComboBox1.Items.Strings[line] = ComboBox1.Text then
        thereis := True;
  if (not thereis) and (ComboBox1.Items.Count < 64) then
    ComboBox1.Items.AddText(ComboBox1.Text);
end;

// remove URL from list
procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  line: byte;
begin
  if ComboBox1.Items.Count > 0 then
  begin
    for line := 0 to ComboBox1.Items.Count - 1 do
      if ComboBox1.Items.Strings[line] = ComboBox1.Text then
        break;
    ComboBox1.Items.Delete(line);
    ComboBox1Change(Sender);
  end;
end;

// event of ComboBox1
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if length(ComboBox1.Text) = 0 then
  begin
    SpeedButton1.Enabled := False;
    SpeedButton2.Enabled := False;
    SpeedButton3.Enabled := False;
  end
  else
  begin
    SpeedButton1.Enabled := True;
    SpeedButton2.Enabled := True;
    SpeedButton3.Enabled := True;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  TabSheet2.Caption := ComboBox2.Items.Strings[ComboBox2.ItemIndex];
end;

// events of Form1
procedure TForm1.FormCreate(Sender: TObject);
var
  b: byte;
begin
  makeuserdir;
  getlang;
  getexepath;
  Form1.Caption := APPNAME + ' v' + VERSION;
  // load configuration
  inifile := untcommonproc.userdir + DIR_CONFIG + 'mm8dread.ini';
  if FileSearch('mm8dread.ini', untcommonproc.userdir + DIR_CONFIG) <> '' then
    if not loadconfiguration(inifile) then
      ShowMessage(MESSAGE01);
  Edit1.Text := untcommonproc.uids;
  for b := 0 to 63 do
    if length(urls[b]) > 0 then
      ComboBox1.Items.Add(untcommonproc.urls[b]);
  // set position of speedbuttons
  SpeedButton1.Top := ComboBox1.Top + ((ComboBox1.Height - SpeedButton1.Height) div 2);
  SpeedButton2.Top := SpeedButton1.Top;
  SpeedButton3.Top := SpeedButton1.Top;
  Edit1.Top := SpeedButton1.Top;
  untcommonproc.value0 := TStringList.Create;
  untcommonproc.value1 := TStringList.Create;
  untcommonproc.value2 := TStringList.Create;
  ComboBox2Change(Sender);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Bevel2.Width := (Form1.Width div 2) - 6;
  Bevel3.Width := Bevel2.Width;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  b: byte;
begin
  for b := 0 to 63 do
    untcommonproc.urls[b] := '';
  if ComboBox1.Items.Count > 0 then
    for b := 0 to ComboBox1.Items.Count - 1 do
      untcommonproc.urls[b] := ComboBox1.Items.Strings[b];
  untcommonproc.uids := Edit1.Text;
  if not saveconfiguration(inifile) then
    ShowMessage(MESSAGE02);
  untcommonproc.value0.Free;
  untcommonproc.value1.Free;
  untcommonproc.value2.Free;
end;

end.
