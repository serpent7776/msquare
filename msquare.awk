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
		rowSums[rows] = $0 + 0;
		for (i = 2; i <= NF; i++) {
			col = i - 2;
			square[rows, col] = $i + 0;
		}
		rows++;
	}
}

function calcRowSum(sq, row) {
	sum = 0;
	for (i = 0; i < cols; i++) {
		sum += sq[row, i];
	}
	return sum;
}

function calcColSum(sq, col) {
	sum = 0;
	for (i = 0; i < rows; i++) {
		sum += sq[i, col];
	}
	return sum;
}

function checkSquare(sq) {
	for (r = 0; r < rows; r++) {
		if (calcRowSum(sq, r) != rowSums[r]) {
			return 0;
		}
	}
	for (c = 0; c < cols; c++) {
		if (calcColSum(sq, c) != colSums[c]) {
			return 0;
		}
	}
	return 1;
}

END {
	for (r = 0; r < rows; r++) {
		for (c = 0; c < cols; c++) {
			print square[r, c];
		}
	}
}
