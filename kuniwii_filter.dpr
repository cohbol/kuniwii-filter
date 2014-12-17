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

program kuniwii_filter;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufmain in 'ufmain.pas' {fkuniwiifilter};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.soInvertedLandscape];
  Application.CreateForm(Tfkuniwiifilter, fkuniwiifilter);
  Application.Run;
end.
