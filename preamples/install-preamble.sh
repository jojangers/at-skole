echo "How many ../ do we have to make?"
read count
j=""
while [ $count -gt 0 ]
do
    j="${j}../"
    count=$(( $count -1 ))
done







options=("Main" "NetworkVLAN" "NetworkLAN" "NetworkWAN" "EMail" "Credentials" "vSphere" "Hardware_Servers" "Hardware_Clients" "Services" "VPN" "Licenses" "ADSecurityGroups" "TSM")

menu() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do 
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    [[ "$msg" ]] && echo "$msg"; :
}

prompt="Check an option (again to uncheck, ENTER when done): "
while menu && read -rp "$prompt" num && [[ "$num" ]]; do
    [[ "$num" != *[![:digit:]]* ]] &&
    (( num > 0 && num <= ${#options[@]} )) ||
    { msg="Invalid option: $num"; continue; }
    ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
    [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
done

for i in ${!options[@]}; do 
    [[ "${choices[i]}" ]] && { cp ${j}Templates/Production/Documentation/${options[i]}.tex .; }
done




echo "type 1 to install preambles aswell"
read agree
if [ $agree -eq 1 ]
then
    ln -s ${j}preamples/preamble.tex preamble.tex
    ln -s ${j}preamples/preamble_heading.tex preamble_heading.tex
    ln -s ${j}preamples/preamble_begin_document.tex preamble_begin_document.tex
    ln -s ${j}preamples/preamble_landscape.tex preamble_landscape.tex
    ln -s ${j}preamples/preamble_tilbud.tex preamble_tilbud.tex
    ln -s ${j}preamples/preamble_tikz.tex preamble_tikz.tex
    mkdir -p logo
    rsync -av ${j}_logo/ logo/
fi

echo "Done"
