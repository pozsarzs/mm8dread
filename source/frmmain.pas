{ +--------------------------------------------------------------------------+ }
{ | MM8DRead v0.3 * Status reader program for MM8D device                    | }
{ | Copyright (C) 2020-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
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
    Bevel28: TBevel;
    Bevel29: TBevel;
    Bevel3: TBevel;
    Bevel30: TBevel;
    Bevel31: TBevel;
    Bevel32: TBevel;
    Bevel33: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label17: TLabel;
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
    Label3: TLabel;
    Label30: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Shape1: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape20: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape3: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape4: TShape;
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
    procedure PageControl1Change(Sender: TObject);
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
  ledoff, ledon: TColor;

resourcestring
  MESSAGE01 = 'Cannot read configuration file!';
  MESSAGE02 = 'Cannot write configuration file!';
  MESSAGE03 = 'Cannot read data from this URL!';
  MESSAGE04 = 'Not compatible controller!';
  MESSAGE05 = 'Bad data!';
  MESSAGE06 = 'Growing mushroom';
  MESSAGE07 = 'Growing hyphae';

implementation

{$R *.lfm}
{ TForm1 }

// read data from device
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  format: TFormatSettings;
  good: boolean;
  t, rh, gc: single;
begin
  good := getdatafromdevice(ComboBox1.Text, Edit1.Text, ComboBox2.ItemIndex + 1);
  if not good then
    ShowMessage(MESSAGE03);
  if good then
    if (value0.Count < 2) or (value1.Count < 10) or (value2.Count < 13) then
    begin
      good := False;
      ShowMessage(MESSAGE05);
    end;
  if good then
    if (value0.Strings[0] <> 'MM8D') or (value0.Strings[1] <> 'v0.3') then
    begin
      good := False;
      ShowMessage(MESSAGE04);
    end;
  if not good then
  begin
    ComboBox2Change(Sender);
    // Status bar
    StatusBar1.Panels.Items[0].Text := '';
    StatusBar1.Panels.Items[1].Text := '';
  end
  else
  begin
    // Channel #0
    Label26.Caption := value1.Strings[0];
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
    ledoff := clOlive;
    ledon := clYellow;
    if value1.Strings[7] = '1' then
      Shape18.Brush.Color := ledon
    else
      Shape18.Brush.Color := ledoff;
    if value1.Strings[8] = '1' then
      Shape19.Brush.Color := ledon
    else
      Shape19.Brush.Color := ledoff;
    if value1.Strings[9] = '1' then
      Shape20.Brush.Color := ledon
    else
      Shape20.Brush.Color := ledoff;
    trystrtofloat(value1.Strings[6], t, format);
    t := round(t);
    if (t >= -50) and (t < 100) then
      Label9.Caption := floattostr(t) + ' °C'
    else
      Label9.Caption := '0 °C';
    // Other channels
    Label30.Caption := value2.Strings[0];
    // MM7D
    format.DecimalSeparator := '.';
    trystrtofloat(value2.Strings[3], t, format);
    trystrtofloat(value2.Strings[4], rh, format);
    trystrtofloat(value2.Strings[5], gc, format);
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
    gc := round(gc);
    if (gc >= 0) and (gc < 101) then
      Label5.Caption := floattostr(gc) + ' %'
    else
      Label5.Caption := '0 %';
    ledoff := clGreen;
    ledon := clLime;
    // MM6D
    if value2.Strings[6] = '0' then
      Label8.Caption := MESSAGE06
    else
      Label8.Caption := MESSAGE07;
    ledoff := clOlive;
    ledon := clYellow;
    if value2.Strings[7] = '1' then
      Shape27.Brush.Color := ledon
    else
      Shape27.Brush.Color := ledoff;
    ledoff := clMaroon;
    ledon := clRed;
    if value2.Strings[8] = '1' then
      Shape28.Brush.Color := ledon
    else
      Shape28.Brush.Color := ledoff;
    if value2.Strings[9] = '1' then
      Shape29.Brush.Color := ledon
    else
      Shape29.Brush.Color := ledoff;
    ledoff := clGreen;
    ledon := clLime;
    if value2.Strings[10] = '1' then
      Shape30.Brush.Color := ledon
    else
      Shape30.Brush.Color := ledoff;
    if value2.Strings[11] = '1' then
      Shape31.Brush.Color := ledon
    else
      Shape31.Brush.Color := ledoff;
    if value2.Strings[12] = '1' then
      Shape32.Brush.Color := ledon
    else
      Shape32.Brush.Color := ledoff;
    // Status bar
    StatusBar1.Panels.Items[0].Text := ' ' + value0.Strings[0] + ' ' + value0.Strings[1];
    PageControl1Change(Sender)
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
  // Channel #0
  Label19.Caption := '';
  Label26.Caption := '';
  ledoff := clMaroon;
  Shape15.Brush.Color := ledoff;
  Shape16.Brush.Color := ledoff;
  Shape17.Brush.Color := ledoff;
  ledoff := clOlive;
  Shape18.Brush.Color := ledoff;
  Shape19.Brush.Color := ledoff;
  Shape20.Brush.Color := ledoff;
  Label9.Caption := '0°C';
  // Other channels
  Label30.Caption := '';
  // MM7D
  Label3.Caption := '0°C';
  Label4.Caption := '0%';
  Label5.Caption := '0%';
  // MM6D
  Label8.Caption := '';
  ledoff := clOlive;
  Shape27.Brush.Color := ledoff;
  ledoff := clMaroon;
  Shape28.Brush.Color := ledoff;
  Shape29.Brush.Color := ledoff;
  ledoff := clGreen;
  Shape30.Brush.Color := ledoff;
  Shape31.Brush.Color := ledoff;
  Shape32.Brush.Color := ledoff;
  // Status bar
  StatusBar1.Panels.Items[0].Text := '';
  StatusBar1.Panels.Items[1].Text := '';
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

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  if (value1.Count > 3) and (value2.Count > 3) then
    if PageControl1.ActivePageIndex = 0 then
      StatusBar1.Panels.Items[1].Text :=
        ' ' + value1.Strings[1] + ' ' + value1.Strings[2]
    else
      StatusBar1.Panels.Items[1].Text :=
        ' ' + value2.Strings[1] + ' ' + value2.Strings[2];
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
