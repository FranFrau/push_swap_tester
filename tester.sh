# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/11 19:52:02 by ffrau             #+#    #+#              #
#    Updated: 2022/06/16 11:27:51 by ffrau            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

IRED="\033[41m"
BLACK="\033[30m"
RED="\033[31m"
LGREEN="\033[32m"
YELLOW="\033[33m"
NC="\033[0m"
CURR_PATH=$(pwd)
PUSH_SWAP="${CURR_PATH}/../push_swap"
CHECKER="${CURR_PATH}/../checker"
CHECKER_MAC="${CURR_PATH}/../checker_Mac"
ERROR_FILE="errors.txt"
OUTPUT_FILE="output.txt"

print_message()
{
	# echo "$1 || $2 || $3 || $4 || $5 || $6 || $7"
	# echo "Num || Counter || totalTests || totalAvarage || nMin || nMax || maxMoves"
	printf "| ${LGREEN}$1${NC}	 | Numbers: You made "
	if [ $1 -le 5 ] && [ ! $2 == $3 ]; then
		printf "${RED}${COUNTER}${LGREEN}/$3${NC}"
	elif [ $1 -le 5 ] && [ $2 == $3 ]; then
		printf "${LGREEN}${COUNTER}/$3${NC}"
	fi
	if [ $1 -gt 5 ] && [ $2 == $3 ]; then
		printf "${LGREEN}${COUNTER}/$3${NC}"
	elif [ $1 -gt 5 ] && [ $2 -gt $((($3 / 4) * 3)) ]; then
		printf "${YELLOW}${COUNTER}${LGREEN}/$3${NC}"
	elif [ $1 -gt 5 ] && [ $2 -le $((($3 / 4) * 3)) ]; then
		printf "${RED}${COUNTER}${LGREEN}/$3${NC}"
	fi
	if [ $1 == 3 ]; then
		printf "     Average of "
	else
		printf " Average of "
	fi
	if [ $(($4 / $3)) -gt $7 ]; then
		printf "${RED}$(($4 / $3))${NC}	|"
	else
		printf "${LGREEN}$(($4 / $3))${NC}	|"
	fi
	if [ $5 -le $7 ]; then
		printf "${LGREEN} $5${NC}	 |"
	else
		printf "${RED} $5${NC}	 |"
	fi
	if [ $6 -le $7 ]; then
		printf "${LGREEN} $6${NC}	   |\n"
	else
		printf "${RED} $6${NC}	   |\n"
	fi
}

three_number(){
	COUNTER=0
	RESULT=0
	AVERAGE=0
	MIN=999999999999
	MAX=-999999999999
	for (( i=0; i<3; i++))
	do
		for (( j=0; j<3; j++))
		do
			for (( k=0; k<3; k++))
			do
				if [[ ! ${i} == ${j} ]] && [[ ! ${i} == ${k} ]] && [[ ! ${k} == ${j} ]]; then
					RESULT=$(${PUSH_SWAP} ${i} ${j} ${k} | wc -l)
					if [ ${RESULT} -le ${MIN} ]; then
						MIN=${RESULT}
					fi
					if [ ${RESULT} -ge ${MAX} ]; then
						MAX=${RESULT}
					fi
					AVERAGE=$((AVERAGE + RESULT))
					if [ $RESULT -le 3 ]; then
						COUNTER=$((COUNTER +1))
					else
						printf "${RED}Error with ${NC}'${PUSH_SWAP} ${i} ${j} ${k}'\n" >> ${ERROR_FILE}
					fi
				fi
			done
		done
	done
	print_message 3 ${COUNTER} 6 ${AVERAGE} ${MIN} ${MAX} 3
}

five_number(){
	COUNTER=0
	RESULT=0
	AVERAGE=0
	MIN=999999999999
	MAX=-999999999999
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
							RESULT=$(${PUSH_SWAP} ${i} ${j} ${k} ${x} ${y} | wc -l)
							if [ ${RESULT} -le ${MIN} ]; then
								MIN=${RESULT}
							fi
							if [ ${RESULT} -ge ${MAX} ]; then
								MAX=${RESULT}
							fi
							AVERAGE=$((AVERAGE + RESULT))
							if [ $RESULT -le  12 ]; then
								COUNTER=$((COUNTER +1))
							else
								printf "${RED}Error with ${NC}'${PUSH_SWAP} ${i} ${j} ${k} ${x} ${y}'\n" >> ${ERROR_FILE}
							fi
						fi
					done
				done
			done
		done
	done
	print_message 5 ${COUNTER} 120 ${AVERAGE} ${MIN} ${MAX} 12
}

