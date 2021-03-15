Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6862C33B1B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 12:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCOLtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 07:49:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229813AbhCOLsq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 07:48:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FBY1uD163537;
        Mon, 15 Mar 2021 07:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fyEwwqMBlDG8GnbPpRyGQM5LunZqsfWP696dxHsJ3sE=;
 b=B/yVIlyE+LHYTy28WtXijaOmyy/2htfiIbznF65wqrUM2A0IwX024bH22smjIck+NIek
 5VnlWeje7oh/c4xzsF4xFLH1LhE93z8foG6RWN+Mv38ynYHGWgStwIMF+VOHAEMyUsdh
 V8IXcIohwPkEUm4KvJqLMXKw4BZZlnsI8LWGww9ZP7wAAMe+/Cg4r1yN5jI6+1De7NaN
 FYt4oZEHaNXzisKBtoT2eFKb5F4tL4EF9EG++P8Z4gBsEEplFKlc/Pjumjd3Gu8JsmvS
 MRPS5xbsr/M+FwqemIH2T+kTPDFs5MEdG0aOfSeIz5hczxbRBrXO10BuKSdfKoxe3kAA VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 379yj1uhgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 07:48:42 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12FBcJTI180413;
        Mon, 15 Mar 2021 07:48:41 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 379yj1uhgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 07:48:41 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12FBhx05011623;
        Mon, 15 Mar 2021 11:48:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 378n18htkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 11:48:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12FBmbBo45220214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 11:48:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0FB452054;
        Mon, 15 Mar 2021 11:48:36 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.95.254])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 74A2752057;
        Mon, 15 Mar 2021 11:48:34 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com
Subject: [RFC 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
Date:   Mon, 15 Mar 2021 17:18:27 +0530
Message-Id: <20210315114827.46036-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210315114827.46036-1-psampat@linux.ibm.com>
References: <20210315114827.46036-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_03:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150081
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cpuidle latency selftest provides support to systematically extract,
analyse and present IPI and timer based wakeup latencies for each CPU
and each idle state available on the system.

The selftest leverages test-cpuidle_latency module's debugfs interface
to interact and extract latency information from the kernel.

The selftest inserts the module if already not inserted, disables all
the idle states and enables them one by one testing the following:
1. Keeping source CPU constant, iterate through all the CPUS measuring
  IPI latency for baseline (CPU is busy with cat /dev/random > /dev/null
  workload) and then when the CPU is allowed to be at rest
2. Iterating through all the CPUs, sending expected timer durations to
  be equivalent to the residency of the deepest idle state enabled
  and extracting the difference in time between the time of wakeup and
  the expected timer duration

To run this test specifically:
$ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

There are a few optinal arguments too that the script can take
        [-h <help>]
        [-m <location of the module>]
        [-o <location of the output>]
        [-v <verbose> (run on all cpus)]
Default Output location in: tools/testing/cpuidle/cpuidle.log

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 316 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   2 +
 4 files changed, 325 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8a917cb4426a..8ac7a4fb86f9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -7,6 +7,7 @@ TARGETS += cgroup
 TARGETS += clone3
 TARGETS += core
 TARGETS += cpufreq
+TARGETS += cpuidle
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
 TARGETS += efivarfs
diff --git a/tools/testing/selftests/cpuidle/Makefile b/tools/testing/selftests/cpuidle/Makefile
new file mode 100644
index 000000000000..cbe13feced34
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := cpuidle.sh
+
+include ../lib.mk
\ No newline at end of file
diff --git a/tools/testing/selftests/cpuidle/cpuidle.sh b/tools/testing/selftests/cpuidle/cpuidle.sh
new file mode 100755
index 000000000000..de5141d5b76b
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle.sh
@@ -0,0 +1,316 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+LOG=cpuidle.log
+MODULE=/lib/modules/$(uname -r)/kernel/drivers/cpuidle/test-cpuidle_latency.ko
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+SMT=$(lscpu | grep "Thread(s) per core" | awk '{print $4}')
+
+helpme()
+{
+	printf "Usage: $0 [-h] [-todg args]
+	[-h <help>]
+	[-m <location of the module>]
+	[-o <location of the output>]
+	[-v <verbose>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ht:m:o:vt: arg
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
+			v) # Verbose mode
+				SMT=1
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
+	debugfs_file=/sys/kernel/debug/latency_test/ipi_latency_ns
+	# Check if the module is already loaded
+	if [ -f "$debugfs_file" ]; then
+		printf "Module already loaded\n\n"
+		return 0
+	fi
+	# Try to load the module
+	if [ ! -f "$MODULE" ]; then
+		printf "$MODULE module does not exist. Exitting\n"
+		exit $ksft_skip
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
+	if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
+		echo 0
+		return
+	fi
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
+	echo -e "--IPI Latency Test---" | tee -a $LOG
+
+	echo -e "--Baseline IPI Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
+	for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
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
+	echo -e "Baseline Avg IPI latency(ns): $avg" | tee -a $LOG
+
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		unset avg_arr
+		echo -e "---Enabling state: $state---" >> $LOG
+		cpuidle_enable_state $state
+		printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
+		for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
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
+		echo -e "Observed Avg IPI latency(ns) - State $state: $avg" | tee -a $LOG
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
+	echo -e "\n--Timeout Latency Test--" | tee -a $LOG
+
+	echo -e "--Baseline Timeout Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
+	for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		timeout_test_once "baseline" $cpu 1000000
+		printf "%-3s %13s\n" $src_cpu $timeout_diff >> $LOG
+		avg_arr+=($timeout_diff)
+	done
+	compute_average "${avg_arr[@]}"
+	echo -e "Baseline Avg timeout diff(ns): $avg" | tee -a $LOG
+
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		unset avg_arr
+		echo -e "---Enabling state: $state---" >> $LOG
+		cpuidle_enable_state $state
+		printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)" "Delay(ns)" >> $LOG
+		for ((cpu=0; cpu<NUM_CPUS; cpu+=SMT))
+		do
+			local cpu_status=$(cpu_is_online $cpu)
+			if [ $cpu_status == 0 ]; then
+				continue
+			fi
+			timeout_test_once "test" $cpu 1000000
+			printf "%-3s %13s %18s\n" $src_cpu $baseline_timeout_diff $timeout_diff >> $LOG
+			avg_arr+=($timeout_diff)
+		done
+		compute_average "${avg_arr[@]}"
+		echo -e "Expected timeout(ns): ${residency_arr[$state]}" >> $LOG
+		echo -e "Observed Avg timeout diff(ns) - State $state: $avg" | tee -a $LOG
+		cpuidle_disable_state $state
+	done
+}
+
+declare -a residency_arr
+declare -a latency_arr
+
+parse_arguments $@
+
+rm -f $LOG
+touch $LOG
+NUM_CPUS=$(nproc --all)
+NUM_STATES=$(ls -1 /sys/devices/system/cpu/cpu0/cpuidle/ | wc -l)
+
+ins_mod $MODULE
+
+run_ipi_tests
+run_timeout_tests
+
+printf "Removing $MODULE module\n"
+printf "Full Output logged at: $LOG\n"
+rmmod $MODULE
diff --git a/tools/testing/selftests/cpuidle/settings b/tools/testing/selftests/cpuidle/settings
new file mode 100644
index 000000000000..a26c38a70d77
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/settings
@@ -0,0 +1,2 @@
+timeout=0
+
-- 
2.17.1

