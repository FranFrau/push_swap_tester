# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tester.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ffrau <ffrau@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/11 19:52:02 by ffrau             #+#    #+#              #
#    Updated: 2022/06/12 18:20:11 by ffrau            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED="\033[31m"
IRED="\033[41m"
LGREEN="\033[32m"
NC="\033[0m"
CURR_PATH=$(pwd)
PUSH_SWAP="${CURR_PATH}/../push_swap"
CHECKER="${CURR_PATH}/../checker"
CHECKER_MAC="${CURR_PATH}/../checker_Mac"
#dirname "$0"

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
					RESULT=$(${PUSH_SWAP} ${i} ${j} ${k} | wc -l)
					AVERAGE=$((AVERAGE + RESULT))
					if [ $RESULT -le  3 ]; then
						COUNTER=$((COUNTER +1))
					else
						printf "${RED}Error with ${NC}'${PUSH_SWAP} ${i} ${j} ${k}'"
					fi
				fi
			done
		done
	done
	printf "${LGREEN}3${NC}	Numbers: You made ${LGREEN}${COUNTER}/6${NC}.		Average of ${LGREEN}$((AVERAGE / 6))${NC}\n"
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
							RESULT=$(${PUSH_SWAP} ${i} ${j} ${k} ${x} ${y} | wc -l)
							AVERAGE=$((AVERAGE + RESULT))
							if [ $RESULT -le  12 ]; then
								COUNTER=$((COUNTER +1))
							else
								printf "${RED}Error with ${NC}'${PUSH_SWAP} ${i} ${j} ${k} ${x} ${y}'"
							fi
						fi
					done
				done
			done
		done
	done
	printf "${LGREEN}5${NC}	Numbers: You made ${LGREEN}${COUNTER}/120${NC}.	Average of ${LGREEN}$((AVERAGE / 120))${NC}\n"
}

one_hundred(){
	COUNTER=0
	AVERAGE=0
	MOVES=$1
	TESTS=$2
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
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le ${MOVES} ]; then
			COUNTER=$((COUNTER +1))
		else
			printf "${RED}Error${NC}\n"
			echo "'./push_swap ${SEQUENCE}'" >> errors.txt
		fi
	done
	printf "${LGREEN}100${NC}	Numbers: You made ${LGREEN}${COUNTER}/${TESTS}${NC}.	Average of ${LGREEN}$((AVERAGE / ${TESTS}))${NC}\n"
	if [ ! ${COUNTER} == ${TESTS} ]; then
		printf "You can find the errors in errors.txxt file. You can also read it with ./tester showerrors\n"
	fi
}

five_hundred(){
	COUNTER=0
	AVERAGE=0
	MOVES=$1
	TESTS=$2
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
		AVERAGE=$((AVERAGE + RESULT))
		if [ ${RESULT} -le ${MOVES} ]; then
			COUNTER=$((COUNTER +1))
		else
			printf "${RED}Error${NC}\n"
			echo "'./push_swap ${SEQUENCE}'" >> errors.txt
		fi
	done
	printf "${LGREEN}500${NC}	Numbers: You made ${LGREEN}${COUNTER}/${TESTS}${NC}.	Average of ${LGREEN}$((AVERAGE / ${TESTS}))${NC}\n"
	if [ ! ${COUNTER} == ${TESTS} ]; then
		printf "You can find the errors in errors.txxt file. You can also read it with ./tester showerrors\n"
	fi
}

showerrors(){
	if [ -f ./errors.txt ]; then
		cat ./errors.txt
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
	if [ ${CHECKER_USE} == 0 ] && [ ${CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
	fi
	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${RED}Error. The output isn't valid${NC}\n"
		printf "./push_swap ${ARG}\n"
	fi
	ARG="1 5 2 4 3"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
	fi
	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${RED}Error. The output isn't valid${NC}\n"
		printf "./push_swap ${ARG}\n"
	fi
	ARG="-1 +5 -2 4 3"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
	fi
	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${RED}Error. The output isn't valid${NC}\n"
		printf "./push_swap ${ARG}\n"
	fi
	ARG="$(ruby -e "puts (-50..48).to_a.shuffle.join(' ')")"
	if [ ${CHECKER_USE} == 1 ]; then
		OUTPUT_CHECKER=$(${PUSH_SWAP} ${ARG} | ${CHECKER} ${ARG})
	fi
	OUTPUT_CHECKER_MAC=$(${PUSH_SWAP} ${ARG} | ${CHECKER_MAC} ${ARG})
	if [ ${CHECKER_USE} == 0 ] && [ ${CHECKER_MAC} == "KO" ]; then
		SHOW_ERROR=1
	elif [ ${CHECKER_USE} == 1 ] && [ ! ${OUTPUT_CHECKER} == ${OUTPUT_CHECKER_MAC} ]; then
		SHOW_ERROR=1
	fi
	if [ ${SHOW_ERROR} == 1 ]; then
		printf "${RED}Error. The output isn't valid${NC}\n"
		printf "./push_swap ${ARG}\n"
	fi
}

output_validator()
{
	SHOW_ERROR=0
	printf "${RED}Default tests${NC}\n"
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
		printf "${LGREEN}Test passed successfully${NC}\n"
	fi
}

stderr_validator()
{
	SHOW_ERROR=0
	printf "${RED}fd tests. Five error messages will be printed.${NC}\n"
	OUTPUT=$(${PUSH_SWAP} a | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 1 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 -2147483649 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} 1 +2147483648 | wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3| wc -l)
	if [ ! ${OUTPUT} == 0 ]; then
		SHOW_ERROR=1
	fi

	OUTPUT=$(${PUSH_SWAP} +-"1" 3| wc -l)
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
		printf "${LGREEN}Test passed successfully${NC}\n"
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
	make re -C ${CURR_PATH}/../
	if [ ! -f ${CHECKER_MAC} ]; then
		CHECKERP=0
		curl -o checker_Mac https://projects.intra.42.fr/uploads/document/document/8245/checker_Mac
		chmod +x ./checker_Mac
		mv checker_Mac ../
	fi
	make clean -C ${CURR_PATH}/../
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
		make re -C ${CURR_PATH}/../
	fi
}

press_any_key(){
	printf "${LGREEN}Press any key to continue${NC}";
	read -rsn1; echo
}

end_test(){
	press_any_key
	make fclean -C ${CURR_PATH}/../
	rm -rf ${CHECKER_MAC}
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


valid_params()
{
	if [ ! $1 ]; then
		makefile_checker
		norme
		stderr_validator
		output_validator
		stresstests
		three_number
		five_number
		one_hundred
		five_hundred
		showerrors
	else
		case $1 in
			"makefile")
				makefile_checker
				end_test
				;;
			"errors")
				make re -C ${CURR_PATH}/../
				stderr_validator
				output_validator
				end_test
				;;
			'3')
				make re -C ${CURR_PATH}/../
				three_number
				end_test
				;;
			'5')
				make re -C ${CURR_PATH}/../
				five_number
				end_test
				;;
			"100")
				make re -C ${CURR_PATH}/../
				one_hundred $2 $3
				end_test
				;;
			"500")
				make re -C ${CURR_PATH}/../
				five_hundred $2 $3
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