one_hundred(){
	COUNTER=0
	AVERAGE=0
	MOVES=$1
	TESTS=$2
	MIN=999999999999
	MAX=-999999999999
	if [ ! $1 ] || [ $1 == "default" ]; then
		MOVES=700
	fi
	if [ ! $2 ]; then
		TESTS=100
	fi
	for (( i=0; i<${TESTS}; i++ ))
	do
		SEQUENCE="$(ruby -e "puts (-50..48).to_a.shuffle.join(' ')")"
		RESULT=$(${PUSH_SWAP} ${SEQUENCE} | wc -l)
		if [ ${RESULT} -le ${MIN} ]; then
			MIN=${RESULT}
		fi
		if [ ${RESULT} -ge ${MAX} ]; then
			MAX=${RESULT}
		fi
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le ${MOVES} ]; then
			COUNTER=$((COUNTER +1))
		else
			echo "'./push_swap ${SEQUENCE}'" >> ${ERROR_FILE}
			printf "Moves: ${RED}${RESULT}${NC}\n" >> ${ERROR_FILE}
		fi
	done
	print_message 100 ${COUNTER} ${TESTS} ${AVERAGE} ${MIN} ${MAX} ${MOVES}
}

five_hundred(){
	COUNTER=0
	AVERAGE=0
	MOVES=$1
	TESTS=$2
	MIN=999999999999
	MAX=-999999999999
	if [ ! $1 ] || [ $1 == "default" ]; then
		MOVES=5500
	fi
	if [ ! $2 ]; then
		TESTS=100
	fi
	for (( i=0; i<${TESTS}; i++ ))
	do
		SEQUENCE="$(ruby -e "puts (-249..250).to_a.shuffle.join(' ')")"
		RESULT=$(${PUSH_SWAP} ${SEQUENCE} | wc -l)
		if [ ${RESULT} -le ${MIN} ]; then
			MIN=${RESULT}
		fi
		if [ ${RESULT} -ge ${MAX} ]; then
			MAX=${RESULT}
		fi
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le ${MOVES} ]; then
			COUNTER=$((COUNTER +1))
		else
			echo "'./push_swap ${SEQUENCE}'" >> ${ERROR_FILE}
			printf "Moves: ${RED}${RESULT}${NC}\n" >> ${ERROR_FILE}
		fi
	done
	print_message 500 ${COUNTER} ${TESTS} ${AVERAGE} ${MIN} ${MAX} ${MOVES}
}

showerrors(){
	if [ -f ./${ERROR_FILE} ]; then
		cat ./${ERROR_FILE}
	else
		printf "${LGREEN}No errors to show${NC}\n"
	fi
}

