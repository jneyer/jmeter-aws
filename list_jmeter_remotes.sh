ips=`aws ec2 describe-instances --filters "Name=tag:Name,Values=jmeter" "Name=instance-state-name,Values=running" | grep PublicIpAddress | sed -n 's|^.*PublicIpAddress": "\([0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\)",.*$|\1|p'`

count=1
for ip in $ips; do
echo "$ip	jmeter$count"
count=$[$count + 1]
done
