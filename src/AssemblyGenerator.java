import java.util.*;
import java.io.*;

import STO.*;
import Types.*;

public class AssemblyGenerator {
	//output writer
	private FileWriter fileWriter;
	private int indentLevel = 0;
	public static List<String> gVars = new Vector<String>();
	public static List<String> sVars = new Vector<String>();
	public boolean inGlobalScope = true;
	public List<String> tQueue = new Vector<String>();
	public List<String> dQueue = new Vector<String>();
	public int stringLits = 0;
	
	private List<String> executeBuffer = new Vector<String>();
	
	public AssemblyGenerator(String fileName) {
		try {
			fileWriter = new FileWriter(fileName);
		} catch(IOException e) {
			System.out.println("nope.");
			e.printStackTrace();
		}
	}
	
	public void internalConstants(){
		// from slides
		write("! DEFINING INTERNAL CONSTANTS --\n");
		write(assembleString(Strings.section,".section","\".rodata\""));
		write(assembleString(Strings.init, Strings.endl + ":", ".asciz", "\"\\n\""));
		write(assembleString(Strings.init, Strings.intfmt + ":", ".asciz", "\"%d\""));
		write(assembleString(Strings.init, Strings.strfmt + ":", ".asciz", "\"%s\""));
		write(assembleString(Strings.init, Strings.boolt + ":", ".asciz", "\"true\""));
		write(assembleString(Strings.init, Strings.boolf + ":", ".asciz", "\"false\""));
		
		write(assembleString("\n"));
	}
	
	public void beginText(){
		// from slides
		generateASM(Strings.section, ".section", "\".text\"");
		generateASM(Strings.falign, Strings.align, "4");
	}
	
	public void beginData(){
		write("! --globals--\n");
		write(assembleString(Strings.section, ".section", "\".data\""));
		write(assembleString(Strings.falign, Strings.align, "4"));
	}
	
	public void beginBSS(){
		generateASM(Strings.section, ".section", "\".bss\"");
	}
	
	public void doData(STO lhs, STO rhs){
		//since we're in data... either global or static
		if(lhs.isGlobal){
			gVars.add(lhs.offset);
		}else{
			sVars.add(lhs.offset);
		}
		
		String str = "";
		if(rhs.isConst()){
			ConstSTO csto = (ConstSTO)rhs;
			if(lhs.getType().isInt() || lhs.getType().isBool()){
				str = assembleString(Strings.init, lhs.offset + ":", ".word", Integer.toString(csto.getIntValue()));
			}else if(lhs.getType().isFloat()){
				//got this from regi, not sure why though
				str = assembleString(Strings.init, lhs.offset + ":", ".single", "0r" + Float.toString(csto.getFloatValue()));
			}
		}else{
			if(lhs.getType().isFloat()){
				str = assembleString(Strings.init, lhs.offset + ":", ".single", "0r0");
			}else{
				str = assembleString(Strings.init, lhs.offset + ":", ".word", "0");
			}
			//TODO do the store
			//x
			//x .word 0
		}
		dQueue.add(str);
	}
	
	public void doBSS(STO sto){
		generateASM(Strings.section, ".section", "\".bss\"");
		generateASM(Strings.falign, Strings.align);
		generateASM(Strings.init, sto.getName() + ":", ".skip", "4");
		gVars.add(sto.getName());
		generateASM("\n");
	}
	
	public void flushText(){
		for(String t : tQueue){
			//just write the code as is
			write(t);
		}
	}
	
	public void flushData(){
		if(dQueue.size() > 0){
			beginData();
		}else{
			return;
		}
		
		if(gVars.size() > 0){
			String vars = "";
			for(String s : gVars){
				if(vars.length() == 0){
					vars = s;
				}else{
					vars = vars + "," + s;
				}
			}
			
			write(assembleString(Strings.section, ".global", vars));
		}
		
		for(String str : dQueue){
			write(str);
		}
		
		dQueue.clear();
	}
	
	public void doPrintConstInt(String str){
		generateASM(Strings.tab + Strings.two_param, Instructions.set, Strings.intfmt, Registers.o0);
		generateASM(Strings.tab + Strings.two_param, Instructions.set, str, Registers.o1);
		generateASM(Strings.tab + Strings.call_op, Strings.printf);
		generateASM(Strings.tab + Strings.nop);
		generateASM("\n");
	}
	
