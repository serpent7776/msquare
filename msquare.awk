BEGIN {
	FS=/\s*/;
	rows = 0;
	cols = 0;
}

{
	if (cols == 0) {
		cols = NF - 1;
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

function createMask() {
	n = rows * cols;
	maxSteps = 2 ^ n;
	for (i = 0; i < n; i++) {
		mask[i] = 0;
	}
	step = 0;
}

function nextStep() {
	i = 0;
	mask[i]++;
	while (mask[i] > 1) {
		mask[i] = 0;
		i++;
		mask[i]++;
	}
	step++;
}

	for (r = 0; r < rows; r++) {
		for (c = 0; c < cols; c++) {
			print square[r, c];
		}
	}
}
