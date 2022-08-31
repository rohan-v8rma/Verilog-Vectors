# Table of Contents

- [Table of Contents](#table-of-contents)
- [What is Verilog?](#what-is-verilog)
- [FPGA (Field Programmable Gate Array)](#fpga-field-programmable-gate-array)
- [Synthesizable vs. Non-Synthesizable code](#synthesizable-vs-non-synthesizable-code)
- [Best Practices](#best-practices)
  - [Verilog Naming Convention](#verilog-naming-convention)
- [Compiling and Simulating a file in Modelsim](#compiling-and-simulating-a-file-in-modelsim)
- [Lexical Tokens](#lexical-tokens)
  - [White Space](#white-space)
  - [Comments](#comments)
  - [Numbers](#numbers)
    - [Integer Number](#integer-number)
  - [Identifiers](#identifiers)
  - [Operators](#operators)
    - [Bit-wise Operators](#bit-wise-operators)
    - [Logical Operators](#logical-operators)
  - [Operands](#operands)
    - [`reg`](#reg)
    - [`wire`](#wire)
- [Vectors & Scalars](#vectors--scalars)
- [Verilog Module](#verilog-module)
  - [Top-level Modules](#top-level-modules)
  - [`design` Top-Level](#design-top-level)
  - [`testbench` Top-Level](#testbench-top-level)
- [Verilog Ports](#verilog-ports)
  - [Port Declaration](#port-declaration)
  - [`wire` and `reg`](#wire-and-reg)
- [Block Statements](#block-statements)
  - [Sequential Block-Statements](#sequential-block-statements)
  - [Parallel Block Statements](#parallel-block-statements)
  - [Naming of Blocks](#naming-of-blocks)
- [Assignments in Verilog](#assignments-in-verilog)
  - [Continuous Assigns (`assign` statements)](#continuous-assigns-assign-statements)
  - [Procedural Assignments](#procedural-assignments)
  - [Driving values in verilog](#driving-values-in-verilog)
- [Verilog Compiler Directives](#verilog-compiler-directives)
  - [1. `timescale](#1-timescale)
    - [Checking the Default Timescale (`$printtimescale`)](#checking-the-default-timescale-printtimescale)
  - [2. `include](#2-include)
- [Verilog System Tasks](#verilog-system-tasks)
- [Verilog Timing Control](#verilog-timing-control)
  - [Delay control](#delay-control)
  - [Rise and Fall](#rise-and-fall)
- [`initial` and `always` Statements](#initial-and-always-statements)
  - [Syntax for using `initial` statement](#syntax-for-using-initial-statement)
    - [Multiple `initial` statements in a program](#multiple-initial-statements-in-a-program)
- [Types of Modeling](#types-of-modeling)
  - [Dataflow Modelling](#dataflow-modelling)
  - [Gate-Level Modelling](#gate-level-modelling)
  - [Behavorial Modelling](#behavorial-modelling)
- [TODO](#todo)

# What is Verilog?

Verilog is a Hardware Description Language (HDL). 

It is a language used for describing a digital system such as a network switch, a microprocessor, a memory, or a flip-flop. 

We can describe any digital hardware by using HDL at any level. 

Designs described in HDL are independent of technology, very easy for designing and debugging, and are normally more useful than schematics, particularly for large circuits.

# FPGA (Field Programmable Gate Array)

TODO

# Synthesizable vs. Non-Synthesizable code

When you write you Verilog or VHDL code, you are writing code that will be translated into gates, registers, RAMs, etc. 

The program that performs this task is known as a **Synthesis Tool**. It is the job of the **Synthesis Tool** to take your Verilog or VHDL code and turn it into something that the FPGA can understand. 

However, there are some parts of Verilog and VHDL that the FPGA simply cannot implement. When you write code like this, it is called non-synthesizable code.

So why would you have a language that contains code that is non-synthesizable? 

The reason is that it makes your testbenches more powerful. When you write a testbench for simulation, often using non-synthesizable code constructs makes your testbench better and allows you to accomplish things easier.

# Best Practices

Only one `module` should be defined per verilog file. 

## Verilog Naming Convention

| Construct                                                             | Style                          |
| --------------------------------------------------------------------- | ------------------------------ |
| Declarations (module, class, package, interface)                      | `lower_snake_case`             |
| Instance names                                                        | `lower_snake_case`             |
| Signals (nets and ports)                                              | `lower_snake_case`             |
| Variables, functions, tasks                                           | `lower_snake_case`             |
| Named code blocks                                                     | `lower_snake_case`             |
| **\`define** macros                                                   | `ALL_CAPS`                     |
| Tunable parameters for parameterized modules, classes, and interfaces | `UpperCamelCase`               |
| Constants                                                             | `ALL_CAPS` or `UpperCamelCase` |
| Enumeration types                                                     | `lower_snake_case_e`           |
| Other typedef types                                                   | `lower_snake_case_t`           |
| Enumerated value names                                                | `UpperCamelCase`               |

# Compiling and Simulating a file in Modelsim

1. Open modelsim 
2. `Create Project` (keep project name in PascalCase)
3. `Create New File` (Change file type from default `VHDL` to `Verilog`, and keep the library as default - `work`)
4. File is created
5. Right click on the file name and click on `Edit`
6. After writing the code, right click on the file again, and click on `Compile Selected`
7. `Status` symbol next to file name changes from a question mark to tick to indicate that compilation was successful. Successful message also shown in Transcript panel
8. Next, in order to convert the source code into a model, we have to simulate the compiled **module**.
9. Go to the `Library` panel, into the `work` library, right-click on the module and selecte `Simulate`.
10. The Layout of ModelSim changes from `No Design` to `Simulate`.
11. a. Select the `Instance` of the module from the `sim` tab, then drag the `Objects` i.e., the quantities you wish to see in the `Waves` panel
    b. Or right click on a particular quantity in Object panel and select `Add Waves` 
12. We can `Force` quantities to be a certain value in the `Waves` panel by right-clicking on them.
13. Press `F9` to run the simulation behaviour

# Lexical Tokens

A lexical token is a sequence of characters that can be treated as a unit in the grammar of the programming languages.

Lexical conventions in Verilog are similar to the C programming language. Verilog language source text files are a stream of lexical tokens.

A lexical token may consist of one or more characters, and every single character is in exactly one token.

The tokens can be keywords, comments, numbers, white space, or strings. 

All lines should be terminated by a semi-colon (`;`).

## White Space

White space can contain the characters for tabs, blanks, newlines, and form feeds. These characters are ignored except when they serve to separate other tokens. However, blanks and tabs are significant in strings.

## Comments

Like in C-language

## Numbers 

We can specify constant numbers in binary, decimal, hexadecimal, or octal format. 

Negative numbers are represented in 2's complement form. 

The question mark (`?`) character is the Verilog alternative for the z character when used in a number. 

The underscore character (`_`) is legal anywhere in a number, but it is ignored as the first character.

### Integer Number

Verilog HDL allows integer numbers to be specified as:

- Sized or unsized numbers (Unsized size is 32 bits).
- In a radix of decimal (`d`), hexadecimal (`h`), binary (`b`) or octal (`o`).
- Radix and hex digits (a,b,c,d) are case INSENSITIVE. Spaces are allowed between the radix, size, and value.


The syntax is given as:

```verilog
<size>'<radix><value>  

// Examples
1'b0
32'd10
10'h f1
```
## Identifiers

The identifier is the name used to define the object, such as a function, module, or register. 

- Identifiers must begin with an alphabetic character or the underscore character (`a-z`, `A-Z`, `_`).
- Identifiers may contain alphabetic characters, numeric characters, the underscore, and the dollar sign (`a-z`, `A-Z`, `0-9`, `_`, `$`).

- Identifiers can be up to 1024 characters long.

## Operators

### Bit-wise Operators

Bit-wise operators do a bit-by-bit comparison between two operands. 

The operators included in Bit-wise operation are:
- `&` : (Bit-wise AND)
- `|` : (Bit-wise OR)
- `~` : (Bit-wise NOT)
- `^` : (Bit-wise XOR)
- `~^` or `^~` : (Bit-wise XNOR)

### Logical Operators

Logical operators are used only for single-bit operands. They return a single bit value, 0 or 1. They can work on integers or groups of bits, expressions and treat all non-zero values as 1.

Logical operators are generally used in conditional statements since they work with expressions. 

The operators included in Logical operation are:

- `!`  : (logical NOT)
- `&&` : (logical AND)
- `||` : (logical OR)

## Operands

Operands are expressions or values on which an operator operates or works. All expressions have at least one operand.

### `reg`

Identifiers declared as `reg` are manipulated within procedural blocks ([`always` and `initial`](#initial-and-always-statements)) only.

Registers represent data storage elements. 

Registers retain value until another value is placed onto them. 

In Verilog, the term register merely means a variable that can hold a value.

### `wire`

TODO

# Vectors & Scalars

By default, a Verilog [`reg`](#wire-and-reg) or [`wire`](#wire-and-reg) is 1 bit wide. This is a scalar:

```verilog
wire  x;  // 1 bit wire
reg   y;  // also 1 bit
logic z;  // me too!
```
A scalar can only hold 0 or 1.

We need a vector to hold values other than 0 and 1.

A vector is declared like this: 

```verilog
type [upper:lower] name;

wire   [5:0] a;  // 6-bit wire
reg    [7:0] b;  // 8-bit reg
logic [11:0] c;  // 12-bit logic
```

- `wire` **a** handles 0-63 inclusive : 6 bits from $2^0$ to $2^5$ ($2^6$ is 64).
- `register` **b** handles 0-255 inclusive : 8 bits from $2^0$ to $2^7$ ($2^8$ is 256).
- `logic` **c** handles 0-4095 inclusive : 12 bits from $2^0$ to $2^{11}$ ($2^{12}$ is 4096).

You need to ensure your vector is large enough to handle the full range of values your design requires. 

Synthesis tools are good at discarding unused bits, so it’s better to err on the side of too large rather than too small.

![](README-images/scalar-vector.png)

# Verilog Module

A module is a block of Verilog code that implements certain functionality. 

Modules can be embedded/instantiated within other modules, and a higher level module can communicate with its lower-level modules using their `input` and `output` [ports](#verilog-ports).

A module should be enclosed within a `module` and `endmodule` keywords. 

The name of the module should be given right after the `module` keyword, and an optional list of ports may be declared as well.

```verilog
module <name> ([port_list]);  
        // Contents of the module  

endmodule  

// A module can have an empty portlist  
  
module name;  
        // Contents of the module  
  
endmodule  

```

## Top-level Modules

A top-level module is one that contains  all other modules. Although module definitions can't contain other module definitions, but modules can be instantiated within other module definitions.

A top-level module is not INSTANTIATED within any other module.

For example, `design` modules are usually instantiated within top-level `testbench` modules so that simulation can be run by providing input stimulus.

But, the `testbench` is not instantiated within any other module because it is a block that encapsulates everything else.

## `design` Top-Level

The Design top-level module contains all other sub-modules required to make the design complete.

## `testbench` Top-Level

The `testbench` module contains a stimulus to check the functionality of the `design` and primarily used for functional verification by using simulation tools.

Hence the `design` is instantiated and called `<name>` inside the `testbench` module. 

The `testbench` is the top-level module from a simulator perspective.

# Verilog Ports

Port is an essential component of the Verilog module. 

Ports are used by a module to communicate with the external world through `input` and `output`.

## Port Declaration

Every port in the port list must be declared as `input`, `output` or `inout`, based on the port signal's direction.

Every port in the port list must be declared as `input`, `output` or `inout`. 

## `wire` and `reg`

In Verilog, all port declarations are implicitly declared as `wire`. If a port is intended to be a `wire`, it is sufficient to declare it as `output`, `input`, or `inout`.

`input` and `inout` ports are generally declared as wires. 

However, if output ports hold their value, they must be declared as `reg`.

# Block Statements

There are ways to group a set of statements together that are syntactically equivalent to a single statement and are known as Block Statements.

There are two types of block statements:
- Sequential
- Parallel

## Sequential Block-Statements

In Sequential Block-Statements, a set of statements are wrapped using `begin` and `end` keywords and will be executed sequentially in the given order, one after the other. 


After all the statements within the block are executed, control may be passed elsewhere. 

Delay values are treated relative to the time of execution of the previous statement. 

![](README-images/initial-begin-end-verilog.png)

 In this example, the first statement in the `begin`-`end` block will be executed at `10` time units, and the second statement at `30` time units because of the relative nature. 
 
 It is `20` time units after execution of the previous statement.

## Parallel Block Statements
 
A Parallel Block-Statement can execute statements concurrently and delay control can be used to provide time-ordering of the assignments. 

Statements are launched in parallel by wrapping them within the `fork` and `join` keywords.

Delay values are treated as absolute from the start of the Parallel Block. 

![](README-images/fork-join-verilog.png)

 In this example, the `fork`-`join` block will be launched after executing the statement at `10` time units.
 
 Statements within this block will be executed in parallel and the first statement that will be launched will be the one where data is assigned a value of `8'h00` since the delay for that is `10` time units after the launch of the fork-join. 
 
 After `10` MORE time units, the first statement will be launched and data will get the value `8'h11`.

## Naming of Blocks

Both [Sequential](#sequential-block-statements) and [Parallel](#parallel-block-statements) blocks can be named by adding `name_of_block` after the `begin` and `fork` keywords. 

```verilog
begin: name_seq  
    [statements]  
end  
fork: name_fork  
    [statements]  
join  
```

By doing this, the block can be referenced in a `disable` statement.

# Assignments in Verilog

## Continuous Assigns (`assign` statements)

A module may have any number of continuous `assign` statements. 

Continuous `assign` statements are used to [drive](#driving-values-in-verilog) values on to `wire`s, and are evaluated and updated whenever an input operand changes value. For example:

```verilog
assign a = b & c;
```

This is referred to as a continuous assign because the `wire` on the left-hand side of the assignment operator is continuously driven with the value of the expression on the right-hand side. 

The target of the assign statement must be a [`wire`](#wire). 

The continuous assign statement is not a procedural statement and so must be used at the module level; it cannot be placed in an [`initial` or `always`](#initial-and-always-statements) process.

You can add delay to a continuous assign statement as follows:

```verilog
assign #10 a = b & c;
```

In this case, the value of `a` changes 10 units of time after the expression `b & c` changes. 

## Procedural Assignments

Procedural assignments update the value of register variables under the control of the procedural flow constructs that surround them.

## Driving values in verilog

A driver is a concurrent process that determines the value of a signal.

# Verilog Compiler Directives

## 1. `timescale

Verilog simulation depends on how time is defined because the simulator needs to know what a `#1` means in terms of time.

The **`timescale** pre-processor directive specifies the time unit and precision for the modules that follow it.

This is the syntax for it:
```verilog
`timescale <time_unit>/<time_precision>  
// for example  
`timescale 1ns/1ps  
`timescale 10us/100ns  
`timescale 10ns/1ns  
```

- The `time_unit` is the measurement of delays and simulation time. 
- The `time_precision` specifies how delay values are rounded before being used in the simulation.

### Checking the Default Timescale (`$printtimescale`)

Although Verilog modules are expected to have a timescale defined before the module, simulators may insert a DEFAULT timescale.

The actual timescale that gets applied at any scope in a Verilog elaborated hierarchy can be printed using the system task `$printtimescale`, which accepts the scope as an argument.

```verilog
module tb;  
    initial begin  
        // Print timescale of this module  
        $printtimescale(tb);  
    end  
endmodule  
```

## 2. `include

Other files can be included in the current file using an **`include** pre-processor directive makes the compiler place contents of the included file before compilation.

This is equivalent to simply pasting the entire contents of the other file in this main file.

TODO

# Verilog System Tasks

- `$display`: displays values of variables, string, or expressions
  ```verilog
  $display(ep1, ep2, …, epn);
  ```
  ep1, ep2, …, epn: quoted strings, variables, expressions.
- `$monitor`: monitors a signal when its value changes.
  ```verilog
  $monitor(ep1, ep2, …, epn);
  ```
- `$monitoton`: enables monitoring operation.
- `$monitotoff`: disables monitoring operation.
- `$stop`: suspends the simulation.
- `$finish`: terminates the simulation.

# Verilog Timing Control

Timing control statements are required in simulation to advance time. 

The time at which procedural statements will get executed shall be specified using timing controls.


## Delay control

The delay control is a way of adding a delay between when the simulator encounters the statement and when it executes.

Delay control is achieved by specifying the waiting time to execution when the statement is encountered. 

The symbol `#` is used to specify the delay.

```verilog
#10 $display("Hello World");
```
The `#10` command advances time by 10 units. So, Hello World is displayed after 10 units of time.

## Rise and Fall

TODO

# `initial` and `always` Statements

Two basic structured procedure statements or procedural blocks are `always` ([synthesizable](#synthesizable-vs-non-synthesizable-code)) and `initial` ([non-synthesizable](#synthesizable-vs-non-synthesizable-code)).

General common information about these blocks:

- All behavioral statements can appear only inside these blocks
- Each `always` or `initial` block has a separate activity flow (concurrency)
- There can be multiple `always` and `initial` blocks in a module
- All procedural blocks start from simulation time 0
- Cannot be nested

`initial` and `always` statements describe independent processes (blocks of code), meaning that the statements in one process execute autonomously. 

Both types of processes consist of procedural statements and both start immediately as the simulator is started. 

The difference between the two is that `initial` processes execute once, whereas `always` process execute repeatedly forever. 

As such, an `always` process must contain timing statements that will occasionally block execution and allow time to advance (time in `initial` and `always` process only advances when they are blocked). 

Thus, activity in these process progresses in a burst during which time does not advance, and then the activity blocks, which allows time to move forward.

## Syntax for using `initial` statement

```verilog
initial  
    [single statement]  
  
initial begin  
    [multiple statements]  
  
end  
```

### Multiple `initial` statements in a program

There are no limits to the number of initial blocks that can be defined inside a module. 

![](README-images/multiple-initial-statements.png)

The code shown below has three initial blocks, all of which are STARTED AT THE SAME TIME and run in parallel.

However, depending on the statements and the delays within each initial block, the time taken to finish the block may vary.

# Types of Modeling

## Dataflow Modelling

Dataflow modeling makes use of the **FUNCTIONS** that define the working of the circuit instead of its gate structure ([gate-level modelling](#gate-level-modelling)).

Dataflow modeling uses several [**OPERATORS**](#operators) that act on [operands](#operands) to produce the desired results. Verilog provides about 30 operator types.

Dataflow modeling describes hardware in terms of the flow of data from input to output.

The dataflow modeling style is mainly used to describe combinational circuits. 

The primary mechanism used is a [continuous assignment](#continuous-assigns-assign-statements).

For example:

```verilog
module half_adder(x,y,sum,carry);
  input x,y;
  output sum, carry;
  assign carry = x&y;
  assign sum = x^y;
endmodule
```

## Gate-Level Modelling

Modules implemented in terms of built-in logic gate functions like (`and`, `or`, `xor`, etc) and interconnnect these.

For example:

```verilog
module gatemodelone(a, b, c, out);
  input a, b, c;
  output out;  
  
  wire wire_1, wire_2, wire_3;

  and(wire_1, a, b);
  
  and(wire_2, ~b, c);
  
  or(out, wire_2, wire_1);

endmodule
```

## Behavorial Modelling

Behavioral models in Verilog contain procedural statements, which control the simulation and manipulate variables of the data types. 

All these statements are contained within the procedures. Each of the procedure has an activity flow associated with it.

During simulation of BEHAVIORAL model, all the flows defined by the [`always` and `initial`](#initial-and-always-statements) statements start together at simulation time ‘zero’. 

The `initial` statements are executed once, and the `always` statements are executed repetitively.

For example: 

```verilog
reg x, y; 

initial begin
  #20    x = 1'b0 ; y = 1'b0;
  #20    x = 1'b0 ; y = 1'b1;
  #20    x = 1'b1 ; y = 1'b0;
  #20    x = 1'b1 ; y = 1'b1;
end
```

# TODO

- Learn about wire and reg in detail
