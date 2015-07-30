# Distributed JMeter test environment

## Quick Start (to connect to existing JMeter workers):

- Check out this repository.
- Run ./setup-local to download and extract meter.
- Copy your AWS private key to the certs directory. This is the key you use to log in to the AWS instances.
- To verify you can connect to a jmeter node run ./connect jmeter1 to open an ssh connection. Exit.
- Run ./stop-nodes to stop any running jmeter nodes.
- Run ./start-nodes to open the SSH tunnels and start the nodes for your test.
- Run ./start-gui to launch the jmeter project.

##Instructions
1. Run ./setup-local from this directory
This script downloads JMeter 2.13 and unpacks it in the test directory.

2. Create stock AWS Ubuntu instances for JMeter worker nodes.
The t2.micro instances will allow you to run up to 250 threads per node. The jmeter.propertes file may need to be updated to tune for more threads/nodes. Ubuntu instances should be configured with a public IP address and SSH access to the test master. You should use the same .pem key for each instance so we can connect to the machines later.

3. Record the IP Addresses and a worker node alias in the remotes file. Node aliases do not need to be machine names and do not need to appear in the /etc/hosts file. They are only used as machine shortcuts for the launch scripts.

4. After making any changes to the remotes file 
	- Run ./update-properties
This will update the jmeter.properties and settings file with the updated worker node addresses.

5. Copy the .pem key for the AWS instances to the certs directory. Make sure key is chmod 400 for ssh to connect.

6. Run ./setup-nodes from this directory
This script will connect to each worker node in the remotes file, download meter 2.13, update and install openjdk-7-jdk via apt, and unpack JMeter into the home directory.

7. To start the worker nodes (for each node):
	- Open a terminal
	- Run ./launch <node alias>

8. To start the test client:
	- Open a terminal
	- Run ./start-gui

9. From the GUI menu: Run -> Remote Start -> <node ip address>
Starting nodes seems to work best if you start them one at a time. Otherwise there may be socket contention on the client machine. If you start seeing Too many open files errors in the worker node consoles, try starting one client, let the threads initialize, then the next… and so on.

10. Collect data and stop and Run -> Remote Stop All
Data should be collected in the results folder:
	$TEST_HOME/results/summary-results.jtl

# Other Tools
- connect <remote alias> - SSH to the worker node alias.
- connect <remote alias> [command] - Execute a command on the worker node.
- reboot-nodes - Reboot all of the worker node instances.
- start-tunnels - Launch SSH reverse tunnels to report back to test master. (requires killall ssh to stop the tunnels)
- start-nodes - Batch script to start all of the worker nodes and intiate SSH tunnels. (requires killall ssh to stop the tunnels)
- stop-nodes - Stop the java process running on all worker nodes.
- start-test - Run the JMeter test headless.
