# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42roma.it>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/11 19:52:02 by ffrau             #+#    #+#              #
#    Updated: 2022/06/25 01:16:54 by ffrau            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

IRED="\033[41m"
BLACK="\033[30m"
RED="\033[31m"
LGREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
NC="\033[0m"
CURR_PATH=$(pwd)
PUSH_SWAP="${CURR_PATH}/../push_swap"
CHECKER="${CURR_PATH}/../checker"
CHECKER_INTRA="${CURR_PATH}/../checker_intra"
ERROR_FILE="errors.txt"
FD_ERROR_FILE="fd_errors.txt"
OUTPUT_FILE="output.txt"
OUT_FILE=".out"
AVERAGE_ONEH=0
AVERAGE_FIVEH=0

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
		printf "	Average of "
	else
		printf "	Average of "
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
							if [ $RESULT -le 12 ]; then
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

number_test(){
	# nb || tests || mv
	COUNTER=0
	AVERAGE=0
	NUMBER=$1
	TESTS=$2
	MOVES=$3
	TMIN=$(((${NUMBER} / 2) * -1))
	TMAX=$(((${NUMBER} / 2) - 2))
	MIN=999999999999
	MAX=-999999999999
	if [ ! $1 ] ; then
		MOVES=1000
	fi
	if [ ! $2 ]; then
		TESTS=100
	fi
	for (( i=0; i<${TESTS}; i++ ))
	do
		SEQUENCE="$(ruby -e "puts (${TMIN}..${TMAX}).to_a.shuffle.join(' ')")"
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
	if [ ${NUMBER} == 100 ] && [ ${COUNTER} -ge $(((${TESTS} / 4) * 3)) ]; then
		AVERAGE_ONEH=$((${AVERAGE} / ${TESTS}))
	elif [ ${NUMBER} == 500 ] && [ ${COUNTER} -ge $(((${TESTS} / 4) * 3)) ]; then
		AVERAGE_FIVEH=$((${AVERAGE} / ${TESTS}))
	elif [ ${NUMBER} == 100 ]; then
		AVERAGE_ONEH=${MAX}
	elif [ ${NUMBER} == 500 ]; then
		AVERAGE_FIVEH=${MAX}
	fi
	print_message ${NUMBER} ${COUNTER} ${TESTS} ${AVERAGE} ${MIN} ${MAX} ${MOVES}
}

showerrors(){
	if [ -f ./${ERROR_FILE} ]; then
		cat ./${ERROR_FILE}
	else
		printf "${LGREEN}No errors to show${NC}\n"
	fi
}

checker_test()
{
	# echo "$1 || $2"
	# echo "ARG || CHECKER_USE"
	if [ $2 == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} $1 2> ${FD_ERROR_FILE} | ${CHECKER} $1 2> ${FD_ERROR_FILE})
	fi
	OUTPUT_CHECKER_INTRA=$(${PUSH_SWAP} $1 2> ${FD_ERROR_FILE} | ${CHECKER_INTRA} $1)
	if [ $2 == 0 ] && [ ${OUTPUT_CHECKER_INTRA} == "KO" ]; then
		printf "${RED}Checker	test. Error with $1 ❌${NC}\n"
		printf "./push_swap $1\n" >> ${ERROR_FILE}
		return 1
	elif [ $2 == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_INTRA} ]; then
		printf "${RED}Checker	test. Intra checker and your checker output are differents. Error with $1 ❌${NC}\n"
		printf "./push_swap $1\n" >> ${ERROR_FILE}
		return 1
	fi
	return 0
}

