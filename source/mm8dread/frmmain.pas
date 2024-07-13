{ +--------------------------------------------------------------------------+ }
{ | MM8DRead v0.4 * Status reader program for MM8D device                    | }
{ | Copyright (C) 2020-2024 Pozsár Zsolt <pozsarzs@gmail.com>                | }
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
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, ValEdit, untcommonproc;

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
    Bevel5: TBevel;
    Bevel6: TBevel;
    Button1: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
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
    Label11: TLabel;
    Label12: TLabel;
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
    PageControl2: TPageControl;
    Process1: TProcess;
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
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape4: TShape;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ValueListEditor1: TValueListEditor;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label12MouseEnter(Sender: TObject);
    procedure Label12MouseLeave(Sender: TObject);
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
//  ledoff, ledon: TColor;

resourcestring
  MESSAGE01 = 'Cannot read configuration file!';
  MESSAGE02 = 'Cannot write configuration file!';
  MESSAGE03 = 'Cannot read data from this URL!';
  MESSAGE04 = 'Not compatible controller!';
  MESSAGE05 = 'Bad data!';
  MESSAGE06 = 'Growing mushroom';
  MESSAGE07 = 'Growing hyphae';
  MESSAGE08 = 'Stand-by';
  MESSAGE09 = 'name';
  MESSAGE10 = 'version';
  MESSAGE11 = 'channel name';
  MESSAGE12 = 'date';
  MESSAGE13 = 'time';
  MESSAGE14 = 'overcurrent breaker';
  MESSAGE15 = 'low pressure';
  MESSAGE16 = 'high pressure';
  MESSAGE17 = 'outdoor temperature';
  MESSAGE18 = 'irrigator tube #1';
  MESSAGE19 = 'irrigator tube #2';
  MESSAGE20 = 'irrigator tube #3';
  MESSAGE21 = 'temperature';
  MESSAGE22 = 'relative humidity';
  MESSAGE23 = 'manual operation';
  MESSAGE24 = 'operation mode';
  MESSAGE25 = 'overcurrent breaker';
  MESSAGE26 = 'alarm';
  MESSAGE27 = 'timeout error';
  MESSAGE28 = 'light';
  MESSAGE29 = 'ventilator';
  MESSAGE30 = 'heater';
  MESSAGE31 = 'override channel';
  MESSAGE32 = 'Cannot run default webbrowser!';
  MESSAGE33 = 'Channel #';

implementation

{$R *.lfm}
{ TForm1 }

function led(color: byte; status: string): TColor;
const
  colors: array[0..1,0..2] of TColor = ((clMaroon, clOlive, clGreen),
                                        (clRed, clYellow, clLime));
begin
  led := colors[strtoint(status), color];
end;

// read data from device
procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  format: TFormatSettings;
  good: boolean;
  t, rh, gc: single;
  b: byte;
