-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "06/04/2020 23:44:01"

-- 
-- Device: Altera EPM240T100C5 Package TQFP100
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY IEEE;
LIBRARY MAXII;
USE IEEE.STD_LOGIC_1164.ALL;
USE MAXII.MAXII_COMPONENTS.ALL;

ENTITY 	sqrtmachine IS
    PORT (
	clk : IN std_logic;
	rst : IN std_logic;
	input : IN std_logic_vector(7 DOWNTO 0);
	output : OUT std_logic_vector(3 DOWNTO 0)
	);
END sqrtmachine;

-- Design Ports Information
-- clk	=>  Location: PIN_12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[7]	=>  Location: PIN_8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[6]	=>  Location: PIN_7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[5]	=>  Location: PIN_6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[4]	=>  Location: PIN_5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[3]	=>  Location: PIN_4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[2]	=>  Location: PIN_3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[0]	=>  Location: PIN_1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- input[1]	=>  Location: PIN_2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- rst	=>  Location: PIN_44,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- output[0]	=>  Location: PIN_17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- output[1]	=>  Location: PIN_18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- output[2]	=>  Location: PIN_19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
-- output[3]	=>  Location: PIN_20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA


ARCHITECTURE structure OF sqrtmachine IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst : std_logic;
SIGNAL ww_input : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_output : std_logic_vector(3 DOWNTO 0);
SIGNAL \sqr0|Add0~20\ : std_logic;
SIGNAL \clk~combout\ : std_logic;
SIGNAL \rst~combout\ : std_logic;
SIGNAL \Selector5~0\ : std_logic;
SIGNAL \cur.p1~regout\ : std_logic;
SIGNAL \cur.p40~regout\ : std_logic;
SIGNAL \Selector1~0\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \sqr0|tmp3[5]~0_combout\ : std_logic;
SIGNAL \sqr0|tmp1[3]~0_combout\ : std_logic;
SIGNAL \sqr0|tmp2[3]~1_combout\ : std_logic;
SIGNAL \sqr0|tmp1[2]~1_combout\ : std_logic;
SIGNAL \sqr0|tmp2[1]~2_combout\ : std_logic;
SIGNAL \sqr0|Add0~22_cout0\ : std_logic;
SIGNAL \sqr0|Add0~22COUT1_31\ : std_logic;
SIGNAL \sqr0|Add0~2\ : std_logic;
SIGNAL \sqr0|Add0~2COUT1_33\ : std_logic;
SIGNAL \sqr0|Add0~17\ : std_logic;
SIGNAL \sqr0|Add0~17COUT1_35\ : std_logic;
SIGNAL \sqr0|Add0~12\ : std_logic;
SIGNAL \sqr0|Add0~12COUT1_37\ : std_logic;
SIGNAL \sqr0|Add0~5_combout\ : std_logic;
SIGNAL \sqr0|Add0~10_combout\ : std_logic;
SIGNAL \sqr0|Add0~15_combout\ : std_logic;
SIGNAL \sqr0|Add0~0_combout\ : std_logic;
SIGNAL \sqr0|Add1~2\ : std_logic;
SIGNAL \sqr0|Add1~2COUT1_31\ : std_logic;
SIGNAL \sqr0|Add1~22\ : std_logic;
SIGNAL \sqr0|Add1~22COUT1_33\ : std_logic;
SIGNAL \sqr0|Add1~17\ : std_logic;
SIGNAL \sqr0|Add1~17COUT1_35\ : std_logic;
SIGNAL \sqr0|Add1~12\ : std_logic;
SIGNAL \sqr0|Add1~12COUT1_37\ : std_logic;
SIGNAL \sqr0|Add1~5_combout\ : std_logic;
SIGNAL \sqr0|Add1~10_combout\ : std_logic;
SIGNAL \sqr0|tmp2[4]~0_combout\ : std_logic;
SIGNAL \sqr0|Add1~15_combout\ : std_logic;
SIGNAL \sqr0|Add1~20_combout\ : std_logic;
SIGNAL \sqr0|output[3]~22\ : std_logic;
SIGNAL \sqr0|output[3]~22COUT1_31\ : std_logic;
SIGNAL \sqr0|output[4]~17\ : std_logic;
SIGNAL \sqr0|output[4]~17COUT1_33\ : std_logic;
SIGNAL \sqr0|output[5]~12\ : std_logic;
SIGNAL \sqr0|output[5]~12COUT1_35\ : std_logic;
SIGNAL \sqr0|output[6]~7\ : std_logic;
SIGNAL \sqr0|output[6]~7COUT1_37\ : std_logic;
SIGNAL \sqr0|output[7]~0_combout\ : std_logic;
SIGNAL \sqr0|output[6]~5_combout\ : std_logic;
SIGNAL \sqr0|output[5]~10_combout\ : std_logic;
SIGNAL \sqr0|output[4]~15_combout\ : std_logic;
SIGNAL \sqr0|output[3]~20_combout\ : std_logic;
SIGNAL \cpr0|sig~2_combout\ : std_logic;
SIGNAL \sqr0|Add1~0_combout\ : std_logic;
SIGNAL \cpr0|sig~3_combout\ : std_logic;
SIGNAL \cpr0|sig~4_combout\ : std_logic;
SIGNAL \cpr0|sig~8_combout\ : std_logic;
SIGNAL \cpr0|sig~5_combout\ : std_logic;
SIGNAL \cpr0|sig~6_combout\ : std_logic;
SIGNAL \cpr0|sig~7_combout\ : std_logic;
SIGNAL \cur.p41~regout\ : std_logic;
SIGNAL \cur.p30~regout\ : std_logic;
SIGNAL \cur.p31~regout\ : std_logic;
SIGNAL \Selector2~0\ : std_logic;
SIGNAL \cur.p20~regout\ : std_logic;
SIGNAL \cur.p21~regout\ : std_logic;
SIGNAL \cur.p10~regout\ : std_logic;
SIGNAL \cur.p11~regout\ : std_logic;
SIGNAL \cur.p0~regout\ : std_logic;
SIGNAL \Selector3~0\ : std_logic;
SIGNAL \output[0]~reg0_regout\ : std_logic;
SIGNAL \output[1]~reg0_regout\ : std_logic;
SIGNAL \output[2]~reg0_regout\ : std_logic;
SIGNAL \output[3]~reg0_regout\ : std_logic;
SIGNAL tmp : std_logic_vector(3 DOWNTO 0);
SIGNAL \input~combout\ : std_logic_vector(7 DOWNTO 0);