stresstests()
{
	SHOW_ERROR=0
	CHECKER_USE=0
	OUTPUT_CHECKER=""
	OUTPUT_CHECKER_INTRA=""
	if [ -f ${CHECKER} ]; then
		CHECKER_USE=1
	fi

	checker_test "2 1 0" ${CHECKER_USE}
	RES=$?
	if [ ${SHOW_ERROR} == 0 ] && [ ! ${RES} == 0 ]; then
		SHOW_ERROR=1
	fi
	checker_test "1 5 2 4 3" ${CHECKER_USE}
	RES=$?
	if [ ${SHOW_ERROR} == 0 ] && [ ! ${RES} == 0 ]; then
		SHOW_ERROR=1
	fi
	checker_test "-1 +5 -2 4 3" ${CHECKER_USE}
	RES=$?
	if [ ${SHOW_ERROR} == 0 ] && [ ! ${RES} == 0 ]; then
		SHOW_ERROR=1
	fi
	checker_test "$(ruby -e "puts (-50..48).to_a.shuffle.join(' ')")" ${CHECKER_USE}
	RES=$?
	if [ ${SHOW_ERROR} == 0 ] && [ ! ${RES} == 0 ]; then
		SHOW_ERROR=1
	fi

	if [ ${SHOW_ERROR} == 0 ]; then
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
		printf "${RED}Output	test not passed. You print somethings when the subject say not ❌${NC}\n"
	else
		printf "${LGREEN}Output	test passed successfully ✅${NC}\n"
	fi
}

