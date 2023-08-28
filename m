Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3AB78A594
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjH1GQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjH1GP6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 02:15:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53D1BF;
        Sun, 27 Aug 2023 23:15:54 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37S5ohm3021832;
        Mon, 28 Aug 2023 06:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f5vYyEM6sFjbjkcD2j1OT450eJyBoOZeLtxrAJF1Ubk=;
 b=rt/4nlwYgrc5AWc7tOwl8uD5B/4LkULOyXG0o4Z/jDfQgY7d10IlC8yi/g3CT+4W8U7i
 JfBqbhtQSQAKJMliBiHyKbpBSBpnYMFuBT+9CY3vhz9+MkPb1sMW0LXEYS4uj7O6PClO
 cm7/LoEfp/G/1AD38utHJUeRJQJP4uNDjhD6ryDY5Wso8hvcp4PQRPta/CVJVes2Th8q
 /ZRy+efjxDNtXTydGdz706oY1k88T4MGT0D0bE9tzCesi0ADxz/0/TsJgyCXpLErsv80
 E+uNd4IvmmGQCVNGzW8W5FXPsn3ICuvu76p4drQaEzSkME/zHeYQrWmh4WxdjUUKSDnE qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr64rpkkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:15:42 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37S5k5Me005797;
        Mon, 28 Aug 2023 06:15:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr64rpkk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:15:42 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37S50TVZ009903;
        Mon, 28 Aug 2023 06:15:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7k0a9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 06:15:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37S6Fcpi19595998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 06:15:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A18FA2004E;
        Mon, 28 Aug 2023 06:15:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6348520040;
        Mon, 28 Aug 2023 06:15:36 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.in.ibm.com (unknown [9.204.200.131])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Aug 2023 06:15:36 +0000 (GMT)
From:   Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
To:     aboorvad@linux.vnet.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        rmclure@linux.ibm.com, arnd@arndb.de, joel@jms.id.au,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
Subject: [RFC v2 2/2] powerpc/selftest: Add support for cpuidle latency measurement
Date:   Mon, 28 Aug 2023 11:45:30 +0530
Message-Id: <20230828061530.126588-3-aboorvad@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230828061530.126588-1-aboorvad@linux.vnet.ibm.com>
References: <20230828061530.126588-1-aboorvad@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LWCuxF9UqkzygDbG23oiUdQMjhX4UCrp
X-Proofpoint-ORIG-GUID: 17r0P8jBrsz8TlYmdnK69mqhhzNVSLeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_03,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Pratik R. Sampat <psampat@linux.ibm.com>

The cpuidle latency selftest provides support to systematically extract,
analyse and present IPI and timer based wakeup latencies for each CPU
and each idle state available on the system.

The selftest leverages test_cpuidle_latency module's debugfs interface
to interact and extract latency information from the kernel.

The selftest inserts the module if already not inserted, disables all
the idle states and enables them one by one testing the following:

1. Keeping source CPU constant, iterate through all the cores and pick
   a single CPU for each core measuring IPI latency for baseline
   (CPU is busy with cat /dev/random > /dev/null workload) and then
   when the CPU is idle.
2. Iterating through all the CPU cores and selecting one CPU for each
   core, then, the expected timer durations to be equivalent to the
   residency of the deepest idle state enabled is sent to the selected
   target CPU, then the difference between the expected timer duration
   and the time of wakeup is determined.

To run this test specifically:
$ sudo make -C tools/testing/selftests \
  TARGETS="powerpc/cpuidle_latency" run_tests

There are a few optional arguments too that the script can take
        [-h <help>]
        [-i <run timer tests>]
        [-m <location of the module>]
        [-s <source cpu for ipi test>]
        [-o <location of the output>]
        [-v <verbose> (run on all cpus)]

Default Output location in:
tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.log

To run the test without re-compiling:
$ cd tools/testing/selftest/powerpc/cpuidle_latency/
$ sudo ./cpuidle_latency.sh

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/cpuidle_latency/.gitignore        |   2 +
 .../powerpc/cpuidle_latency/Makefile          |   6 +
 .../cpuidle_latency/cpuidle_latency.sh        | 443 ++++++++++++++++++
 .../powerpc/cpuidle_latency/settings          |   1 +
 5 files changed, 453 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/Makefile
 create mode 100755 tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/settings

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 49f2ad1793fd..efac7270ce1f 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -17,6 +17,7 @@ SUB_DIRS = alignment		\
 	   benchmarks		\
 	   cache_shape		\
 	   copyloops		\