BEGIN

ww_clk <= clk;
ww_rst <= rst;
ww_input <= input;
output <= ww_output;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: PIN_12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\clk~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_clk,
	combout => \clk~combout\);

-- Location: PIN_44,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\rst~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_rst,
	combout => \rst~combout\);

-- Location: LC_X3_Y2_N2
\cur.p1\ : maxii_lcell
-- Equation(s):
-- \Selector5~0\ = (((!\cur.p0~regout\ & \rst~combout\)))
-- \cur.p1~regout\ = DFFEAS(\Selector5~0\, GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0f00",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => \cur.p0~regout\,
	datad => \rst~combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector5~0\,
	regout => \cur.p1~regout\);

-- Location: LC_X3_Y2_N8
\cur.p40\ : maxii_lcell
-- Equation(s):
-- \cur.p40~regout\ = DFFEAS((((\cur.p1~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datad => \cur.p1~regout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p40~regout\);

-- Location: LC_X3_Y2_N5
\cur.p41\ : maxii_lcell
-- Equation(s):
-- \Selector1~0\ = (\cur.p0~regout\ & (((cur.p41 & !tmp(2))))) # (!\cur.p0~regout\ & (\rst~combout\ & ((tmp(2)))))
-- \cur.p41~regout\ = DFFEAS(\Selector1~0\, GLOBAL(\clk~combout\), VCC, , , \cur.p40~regout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "22c0",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \rst~combout\,
	datab => \cur.p0~regout\,
	datac => \cur.p40~regout\,
	datad => tmp(2),
	aclr => GND,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector1~0\,
	regout => \cur.p41~regout\);

-- Location: LC_X3_Y2_N0
\Selector0~0\ : maxii_lcell
-- Equation(s):
-- \Selector0~0_combout\ = (tmp(3) & (\rst~combout\ & (!\cur.p0~regout\))) # (!tmp(3) & (((\cur.p0~regout\ & \cur.p1~regout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "5808",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => tmp(3),
	datab => \rst~combout\,
	datac => \cur.p0~regout\,
	datad => \cur.p1~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector0~0_combout\);

-- Location: LC_X3_Y3_N7
\tmp[3]\ : maxii_lcell
-- Equation(s):
-- tmp(3) = DFFEAS((\Selector0~0_combout\ & (!\cur.p40~regout\ & (!tmp(3)))) # (!\Selector0~0_combout\ & (tmp(3) & ((!\cpr0|sig~7_combout\) # (!\cur.p40~regout\)))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1252",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \Selector0~0_combout\,
	datab => \cur.p40~regout\,
	datac => tmp(3),
	datad => \cpr0|sig~7_combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => tmp(3));

-- Location: LC_X4_Y2_N2
\sqr0|tmp3[5]~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp3[5]~0_combout\ = (((tmp(2) & tmp(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(2),
	datad => tmp(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp3[5]~0_combout\);

-- Location: LC_X2_Y3_N8
\sqr0|tmp1[3]~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp1[3]~0_combout\ = (((tmp(0) & tmp(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(0),
	datad => tmp(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp1[3]~0_combout\);

-- Location: LC_X4_Y3_N9
\sqr0|tmp2[3]~1\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp2[3]~1_combout\ = (((tmp(1) & tmp(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(1),
	datad => tmp(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp2[3]~1_combout\);

-- Location: LC_X3_Y3_N9
\sqr0|tmp1[2]~1\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp1[2]~1_combout\ = (((tmp(0) & tmp(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(0),
	datad => tmp(2),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp1[2]~1_combout\);

-- Location: LC_X3_Y3_N8
\sqr0|tmp2[1]~2\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp2[1]~2_combout\ = (((tmp(0) & tmp(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(0),
	datad => tmp(1),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp2[1]~2_combout\);

-- Location: LC_X3_Y3_N0
\sqr0|Add0~22\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add0~22_cout0\ = CARRY((\sqr0|tmp2[1]~2_combout\))
-- \sqr0|Add0~22COUT1_31\ = CARRY((\sqr0|tmp2[1]~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ffaa",
	operation_mode => "arithmetic",
	output_mode => "none",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp2[1]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add0~20\,
	cout0 => \sqr0|Add0~22_cout0\,
	cout1 => \sqr0|Add0~22COUT1_31\);

-- Location: LC_X3_Y3_N1
\sqr0|Add0~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add0~0_combout\ = tmp(1) $ (\sqr0|tmp1[2]~1_combout\ $ ((\sqr0|Add0~22_cout0\)))
-- \sqr0|Add0~2\ = CARRY((tmp(1) & (!\sqr0|tmp1[2]~1_combout\ & !\sqr0|Add0~22_cout0\)) # (!tmp(1) & ((!\sqr0|Add0~22_cout0\) # (!\sqr0|tmp1[2]~1_combout\))))
-- \sqr0|Add0~2COUT1_33\ = CARRY((tmp(1) & (!\sqr0|tmp1[2]~1_combout\ & !\sqr0|Add0~22COUT1_31\)) # (!tmp(1) & ((!\sqr0|Add0~22COUT1_31\) # (!\sqr0|tmp1[2]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => tmp(1),
	datab => \sqr0|tmp1[2]~1_combout\,
	cin0 => \sqr0|Add0~22_cout0\,
	cin1 => \sqr0|Add0~22COUT1_31\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add0~0_combout\,
	cout0 => \sqr0|Add0~2\,
	cout1 => \sqr0|Add0~2COUT1_33\);

-- Location: LC_X3_Y3_N2
\sqr0|Add0~15\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add0~15_combout\ = \sqr0|tmp1[3]~0_combout\ $ (\sqr0|tmp2[3]~1_combout\ $ ((!\sqr0|Add0~2\)))
-- \sqr0|Add0~17\ = CARRY((\sqr0|tmp1[3]~0_combout\ & ((\sqr0|tmp2[3]~1_combout\) # (!\sqr0|Add0~2\))) # (!\sqr0|tmp1[3]~0_combout\ & (\sqr0|tmp2[3]~1_combout\ & !\sqr0|Add0~2\)))
-- \sqr0|Add0~17COUT1_35\ = CARRY((\sqr0|tmp1[3]~0_combout\ & ((\sqr0|tmp2[3]~1_combout\) # (!\sqr0|Add0~2COUT1_33\))) # (!\sqr0|tmp1[3]~0_combout\ & (\sqr0|tmp2[3]~1_combout\ & !\sqr0|Add0~2COUT1_33\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp1[3]~0_combout\,
	datab => \sqr0|tmp2[3]~1_combout\,
	cin0 => \sqr0|Add0~2\,
	cin1 => \sqr0|Add0~2COUT1_33\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add0~15_combout\,
	cout0 => \sqr0|Add0~17\,
	cout1 => \sqr0|Add0~17COUT1_35\);

-- Location: LC_X3_Y3_N3
\sqr0|Add0~10\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add0~10_combout\ = \sqr0|Add0~17\ $ (((tmp(1) & (tmp(3)))))
-- \sqr0|Add0~12\ = CARRY(((!\sqr0|Add0~17\) # (!tmp(3))) # (!tmp(1)))
-- \sqr0|Add0~12COUT1_37\ = CARRY(((!\sqr0|Add0~17COUT1_35\) # (!tmp(3))) # (!tmp(1)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "787f",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => tmp(1),
	datab => tmp(3),
	cin0 => \sqr0|Add0~17\,
	cin1 => \sqr0|Add0~17COUT1_35\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add0~10_combout\,
	cout0 => \sqr0|Add0~12\,
	cout1 => \sqr0|Add0~12COUT1_37\);

-- Location: LC_X3_Y3_N4
\sqr0|Add0~5\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add0~5_combout\ = (((!\sqr0|Add0~12\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "0f0f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	cin0 => \sqr0|Add0~12\,
	cin1 => \sqr0|Add0~12COUT1_37\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add0~5_combout\);

-- Location: LC_X5_Y3_N5
\sqr0|Add1~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add1~0_combout\ = \sqr0|tmp1[2]~1_combout\ $ ((\sqr0|Add0~0_combout\))
-- \sqr0|Add1~2\ = CARRY((\sqr0|tmp1[2]~1_combout\ & (\sqr0|Add0~0_combout\)))
-- \sqr0|Add1~2COUT1_31\ = CARRY((\sqr0|tmp1[2]~1_combout\ & (\sqr0|Add0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "6688",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp1[2]~1_combout\,
	datab => \sqr0|Add0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add1~0_combout\,
	cout0 => \sqr0|Add1~2\,
	cout1 => \sqr0|Add1~2COUT1_31\);

-- Location: LC_X5_Y3_N6
\sqr0|Add1~20\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add1~20_combout\ = \sqr0|tmp2[3]~1_combout\ $ (\sqr0|Add0~15_combout\ $ ((\sqr0|Add1~2\)))
-- \sqr0|Add1~22\ = CARRY((\sqr0|tmp2[3]~1_combout\ & (!\sqr0|Add0~15_combout\ & !\sqr0|Add1~2\)) # (!\sqr0|tmp2[3]~1_combout\ & ((!\sqr0|Add1~2\) # (!\sqr0|Add0~15_combout\))))
-- \sqr0|Add1~22COUT1_33\ = CARRY((\sqr0|tmp2[3]~1_combout\ & (!\sqr0|Add0~15_combout\ & !\sqr0|Add1~2COUT1_31\)) # (!\sqr0|tmp2[3]~1_combout\ & ((!\sqr0|Add1~2COUT1_31\) # (!\sqr0|Add0~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp2[3]~1_combout\,
	datab => \sqr0|Add0~15_combout\,
	cin0 => \sqr0|Add1~2\,
	cin1 => \sqr0|Add1~2COUT1_31\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add1~20_combout\,
	cout0 => \sqr0|Add1~22\,
	cout1 => \sqr0|Add1~22COUT1_33\);

-- Location: LC_X5_Y3_N7
\sqr0|Add1~15\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add1~15_combout\ = tmp(2) $ (\sqr0|Add0~10_combout\ $ ((!\sqr0|Add1~22\)))
-- \sqr0|Add1~17\ = CARRY((tmp(2) & ((\sqr0|Add0~10_combout\) # (!\sqr0|Add1~22\))) # (!tmp(2) & (\sqr0|Add0~10_combout\ & !\sqr0|Add1~22\)))
-- \sqr0|Add1~17COUT1_35\ = CARRY((tmp(2) & ((\sqr0|Add0~10_combout\) # (!\sqr0|Add1~22COUT1_33\))) # (!tmp(2) & (\sqr0|Add0~10_combout\ & !\sqr0|Add1~22COUT1_33\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => tmp(2),
	datab => \sqr0|Add0~10_combout\,
	cin0 => \sqr0|Add1~22\,
	cin1 => \sqr0|Add1~22COUT1_33\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add1~15_combout\,
	cout0 => \sqr0|Add1~17\,
	cout1 => \sqr0|Add1~17COUT1_35\);

-- Location: LC_X5_Y3_N8
\sqr0|Add1~10\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add1~10_combout\ = \sqr0|tmp3[5]~0_combout\ $ (\sqr0|Add0~5_combout\ $ ((\sqr0|Add1~17\)))
-- \sqr0|Add1~12\ = CARRY((\sqr0|tmp3[5]~0_combout\ & (!\sqr0|Add0~5_combout\ & !\sqr0|Add1~17\)) # (!\sqr0|tmp3[5]~0_combout\ & ((!\sqr0|Add1~17\) # (!\sqr0|Add0~5_combout\))))
-- \sqr0|Add1~12COUT1_37\ = CARRY((\sqr0|tmp3[5]~0_combout\ & (!\sqr0|Add0~5_combout\ & !\sqr0|Add1~17COUT1_35\)) # (!\sqr0|tmp3[5]~0_combout\ & ((!\sqr0|Add1~17COUT1_35\) # (!\sqr0|Add0~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp3[5]~0_combout\,
	datab => \sqr0|Add0~5_combout\,
	cin0 => \sqr0|Add1~17\,
	cin1 => \sqr0|Add1~17COUT1_35\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add1~10_combout\,
	cout0 => \sqr0|Add1~12\,
	cout1 => \sqr0|Add1~12COUT1_37\);

-- Location: LC_X5_Y3_N9
\sqr0|Add1~5\ : maxii_lcell
-- Equation(s):
-- \sqr0|Add1~5_combout\ = (((!\sqr0|Add1~12\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "0f0f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	cin0 => \sqr0|Add1~12\,
	cin1 => \sqr0|Add1~12COUT1_37\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|Add1~5_combout\);

-- Location: LC_X4_Y2_N5
\sqr0|tmp2[4]~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|tmp2[4]~0_combout\ = (((tmp(1) & tmp(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f000",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datac => tmp(1),
	datad => tmp(3),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|tmp2[4]~0_combout\);

-- Location: LC_X5_Y3_N0
\sqr0|output[3]~20\ : maxii_lcell
-- Equation(s):
-- \sqr0|output[3]~20_combout\ = \sqr0|Add1~20_combout\ $ ((\sqr0|tmp1[3]~0_combout\))
-- \sqr0|output[3]~22\ = CARRY((\sqr0|Add1~20_combout\ & (\sqr0|tmp1[3]~0_combout\)))
-- \sqr0|output[3]~22COUT1_31\ = CARRY((\sqr0|Add1~20_combout\ & (\sqr0|tmp1[3]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "6688",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|Add1~20_combout\,
	datab => \sqr0|tmp1[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|output[3]~20_combout\,
	cout0 => \sqr0|output[3]~22\,
	cout1 => \sqr0|output[3]~22COUT1_31\);

-- Location: LC_X5_Y3_N1
\sqr0|output[4]~15\ : maxii_lcell
-- Equation(s):
-- \sqr0|output[4]~15_combout\ = \sqr0|tmp2[4]~0_combout\ $ (\sqr0|Add1~15_combout\ $ ((\sqr0|output[3]~22\)))
-- \sqr0|output[4]~17\ = CARRY((\sqr0|tmp2[4]~0_combout\ & (!\sqr0|Add1~15_combout\ & !\sqr0|output[3]~22\)) # (!\sqr0|tmp2[4]~0_combout\ & ((!\sqr0|output[3]~22\) # (!\sqr0|Add1~15_combout\))))
-- \sqr0|output[4]~17COUT1_33\ = CARRY((\sqr0|tmp2[4]~0_combout\ & (!\sqr0|Add1~15_combout\ & !\sqr0|output[3]~22COUT1_31\)) # (!\sqr0|tmp2[4]~0_combout\ & ((!\sqr0|output[3]~22COUT1_31\) # (!\sqr0|Add1~15_combout\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|tmp2[4]~0_combout\,
	datab => \sqr0|Add1~15_combout\,
	cin0 => \sqr0|output[3]~22\,
	cin1 => \sqr0|output[3]~22COUT1_31\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|output[4]~15_combout\,
	cout0 => \sqr0|output[4]~17\,
	cout1 => \sqr0|output[4]~17COUT1_33\);

-- Location: LC_X5_Y3_N2
\sqr0|output[5]~10\ : maxii_lcell
-- Equation(s):
-- \sqr0|output[5]~10_combout\ = \sqr0|Add1~10_combout\ $ (\sqr0|tmp3[5]~0_combout\ $ ((!\sqr0|output[4]~17\)))
-- \sqr0|output[5]~12\ = CARRY((\sqr0|Add1~10_combout\ & ((\sqr0|tmp3[5]~0_combout\) # (!\sqr0|output[4]~17\))) # (!\sqr0|Add1~10_combout\ & (\sqr0|tmp3[5]~0_combout\ & !\sqr0|output[4]~17\)))
-- \sqr0|output[5]~12COUT1_35\ = CARRY((\sqr0|Add1~10_combout\ & ((\sqr0|tmp3[5]~0_combout\) # (!\sqr0|output[4]~17COUT1_33\))) # (!\sqr0|Add1~10_combout\ & (\sqr0|tmp3[5]~0_combout\ & !\sqr0|output[4]~17COUT1_33\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "698e",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|Add1~10_combout\,
	datab => \sqr0|tmp3[5]~0_combout\,
	cin0 => \sqr0|output[4]~17\,
	cin1 => \sqr0|output[4]~17COUT1_33\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|output[5]~10_combout\,
	cout0 => \sqr0|output[5]~12\,
	cout1 => \sqr0|output[5]~12COUT1_35\);

-- Location: LC_X5_Y3_N3
\sqr0|output[6]~5\ : maxii_lcell
-- Equation(s):
-- \sqr0|output[6]~5_combout\ = tmp(3) $ (\sqr0|Add1~5_combout\ $ ((\sqr0|output[5]~12\)))
-- \sqr0|output[6]~7\ = CARRY((tmp(3) & (!\sqr0|Add1~5_combout\ & !\sqr0|output[5]~12\)) # (!tmp(3) & ((!\sqr0|output[5]~12\) # (!\sqr0|Add1~5_combout\))))
-- \sqr0|output[6]~7COUT1_37\ = CARRY((tmp(3) & (!\sqr0|Add1~5_combout\ & !\sqr0|output[5]~12COUT1_35\)) # (!tmp(3) & ((!\sqr0|output[5]~12COUT1_35\) # (!\sqr0|Add1~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "9617",
	operation_mode => "arithmetic",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => tmp(3),
	datab => \sqr0|Add1~5_combout\,
	cin0 => \sqr0|output[5]~12\,
	cin1 => \sqr0|output[5]~12COUT1_35\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|output[6]~5_combout\,
	cout0 => \sqr0|output[6]~7\,
	cout1 => \sqr0|output[6]~7COUT1_37\);

-- Location: LC_X5_Y3_N4
\sqr0|output[7]~0\ : maxii_lcell
-- Equation(s):
-- \sqr0|output[7]~0_combout\ = (((!\sqr0|output[6]~7\)))

-- pragma translate_off
GENERIC MAP (
	cin0_used => "true",
	cin1_used => "true",
	lut_mask => "0f0f",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "cin",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	cin0 => \sqr0|output[6]~7\,
	cin1 => \sqr0|output[6]~7COUT1_37\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \sqr0|output[7]~0_combout\);

-- Location: PIN_8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[7]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(7),
	combout => \input~combout\(7));

-- Location: PIN_7,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[6]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(6),
	combout => \input~combout\(6));

-- Location: PIN_6,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[5]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(5),
	combout => \input~combout\(5));

-- Location: PIN_5,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[4]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(4),
	combout => \input~combout\(4));

-- Location: PIN_4,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[3]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(3),
	combout => \input~combout\(3));

-- Location: PIN_2,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[1]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(1),
	combout => \input~combout\(1));

-- Location: PIN_1,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[0]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(0),
	combout => \input~combout\(0));

-- Location: LC_X2_Y3_N5
\cpr0|sig~2\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~2_combout\ = ((!\input~combout\(1) & (!\input~combout\(0) & tmp(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0300",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \input~combout\(1),
	datac => \input~combout\(0),
	datad => tmp(0),
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~2_combout\);

-- Location: PIN_3,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
\input[2]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "input")
-- pragma translate_on
PORT MAP (
	oe => GND,
	padio => ww_input(2),
	combout => \input~combout\(2));

-- Location: LC_X4_Y3_N0
\cpr0|sig~3\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~3_combout\ = (\cpr0|sig~2_combout\ & (((\sqr0|Add1~0_combout\) # (!\input~combout\(2))))) # (!\cpr0|sig~2_combout\ & (((!\input~combout\(2) & \sqr0|Add1~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "af0a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \cpr0|sig~2_combout\,
	datac => \input~combout\(2),
	datad => \sqr0|Add1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~3_combout\);

-- Location: LC_X4_Y3_N1
\cpr0|sig~4\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~4_combout\ = ((\input~combout\(3) & (\sqr0|output[3]~20_combout\ & \cpr0|sig~3_combout\)) # (!\input~combout\(3) & ((\sqr0|output[3]~20_combout\) # (\cpr0|sig~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f330",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \input~combout\(3),
	datac => \sqr0|output[3]~20_combout\,
	datad => \cpr0|sig~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~4_combout\);

-- Location: LC_X4_Y3_N2
\cpr0|sig~8\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~8_combout\ = (\sqr0|output[4]~15_combout\ & (((\cpr0|sig~4_combout\) # (!\input~combout\(4))))) # (!\sqr0|output[4]~15_combout\ & (((!\input~combout\(4) & \cpr0|sig~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "af0a",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \sqr0|output[4]~15_combout\,
	datac => \input~combout\(4),
	datad => \cpr0|sig~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~8_combout\);

-- Location: LC_X4_Y3_N3
\cpr0|sig~5\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~5_combout\ = ((\input~combout\(5) & (\sqr0|output[5]~10_combout\ & \cpr0|sig~8_combout\)) # (!\input~combout\(5) & ((\sqr0|output[5]~10_combout\) # (\cpr0|sig~8_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f330",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \input~combout\(5),
	datac => \sqr0|output[5]~10_combout\,
	datad => \cpr0|sig~8_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~5_combout\);

-- Location: LC_X4_Y3_N4
\cpr0|sig~6\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~6_combout\ = (\input~combout\(6) & (((\sqr0|output[6]~5_combout\ & \cpr0|sig~5_combout\)))) # (!\input~combout\(6) & (((\sqr0|output[6]~5_combout\) # (\cpr0|sig~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "f550",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	dataa => \input~combout\(6),
	datac => \sqr0|output[6]~5_combout\,
	datad => \cpr0|sig~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~6_combout\);

-- Location: LC_X4_Y3_N5
\cpr0|sig~7\ : maxii_lcell
-- Equation(s):
-- \cpr0|sig~7_combout\ = ((\sqr0|output[7]~0_combout\ & ((\cpr0|sig~6_combout\) # (!\input~combout\(7)))) # (!\sqr0|output[7]~0_combout\ & (!\input~combout\(7) & \cpr0|sig~6_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "cf0c",
	operation_mode => "normal",
	output_mode => "comb_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	datab => \sqr0|output[7]~0_combout\,
	datac => \input~combout\(7),
	datad => \cpr0|sig~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \cpr0|sig~7_combout\);

-- Location: LC_X4_Y3_N8
\tmp[2]\ : maxii_lcell
-- Equation(s):
-- tmp(2) = DFFEAS((\Selector1~0\ & (!\cur.p30~regout\ & ((!tmp(2))))) # (!\Selector1~0\ & (tmp(2) & ((!\cpr0|sig~7_combout\) # (!\cur.p30~regout\)))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1522",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \Selector1~0\,
	datab => \cur.p30~regout\,
	datac => \cpr0|sig~7_combout\,
	datad => tmp(2),
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => tmp(2));

-- Location: LC_X2_Y3_N9
\cur.p30\ : maxii_lcell
-- Equation(s):
-- \cur.p30~regout\ = DFFEAS((((\cur.p41~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datad => \cur.p41~regout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p30~regout\);

-- Location: LC_X2_Y3_N6
\cur.p31\ : maxii_lcell
-- Equation(s):
-- \cur.p31~regout\ = DFFEAS((((\cur.p30~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datad => \cur.p30~regout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p31~regout\);

-- Location: LC_X4_Y3_N6
\cur.p20\ : maxii_lcell
-- Equation(s):
-- \Selector2~0\ = (tmp(1) & (!\Selector5~0\ & ((!\cpr0|sig~7_combout\) # (!cur.p20))))
-- \cur.p20~regout\ = DFFEAS(\Selector2~0\, GLOBAL(\clk~combout\), VCC, , , \cur.p31~regout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0222",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => tmp(1),
	datab => \Selector5~0\,
	datac => \cur.p31~regout\,
	datad => \cpr0|sig~7_combout\,
	aclr => GND,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector2~0\,
	regout => \cur.p20~regout\);

-- Location: LC_X4_Y3_N7
\tmp[1]\ : maxii_lcell
-- Equation(s):
-- tmp(1) = DFFEAS((\Selector2~0\) # ((\cur.p31~regout\ & (\cur.p0~regout\ & !\cur.p20~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff08",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \cur.p31~regout\,
	datab => \cur.p0~regout\,
	datac => \cur.p20~regout\,
	datad => \Selector2~0\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => tmp(1));

-- Location: LC_X2_Y3_N4
\cur.p21\ : maxii_lcell
-- Equation(s):
-- \cur.p21~regout\ = DFFEAS(GND, GLOBAL(\clk~combout\), VCC, , , \cur.p20~regout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => \cur.p20~regout\,
	aclr => GND,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p21~regout\);

-- Location: LC_X3_Y3_N5
\cur.p10\ : maxii_lcell
-- Equation(s):
-- \Selector3~0\ = (tmp(0) & (!\Selector5~0\ & ((!\cpr0|sig~7_combout\) # (!cur.p10))))
-- \cur.p10~regout\ = DFFEAS(\Selector3~0\, GLOBAL(\clk~combout\), VCC, , , \cur.p21~regout\, , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0222",
	operation_mode => "normal",
	output_mode => "reg_and_comb",
	register_cascade_mode => "off",
	sum_lutc_input => "qfbk",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => tmp(0),
	datab => \Selector5~0\,
	datac => \cur.p21~regout\,
	datad => \cpr0|sig~7_combout\,
	aclr => GND,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	combout => \Selector3~0\,
	regout => \cur.p10~regout\);

-- Location: LC_X3_Y2_N4
\cur.p11\ : maxii_lcell
-- Equation(s):
-- \cur.p11~regout\ = DFFEAS(((\cur.p10~regout\) # ((\cur.p11~regout\ & \rst~combout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "faf0",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \cur.p11~regout\,
	datac => \cur.p10~regout\,
	datad => \rst~combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p11~regout\);

-- Location: LC_X3_Y2_N7
\cur.p0\ : maxii_lcell
-- Equation(s):
-- \cur.p0~regout\ = DFFEAS(((\rst~combout\) # ((!\cur.p11~regout\ & \cur.p0~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff50",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \cur.p11~regout\,
	datac => \cur.p0~regout\,
	datad => \rst~combout\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \cur.p0~regout\);

-- Location: LC_X3_Y3_N6
\tmp[0]\ : maxii_lcell
-- Equation(s):
-- tmp(0) = DFFEAS((\Selector3~0\) # ((\cur.p0~regout\ & (\cur.p21~regout\ & !\cur.p10~regout\))), GLOBAL(\clk~combout\), VCC, , , , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff08",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	dataa => \cur.p0~regout\,
	datab => \cur.p21~regout\,
	datac => \cur.p10~regout\,
	datad => \Selector3~0\,
	aclr => GND,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => tmp(0));

-- Location: LC_X3_Y2_N1
\output[0]~reg0\ : maxii_lcell
-- Equation(s):
-- \output[0]~reg0_regout\ = DFFEAS(GND, GLOBAL(\clk~combout\), VCC, , \cur.p11~regout\, tmp(0), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => tmp(0),
	aclr => GND,
	sload => VCC,
	ena => \cur.p11~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output[0]~reg0_regout\);

-- Location: LC_X3_Y2_N6
\output[1]~reg0\ : maxii_lcell
-- Equation(s):
-- \output[1]~reg0_regout\ = DFFEAS(GND, GLOBAL(\clk~combout\), VCC, , \cur.p11~regout\, tmp(1), , , VCC)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "on")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datac => tmp(1),
	aclr => GND,
	sload => VCC,
	ena => \cur.p11~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output[1]~reg0_regout\);

-- Location: LC_X3_Y2_N9
\output[2]~reg0\ : maxii_lcell
-- Equation(s):
-- \output[2]~reg0_regout\ = DFFEAS((((tmp(2)))), GLOBAL(\clk~combout\), VCC, , \cur.p11~regout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datad => tmp(2),
	aclr => GND,
	ena => \cur.p11~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output[2]~reg0_regout\);

-- Location: LC_X3_Y2_N3
\output[3]~reg0\ : maxii_lcell
-- Equation(s):
-- \output[3]~reg0_regout\ = DFFEAS((((tmp(3)))), GLOBAL(\clk~combout\), VCC, , \cur.p11~regout\, , , , )

-- pragma translate_off
GENERIC MAP (
	lut_mask => "ff00",
	operation_mode => "normal",
	output_mode => "reg_only",
	register_cascade_mode => "off",
	sum_lutc_input => "datac",
	synch_mode => "off")
-- pragma translate_on
PORT MAP (
	clk => \clk~combout\,
	datad => tmp(3),
	aclr => GND,
	ena => \cur.p11~regout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	regout => \output[3]~reg0_regout\);

-- Location: PIN_17,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[0]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[0]~reg0_regout\,
	oe => VCC,
	padio => ww_output(0));

-- Location: PIN_18,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[1]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[1]~reg0_regout\,
	oe => VCC,
	padio => ww_output(1));

-- Location: PIN_19,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[2]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[2]~reg0_regout\,
	oe => VCC,
	padio => ww_output(2));

-- Location: PIN_20,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 16mA
\output[3]~I\ : maxii_io
-- pragma translate_off
GENERIC MAP (
	operation_mode => "output")
-- pragma translate_on
PORT MAP (
	datain => \output[3]~reg0_regout\,
	oe => VCC,
	padio => ww_output(3));
END structure;


