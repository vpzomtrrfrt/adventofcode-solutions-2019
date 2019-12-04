with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Part1 is
	CurrentLine : String (1 .. 8);
	CurrentLineLength : Natural;

	CurrentModuleMass, CurrentModuleFuel: Natural;
	TotalFuel : Natural := 0;
begin
	while not Ada.Text_IO.End_Of_File loop
		Ada.Text_IO.Get_Line(CurrentLine, CurrentLineLength);
		CurrentModuleMass := Natural'Value(CurrentLine (1 .. CurrentLineLength));
		CurrentModuleFuel := (CurrentModuleMass / 3) - 2;

		TotalFuel := TotalFuel + CurrentModuleFuel;
	end loop;

	Ada.Integer_Text_IO.Put(TotalFuel);
	Ada.Text_IO.New_Line;
end;
