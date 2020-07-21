Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E687D228033
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 14:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGUMnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 08:43:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32646 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729431AbgGUMnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 08:43:41 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LCZXUs046401;
        Tue, 21 Jul 2020 08:43:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d91v5j2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 08:43:15 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LCY5G5041677;
        Tue, 21 Jul 2020 08:43:14 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d91v5j2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 08:43:14 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LCfgGJ018999;
        Tue, 21 Jul 2020 12:43:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq83w58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 12:43:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LCh9BD47906822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 12:43:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AA0E4203F;
        Tue, 21 Jul 2020 12:43:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B799142041;
        Tue, 21 Jul 2020 12:43:06 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.79.210.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 12:43:06 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
Date:   Tue, 21 Jul 2020 18:13:00 +0530
Message-Id: <20200721124300.65615-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721124300.65615-1-psampat@linux.ibm.com>
References: <20200721124300.65615-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210087
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds support to trace IPI based and timer based wakeup
latency from idle states

Latches onto the test-cpuidle_latency kernel module using the debugfs
interface to send IPIs or schedule a timer based event, which in-turn
populates the debugfs with the latency measurements.

Currently for the IPI and timer tests; first disable all idle states
and then test for latency measurements incrementally enabling each state

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 310 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   1 +
 4 files changed, 318 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..ab6cf51f3518 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -7,6 +7,7 @@ TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += clone3
 TARGETS += cpufreq