	public void doPrintConstBool(String str){
		generateASM(Strings.tab + Strings.two_param, Instructions.set, Strings.intfmt, Registers.o0);
		generateASM(Strings.tab + Strings.two_param, Instructions.set, str.equals("true") ? Strings.boolt : Strings.boolf, Registers.o1);
		generateASM(Strings.tab + Strings.call_op, Strings.printf);
		generateASM(Strings.tab + Strings.nop);
		generateASM("\n");
	}
	
	public void doPrintConstFloat(String str){
		//TODO not sure
	}
	
	public void beginFunction(FuncSTO fsto){
		String fname = fsto.getName();
		generateASM(Strings.section, ".section", "\".text\"");
		generateASM(Strings.falign, Strings.align);
		generateASM(Strings.section, ".global ", fname);		
		generateASM(Strings.label, fname);
		generateASM(Strings.tab + Strings.two_param, "set", "SAVE." + fname, "%g1");
		generateASM(Strings.tab + Strings.three_param, "save", "%sp", "%g1", "%sp");
	}
	
	public void endFunction(FuncSTO fsto){
		String fname = fsto.getName();
		generateASM(Strings.tab + Strings.ret, "ret");
		generateASM(Strings.tab + Strings.restore, "restore");
		
		generateASM("SAVE." + fname + " = " + "-(92 + " + fsto.getStackSize() + ") & -8");
		generateASM(Strings.newline);
		//assembleString(Strings.save, fname, String.valueOf(fsto.stackSize); ??
		inGlobalScope = true;
	}
	
	public void doMove(String r1, String r2){
		generateASM(Strings.two_param, Instructions.move, r1, r2);
	}
	
	public void storeConstant(STO sto, ConstSTO csto){
		generateASM(Strings.tab + "! --storing constant " + sto.getName() + " with value " + csto.getValue() + "\n");
		//generateASM(Strings.tab + Strings.two_param, Instructions.set, sto.offset, Registers.l0);
		//generateASM(Strings.tab + Strings.three_param, Instructions.add, sto.base, Registers.l0, Registers.l0);
		if(!sto.getType().isFloat()){
			generateASM(Strings.tab + Strings.two_param, Instructions.set, String.valueOf(csto.getIntValue()), Registers.l1);
			generateASM(Strings.tab + Strings.two_param, Instructions.store, Registers.l1, "[" + Registers.l0 + "]");
		}else{
			generateASM(Strings.tab + Strings.two_param, Instructions.set, csto.offset, Registers.l1);
			generateASM(Strings.tab + Strings.two_param, Instructions.load, "[" + Registers.l1 + "]", Registers.f1);
			generateASM(Strings.tab + Strings.two_param, Instructions.store, Registers.f1, "[" + Registers.l0 + "]");
		}
	}
	
	public void generateASM(String temp, String ... args){
		StringBuilder str = new StringBuilder();		
		str.append(String.format(temp, (Object[])args));
		if(!inGlobalScope){
			tQueue.add(str.toString());
		}else{
			executeBuffer.add(str.toString());
		}
	}
	
	public void generateASM(String s){
		StringBuilder str = new StringBuilder();		
		str.append(s);
		if(!inGlobalScope){
			tQueue.add(str.toString());
		}else{
			executeBuffer.add(str.toString());
		}
	}
	
	public void generateComment(String s) {
		StringBuilder str = new StringBuilder();
		str.append("/* ");
		str.append(s);
		str.append(" */\n");
		if(!inGlobalScope) {
			tQueue.add(str.toString());
		} else {
			executeBuffer.add(str.toString());
		}
	}
	
	public void write(String str){
		try{
			System.out.println(str);
			fileWriter.write(str);
		}
		catch(IOException e){
			System.out.println("Error writing to file");
			e.printStackTrace();
		}
	}
	
	public void end(){
		try{
			if(dQueue.size() > 0){
				flushData();
			}			
			write("\n");
			internalConstants();
			//flush text
			flushText();
			fileWriter.close();
		}catch(IOException e){
			System.out.println("can't close for some reason");
			System.exit(1);
		}
	}
	
	public String assembleString(String temp, String ... args){
		StringBuilder str = new StringBuilder();
		str.append(String.format(temp, (Object[])args));
		return str.toString();
	}
	
	public void increaseIndent(){
		++indentLevel;
	}
	
	public void decreaseIndent(){
		--indentLevel;
	}

