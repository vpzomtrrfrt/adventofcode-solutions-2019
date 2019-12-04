with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Part2 is
	CurrentLine : String (1 .. 8);
	CurrentLineLength : Natural;

	CurrentModuleMass, CurrentModuleFuel: Natural;
	CurrentFuelFuel: Integer;

	TotalFuel : Natural := 0;
begin
	while not Ada.Text_IO.End_Of_File loop
		Ada.Text_IO.Get_Line(CurrentLine, CurrentLineLength);
		CurrentModuleMass := Natural'Value(CurrentLine (1 .. CurrentLineLength));
		CurrentModuleFuel := (CurrentModuleMass / 3) - 2;

		CurrentFuelFuel := CurrentModuleFuel; -- not technically correct, but makes the loop work

		FuelFuelLoop:
			loop
				CurrentFuelFuel := (CurrentFuelFuel / 3) - 2;

				exit FuelFuelLoop when CurrentFuelFuel <= 0;

				CurrentModuleFuel := CurrentModuleFuel + CurrentFuelFuel;
			end loop FuelFuelLoop;


		TotalFuel := TotalFuel + CurrentModuleFuel;
	end loop;

	Ada.Integer_Text_IO.Put(TotalFuel);
	Ada.Text_IO.New_Line;
end;
