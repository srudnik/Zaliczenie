#!/bin/bash

menu()
{

echo "Wybierz grę"
select x in zgadywanie1 zgadywanie2 zgadywanie3 wyjscie
do
case $x in 
zgadywanie1) zgadywanie1;;
zgadywanie2) zgadywanie2;;
zgadywanie3) zgadywanie3;;
wyjscie) wyjscie;;
*) echo "blad";;
esac
break
done

}


zgadywanie1()
{
echo "Masz 10 mozliwosci na wpisanie liczb od 0 do 100, jesli odgadniesz liczbe"
echo "dostajesz 10 pkt, jesli pomylisz sie o 1 to dostajesz 9 pkt, jak o 2 to 8 pkt itd."
echo "LOSOWA liczba zmnienia sie wraz z kolejnym ruchem!"
for (( x=10; x > 0; x-- )) ; do  
	echo "podaj liczbe w przedziale od 0 do 100: "
	read y          
	losowa=$[ ( $RANDOM % 101 ) ]

	if [ "$y" == "$losowa" ]   
	then
		wynik[$x]=10    
	elif [ "$y" -gt "$losowa" ] 
	then	
		tmp=$[y-losowa]      
#		echo $tmp
		if [ "$tmp" -le 10 ] 
		then
			wynik[$x]=10-$tmp   
		else
			wynik[$x]=0 
		fi
	else  
		tmp=$[losowa-y]   
		
		if [ "$tmp" -le 10 ]  

		then
			wynik[$x]=10-$tmp   
		else
			wynik[$x]=0    
		fi
	fi
done 
suma=0
echo
for (( x=10; x > 0; x-- )) ; do   
	echo $[wynik[$x]]                
	suma=$[suma+wynik[$x]]
done
echo "Suma punktow: $suma"

menu

}

zgadywanie2()
{

echo "Witaj w grze Zgadywanie"
liczba=$[ ( $RANDOM % 101 ) ]
echo "Wylosowano liczbe w przedziale 0 - 100 ktora musisz odgadnac"
echo "Wybierz poziom gry"
select y in HARD MEDIUM LOW
do
case $y in 
"HARD") echo "Wybrales maksymalnie 5 ruchow" 
b=$[b+5] ;; 
"MEDIUM") echo "Wybrales maksymalnie 8 ruchow" 
b=$[b+8] ;; 
"LOW") echo "Wybrales maksymalnie 13 ruchow" 
b=$[b+13] ;;
esac
break 
done
for (( x=0; x<$b; x++)) ; do
echo "Podaj liczbe :"
read a
if [ "$a" == "$liczba" ]
then
ruch=$[ruch+1]
echo "Gratulacje! Odgadles liczbe, liczba Twoich ruchow : [[ $ruch ]]" 
ruch=0
b=0

menu

fi
if [ "$a" -gt "$liczba" ]
then
ruch=$[ruch+1]
echo "Zgadywana liczba jest MNIEJSZA niz $a"
else
ruch=$[ruch+1]
echo "Zgadywana liczba jest WIEKSZA niz $a"
fi
done
clear;
echo "Niestety nie udalo Ci sie odgadnac liczby [[ $liczba ]]"

ruch=0

menu

}

zgadywanie3()
{

strzal=0
trafienia=0

echo "Podaj zakres z jakiego ma zostac wylosowana liczba"
read MAX
let "ZAGADKA=$$%${MAX}"   
while [ ${strzal} -ne ${ZAGADKA} ] 
do
strzal=$(zenity --scale --title="Zgadywanka"  --text "Zgadnij liczbę od 0 do $MAX" --min-value=0 --max-value=$MAX --value=0 --step 1);echo $strzal;
	if [ ${strzal} -lt ${ZAGADKA} ] ; then
		zenity --info --text "Moja liczba jest większa \n Spróbuj jeszcze raz!"
	elif [ ${strzal} -gt ${ZAGADKA} ] ; then
		zenity --info --text "Moja liczba jest mniejsza \n Spróbuj jeszcze raz!!"
	fi
	let "trafienia=trafienia+1"
done
if [ $strzal = $ZAGADKA ] ; then  
	zenity --info --title="Wynik" --text "OK Zgadłeś w ${trafienia} krokach. \n Moja liczba to ${ZAGADKA} !!"
else 
	zenity --info --title="Wynik" --text "Ty oszuście !!"
fi

menu

}

wyjscie()
{

echo "zamykanie za 5 sekund"
sleep 5s
exit 0

}


menu

