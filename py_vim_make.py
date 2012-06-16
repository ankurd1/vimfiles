#!/usr/bin/python

import py_compile
import sys
import tempfile
import os
import re
from subprocess import call

tmp_file = tempfile.NamedTemporaryFile(mode='w',delete=False)
tmp_file_name = tmp_file.name

sys.stderr = tmp_file

py_compile.compile(sys.argv[1])

tmp_file.close()

tmp_file = open(tmp_file_name, 'r')

text = tmp_file.readline()
tmp_file.close()
#os.unlink(tmp_file_name)

if (len(text)==0):
    call(["python", sys.argv[1]])
else:
    err_regex = re.compile(r"(.*: )\('(.*)', \('(.*)', (\d+), (\d+), .*\)\)")
    out_list = list(err_regex.match(text).groups())
    out_list2 = [out_list[0] + out_list[1]]
    out_list2.extend(out_list[2:])
    out = "|".join(out_list2)

    print out
