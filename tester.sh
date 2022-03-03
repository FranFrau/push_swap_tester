three_number(){
	COUNTER=0
	RESULT=0
	AVERAGE=0
	for (( i=0; i<3; i++))
	do
		for (( j=0; j<3; j++))
		do
			for (( k=0; k<3; k++))
			do
				if [[ ! ${i} == ${j} ]] && [[ ! ${i} == ${k} ]] && [[ ! ${k} == ${j} ]]; then
					RESULT=$(./push_swap ${i} ${j} ${k} | wc -l)
					AVERAGE=$((AVERAGE + RESULT))
					if [ $RESULT -le  3 ]; then
						COUNTER=$((COUNTER +1))
					else
						echo "Error with './push_swap ${i} ${j} ${k}'"
					fi
				fi
			done
		done
	done
	echo "3 Numbers: You made ${COUNTER}/6, average of $((AVERAGE / 6))"
}

five_number(){
	COUNTER=0
	RESULT=0
	AVERAGE=0
	for (( i=0; i<5; i++))
	do
		for (( j=0; j<5; j++))
		do
			for (( k=0; k<5; k++))
			do
				for (( x=0; x<5; x++))
				do
					for (( y=0; y<5; y++))
					do
						if [[ ! ${i} == ${j} ]] && [[ ! ${i} == ${k} ]] && [[ ! ${i} == ${x} ]] && [[ ! ${i} == ${y} ]]&& [[ ! ${j} == ${k} ]] && [[ ! ${j} == ${x} ]] && [[ ! ${j} == ${y} ]] && [[ ! ${k} == ${x} ]] && [[ ! ${k} == ${y} ]] && [[ ! ${x} == ${y} ]]; then
							RESULT=$(./push_swap ${i} ${j} ${k} ${x} ${y} | wc -l)
							AVERAGE=$((AVERAGE + RESULT))
							if [ $RESULT -le  12 ]; then
								COUNTER=$((COUNTER +1))
							else
								echo "Error with './push_swap ${i} ${j} ${k} ${x} ${y}'"
							fi
						fi
					done
				done
			done
		done
	done
	echo "5 Numbers: You made ${COUNTER}/120, average of $((AVERAGE / 120))"
}

one_hundred(){
	COUNTER=0
	AVERAGE=0
	for (( i=0; i<100; i++ ))
	do
		SEQUENCE="$(ruby -e "puts (0..99).to_a.shuffle.join(' ')")"
		RESULT=$(./push_swap ${SEQUENCE} | wc -l)
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le 700 ]; then
			COUNTER=$((COUNTER +1))
		else
			echo "Error with './push_swap ${SEQUENCE}'"
		fi
	done
	echo "100 Numbers: You made ${COUNTER}/100, average of $((AVERAGE / 100))"
}

five_hundred(){
	COUNTER=0
	AVERAGE=0
	for (( i=0; i<100; i++ ))
	do
		SEQUENCE="$(ruby -e "puts (0..499).to_a.shuffle.join(' ')")"
		RESULT=$(./push_swap ${SEQUENCE} | wc -l)
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le 5500 ]; then
			COUNTER=$((COUNTER +1))
		else
			echo "Error with './push_swap ${SEQUENCE}'"
		fi
	done
	echo "500 Numbers: You made ${COUNTER}/100, average of $((AVERAGE / 100))"
}

make re Makefile
make clean Makefile
three_number
five_number
one_hundred
five_hundred