begin
  // try to read from MM8D
  good := getdatafromdevice(ComboBox1.Text, ComboBox2.ItemIndex + 1);
  if not good then
    ShowMessage(MESSAGE03);
  // check received data
  if good then
    if (value0.Count < 2) or (value1.Count < 10) or
       (value2.Count < 13) or (value3.Count < 4) then
    begin
      good := False;
      ShowMessage(MESSAGE05);
    end;
  // check version of MM8D
  if good then
    if (value0.Strings[0] <> 'MM8D') or (value0.Strings[1] <> '0.6') then
    begin
      good := False;
      ShowMessage(MESSAGE04);
    end;
  if not good then
  begin
    ComboBox2Change(Sender);
    StatusBar1.Panels.Items[0].Text := '';
    StatusBar1.Panels.Items[1].Text := '';
  end else
  begin
    for b := 0 to 1 do ValueListEditor1.Cells[1, b + 1] := value0[b];
    for b := 0 to 9 do ValueListEditor1.Cells[1, b + 1 + 2] := value1[b];
    for b := 0 to 12 do ValueListEditor1.Cells[1, b + 1 + 2 + 10] := value2[b];
    for b := 0 to 3 do ValueListEditor1.Cells[1, b + 1 + 2 + 10 + 13] := value3[b];
    for b := 0 to 3 do ValueListEditor1.Cells[1, b + 1 + 2 + 10 + 13 + 4] := value4[b];
    Label26.Caption := ValueListEditor1.Cells[1, 3];
    Shape15.Brush.Color := led(0, ValueListEditor1.Cells[1,6]);
    Shape16.Brush.Color := led(0, ValueListEditor1.Cells[1,7]);
    Shape17.Brush.Color := led(0, ValueListEditor1.Cells[1,8]);
    Shape18.Brush.Color := led(2, ValueListEditor1.Cells[1,10]);
    Shape19.Brush.Color := led(2, ValueListEditor1.Cells[1,11]);
    Shape20.Brush.Color := led(2, ValueListEditor1.Cells[1,12]);
    format.DecimalSeparator := '.';
    trystrtofloat(ValueListEditor1.Cells[1,9], t, format);
    t := round(t);
    if (t >= -50) and (t < 100) then
      Label9.Caption := floattostr(t) + ' °C'
    else
      Label9.Caption := '0 °C';
    Label30.Caption := ValueListEditor1.Cells[1,13];
    trystrtofloat(ValueListEditor1.Cells[1,16], t, format);
    trystrtofloat(ValueListEditor1.Cells[1,17], rh, format);
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
    case strtoint(ValueListEditor1.Cells[1,19]) of
      0: Label8.Caption := MESSAGE08;
      1: Label8.Caption := MESSAGE07;
      2: Label8.Caption := MESSAGE06;
    else
      Label8.Caption := '';
    end;
    Shape27.Brush.Color := led(1, ValueListEditor1.Cells[1,18]);
    Shape28.Brush.Color := led(0, ValueListEditor1.Cells[1,20]);
    Shape29.Brush.Color := led(0, ValueListEditor1.Cells[1,21]);
    Shape30.Brush.Color := led(2, ValueListEditor1.Cells[1,23]);
    Shape31.Brush.Color := led(2, ValueListEditor1.Cells[1,24]);
    Shape32.Brush.Color := led(2, ValueListEditor1.Cells[1,25]);
    // Status bar
    StatusBar1.Panels.Items[0].Text := ' ' + ValueListEditor1.Cells[1, 1] + ' v' + ValueListEditor1.Cells[1, 2];
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

// open homepage
procedure TForm1.Label12Click(Sender: TObject);
begin
  if length(BROWSER) > 0 then
  begin
    Process1.Executable := BROWSER;
    Process1.Parameters.Add(Label12.Caption);
    try
      Form1.Process1.Execute;
    except
      ShowMessage(MESSAGE32);
    end;
  end;
end;

procedure TForm1.Label12MouseEnter(Sender: TObject);
begin
  Label12.Font.Color := clPurple;
end;

procedure TForm1.Label12MouseLeave(Sender: TObject);
begin
  Label12.Font.Color := clBlue;
end;

// event of ComboBox1-2
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if length(ComboBox1.Text) = 0 then
  begin
    Button1.Enabled := False;
    SpeedButton2.Enabled := False;
    SpeedButton3.Enabled := False;
  end
  else
  begin
    Button1.Enabled := True;
    SpeedButton2.Enabled := True;
    SpeedButton3.Enabled := True;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  TabSheet3.Caption := ComboBox2.Items.Strings[ComboBox2.ItemIndex];
  Label3.Caption := '0 °C';
  Label4.Caption := '0 %';
  Label9.Caption := '0 °C';
  Label8.Caption := '';
  Label19.Caption := '';
  Label26.Caption := '';
  Label30.Caption := '';
  Shape15.Brush.Color := led(0, '0');
  Shape16.Brush.Color := led(0, '0');
  Shape17.Brush.Color := led(0, '0');
  Shape18.Brush.Color := led(2, '0');
  Shape19.Brush.Color := led(2, '0');
  Shape20.Brush.Color := led(2, '0');
  Shape27.Brush.Color := led(1, '0');
  Shape28.Brush.Color := led(0, '0');
  Shape29.Brush.Color := led(0, '0');
  Shape30.Brush.Color := led(2, '0');
  Shape31.Brush.Color := led(2, '0');
  Shape32.Brush.Color := led(2, '0');
  StatusBar1.Panels.Items[0].Text := '';
  StatusBar1.Panels.Items[1].Text := '';
