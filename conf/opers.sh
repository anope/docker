#!/bin/sh

i=0
while [ $i -lt 20 ]; do
    eval name="\"\$ANOPE_${i}_NAME\""

    if [ -n "$name" ]; then
        eval type="\"\$ANOPE_${i}_TYPE\""
        eval require_oper="\"\$ANOPE_${i}_REQUIRE_OPER\""
        eval password="\"\$ANOPE_${i}_PASSWORD\""
        eval password_file="\"\$ANOPE_${i}_PASSWORD_FILE\""
        eval certfp="\"\$ANOPE_${i}_CERTFP\""
        eval host="\"\$ANOPE_${i}_HOST\""
        eval vhost="\"\$ANOPE_${i}_VHOST\""

        # Defaults
        if [ -z "$type" ]; then type="Services Root"; fi
        if [ -z "$require_oper" ]; then require_oper="yes"; fi

        if [ -n "$password_file" ]; then
            if [ -f "$password_file" ]; then
                password=$(cat "$password_file")
            fi
        fi

        cat <<EOF
oper
{
	name = "$name"
	type = "$type"
	require_oper = $require_oper
EOF

        if [ -n "$password" ]; then
            echo "	password = \"$password\""
        fi
        if [ -n "$certfp" ]; then
            echo "	certfp = \"$certfp\""
        fi
        if [ -n "$host" ]; then
            echo "	host = \"$host\""
        fi
        if [ -n "$vhost" ]; then
            echo "	vhost = \"$vhost\""
        fi

        echo "}"
    fi

    i=$((i+1))
done
