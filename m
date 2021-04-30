Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1436F71B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhD3I3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 04:29:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231444AbhD3I3L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 04:29:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U8DZ1a194893;
        Fri, 30 Apr 2021 04:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yaqKNSuV2PwWFoKLztvPYRVGfHmHdidjm6FFN3tGeSM=;
 b=qNqeb1/ryIb5diNWgisLJbgDg3RJggXGKtlo71qKLsjgjh5ys6bykST0LJSEN0Rkg2GC
 GewGYlIOslqL5cNn1FPrsIQibRtEbdLoL5QmRr3rg17j1K2WzzEumy5VZD82FUsbeV9s
 eNx3fcby8CdRyBqWUH0cuuCmmamuyY5I1NJI8znuQBaK8SGH2XJ1u0Pqv1vQ28UyBEcR
 vJtoAJykfpc1usQFPSfx3pO+2u6GvwhBINWSF7X1S5YuYvmXb64hFjSABjYKwRpfh382
 KfvAFumiMO97mtFHCe1ZWVk0G+XobgK6ZJGI407kBPW/up3Om/tsXj1FgMZR6L01MfXa KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388e6p8dmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:19 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13U8E5TS001867;
        Fri, 30 Apr 2021 04:28:18 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 388e6p8dkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:18 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13U8HYWL014074;
        Fri, 30 Apr 2021 08:28:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 384ay8jyjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 08:28:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13U8SDLZ60948806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 08:28:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C69A352050;
        Fri, 30 Apr 2021 08:28:13 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.87.236])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 32A485204F;
        Fri, 30 Apr 2021 08:28:10 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        dsmythies@telus.net, dedekind1@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com, psampat@linux.ibm.com
