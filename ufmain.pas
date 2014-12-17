//*******************************************************
// Copyright (C) 2010-2011 Hiroshi Takey <htakey@gmail.com>
// Santa Cruz de la Sierra, Bolivia.
//
// This file is part of KUniwii Filter.
//
// KUniwii Filter can not be copied and/or distributed without the express
// permission of Hiroshi Takey.
// This file is subject to the terms and conditions defined in
// file 'LICENSE.txt', which is part of this source code package.
//
// ufmain.pas is part of Kuniwii Filter.

//  Kuniwii Filter is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License.

//  Foobar is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
//*******************************************************/

unit ufmain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.Sensors, FMX.StdCtrls, FMX.Edit;

type
  Tfkuniwiifilter = class(TForm)
    timerlectura: TTimer;
    ssalida_crudo: TScrollBar;
    ssalida_filtrada: TScrollBar;
    lmargenError: TLabel;
    lsalida_filtrada: TLabel;
    Proximidad_Ruido: TLabel;
    smargenError: TScrollBar;
    sruido: TScrollBar;
    slecturaVel: TScrollBar;
    bactivar: TButton;
    sensor_movimiento: TMotionSensor;
    llecturavel: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure timerlecturaTimer(Sender: TObject);
    procedure smargenErrorChange(Sender: TObject);
    procedure sruidoChange(Sender: TObject);
    procedure slecturaVelChange(Sender: TObject);
    procedure bactivarClick(Sender: TObject);
  private
    { Private declarations }
  public
    valor_entradatemporal, margenError, acercamiento_ruido:Double;
    lecturaVel:Integer;
    procedure KUniwii_filter(valor_entrada:Double);
    { Public declarations }
  end;

//Const Noise = 0.1 ;

var
  fkuniwiifilter: Tfkuniwiifilter;

implementation


{$R *.fmx}

procedure Tfkuniwiifilter.KUniwii_filter(valor_entrada:Double);
begin

    if ((valor_entrada - valor_entradatemporal) > margenError) or ((valor_entrada - valor_entradatemporal) < ((margenError)*(-1))) then
    begin
      valor_entradatemporal := valor_entradatemporal + (acercamiento_ruido *(valor_entrada - valor_entradatemporal));
    end;

End;

procedure Tfkuniwiifilter.smargenErrorChange(Sender: TObject);
begin
  margenError:= round(smargenError.Value);
end;

procedure Tfkuniwiifilter.sruidoChange(Sender: TObject);
begin
  acercamiento_ruido:= sruido.Value;
end;

procedure Tfkuniwiifilter.slecturaVelChange(Sender: TObject);
begin
  lecturaVel:= round(slecturaVel.Value);
  llecturavel.Text:= IntToStr(lecturaVel);
  timerlectura.Interval:= lecturaVel;
end;

procedure Tfkuniwiifilter.bactivarClick(Sender: TObject);
begin

 if timerlectura.Enabled then
 begin
   timerlectura.Enabled:=false;
   bactivar.Text:= 'Activar';
   sensor_movimiento.Active:= false;
 end
 else
 begin
   bactivar.Text:= 'Desactivar';
   sensor_movimiento.Active:= true;
   sensor_movimiento.Sensor.UpdateInterval:= 10;
   timerlectura.Enabled:=true;
 end;

end;

procedure Tfkuniwiifilter.FormCreate(Sender: TObject);
begin

  ssalida_crudo.Value:= 127;
  valor_entradatemporal := 0;

  margenError:= 3;
  smargenError.Value:= margenError;

  acercamiento_ruido:= 0.01;
  sruido.Value:= acercamiento_ruido;

  slecturaVel.Value:= 30;
  lecturaVel:= round(slecturaVel.Value);
  timerlectura.Interval:= lecturaVel;

end;


procedure Tfkuniwiifilter.timerlecturaTimer(Sender: TObject);
var
  lectura_temporal: double;
begin
  lectura_temporal:= round(sensor_movimiento.Sensor.AccelerationY * (-1) * 15) + (ssalida_crudo.Max / 2);
  ssalida_crudo.Value:= lectura_temporal;
  KUniwii_filter(lectura_temporal);
  ssalida_filtrada.Value:= round(valor_entradatemporal);

  lmargenError.Text:= 'Margen Error: ' + margenError.ToString;
  lsalida_filtrada.Text:= 'Filtro Salida ' + valor_entradatemporal.ToString;
  Proximidad_Ruido.Text:= 'Proximidad_Ruido: ' + acercamiento_ruido.ToString;
end;

end.
