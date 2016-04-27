package calculator;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet {
	private static final long serialVersionUID = -5755605526375713199L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, String> respAttributeMap = new HashMap<String, String>();
		
		// Get request parameters
		String display = String.valueOf(req.getParameter("display"));
		String prevOperand = String.valueOf(req.getParameter("prevOperand"));
		String operator = String.valueOf(req.getParameter("operator"));
		String prevOperator = String.valueOf(req.getParameter("prevOperator"));
		boolean touched = Boolean.valueOf(req.getParameter("touched"));
		
		// Default the result to the number in the display
		String operatorResult = display;
		
		if(!prevOperand.isEmpty() && !prevOperator.isEmpty() && (operator.equals("=") || touched)) { // Compute operation
			Double firstVal, secondVal, result;
			firstVal = secondVal = result = 0d;
			
			try {
				if(!touched) {
					firstVal = Double.parseDouble(display);
					secondVal = Double.parseDouble(prevOperand);
				} else {
					firstVal = Double.parseDouble(prevOperand);
					secondVal = Double.parseDouble(display);
				}
			} catch(Exception e) {
				respAttributeMap.put("msg", e.getMessage());
				forwardResult(respAttributeMap, req, resp);
			}

			switch (prevOperator) {
			case "+":
				result = firstVal + secondVal;
				break;
				
			case "-":
				result = firstVal - secondVal;
				break;
				
			case "*":
				result = firstVal * secondVal;
				break;
				
			case "/":
				if(secondVal != 0)
					result = firstVal / secondVal;
				else {
					respAttributeMap.put("msg", "ERROR: Divided by 0");
					forwardResult(respAttributeMap, req, resp);
				}
				break;
				
			default:
				respAttributeMap.put("msg", "Operator not recognized");
				forwardResult(respAttributeMap, req, resp);
				break;
			}
			
			// remove decimal part if useless
			if(result == Math.floor(result))
				operatorResult = String.valueOf((int)Math.floor(result));
			else
				operatorResult = String.valueOf(result);
		}
		
		if(operator.equals("=")) { // keep last operator used
			respAttributeMap.put("prevOperator", prevOperator);
		} else {
			respAttributeMap.put("prevOperator", operator);
		}

		// In the display show last number or result of the operator
		ServletContext context = getServletContext();
		context.setAttribute("display", operatorResult);
//		respAttributeMap.put("display", operatorResult);
		respAttributeMap.put("prevOperand", !touched ? prevOperand : display);
		forwardResult(respAttributeMap, req, resp);
	}

	private void forwardResult(Map<String, String> respAttributeMap, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		for(Entry<String, String> entry : respAttributeMap.entrySet()) {
			req.setAttribute(entry.getKey(), entry.getValue());
		}
    	req.getRequestDispatcher("/").forward(req, resp);
	}
}
