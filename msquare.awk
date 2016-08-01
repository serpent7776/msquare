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

function calcRowSum(sq, row,  i, sum) {
	sum = 0;
	for (i = 0; i < cols; i++) {
		sum += sq[row, i];
	}
	return sum;
}

function calcColSum(sq, col,  i, sum) {
	sum = 0;
	for (i = 0; i < rows; i++) {
		sum += sq[i, col];
	}
	return sum;
}

function checkSquare(sq,  r, c) {
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

function createMask(  n, i) {
	n = rows * cols;
	maxSteps = 2 ^ n;
	for (i = 0; i < n; i++) {
		mask[i] = 0;
	}
	step = 0;
}

function nextStep(  i) {
	i = 0;
	mask[i]++;
	while (mask[i] > 1) {
		mask[i] = 0;
		i++;
		mask[i]++;
	}
	step++;
}

function prepareSquare(  r, c, i) {
	for (r = 0; r < rows; r++) {
		for (c = 0; c < cols; c++) {
			i = r * cols + c;
			if (mask[i] == 1) {
				sq[r, c] = square[r, c];
			} else {
				sq[r, c] = 0;
			}
		}
	}
}

function printResult(s) {
	printf "#"
	for (c = 0; c < cols; c++) {
		printf " %d", colSums[c];
	}
	print "";
	for (r = 0; r < rows; r++) {
		printf "%d ", rowSums[r];
		for (c = 0; c < cols; c++) {
			printf "%d ", s[r, c];
		}
		print "";
	}
}

function bruteforce(  done) {
	createMask();
	done = 0;
	while (step < maxSteps && !done) {
		nextStep();
		prepareSquare();
		done = checkSquare(sq);
	}
	return done;
}

END {
	done = bruteforce();
	printResult(sq);
	print done ? "done" : "invalid";
}