stresstests()
{
	SHOW_ERROR=0
	CHECKER_USE=0
	OUTPUT_CHECKER=""
	OUTPUT_CHECKER_MAC=""
	if [ -f ${CHECKER} ]; then
		CHECKER_USE=1
	fi

	ARG="2 1 0"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${OUTPUT_CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	fi
	ARG="1 5 2 4 3"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${OUTPUT_CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	fi
	ARG="-1 +5 -2 4 3"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${OUTPUT_CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	fi
	ARG="$(ruby -e "puts (-50..48).to_a.shuffle.join(' ')")"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
		printf "./push_swap ${ARG}\n" >> ${ERROR_FILE}
	fi
	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${IRED}ERROR${NC}${RED}. There are some error with the checkers${NC}\n"
		read -rp "Do you want to continue with the tests? [y/n] " ANSWER
		if [ ${ANSWER} == 'n' ] || [ ${ANSWER} == 'N' ]; then
			exit 0
		fi
	else
		printf "${LGREEN}Checker	test passed successfully ✅${NC}\n"
	fi
}

output_validator()
{
	SHOW_ERROR=0
	OUTPUT=$(${PUSH_SWAP} 42 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 0 1 2 3 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 0 1 2 3 4 5 6 7 8 9 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${IRED}ERROR${NC}${RED}. The student prints something when the subject says not to${NC}\n"
		read -rp "Do you want to continue with the tests? [y/n] " ANSWER
		if [ ${ANSWER} == 'n' ] || [ ${ANSWER} == 'N' ]; then
			exit 0
		fi
	else
		printf "${LGREEN}Output	test passed successfully ✅${NC}\n"
	fi
}

stderr_validator()
{
	SHOW_ERROR=0
	OUTPUT=$(${PUSH_SWAP} a 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 1 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 -2147483649 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 +2147483648 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3 2> /dev/null | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${IRED}ERROR${NC}${RED}. The student does not print the error message on standard error${NC}\n"
		read -rp "Do you want to continue with the tests? [y/n] " ANSWER
		if [ ${ANSWER} == 'n' ] || [ ${ANSWER} == 'N' ]; then
			exit 0
		fi
	else
		printf "${LGREEN}FD	test passed successfully ✅${NC}\n"
	fi
}

makefile_checker()
{
	CHECKERP=1
	RECOMPILE=0
	if [ ! -f ${CURR_PATH}/../Makefile ]; then
		printf "${RED}Error, Makefile not found. I can't compile the program\n${NC}"
		exit 0
	fi
	make re -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	if [ ! -f ${CHECKER_MAC} ]; then
		CHECKERP=0
		curl -o checker_Mac https://projects.intra.42.fr/uploads/document/document/8245/checker_Mac 2> /dev/null
		chmod +x ./checker_Mac
		mv checker_Mac ../
	fi
	make clean -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	if [ ! -f ${PUSH_SWAP} ]; then
		printf "${IRED}ERROR${NC}${RED}. push_swap not found. The 'clean' method also deletes the executable${NC}\n"
		read -rp "Do you want to continue with the tests? [y/n] " ANSWER
		if [ ${ANSWER} == 'n' ] || [ ${ANSWER} == 'N' ]; then
			exit 0
		else
			RECOMPILE=1
		fi
	fi
	if ([ ! -f ${CHECKER} ] && [ ! -f ${CHECKER_MAC} ]) && [ ${CHECKERP} == 1 ]; then
		printf "${IRED}ERROR${NC}${RED}. checker not found. The 'clean' method also deletes the executable${NC}\n"
		read -rp "Do you want to continue with the tests? [y/n] " ANSWER2
		if [ ${ANSWER2} == 'n' ] || [ ${ANSWER2} == 'N' ]; then
			exit 0
		else
			RECOMPILE=1
		fi
	fi
	if [ ${RECOMPILE} == 1 ]; then
		make re -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	fi
	rm -rf ${OUTPUT_FILE}
}

press_any_key(){
	printf "${LGREEN}Press any key to continue${NC}";
	read -rsn1; echo
}

end_test(){
	press_any_key
	make fclean -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	rm -rf ${CHECKER_MAC}
	rm -rf ${OUTPUT_FILE}
	exit
}

list()
{
	printf "${RED}/****************************************/\n"
	printf "${RED}/* ${LGREEN}./tester.sh makefile${RED}			*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh errors			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 3			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 5			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 100 <nmoves> <ntests>	${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 100 default <ntests>	${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 500 <nmoves> <ntests>	${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh 500 default <ntests>	${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh list			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh clear			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh norme			${RED}*/\n"
	printf "${RED}/* ${LGREEN}./tester.sh showerrors		${RED}*/\n"
	printf "${RED}/****************************************/\n${NC}"
}

norme()
{
	NORME=$(norminette ../ | grep Error: | wc -l)
	if [ ! ${NORME} == 0 ]; then
		printf "${IRED}Norme error${NC}\n"
	fi
}

header()
{
	printf "+--------+----------------------------------------------+--------+---------+\n"
	printf "| ${LGREEN}Numbers${NC}|						|${LGREEN} Min    ${NC}| ${LGREEN}Max     ${NC}|\n"
	printf "+--------+----------------------------------------------+--------+---------+\n"
}

footer()
{
	printf "+--------+----------------------------------------------+--------+---------+\n"
	if [ -f ${ERROR_FILE} ]; then
		printf "You can read the errors with ./tester showerrors\n"
	else
		printf "${LGREEN}No errors. Good job!${NC}\n"
	fi
}

single_compile()
{
	if [ ! -f ${CURR_PATH}/../Makefile ]; then
		printf "${RED}Error, Makefile not found. I can't compile the program\n${NC}"
	fi
	make re -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	rm -rf ${OUTPUT_FILE}
}

valid_params()
{
	if [ ! $1 ]; then
		if [ -f ${ERROR_FILE} ]; then
			rm -rf ${ERROR_FILE}
		fi
		makefile_checker
		norme
		stderr_validator
		output_validator
		stresstests
		header
		three_number
		five_number
		one_hundred
		five_hundred
		footer
	else
		case $1 in
			"makefile")
				makefile_checker
				end_test
				;;
			"errors")
				stderr_validator
				output_validator
				end_test
				;;
			'3')
				single_compile
				header
				three_number
				footer
				end_test
				;;
			'5')
				single_compile
				header
				five_number
				footer
				end_test
				;;
			"100")
				single_compile
				header
				one_hundred $2 $3
				footer
				end_test
				;;
			"500")
				single_compile
				header
				five_hundred $2 $3
				footer
				end_test
				;;
			"list")
				list
				exit
				;;
			"clear")
				end_test
				rm -rf ./
				exit
				;;
			"showerrors")
				showerrors
				exit
				;;
			"norme")
				norme
				exit
				;;
		esac
	fi
}
valid_params $1 $2 $3
end_test