+TARGETS += cpuidle
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
new file mode 100644
index 000000000000..72fd5d2e974d
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := cpuidle.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/cpuidle/cpuidle.sh b/tools/testing/selftests/cpuidle/cpuidle.sh
new file mode 100755
index 000000000000..19cc24ccd4af
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle.sh
@@ -0,0 +1,310 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+LOG=cpuidle.log
+MODULE=/lib/modules/$(uname -r)/kernel/drivers/cpuidle/test-cpuidle_latency.ko
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+helpme()
+{
+	printf "Usage: $0 [-h] [-todg args]
+	[-h <help>]
+	[-m <location of the module>]
+	[-o <location of the output>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ht:m:o: arg
+	do
+		case $arg in
+			h) # --help
+				helpme
+				;;
+			m) # --mod-file
+				MODULE=$OPTARG
+				;;
+			o) # output log files
+				LOG=$OPTARG
+				;;
+			\?)
+				helpme
+				;;
+		esac
+	done
+}
+
+ins_mod()
+{
+	if [ ! -f "$MODULE" ]; then
+		printf "$MODULE module does not exist. Exitting\n"
+		exit $ksft_skip
+	fi
+	# Check if the module is already loaded
+	grep "test_cpuidle_latency" /proc/modules
+	if [ $? == 0 ]; then
+		printf "Module: $MODULE already loaded\n\n"
+		return 0
+	fi
+	printf "Inserting $MODULE module\n\n"
+	insmod $MODULE
+	if [ $? != 0 ]; then
+		printf "Insmod $MODULE failed\n"
+		exit $ksft_skip
+	fi
+}
+
+compute_average()
+{
+	arr=("$@")
+	sum=0
+	size=${#arr[@]}
+	if [ $size == 0 ]; then
+		avg=0
+		return 1
+	fi
+	for i in "${arr[@]}"
+	do
+		sum=$((sum + i))
+	done
+	avg=$((sum/size))
+}
+
+# Disable all stop states
+disable_idle()
+{
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		for ((state=0; state<NUM_STATES; state++))
+		do
+			echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
+		done
+	done
+}
+
+# Perform operation on each CPU for the given state
+# $1 - Operation: enable (0) / disable (1)
+# $2 - State to enable
+op_state()
+{
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		echo $1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$2/disable
+	done
+}
+
+cpuidle_enable_state()
+{
+	state=$1
+	op_state 0 $state
+}
+
+cpuidle_disable_state()
+{
+	state=$1
+	op_state 1 $state
+}
+
+cpu_is_online()
+{
+	cpu=$1
+	status=$(cat /sys/devices/system/cpu/cpu$cpu/online)
+	echo $status
+}
+
+# Extract latency in microseconds and convert to nanoseconds
+extract_latency()
+{
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		latency=$(($(cat /sys/devices/system/cpu/cpu0/cpuidle/state$state/latency) * 1000))
+		latency_arr+=($latency)
+	done
+}
+
+# Run the IPI test
+# $1 run for baseline - busy cpu or regular environment
+# $2 destination cpu
+ipi_test_once()
+{
+	dest_cpu=$2
+	if [ "$1" = "baseline" ]; then
+		# Keep the CPU busy
+		taskset -c $dest_cpu cat /dev/random > /dev/null &
+		task_pid=$!
+		# Wait for the workload to achieve 100% CPU usage
+		sleep 1
+	fi
+	taskset 0x1 echo $dest_cpu > /sys/kernel/debug/latency_test/ipi_cpu_dest
+	ipi_latency=$(cat /sys/kernel/debug/latency_test/ipi_latency_ns)
+	src_cpu=$(cat /sys/kernel/debug/latency_test/ipi_cpu_src)
+	if [ "$1" = "baseline" ]; then
+		kill $task_pid
+		wait $task_pid 2>/dev/null
+	fi
+}
+
+# Incrementally Enable idle states one by one and compute the latency
+run_ipi_tests()
+{
+	extract_latency
+	disable_idle
+	declare -a avg_arr
+	echo -e "--IPI Latency Test---" >> $LOG
+
+	echo -e "--Baseline IPI Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		ipi_test_once "baseline" $cpu
+		printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
+		avg_arr+=($ipi_latency)
+	done
+	compute_average "${avg_arr[@]}"
+	echo -e "Baseline Average IPI latency(ns): $avg" >> $LOG
+
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		unset avg_arr
+		echo -e "---Enabling state: $state---" >> $LOG
+		cpuidle_enable_state $state
+		printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
+		for ((cpu=0; cpu<NUM_CPUS; cpu++))
+		do
+			local cpu_status=$(cpu_is_online $cpu)
+			if [ $cpu_status == 0 ]; then
+				continue
+			fi
+			# Running IPI test and logging results
+			sleep 1
+			ipi_test_once "test" $cpu
+			printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
+			avg_arr+=($ipi_latency)
+		done
+		compute_average "${avg_arr[@]}"
+		echo -e "Expected IPI latency(ns): ${latency_arr[$state]}" >> $LOG
+		echo -e "Observed Average IPI latency(ns): $avg" >> $LOG
+		cpuidle_disable_state $state
+	done
+}
+
+# Extract the residency in microseconds and convert to nanoseconds.
+# Add 100 ns so that the timer stays for a little longer than the residency
+extract_residency()
+{
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		residency=$(($(cat /sys/devices/system/cpu/cpu0/cpuidle/state$state/residency) * 1000 + 200))
+		residency_arr+=($residency)
+	done
+}
+
+# Run the Timeout test
+# $1 run for baseline - busy cpu or regular environment
+# $2 destination cpu
+# $3 timeout
+timeout_test_once()
+{
+	dest_cpu=$2
+	if [ "$1" = "baseline" ]; then
+		# Keep the CPU busy
+		taskset -c $dest_cpu cat /dev/random > /dev/null &
+		task_pid=$!
+		# Wait for the workload to achieve 100% CPU usage
+		sleep 1
+	fi
+	taskset -c $dest_cpu echo $3 > /sys/kernel/debug/latency_test/timeout_expected_ns
+	# Wait for the result to populate
+	sleep 0.1
+	timeout_diff=$(cat /sys/kernel/debug/latency_test/timeout_diff_ns)
+	src_cpu=$(cat /sys/kernel/debug/latency_test/timeout_cpu_src)
+	if [ "$1" = "baseline" ]; then
+		kill $task_pid
+		wait $task_pid 2>/dev/null
+	fi
+}
+
+run_timeout_tests()
+{
+	extract_residency
+	disable_idle
+	declare -a avg_arr
+	echo -e "\n--Timeout Latency Test--" >> $LOG
+
+	echo -e "--Baseline Timeout Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		timeout_test_once "baseline" $cpu ${residency_arr[0]}
+		printf "%-3s %13s\n" $src_cpu $timeout_diff >> $LOG
+		avg_arr+=($timeout_diff)
+	done
+	compute_average "${avg_arr[@]}"
+	echo -e "Baseline Average timeout diff(ns): $avg" >> $LOG
+
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		unset avg_arr
+		echo -e "---Enabling state: $state---" >> $LOG
+		cpuidle_enable_state $state
+		printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)" "Delay(ns)" >> $LOG
+		for ((cpu=0; cpu<NUM_CPUS; cpu++))
+		do
+			local cpu_status=$(cpu_is_online $cpu)
+			if [ $cpu_status == 0 ]; then
+				continue
+			fi
+			timeout_test_once "test" $cpu ${residency_arr[$state]}
+			printf "%-3s %13s %18s\n" $src_cpu $baseline_timeout_diff $timeout_diff >> $LOG
+			avg_arr+=($timeout_diff)
+		done
+		compute_average "${avg_arr[@]}"
+		echo -e "Expected timeout(ns): ${residency_arr[$state]}" >> $LOG
+		echo -e "Observed Average timeout diff(ns): $avg" >> $LOG
+		cpuidle_disable_state $state
+	done
+}
+
+declare -a residency_arr
+declare -a latency_arr
+
+# Parse arguments
+parse_arguments $@
+
+rm -f $LOG
+touch $LOG
+NUM_CPUS=$(nproc --all)
+NUM_STATES=$(ls -1 /sys/devices/system/cpu/cpu0/cpuidle/ | wc -l)
+
+# Insert the module
+ins_mod $MODULE
+
+printf "Started IPI latency tests\n"
+run_ipi_tests
+
+printf "Started Timer latency tests\n"
+run_timeout_tests
+
+printf "Removing $MODULE module\n"
+printf "Output logged at: $LOG\n"
+rmmod $MODULE
diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.25.4

