var touched = false;

function manageDisplay() {
	if(!touched) {
		display = document.getElementById('display');
		touched = true;
		document.getElementById('prevOperand').value = display.value;
		if (display.value != "-") display.value = "";
		document.getElementById('touched').value = true;
	}
}

function dotPress() {
	manageDisplay();
	display = document.getElementById('display');
	
	// Look for another dot inside the display
	// Add dot only if it's missing
	if(display.value.indexOf(".") == -1) {
		if(display.value.length == 0)
			display.value = "0.";
		else
			display.value = display.value.concat(".");
	}
}

function digitPress(value) {
	manageDisplay();
	display = document.getElementById('display');
	
	// If number different from 0 on display then concatenate digit
	// Change with single digit otherwise
	if(display.value == "0")
		display.value = value;
	else
		display.value = display.value.concat(value);
}

function operatorPress(operator) {
	display = document.getElementById('display');
	
	// DON'T TOUCH
	// VERY COMPLICATED INNESTED IFs to change/display signs!!!
	if (display.value == "" || display.value == "+") {
		if (operator == "-")
			display.value = "-";
	} else if (display.value == "" || display.value == "-") {
		if (operator == "+")
			display.value = "";
	} else {
		// Send form data
		document.getElementById("operator").value = operator;
		submitForm(operator);
	}
}

function submitForm(operator) {
	document.getElementById("operator").value = operator;
	document.getElementById("calculatorForm").submit();
}

function resetCalculator() {
	var inputs = document.querySelectorAll("#calculatorForm input");
	for (var i = 0; i < inputs.length; i += 1)
	    inputs[i].value = "";
	
	var prevOperatorLabel = document.getElementById("prevOperatorLabel");
	prevOperatorLabel.parentNode.removeChild(prevOperatorLabel);
}

// not used, but available if needed. Not sure if it works though... :D
function invertSign() {
	display = document.getElementById('display');
	
	if(display.value.charAt(0) == "-")
		display.value = display.value.substr(1);
	else
		display.value = "-".concat(display.value);
}