stderr_validator()
{
	SHOW_ERROR=0
	PRINT_ERROR=0
	OUTPUT=$(${PUSH_SWAP} a 2> ${FD_ERROR_FILE} | wc -l)
	if [ ${OUTPUT} ] && [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi
	
	OUTPUT=$(head -n 1 ${FD_ERROR_FILE})
	if [ ${OUTPUT} ] && [ ! ${OUTPUT} == "Error" ]; then
		PRINT_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 1 2>> ${FD_ERROR_FILE} | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 -2147483649 2>> ${FD_ERROR_FILE} | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 +2147483648 2>> ${FD_ERROR_FILE} | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3 2>> ${FD_ERROR_FILE} | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3 2>> ${FD_ERROR_FILE} | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${RED}FD	test not passed. You print the error message in the stdout ❌${NC}\n"
	elif [ ${PRINT_ERROR} == 1 ]; then
		printf "${RED}FD	test not passed. You don't print \"Error\" as message ❌${NC}\n"
	else
		printf "${LGREEN}FD	test passed successfully ✅${NC}\n"
	fi
}

intra_checker_download()
{
	printf "${BLUE}Downloading checker from intranet...${NC}\n"
	$(cat /etc/os-release 2> .out)
	IS_MAC=$(cat .out | grep 'No such file or directory' | wc -l)
	if [ ${IS_MAC}  == 1 ]; then
		curl -o checker_intra https://projects.intra.42.fr/uploads/document/document/8245/checker_Mac 2> ${FD_ERROR_FILE}
		chmod +x ./checker_intra
		mv checker_intra ../
	else
		curl -o checker_intra https://projects.intra.42.fr/uploads/document/document/8246/checker_linux 2> ${FD_ERROR_FILE}
		chmod +x ./checker_intra
		mv checker_intra ../
	fi
}

valid_makefile()
{
	printf "${BLUE}Checking the flags...${NC}\n"
	OUTPUT=$(cat ${CURR_PATH}/../Makefile)
	WALL=$(echo ${OUTPUT} | grep Wall | wc -l)
	WEXTRA=$(echo ${OUTPUT} | grep Wextra | wc -l)
	WERROR=$(echo ${OUTPUT} | grep Werror | wc -l)
	if [ ${WALL} == 0 ] || [ ${WEXTRA} == 0 ] || [ ${WERROR} == 0 ]; then
		printf "${RED}Make	test not passed. You don't compile with the flags ❌${NC}\n"
	fi
	ALL=$(echo ${OUTPUT} | grep all | wc -l)
	CLEAN=$(echo ${OUTPUT} | grep clean | wc -l)
	FCLEAN=$(echo ${OUTPUT} | grep fclean | wc -l)
	RE=$(echo ${OUTPUT} | grep re | wc -l)
	PUSH_S=$(echo ${OUTPUT} | grep push_swap | wc -l)
	BONUS=$(echo ${OUTPUT} | grep bonus | wc -l)
	if [ ${ALL} == 0 ] || [ ${CLEAN} == 0 ] || [ ${FCLEAN} == 0 ] || [ ${RE} == 0 ] || [ ${PUSH_S} == 0 ] || [ ${BONUS} == 0 ];
	then
		printf "${RED}Make	test not passed. Missing operator between:
[all | clean | fclean | re | push_swap | bonus]
or wrong .PHONY ❌${NC}\n"
	fi
}

makefile_checker()
{
	CHECKERP=1
	RECOMPILE=0
	printf "${BLUE}Checking makefile...${NC}\n"
	if [ ! -f ${CURR_PATH}/../Makefile ]; then
		printf "${RED}Error, Makefile not found. I can't compile the program ❌\n${NC}"
		exit 0
	fi
	
	valid_makefile
	intra_checker_download
	printf "${BLUE}Compiling the program...${NC}\n"
	make re -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	if [ ! -f ${CHECKER} ]; then
		CHECKERP=0
	fi

	make clean -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	if [ ! -f ${PUSH_SWAP} ]; then
		printf "${RED}Makefile	test not passed. The 'clean' method also deletes 'push_swap' executable ❌${NC}\n"
		RECOMPILE=1
	fi
	if ([ ! -f ${CHECKER} ] && [ ! -f ${CHECKER_INTRA} ]) && [ ${CHECKERP} == 1 ]; then
		printf "${RED}Makefile	test not passed. The 'clean' method also deletes 'checker' executable ❌${NC}\n"
		RECOMPILE=1
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
	rm -rf ${CHECKER_INTRA}
	rm -rf ${OUTPUT_FILE}
	rm -rf ${OUT_FILE}
	rm -rf ${FD_ERROR_FILE}
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
		printf "${RED}Norme	test not passed ❌${NC}\n"
	else
		printf "${LGREEN}Norme	test passed successfully ✅${NC}\n"
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
	if [ -f ${ERROR_FILE} ]; then
			rm -rf ${ERROR_FILE}
	fi
	if [ ! -f ${CURR_PATH}/../Makefile ]; then
		printf "${RED}Error, Makefile not found. I can't compile the program\n${NC}"
	fi
	make re -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	rm -rf ${OUTPUT_FILE}
}

clear()
{
	press_any_key
	make fclean -C ${CURR_PATH}/../ >> ${OUTPUT_FILE}
	rm -rf ${CHECKER_INTRA}
	rm -rf ${OUTPUT_FILE}
	rm -rf ${FD_ERROR_FILE}
	rm -rf ${ERROR_FILE}
	rm -rf ${CURR_PATH}
	rm -rf ${OUT_FILE}
}

starts_value()
{
	# echo "$1 || $2 || $3 || $4 || $5 || $6 || $7"
	# echo "nb || ct || 1☆ || 2☆ || 3☆ || 4☆ || 5☆" 
	printf "$1 average: "
	if [ $2 -le $3 ]; then
		echo "${YELLOW}★★★★★ ${NC}"
	elif [ $2 -le $4 ]; then
		echo "${YELLOW}★★★★ ${NC}"
	elif [ $2 -le $5 ]; then
		echo "${YELLOW}★★★ ${NC}"
	elif [ $2 -le $6 ]; then
		echo "${YELLOW}★★ ${NC}"
	elif [ $2 -le $7 ]; then
		echo "${YELLOW}★ ${NC}"
	else
		echo "${RED} Zero stars :c ${NC}"
	fi
}

print_starts()
{
	if [ ! ${AVERAGE_ONEH} == 0 ]; then
		starts_value 100 ${AVERAGE_ONEH} 700 900 1100 1300 1500
	fi
	if [ ! ${AVERAGE_FIVEH} == 0 ]; then
		starts_value 500 ${AVERAGE_FIVEH} 5500 7000 8500 10000 115000
	fi
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
		number_test 100 100 700
		number_test 500 100 5500
		footer
		print_starts
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
				number_test 100 $2 $3
				footer
				print_starts
				end_test
				;;
			"500")
				single_compile
				header
				number_test 500 $2 $3
				footer
				print_starts
				end_test
				;;
			"list")
				list
				exit
				;;
			"clear")
				clear
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