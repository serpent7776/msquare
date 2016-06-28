BEGIN {
	FS=/\s*/;
	rows = 0;
	cols = 0;
}

{
	if (cols == 0) {
		cols = NF;
		# if ($1 != "#") {
			# print "die";
			# exit;
		# }
		for (i = 2; i <= NF; i++) {
			colSums[i - 2] = $i + 0;
		}
	} else {
		rowSums[rows] = $0;
		for (i = 2; i <= NF; i++) {
			col = i - 2;
			square[rows, col] = $i;
		}
		rows++;
	}
}

function calcRowSum(row) {
	sum = 0;
	for (i = 0; i < cols; i++) {
		sum += square[row, i];
	}
	return sum;
}

function calcColSum(col) {
	sum = 0;
	for (i = 0; i < rows; i++) {
		sum += square[i, col];
	}
	return sum;
}

END {
	for (r = 0; r < rows; r++) {
		for (c = 0; c < cols; c++) {
			print square[r, c];
		}
	}
}
