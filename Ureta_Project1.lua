--~ Julio ureta
--~ GAM218
--~ 01/22/2015
--~ Game tool that produces random numbered attributes for chosen class.

--~ Establish the random seed to produce a random number later in the program.
math.randomseed(os.time());
math.random();
math.random();
math.random();

--~ Variable Definitions
repeatCheck = "y"
playerClass = "";
availableClasses = "";
strengthAttribute = 0;
dexterityAttribute = 0;
intelligenceAttribute = 0;

repeat
--~ A divider to keep the output readable between repeated runs.
	print("\n****************************************************************");
	print("****************************************************************");
	print("");

--~ Display the available classes to the player, and ask them for a choice.
	print(" 1. Warrior \n 2. Thief \n 3. Wizard \n");
	io.write("Enter the number next to the class you wish to be: ");
	playerClass = io.read();

	print("");

--~ Produce random values for each attribute depending on chosen class.
--~ Display the class they chose, and their randomized results.
	if (playerClass == "1") then
		strengthAttribute = tonumber(math.random(5, 10));
		dexterityAttribute = tonumber(math.random(2, 5));
		intelligenceAttribute = tonumber(math.random(0, 5));

		print("You chose to be a Warrior. Your randomized stats are: \nStr: " ..
				strengthAttribute .. "\nDex: " .. dexterityAttribute ..
				"\nInt: " .. intelligenceAttribute)
	elseif (playerClass == "2") then
		strengthAttribute = tonumber(math.random(2, 5));
		dexterityAttribute = tonumber(math.random(5, 10));
		intelligenceAttribute = tonumber(math.random(0, 5));

		print("You chose to be a Thief. Your randomized stats are: \nStr: " ..
				strengthAttribute .. "\nDex: " .. dexterityAttribute ..
				"\nInt: " .. intelligenceAttribute);
	elseif (playerClass == "3") then
		strengthAttribute = tonumber(math.random(0, 5));
		dexterityAttribute = tonumber(math.random(2, 5));
		intelligenceAttribute = tonumber(math.random(5, 10));

		print("You chose to be a Wizard. Your randomized stats are: \nStr: " ..
				strengthAttribute .. "\nDex: " .. dexterityAttribute ..
				"\nInt: " .. intelligenceAttribute);
	end

--~ Ask the user if they wish to change their class.
	io.write("Do you wish to change your class/roll again? (y/n): ");
	repeatCheck = io.read();

until (repeatCheck == "n")

--~ Thank the user for using your program.
print("\nThank you for using my game tool!");
