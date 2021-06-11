Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0683A4229
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFKMoO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22278 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231274AbhFKMoL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:44:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BCXCs2161363;
        Fri, 11 Jun 2021 08:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ErDpu6qFyoOHGIhMeE8dLUL3Jh7OLsiS943qMfLbBr8=;
 b=KFgrGC8PrJCLLWqRtzUc9sMDnIL67Ob2sU7tb6uBqQEUBqRnlzZAlggUAji2wSnWoTGn
 AjsnaGCqHbHgnGpn03luGIBgAeRiHwbLaw+S6VXej1QJHSFptohvxGv5xvm+ydWRGcR1
 O+JkPy5bCOdiWdpiz3JbAzS8f3ilubvRc/FnWZWp86Q1tyCtbBlA2l2IhVXK9b0qaaB+
 b8xChkYwD0Y2HRHMzeH2Ys5rxCDLBnKMEdqmmN3TnlBCuJ1N8wyanCeUP8wJuJaszSml
 HP3LMM3Ghoalf8F4D4PrQ8LUtY7MM7kWLcq8xPveA6f4da9OGWfaU1G4jGWsckj2Aj/+ bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39457f59yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:06 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15BCXrS0164161;
        Fri, 11 Jun 2021 08:42:05 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39457f59x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BCWvEo004854;
        Fri, 11 Jun 2021 12:42:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8becy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 12:42:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BCg1uQ28639498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:42:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A23CA52050;
        Fri, 11 Jun 2021 12:42:01 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.83.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CD2C25204F;
        Fri, 11 Jun 2021 12:41:59 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [RFC 2/2] powerpc/selftest: Add support for cpuidle latency measurement
Date:   Fri, 11 Jun 2021 18:11:54 +0530
Message-Id: <20210611124154.56427-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611124154.56427-1-psampat@linux.ibm.com>
References: <20210611124154.56427-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wY7oG4CVDe1zknoZWTl8xzJAoQqqpae2
X-Proofpoint-ORIG-GUID: fZJEnuJb8bInLdbCaUJSfxOJN58NchOR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110080
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
$ sudo make -C tools/testing/selftests \
  TARGETS="powerpc/cpuidle_latency" run_tests

There are a few optional arguments too that the script can take
        [-h <help>]
        [-m <location of the module>]
        [-o <location of the output>]
        [-v <verbose> (run on all cpus)]
Default Output location in:
tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.log

To run the test without re-compiling:
$ cd tools/testing/selftest/powerpc/cpuidle_latency/
$ sudo ./cpuidle_latency.sh

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/cpuidle_latency/.gitignore        |   2 +
 .../powerpc/cpuidle_latency/Makefile          |   6 +
 .../cpuidle_latency/cpuidle_latency.sh        | 419 ++++++++++++++++++
 .../powerpc/cpuidle_latency/settings          |   1 +
 5 files changed, 429 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/Makefile
 create mode 100755 tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/settings

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 0830e63818c1..71ce6fff867d 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -17,6 +17,7 @@ SUB_DIRS = alignment		\
 	   benchmarks		\
 	   cache_shape		\
 	   copyloops		\
+	   cpuidle_latency	\
 	   dscr			\
 	   mm			\
 	   nx-gzip		\
diff --git a/tools/testing/selftests/powerpc/cpuidle_latency/.gitignore b/tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
new file mode 100644
index 000000000000..987f8852dc59
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+cpuidle_latency.log
diff --git a/tools/testing/selftests/powerpc/cpuidle_latency/Makefile b/tools/testing/selftests/powerpc/cpuidle_latency/Makefile
new file mode 100644
index 000000000000..04492b6d2582
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := cpuidle_latency.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh b/tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
new file mode 100755
index 000000000000..6b55167de488
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
@@ -0,0 +1,419 @@
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
+LOG=cpuidle_latency.log
+MODULE=/lib/modules/$(uname -r)/kernel/arch/powerpc/kernel/test-cpuidle_latency.ko
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+VERBOSE=0
+
+DISABLE=1
+ENABLE=0
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
+	while getopts ht:m:o:vt:it: arg
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
+			v) # Verbose mode - all threads of the CPU
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
+extract_state_information()
+{
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		state_name=$(cat /sys/devices/system/cpu/cpu0/cpuidle/state$state/name)
+		state_name_arr+=($state_name)
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
+		echo -e "---Enabling state: ${state_name_arr[$state]}---" >> $LOG
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
+		echo -e "Observed Avg IPI latency(ns) - State ${state_name_arr[$state]}: $avg" | tee -a $LOG
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
+		echo -e "---Enabling state: ${state_name_arr[$state]}---" >> $LOG
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
+		echo -e "Observed Avg timeout diff(ns) - State ${state_name_arr[$state]}: $avg" | tee -a $LOG
+		cpuidle_disable_state $state
+	done
+}
+
+declare -a residency_arr
+declare -a latency_arr
+declare -a core_arr
+declare -a first_core_arr
+declare -a state_name_arr
+
+parse_arguments $@
+
+rm -f $LOG
+touch $LOG
+NUM_CPUS=$(nproc --all)
+NUM_STATES=$(ls -1 /sys/devices/system/cpu/cpu0/cpuidle/ | wc -l)
+
+extract_core_information
+extract_state_information
+
+ins_mod $MODULE
+
+run_ipi_tests
+run_timeout_tests
+
+# Enable all idle states for all CPUs
+op_cpuidle $ENABLE
+printf "Removing $MODULE module\n"
+printf "Full Output logged at: $LOG\n"
+rmmod $MODULE
+
diff --git a/tools/testing/selftests/powerpc/cpuidle_latency/settings b/tools/testing/selftests/powerpc/cpuidle_latency/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.17.1

