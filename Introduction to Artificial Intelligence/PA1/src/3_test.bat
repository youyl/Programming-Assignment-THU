@echo off
python pinyin_3.py ../data/case1.in ../data/case1.out
python pinyin_3.py ../data/case2.in ../data/case2.out
python pinyin_3.py ../data/case3.in ../data/case3.out
python pinyin_3.py ../data/case4.in ../data/case4.out
python check.py 1
python check.py 2
python check.py 3
python check.py 4
pause