Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC6D217230
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgGGPaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:30:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbgGGP34 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:29:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067F4UqJ009718;
        Tue, 7 Jul 2020 11:29:30 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32486d0kaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 11:29:29 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067F6VF2016407;
        Tue, 7 Jul 2020 15:29:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7uk2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 15:29:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067FTPWI41877654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 15:29:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A81AE055;
        Tue,  7 Jul 2020 15:29:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12373AE045;
        Tue,  7 Jul 2020 15:29:23 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.70.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 15:29:22 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftest/cpuidle: Add support for cpuidle latency measurement
Date:   Tue,  7 Jul 2020 20:59:17 +0530
Message-Id: <20200707152917.10652-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200707152917.10652-1-psampat@linux.ibm.com>
References: <20200707152917.10652-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070109
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
 tools/testing/selftests/cpuidle/cpuidle.sh | 240 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   1 +
 4 files changed, 248 insertions(+)
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
index 000000000000..11666fe47c34
--- /dev/null
+++ b/tools/testing/selftests/cpuidle/cpuidle.sh
@@ -0,0 +1,240 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+LOG=cpuidle.log
+MODULE=/lib/modules/$(uname -r)/kernel/drivers/cpuidle/test-cpuidle_latency.ko
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
+		exit 2
+	fi
+	printf "Inserting $MODULE module\n\n"
+	insmod $MODULE
+	if [ $? != 0 ]; then
+		printf "Insmod $MODULE failed\n"
+		exit 2
+	fi
+}
+
+compute_average()
+{
+	arr=("$@")
+	sum=0
+	size=${#arr[@]}
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
+		for ((state=0; state<NUM_STATES; state++))
+		do
+			echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable
+		done
+	done
+}
+
+# Enable the idle state supplied
+# $1: State to enable
+enable_state()
+{
+	for ((cpu=0; cpu<NUM_CPUS; cpu++))
+	do
+		echo 0 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$1/disable
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
+# Run the IPI test
+# $1 run for baseline - busy cpu or regular environment
+# $2 destination cpu
+ipi_test_once()
+{
+        dest_cpu=$2
+        if [ "$1" = "baseline" ]; then
+			# Keep the CPU busy
+			taskset -c $dest_cpu yes "" > /dev/null &
+			yes_pid=$!
+        fi
+        taskset 0x1 echo $dest_cpu > /sys/kernel/debug/latency_test/ipi_cpu_dest
+        ipi_latency=$(cat /sys/kernel/debug/latency_test/ipi_latency_ns)
+        src_cpu=$(cat /sys/kernel/debug/latency_test/ipi_cpu_src)
+        if [ "$1" = "baseline" ]; then
+			kill $yes_pid
+			wait $yes_pid 2>/dev/null
+        fi
+}
+
+# Incrementally Enable idle states one by one and compute the latency
+run_ipi_tests()
+{
+        extract_latency
+        disable_idle
+        declare -a avg_arr
+        declare -a baseline_avg_array
+
+        echo -e "--IPI Latency Test---" >> $LOG
+        for ((state=0; state<NUM_STATES; state++))
+        do
+			echo -e "---Enabling state: $state---" >> $LOG
+			enable_state $state
+			printf "%s %10s %12s %12s\n" "SRC_CPU" "DEST_CPU" "Base_IPI_Latency(ns)" "IPI_Latency(ns)" >> $LOG
+			unset avg_arr
+			unset baseline_avg_arr
+			for ((cpu=0; cpu<NUM_CPUS; cpu++))
+			do
+				# Running IPI test and logging results
+				ipi_test_once "baseline" $cpu
+				baseline_ipi_latency=$ipi_latency
+				ipi_test_once "test" $cpu
+				printf "%-3s %10s %12s %18s\n" $src_cpu $cpu $baseline_ipi_latency $ipi_latency >> $LOG
+				avg_arr+=($ipi_latency)
+				baseline_avg_arr+=($baseline_ipi_latency)
+			done
+			compute_average "${avg_arr[@]}"
+			local avg_latency=$avg
+			compute_average "${baseline_avg_arr[@]}"
+			local baseline_avg_latency=$avg
+			echo -e "Expected IPI latency(ns): ${latency_arr[$state]}" >> $LOG
+			echo -e "Baseline Average IPI latency(ns): $baseline_avg_latency" >> $LOG
+			echo -e "Observed Average IPI latency(ns): $avg_latency" >> $LOG
+        done
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
+		taskset -c $dest_cpu yes "" > /dev/null &
+		yes_pid=$!
+	fi
+	taskset -c $dest_cpu echo $3 > /sys/kernel/debug/latency_test/timeout_expected_ns
+	sleep 0.1
+	timeout_diff=$(cat /sys/kernel/debug/latency_test/timeout_diff_ns)
+	src_cpu=$(cat /sys/kernel/debug/latency_test/timeout_cpu_src)
+	if [ "$1" = "baseline" ]; then
+		kill $yes_pid
+		wait $yes_pid 2>/dev/null
+	fi
+}
+
+run_timeout_tests()
+{
+	extract_residency
+	disable_idle
+	declare -a avg_arr
+	declare -a baseline_avg_arr
+	echo -e "\n--Timeout Latency Test--" >> $LOG
+
+	for ((state=0; state<NUM_STATES; state++))
+	do
+		echo -e "---Enabling state: $state---" >> $LOG
+		enable_state $state
+		printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)" "Delay(ns)" >> $LOG
+		unset avg_arr
+		unset baseline_avg_arr
+		for ((cpu=0; cpu<NUM_CPUS; cpu++))
+		do
+			timeout_test_once "baseline" $cpu ${residency_arr[$state]}
+			local baseline_timeout_diff=$timeout_diff
+			timeout_test_once "test" $cpu ${residency_arr[$state]}
+			printf "%-3s %13s %18s\n" $src_cpu $baseline_timeout_diff $timeout_diff >> $LOG
+			avg_arr+=($timeout_diff)
+			baseline_avg_arr+=($baseline_timeout_diff)
+		done
+		compute_average "${baseline_avg_arr[@]}"
+		local baseline_avg=$avg
+		compute_average "${avg_arr[@]}"
+		echo -e "Expected timeout(ns): ${residency_arr[$state]}" >> $LOG
+		echo -e "Baseline Average timeout diff(ns): $baseline_avg" >> $LOG
+		echo -e "Observed Average timeout diff(ns): $avg" >> $LOG
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

