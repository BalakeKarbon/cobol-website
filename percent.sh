#!/bin/bash
cob_size=$(find src/ -type f \( -name "*.cob" -o -name "*.cpy" \) -exec stat -c%s {} + | awk '{s+=$1} END {print s}')
src_size=$(find src/ -type f -exec stat -c%s {} + | awk '{s+=$1} END {print s}')
html_size=$(stat -c%s index.html 2>/dev/null || echo 0)
total_size=$(( src_size + html_size ))
percent=$(echo "scale=2; if ($total_size > 0) 100 * $cob_size / $total_size else 0" | bc)
#echo "COBOL size: $cob_size"
#echo "SRC size: $src_size"
#echo "HTML size: $html_size"
#echo "Total size: $total_size"
echo "$percent" | tee res/percent.txt
