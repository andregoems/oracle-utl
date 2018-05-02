
/*   Warning(275,91): PLW-07204: conversion away from column type may result in sub-optimal query plan

This appears to be a bug, with no fix or real workaround. If you have access to My Oracle Support, look up doc ID 445136.1.

This forum thread (https://community.oracle.com/thread/1115765 ) suggests a workaround:

Run this block before CREATING or REPLACING your packages, functions, or procedures that exhibit this issue:*/


BEGIN
DBMS_WARNING.SET_WARNING_SETTING_STRING('ENABLE:ALL', 'SESSION');
DBMS_WARNING.ADD_WARNING_SETTING_NUM(warning_number => 7202, warning_value => 'DISABLE', scope => 'SESSION');
DBMS_WARNING.ADD_WARNING_SETTING_NUM(warning_number => 7204, warning_value => 'DISABLE', scope => 'SESSION');
END;