end;

// events of PageControl1
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

// events of Form1
procedure TForm1.FormCreate(Sender: TObject);
var
  b: byte;
begin
  makeuserdir;
  getlang;
  getexepath;
  // static text
  Form1.Caption := APPNAME + ' v' + VERSION;
  Label5.Caption := Form1.Caption;
  ValueListEditor1.Cells[0,1]:= MESSAGE09;
  ValueListEditor1.Cells[0,2]:= MESSAGE10;
  ValueListEditor1.Cells[0,3]:= MESSAGE11;
  ValueListEditor1.Cells[0,4]:= MESSAGE12;
  ValueListEditor1.Cells[0,5]:= MESSAGE13;
  ValueListEditor1.Cells[0,6]:= MESSAGE14;
  ValueListEditor1.Cells[0,7]:= MESSAGE15;
  ValueListEditor1.Cells[0,8]:= MESSAGE16;
  ValueListEditor1.Cells[0,9]:= MESSAGE17;
  ValueListEditor1.Cells[0,10] := MESSAGE18;
  ValueListEditor1.Cells[0,11] := MESSAGE19;
  ValueListEditor1.Cells[0,12] := MESSAGE20;
  ValueListEditor1.Cells[0,13] := MESSAGE11;
  ValueListEditor1.Cells[0,14] := MESSAGE12;
  ValueListEditor1.Cells[0,15] := MESSAGE13;
  ValueListEditor1.Cells[0,16] := MESSAGE21;
  ValueListEditor1.Cells[0,17] := MESSAGE22;
  ValueListEditor1.Cells[0,18] := MESSAGE23;
  ValueListEditor1.Cells[0,19] := MESSAGE24;
  ValueListEditor1.Cells[0,20] := MESSAGE25;
  ValueListEditor1.Cells[0,21] := MESSAGE26;
  ValueListEditor1.Cells[0,22] := MESSAGE27;
  ValueListEditor1.Cells[0,23] := MESSAGE28;
  ValueListEditor1.Cells[0,24] := MESSAGE29;
  ValueListEditor1.Cells[0,25] := MESSAGE30;
  ValueListEditor1.Cells[0,26] := MESSAGE31;
  ValueListEditor1.Cells[0,27] := MESSAGE18;
  ValueListEditor1.Cells[0,28] := MESSAGE19;
  ValueListEditor1.Cells[0,29] := MESSAGE20;
  ValueListEditor1.Cells[0,30] := MESSAGE31;
  ValueListEditor1.Cells[0,31] := MESSAGE28;
  ValueListEditor1.Cells[0,32] := MESSAGE29;
  ValueListEditor1.Cells[0,33] := MESSAGE30;
  ValueListEditor1.AutoSizeColumn(0);
  for b := 1 to 8 do
    ComboBox2.Items.Add(MESSAGE33 + inttostr(b));
  ComboBox2.ItemIndex := 0;
  // load configuration
  inifile := untcommonproc.userdir + DIR_CONFIG + 'mm8dread.ini';
  if FileSearch('mm8dread.ini', untcommonproc.userdir + DIR_CONFIG) <> '' then
    if not loadconfiguration(inifile) then
      ShowMessage(MESSAGE01);
  // fill Combobox1 with URLs
  for b := 0 to 63 do
    if length(urls[b]) > 0 then
      ComboBox1.Items.Add(untcommonproc.urls[b]);
  if ComboBox1.Items.Count > 0 then
  begin
    ComboBox1.ItemIndex := 0;
    Button1.Enabled := true;
    SpeedButton2.Enabled := true;
    SpeedButton3.Enabled := true;
  end;
  untcommonproc.value0 := TStringList.Create;
  untcommonproc.value1 := TStringList.Create;
  untcommonproc.value2 := TStringList.Create;
  untcommonproc.value3 := TStringList.Create;
  untcommonproc.value4 := TStringList.Create;
  // clear displays
  ComboBox2Change(Sender);
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
  if not saveconfiguration(inifile) then
    ShowMessage(MESSAGE02);
  untcommonproc.value0.Free;
  untcommonproc.value1.Free;
  untcommonproc.value2.Free;
  untcommonproc.value3.Free;
  untcommonproc.value4.Free;
end;

end.