Subject: [PATCH v5 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
Date:   Fri, 30 Apr 2021 13:58:04 +0530
Message-Id: <20210430082804.38018-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430082804.38018-1-psampat@linux.ibm.com>
References: <20210430082804.38018-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1QCzU0j5uoPJfgCx_kDg03bTK9TwazMi
X-Proofpoint-GUID: xZZ7te942f3A_y1aVgtvT-aBTSHE6reb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_03:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300056
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

The timer based test produces run to run variance on some intel based
systems that sport a mechansim "C-state pre-wake" which can
pre-wake a CPU from an idle state when timers are armed. For systems and
architectures that don't have this mechansim can leverage timer tests
with the -i option.

To run this test specifically:
$ sudo make -C tools/testing/selftests TARGETS="cpuidle" run_tests

There are a few optional arguments too that the script can take
        [-h <help>]
        [-i <run timer tests>]
        [-m <location of the module>]
        [-o <location of the output>]
        [-v <verbose> (run on all cpus)]
Default Output location in: tools/testing/selftest/cpuidle/cpuidle.log

To run the test without re-compiling:
$ cd tools/testing/selftest/cpuidle/
$ sudo ./cpuidle.sh

CC: Shuah Khan <skhan@linuxfoundation.org>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 414 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   2 +
 4 files changed, 423 insertions(+)
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6c575cf34a71..561eb67a4839 100644
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
index 000000000000..4d5c02ab1eb5
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle.sh
@@ -0,0 +1,414 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# CPU-Idle latency selftest provides support to systematically extract,
+# analyse and present IPI and timer based wakeup latencies for each CPU
+# and each idle state available on the system by leveraging the
+# test-cpuidle_latency module
+#
+# Author: Pratik R. Sampat <psampat@linux.ibm.com>
+
+LOG=cpuidle.log
+MODULE=/lib/modules/$(uname -r)/kernel/drivers/cpuidle/test-cpuidle_latency.ko
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+RUN_TIMER_TEST=0
+VERBOSE=0
+
+DISABLE=1
+ENABLE=0
+
+helpme()
+{
+	printf "Usage: $0 [-h] [-todg args]
+	[-h <help>]
+	[-i <run timer tests>]
+	[-m <location of the module>]
+	[-o <location of the output>]
+	[-v <verbose>]
+	\n"
+	exit 2
+}
+
+parse_arguments()
+{
+	while getopts ht:m:o:vt:it: arg
+	do
+		case $arg in
+			h) # --help
+				helpme
+				;;
+			i) # run timer tests
+				RUN_TIMER_TEST=1
+				;;
+			m) # --mod-file
+				MODULE=$OPTARG
+				;;
+			o) # output log files
+				LOG=$OPTARG
+				;;
+			v) # Verbose mode
+				VERBOSE=1
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
+cpu_is_online()
+{
+	cpu=$1
+	if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
+		echo 1
+		return
+	fi
+	status=$(cat /sys/devices/system/cpu/cpu$cpu/online)
+	echo $status
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
+	op_state $ENABLE $state
+}
+
+cpuidle_disable_state()
+{
+	state=$1
+	op_state $DISABLE $state
+}
+
+# Enable/Disable all stop states for all CPUs
+# $1 - Operation: enable (0) / disable (1)
+op_cpuidle()
+{
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		op_state $1 $state
+	done
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
+# Simple linear search in an array
+# $1 - Element to search for
+# $2 - Array
+element_in()
+{
+	local item="$1"
+	shift
+	for element in "$@";
+	do
+		if [ "$element" == "$item" ]; then
+			return 0
+		fi
+	done
+	return 1
+}
+
+# Parse and return a cpuset with ","(individual) and "-" (range) of CPUs
+# $1 - cpuset string
+parse_cpuset()
+{
+	echo $1 | awk '/-/{for (i=$1; i<=$2; i++)printf "%s%s",i,ORS;next} 1' RS=, FS=-
+}
+
+extract_core_information()
+{
+	declare -a thread_arr
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+
+		siblings=$(cat /sys/devices/system/cpu/cpu$cpu/topology/thread_siblings_list)
+		sib_arr=()
+		for c in $(parse_cpuset $siblings)
+		do
+			sib_arr+=($c)
+		done
+
+		if [ $VERBOSE == 1 ]; then
+			core_arr+=($cpu)
+			for thread in "${sib_arr[@]}"
+			do
+				if [ $cpu == 0 ]; then
+					first_core_arr+=($thread)
+				fi
+			done
+			continue
+		fi
+
+		element_in "${sib_arr[0]}" "${thread_arr[@]}"
+		if [ $? == 0 ]; then
+			continue
+		fi
+		core_arr+=(${sib_arr[0]})
+
+		for thread in "${sib_arr[@]}"
+		do
+			thread_arr+=($thread)
+			if [ $cpu == 0 ]; then
+				first_core_arr+=($thread)
+			fi
+		done
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
+	# Disable idle states for CPUs
+	op_cpuidle $DISABLE
+
+	declare -a avg_arr
+	echo -e "--IPI Latency Test---" | tee -a $LOG
+
+	echo -e "--Baseline IPI Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
+	for cpu in "${core_arr[@]}"
+	do
+		local cpu_status=$(cpu_is_online $cpu)
+		if [ $cpu_status == 0 ]; then
+			continue
+		fi
+		ipi_test_once "baseline" $cpu
+		printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
+		# Skip computing latency average from the source CPU to avoid bias
+		element_in "$cpu" "${first_core_arr[@]}"
+		if [ $? == 0 ]; then
+			continue
+		fi
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
+		for cpu in "${core_arr[@]}"
+		do
+			local cpu_status=$(cpu_is_online $cpu)
+			if [ $cpu_status == 0 ]; then
+				continue
+			fi
+			# Running IPI test and logging results
+			sleep 1
+			ipi_test_once "test" $cpu
+			printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
+			# Skip computing latency average from the source CPU to avoid bias
+			element_in "$cpu" "${first_core_arr[@]}"
+			if [ $? == 0 ]; then
+				continue
+			fi
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
+# Add 200 ns so that the timer stays for a little longer than the residency
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
+	# Disable idle states for all CPUs
+	op_cpuidle $DISABLE
+
+	declare -a avg_arr
+	echo -e "\n--Timeout Latency Test--" | tee -a $LOG
+
+	echo -e "--Baseline Timeout Latency measurement: CPU Busy--" >> $LOG
+	printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
+	for cpu in "${core_arr[@]}"
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
+		for cpu in "${core_arr[@]}"
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
+declare -a core_arr
+declare -a first_core_arr
+
+parse_arguments $@
+
+rm -f $LOG
+touch $LOG
+NUM_CPUS=$(nproc --all)
+NUM_STATES=$(ls -1 /sys/devices/system/cpu/cpu0/cpuidle/ | wc -l)
+
+extract_core_information
+
+ins_mod $MODULE
+
+run_ipi_tests
+if [ $RUN_TIMER_TEST == 1 ]; then
+	run_timeout_tests
+fi
+
+# Enable all idle states for all CPUs
+op_cpuidle $ENABLE
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