	public void localVarInit(STO left, STO right) {
		//checking for automatic int -> float casting
		if(left.getType().isFloat() && right.getType().isInt()) {
			//stuff here
		} else {
			generateComment("setting " + left.getName() + " = " + ((ConstSTO) right).getName());
			generateASM(Strings.tab + Strings.two_param, Instructions.set, left.offset, Registers.l0);
			generateASM(Strings.tab + Strings.three_param, Instructions.add, left.base, Registers.l0, Registers.l0);
			
			if(right.isConst()) {
				if(right.getType().isInt() || right.getType().isBool()) {
					generateASM(Strings.tab + Strings.two_param, Instructions.set, String.valueOf(((ConstSTO) right).getIntValue()), Registers.l1);
					generateASM(Strings.tab + Strings.two_param, Instructions.store, Registers.l1, "[" + Registers.l0 + "]");
				} else if(right.getType().isFloat()) {
					generateComment("setting float");
					generateASM(Strings.tab + Strings.two_param, Instructions.set, left.offset, Registers.l1);
					//l1 f0, l0
					generateASM(Strings.tab + Strings.two_param, Instructions.load, "[" + Registers.l1 + "]", Registers.f0);
					generateASM(Strings.tab + Strings.two_param, Instructions.set, Registers.f0, "[" + Registers.l0 + "]");
					
				}
			}
		}
	}
	
	public String promoteIntToFloat(STO left, STO right) {
		STO tmp = new ExprSTO("promoteCasting", new FloatType());
		tmp.base = Registers.fp;
		tmp.offset = "" + tmp.getType().getSize();
		
		if(right.isConst()) {
			storeVariable(tmp, right);
			loadVariable(Registers.f1, tmp);
		} else {
			loadVariable(Registers.f1, right);
		}
		
		generateASM(Strings.two_param, Instructions.fitos, Registers.f1, Registers.f1);
		
		return Registers.f1;
	}
	
	public void storeVariable(STO dest, STO value) {
		String dest_register = "";
		
		if(value.getType().isFloat()) {
			dest_register += Registers.f1;
		} else {
			dest_register += Registers.l1;
		}
		
		if(value.isConst() && !value.getType().isFloat()) {
			generateASM(Strings.two_param, Instructions.set, "" + ((ConstSTO) value).getIntValue(), dest_register);
		} else {
			generateASM(Strings.two_param, Instructions.set, value.offset, Registers.l0);
			generateASM(Strings.three_param, Instructions.add, value.base, Registers.l0, Registers.l0);
			//???
			generateASM(Strings.two_param, Instructions.load, "[" + Registers.l0 + "]", dest_register);
		}
		
		generateASM(Strings.two_param, Instructions.set, dest.offset, Registers.l0);
		generateASM(Strings.three_param, Instructions.add, dest.base, Registers.l0, Registers.l0);
		generateASM(Strings.two_param, Instructions.load, dest_register, "[" + Registers.l0 + "]");
		
	}

	public void loadVariable(String register, STO sto) {
		if(sto.isConst()) {
			Type type = ((ConstSTO) sto).getType();
			
			if(type.isInt() || type.isBool()) {
				generateASM(Strings.two_param, Instructions.set, "" + ((ConstSTO) sto).getIntValue(), register);
			} else if(type.isFloat()) {
				//i think we can leave it as a getvalue for now.
				generateASM(Strings.two_param, Instructions.set, "" + ((ConstSTO) sto).getValue(), register);
			}
		} else {
			generateASM(Strings.two_param, Instructions.set, sto.offset, Registers.l0);
			generateASM(Strings.three_param, Instructions.add, sto.base, Registers.l0, Registers.l0);
			generateASM(Strings.two_param, Instructions.load, "[" + Registers.l0 + "]", register);
		}
	}

	public void doCoutEndl() {
		// TODO Auto-generated method stub
		generateASM(Strings.tab + Strings.two_param, Instructions.set, Strings.endl, Registers.o0);
		generateASM(Strings.tab + Strings.call_op, Strings.printf);
		generateASM(Strings.tab + Strings.nop);
		generateASM(Strings.newline);
	}
	
	//whoops, assemblestring is already here.
	public String generateString(String fmt, String ... args) {
		StringBuilder str = new StringBuilder();
		str.append(String.format(fmt, (Object[])args));
		return str.toString();
		
	}
	
	public void printString(String s) {
		write(assembleString(Strings.init, "str_" + ++stringLits + ":", ".asciz", "\"" + s + "\""));
		generateASM(Strings.tab + Strings.two_param, Instructions.set, Strings.strfmt, Registers.o0);
		generateASM(Strings.tab + Strings.two_param, Instructions.set, Strings.string + stringLits, Registers.o1);
		generateASM(Strings.tab + Strings.call_op, Strings.printf);
		generateASM(Strings.tab + Strings.nop);
		generateASM(Strings.newline);
	}
}