+	   cpuidle_latency	\
 	   dexcr		\
 	   dscr			\
 	   mm			\
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
index 000000000000..f7b7a9dc2e08
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
@@ -0,0 +1,443 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# CPU-Idle latency selftest enables systematic retrieval and presentation
+# of IPI and timer-triggered wake-up latencies for every CPU and available
+# system idle state by leveraging the test_cpuidle_latency module.
+#
+# Author: Pratik R. Sampat  <psampat at linux.ibm.com>
+# Author: Aboorva Devarajan <aboorvad at linux.ibm.com>
+
+DISABLE=1
+ENABLE=0
+
+LOG=cpuidle_latency.log
+MODULE=/lib/modules/$(uname -r)/kernel/arch/powerpc/kernel/test_cpuidle_latency.ko
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+exit_status=0
+
+RUN_TIMER_TEST=1
+TIMEOUT=1000000
+VERBOSE=0
+
+IPI_SRC_CPU=0
+
+helpme() {
+    printf "Usage: %s [-h] [-todg args]
+	[-h <help>]
+	[-s <source cpu for ipi test> (default: 0)]
+	[-m <location of the module>]
+	[-o <location of the output>]
+	[-v <verbose> (execute test across all CPU threads)]
+	[-i <run timer tests>]
+	\n" "$0"
+    exit 2
+}
+
+cpu_is_online() {
+    local cpu=$1
+    if [ ! -f "/sys/devices/system/cpu/cpu$cpu/online" ]; then
+        printf "CPU %s: file not found: /sys/devices/system/cpu/cpu%s/online" "$cpu" "$cpu"
+        return 0
+    fi
+    status=$(cat /sys/devices/system/cpu/cpu"$cpu"/online)
+    return "$status"
+}
+
+check_valid_cpu() {
+    local cpu="$1"
+    local cpu_count
+
+    cpu_count="$(nproc)" # Get the number of CPUs on the system
+
+    if [[ "$cpu" =~ ^[0-9]+$ ]]; then
+        if ((cpu >= 0 && cpu < cpu_count)); then
+            cpu_is_online "$cpu"
+            online_status=$?
+            if [ "$online_status" -eq "1" ]; then
+                return 1
+            else
+                printf "CPU %s is offline." "$cpu"
+                return 0
+            fi
+        fi
+    fi
+    return 0
+}
+
+parse_arguments() {
+    while getopts ht:m:s:o:vt:it: arg; do
+        case $arg in
+        h) # --help
+            helpme
+            ;;
+        m) # --mod-file
+            MODULE=$OPTARG
+            ;;
+        s) #
+            IPI_SRC_CPU=$OPTARG
+            check_valid_cpu "$IPI_SRC_CPU"
+            cpu_status=$?
+            if [ "$cpu_status" == "0" ]; then
+                printf "%s is an invalid CPU. Exiting.." "$IPI_SRC_CPU"
+                exit
+            fi
+            ;;
+        o) # output log files
+            LOG=$OPTARG
+            ;;
+        v) # verbose mode - execute tests across all CPU threads
+            VERBOSE=1
+            ;;
+        i) # run timer tests
+            RUN_TIMER_TEST=1
+            ;;
+        \?)
+            helpme
+            ;;
+        esac
+    done
+}
+
+ins_mod() {
+    debugfs_file=/sys/kernel/debug/powerpc/latency_test/ipi_latency_ns
+    # Check if the module is already loaded
+    if [ -f "$debugfs_file" ]; then
+        printf "Module %s already loaded\n\n" "$MODULE"
+        return 0
+    fi
+    # Try to load the module
+    if [ ! -f "$MODULE" ]; then
+        printf "%s module does not exist. Exiting\n" "$MODULE"
+        exit $ksft_skip
+    fi
+    printf "Inserting %s module\n\n" "$MODULE"
+    insmod "$MODULE"
+    if [ $? != 0 ]; then
+        printf "Insmod %s failed\n" "$MODULE"
+        exit $ksft_skip
+    fi
+}
+
+compute_average() {
+    arr=("$@")
+    sum=0
+    size=${#arr[@]}
+    if [ "$size" == 0 ]; then
+        avg=0
+        return 1
+    fi
+    for i in "${arr[@]}"; do
+        sum=$((sum + i))
+    done
+    avg=$((sum / size))
+}
+
+# Perform operation on each CPU for the given state
+# $1 - Operation: enable (0) / disable (1)
+# $2 - State to enable
+op_state() {
+    for ((cpu = 0; cpu < NUM_CPUS; cpu++)); do
+        cpu_is_online "$cpu"
+        local cpu_status=$?
+        if [ "$cpu_status" == 0 ]; then
+            continue
+        fi
+        echo "$1" >/sys/devices/system/cpu/cpu"$cpu"/cpuidle/state"$2"/disable
+    done
+}
+
+cpuidle_enable_state() {
+    state=$1
+    op_state "$ENABLE" "$state"
+}
+
+cpuidle_disable_state() {
+    state=$1
+    op_state "$DISABLE" "$state"
+}
+
+# Enable/Disable all stop states for all CPUs
+# $1 - Operation: enable (0) / disable (1)
+op_cpuidle() {
+    for ((state = 0; state < NUM_STATES; state++)); do
+        op_state "$1" "$state"
+    done
+}
+
+extract_state_information() {
+    for ((state = 0; state < NUM_STATES; state++)); do
+        state_name=$(cat /sys/devices/system/cpu/cpu"$IPI_SRC_CPU"/cpuidle/state"$state"/name)
+        state_name_arr+=("$state_name")
+    done
+}
+
+# Extract latency in microseconds and convert to nanoseconds
+extract_latency() {
+    for ((state = 0; state < NUM_STATES; state++)); do
+        latency=$(($(cat /sys/devices/system/cpu/cpu"$IPI_SRC_CPU"/cpuidle/state"$state"/latency) * 1000))
+        latency_arr+=("$latency")
+    done
+}
+
+# Simple linear search in an array
+# $1 - Element to search for
+# $2 - Array
+element_in() {
+    local item="$1"
+    shift
+    for element in "$@"; do
+        if [ "$element" == "$item" ]; then
+            return 0
+        fi
+    done
+    return 1
+}
+
+# Parse and return a cpuset with ","(individual) and "-" (range) of CPUs
+# $1 - cpuset string
+parse_cpuset() {
+    echo "$1" | awk '/-/{for (i=$1; i<=$2; i++)printf "%s%s",i,ORS;next} 1' RS=, FS=-
+}
+
+extract_core_information() {
+    declare -a thread_arr
+    for ((cpu = 0; cpu < NUM_CPUS; cpu++)); do
+        cpu_is_online "$cpu"
+        local cpu_status=$?
+        if [ "$cpu_status" == 0 ]; then
+            continue
+        fi
+
+        siblings=$(cat /sys/devices/system/cpu/cpu"$cpu"/topology/thread_siblings_list)
+        sib_arr=()
+
+        for c in $(parse_cpuset "$siblings"); do
+            sib_arr+=("$c")
+        done
+
+        if [ "$VERBOSE" == 1 ]; then
+            core_arr+=("$cpu")
+            continue
+        fi
+        element_in "${sib_arr[0]}" "${thread_arr[@]}"
+        if [ $? == 0 ]; then
+            continue
+        fi
+        core_arr+=("${sib_arr[0]}")
+
+        for thread in "${sib_arr[@]}"; do
+            thread_arr+=("$thread")
+        done
+    done
+
+    src_siblings=$(cat /sys/devices/system/cpu/cpu"$IPI_SRC_CPU"/topology/thread_siblings_list)
+    for c in $(parse_cpuset "$src_siblings"); do
+        first_core_arr+=("$c")
+    done
+}
+
+# Run the IPI test
+# $1 run for baseline - busy cpu or regular environment
+# $2 destination cpu
+ipi_test_once() {
+    dest_cpu=$2
+    if [ "$1" = "baseline" ]; then
+        # Keep the CPU busy
+        taskset -c "$dest_cpu" cat /dev/random >/dev/null &
+        task_pid=$!
+        # Wait for the workload to achieve 100% CPU usage
+        sleep 1
+    fi
+    taskset -c "$IPI_SRC_CPU" echo "$dest_cpu" >/sys/kernel/debug/powerpc/latency_test/ipi_cpu_dest
+    ipi_latency=$(cat /sys/kernel/debug/powerpc/latency_test/ipi_latency_ns)
+    src_cpu=$(cat /sys/kernel/debug/powerpc/latency_test/ipi_cpu_src)
+    if [ "$1" = "baseline" ]; then
+        kill "$task_pid"
+        wait "$task_pid" 2>/dev/null
+    fi
+}
+
+# Incrementally enable idle states one by one and compute the latency
+run_ipi_tests() {
+    extract_latency
+    # Disable idle states for CPUs
+    op_cpuidle "$DISABLE"
+
+    declare -a avg_arr
+    printf "...IPI Latency Test...\n" | tee -a "$LOG"
+
+    printf "...Baseline IPI Latency measurement: CPU Busy...\n" >>"$LOG"
+    printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >>"$LOG"
+    for cpu in "${core_arr[@]}"; do
+        cpu_is_online "$cpu"
+        local cpu_status=$?
+        if [ "$cpu_status" == 0 ]; then
+            continue
+        fi
+        ipi_test_once "baseline" "$cpu"
+        printf "%-3s %10s %12s\n" "$src_cpu" "$cpu" "$ipi_latency" >>"$LOG"
+        # Skip computing latency average from the source CPU to avoid bias
+        element_in "$cpu" "${first_core_arr[@]}"
+        if [ $? == 0 ]; then
+            continue
+        fi
+        avg_arr+=("$ipi_latency")
+    done
+    compute_average "${avg_arr[@]}"
+    printf "Baseline Avg IPI latency(ns): %s\n" "$avg" | tee -a "$LOG"
+
+    for ((state = 0; state < NUM_STATES; state++)); do
+        unset avg_arr
+        printf "...Enabling state: %s...\n" "${state_name_arr[$state]}" >>"$LOG"
+        cpuidle_enable_state $state
+        printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >>"$LOG"
+        for cpu in "${core_arr[@]}"; do
+            cpu_is_online "$cpu"
+            local cpu_status=$?
+            if [ "$cpu_status" == 0 ]; then
+                continue
+            fi
+            # Running IPI test and logging results
+            sleep 1
+            ipi_test_once "test" "$cpu"
+            printf "%-3s %10s %12s\n" "$src_cpu" "$cpu" "$ipi_latency" >>"$LOG"
+            # Skip computing latency average from the source CPU to avoid bias
+            element_in "$cpu" "${first_core_arr[@]}"
+            if [ $? == 0 ]; then
+                continue
+            fi
+            avg_arr+=("$ipi_latency")
+        done
+
+        compute_average "${avg_arr[@]}"
+        printf "Expected IPI latency(ns): %s\n" "${latency_arr[$state]}" >>"$LOG"
+        printf "Observed Avg IPI latency(ns) - State %s: %s\n" "${state_name_arr[$state]}" "$avg" | tee -a "$LOG"
+        cpuidle_disable_state $state
+    done
+}
+
+# Extract the residency in microseconds and convert to nanoseconds.
+# Add 200 ns so that the timer stays for a little longer than the residency
+extract_residency() {
+    for ((state = 0; state < NUM_STATES; state++)); do
+        residency=$(($(cat /sys/devices/system/cpu/cpu"$IPI_SRC_CPU"/cpuidle/state"$state"/residency) * 1000 + 200))
+        residency_arr+=("$residency")
+    done
+}
+
+# Run the Timeout test
+# $1 run for baseline - busy cpu or regular environment
+# $2 destination cpu
+# $3 timeout
+timeout_test_once() {
+    dest_cpu=$2
+    if [ "$1" = "baseline" ]; then
+        # Keep the CPU busy
+        taskset -c "$dest_cpu" cat /dev/random >/dev/null &
+        task_pid=$!
+        # Wait for the workload to achieve 100% CPU usage
+        sleep 1
+    fi
+    taskset -c "$dest_cpu" sleep 1
+    taskset -c "$dest_cpu" echo "$3" >/sys/kernel/debug/powerpc/latency_test/timeout_expected_ns
+    # Wait for the result to populate
+    sleep 0.1
+    timeout_diff=$(cat /sys/kernel/debug/powerpc/latency_test/timeout_diff_ns)
+    src_cpu=$(cat /sys/kernel/debug/powerpc/latency_test/timeout_cpu_src)
+    if [ "$1" = "baseline" ]; then
+        kill "$task_pid"
+        wait "$task_pid" 2>/dev/null
+    fi
+}
+
+run_timeout_tests() {
+    extract_residency
+    # Disable idle states for all CPUs
+    op_cpuidle "$DISABLE"
+
+    declare -a avg_arr
+    printf "\n...Timeout Latency Test...\n" | tee -a "$LOG"
+
+    printf "...Baseline Timeout Latency measurement: CPU Busy...\n" >>"$LOG"
+    printf "%s %10s\n" "Wakeup_src" "Baseline_delay(ns)" >>"$LOG"
+    for cpu in "${core_arr[@]}"; do
+        cpu_is_online "$cpu"
+        local cpu_status=$?
+        if [ "$cpu_status" == 0 ]; then
+            continue
+        fi
+        timeout_test_once "baseline" "$cpu" "$TIMEOUT"
+        printf "%-3s %13s\n" "$src_cpu" "$timeout_diff" >>"$LOG"
+        avg_arr+=("$timeout_diff")
+    done
+    compute_average "${avg_arr[@]}"
+    printf "Baseline Avg timeout diff(ns): %s\n" "$avg" | tee -a "$LOG"
+
+    for ((state = 0; state < NUM_STATES; state++)); do
+        unset avg_arr
+        printf "...Enabling state: %s...\n" "${state_name_arr["$state"]}" >>"$LOG"
+        cpuidle_enable_state "$state"
+        printf "%s %10s\n" "Wakeup_src" "Delay(ns)" >>"$LOG"
+        for cpu in "${core_arr[@]}"; do
+            cpu_is_online "$cpu"
+            local cpu_status=$?
+            if [ "$cpu_status" == 0 ]; then
+                continue
+            fi
+            timeout_test_once "test" "$cpu" "$TIMEOUT"
+            printf "%-3s %13s\n" "$src_cpu" "$timeout_diff" >>"$LOG"
+            avg_arr+=("$timeout_diff")
+        done
+        compute_average "${avg_arr[@]}"
+        printf "Expected timeout(ns): %s\n" "${residency_arr["$state"]}" >>"$LOG"
+        printf "Observed Avg timeout diff(ns) - State %s: %s\n" "${state_name_arr["$state"]}" "$avg" | tee -a "$LOG"
+        cpuidle_disable_state "$state"
+    done
+}
+
+# Function to exit the test if not intended
+exit_test() {
+    printf "Exiting the test. Test not intended to run.\n"
+    exit "$ksft_skip"
+}
+
+printf "Running this test enables all CPU idle states by the time it concludes.\n"
+printf "Note: This test does not restore previous idle state.\n"
+
+declare -a residency_arr
+declare -a latency_arr
+declare -a core_arr
+declare -a first_core_arr
+declare -a state_name_arr
+
+parse_arguments "$@"
+
+rm -f "$LOG"
+touch "$LOG"
+
+NUM_CPUS=$(nproc --all)
+NUM_STATES=$(ls -1 /sys/devices/system/cpu/cpu"$IPI_SRC_CPU"/cpuidle/ | wc -l)
+
+extract_core_information
+extract_state_information
+
+ins_mod "$MODULE"
+
+run_ipi_tests
+if [ "$RUN_TIMER_TEST" == "1" ]; then
+    run_timeout_tests
+fi
+
+# Enable all idle states for all CPUs
+op_cpuidle $ENABLE
+printf "Removing %s module\n" "$MODULE"
+printf "Full Output logged at: %s\n" "$LOG"
+
+if [ -f "$MODULE" ]; then
+    rmmod "$MODULE"
+fi
+
+exit "$exit_status"
diff --git a/tools/testing/selftests/powerpc/cpuidle_latency/settings b/tools/testing/selftests/powerpc/cpuidle_latency/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/powerpc/cpuidle_latency/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.25.1

