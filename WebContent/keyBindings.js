window.addEventListener('keydown', function(event) {
	switch(event.keyCode) {
		case 48: // 0
		case 96: // numpad 0
			digitPress(0);
		break;
		
		case 49: // 1
		case 97: // numpad 1
			digitPress(1);
		break;
		
		case 50: // 2
		case 98: // numpad 2
			digitPress(2);
		break;
		
		case 51: // 3
		case 99: // numpad 3
			digitPress(3);
		break;
		
		case 52: // 4
		case 100: // numpad 4
			digitPress(4);
		break;
		
		case 53: // 5
		case 101: // numpad 5
			digitPress(5);
		break;
		
		case 54: // 6
		case 102: // numpad 6
			digitPress(6);
		break;
		
		case 55: // 7
		case 103: // numpad 7
			digitPress(7);
		break;
		
		case 56: // 8
		case 104: // numpad 8
			digitPress(8);
		break;
		
		case 57: // 9
		case 105: // numpad 9
			digitPress(9);
		break;
		
		case 190: // .
		case 110: // numpad .
			dotPress();
		break;
		
		case 107: // +
			operatorPress("+");
		break;
		
		case 109: // -
			operatorPress("-");
		break;
		
		case 106: // *
			operatorPress("*");
		break;
		
		case 111: // /
			operatorPress("/");
		break;
		
		case 13: // enter
			submitForm('=');
		break;
		
		case 46: // canc
		case 27: // esc
			resetCalculator();
		break;
	}
})