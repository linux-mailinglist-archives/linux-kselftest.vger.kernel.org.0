Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C790A225742
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 07:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTFxP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 01:53:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgGTFxO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 01:53:14 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K5WXq2125187;
        Mon, 20 Jul 2020 01:52:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqu82e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 01:52:50 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K5WkPI128547;
        Mon, 20 Jul 2020 01:52:50 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqu82dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 01:52:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K5kHJv023042;
        Mon, 20 Jul 2020 05:52:48 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 32brq8tar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 05:52:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K5qlHI65602012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 05:52:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80DB07805C;
        Mon, 20 Jul 2020 05:52:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1DE7805E;
        Mon, 20 Jul 2020 05:52:46 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.23.82])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 05:52:46 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id A98DC2E3225; Mon, 20 Jul 2020 11:22:42 +0530 (IST)
Date:   Mon, 20 Jul 2020 11:22:42 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftest/cpuidle: Add support for cpuidle latency
 measurement
Message-ID: <20200720055242.GB31497@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200717091801.29289-1-psampat@linux.ibm.com>
 <20200717091801.29289-3-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717091801.29289-3-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_01:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200040
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,


On Fri, Jul 17, 2020 at 02:48:01PM +0530, Pratik Rajesh Sampat wrote:
> This patch adds support to trace IPI based and timer based wakeup
> latency from idle states
> 
> Latches onto the test-cpuidle_latency kernel module using the debugfs
> interface to send IPIs or schedule a timer based event, which in-turn
> populates the debugfs with the latency measurements.
> 
> Currently for the IPI and timer tests; first disable all idle states
> and then test for latency measurements incrementally enabling each state
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

A few comments below.

> ---
>  tools/testing/selftests/Makefile           |   1 +
>  tools/testing/selftests/cpuidle/Makefile   |   6 +
>  tools/testing/selftests/cpuidle/cpuidle.sh | 257 +++++++++++++++++++++
>  tools/testing/selftests/cpuidle/settings   |   1 +
>  4 files changed, 265 insertions(+)
>  create mode 100644 tools/testing/selftests/cpuidle/Makefile
>  create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
>  create mode 100644 tools/testing/selftests/cpuidle/settings
> 

[..skip..]

> +
> +ins_mod()
> +{
> +	if [ ! -f "$MODULE" ]; then
> +		printf "$MODULE module does not exist. Exitting\n"

If the module has been compiled into the kernel (due to a
localyesconfig, for instance), then it is unlikely that we will find
it in /lib/modules. Perhaps you want to check if the debugfs
directories created by the module exist, and if so, print a message
saying that the modules is already loaded or some such?

> +		exit $ksft_skip
> +	fi
> +	printf "Inserting $MODULE module\n\n"
> +	insmod $MODULE
> +	if [ $? != 0 ]; then
> +		printf "Insmod $MODULE failed\n"
> +		exit $ksft_skip
> +	fi
> +}
> +
> +compute_average()
> +{
> +	arr=("$@")
> +	sum=0
> +	size=${#arr[@]}
> +	for i in "${arr[@]}"
> +	do
> +		sum=$((sum + i))
> +	done
> +	avg=$((sum/size))

It would be good to assert that "size" isn't 0 here.

> +}
> +
> +# Disable all stop states
> +disable_idle()
> +{
> +	for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +	do
> +		for ((state=0; state<NUM_STATES; state++))
> +		do
> +			echo 1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$state/disable

So, on offlined CPUs, we won't see
/sys/devices/system/cpu/cpu$cpu/cpuidle/state$state directory. You
should probably perform this operation only on online CPUs.


> +		done
> +	done
> +}
> +
> +# Perform operation on each CPU for the given state
> +# $1 - Operation: enable (0) / disable (1)
> +# $2 - State to enable
> +op_state()
> +{
> +	for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +	do
> +		echo $1 > /sys/devices/system/cpu/cpu$cpu/cpuidle/state$2/disable


Ditto

> +	done
> +}

This is a helper function. For better readability of the main code you
can define the following wrappers and use them.


cpuidle_enable_state()
{
	state=$1
	op_state 1 $state
}

cpuidle_disable_state()
{
	state=$1
	op_state 0 $state

}


> +

[..snip..]

> +run_ipi_tests()
> +{
> +        extract_latency
> +        disable_idle
> +        declare -a avg_arr
> +        echo -e "--IPI Latency Test---" >> $LOG
> +
> +		echo -e "--Baseline IPI Latency measurement: CPU Busy--" >> $LOG
> +		printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
> +		for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +		do
> +			ipi_test_once "baseline" $cpu
> +			printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
> +			avg_arr+=($ipi_latency)
> +		done
> +		compute_average "${avg_arr[@]}"
> +		echo -e "Baseline Average IPI latency(ns): $avg" >> $LOG
> +
> +        for ((state=0; state<NUM_STATES; state++))
> +        do
> +			unset avg_arr
> +			echo -e "---Enabling state: $state---" >> $LOG
> +			op_state 0 $state
> +			printf "%s %10s %12s\n" "SRC_CPU" "DEST_CPU" "IPI_Latency(ns)" >> $LOG
> +			for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +			do

If a CPU is offline, then we should skip it here.

> +				# Running IPI test and logging results
> +				sleep 1
> +				ipi_test_once "test" $cpu
> +				printf "%-3s %10s %12s\n" $src_cpu $cpu $ipi_latency >> $LOG
> +				avg_arr+=($ipi_latency)
> +			done
> +			compute_average "${avg_arr[@]}"
> +			echo -e "Expected IPI latency(ns): ${latency_arr[$state]}" >> $LOG
> +			echo -e "Observed Average IPI latency(ns): $avg" >> $LOG
> +			op_state 1 $state
> +        done
> +}
> +
> +# Extract the residency in microseconds and convert to nanoseconds.
> +# Add 100 ns so that the timer stays for a little longer than the residency
> +extract_residency()
> +{
> +	for ((state=0; state<NUM_STATES; state++))
> +	do
> +		residency=$(($(cat /sys/devices/system/cpu/cpu0/cpuidle/state$state/residency) * 1000 + 200))
> +		residency_arr+=($residency)
> +	done
> +}
> +
> +# Run the Timeout test
> +# $1 run for baseline - busy cpu or regular environment
> +# $2 destination cpu
> +# $3 timeout
> +timeout_test_once()
> +{
> +	dest_cpu=$2
> +	if [ "$1" = "baseline" ]; then
> +		# Keep the CPU busy
> +		taskset -c $dest_cpu cat /dev/random > /dev/null &
> +		task_pid=$!
> +		# Wait for the workload to achieve 100% CPU usage
> +		sleep 1
> +	fi
> +	taskset -c $dest_cpu echo $3 > /sys/kernel/debug/latency_test/timeout_expected_ns
> +	# Wait for the result to populate
> +	sleep 0.1
> +	timeout_diff=$(cat /sys/kernel/debug/latency_test/timeout_diff_ns)
> +	src_cpu=$(cat /sys/kernel/debug/latency_test/timeout_cpu_src)
> +	if [ "$1" = "baseline" ]; then
> +		kill $task_pid
> +		wait $task_pid 2>/dev/null
> +	fi
> +}
> +
> +run_timeout_tests()
> +{
> +	extract_residency
> +	disable_idle
> +	declare -a avg_arr
> +	echo -e "\n--Timeout Latency Test--" >> $LOG
> +
> +	echo -e "--Baseline Timeout Latency measurement: CPU Busy--" >> $LOG
> +	printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)">> $LOG
> +	for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +	do

Again only perform this on online CPUs.

> +		timeout_test_once "baseline" $cpu ${residency_arr[0]}
> +		printf "%-3s %13s\n" $src_cpu $timeout_diff >> $LOG
> +		avg_arr+=($timeout_diff)
> +	done
> +	compute_average "${avg_arr[@]}"
> +	echo -e "Baseline Average timeout diff(ns): $avg" >> $LOG
> +
> +	for ((state=0; state<NUM_STATES; state++))
> +	do

> +		echo -e "---Enabling state: $state---" >> $LOG
> +		op_state 0 $state
> +		printf "%s %10s %10s\n" "Wakeup_src" "Baseline_delay(ns)" "Delay(ns)" >> $LOG
> +		unset avg_arr
> +		for ((cpu=0; cpu<NUM_CPUS; cpu++))
> +		do

Ditto.

> +			timeout_test_once "test" $cpu ${residency_arr[$state]}
> +			printf "%-3s %13s %18s\n" $src_cpu $baseline_timeout_diff $timeout_diff >> $LOG
> +			avg_arr+=($timeout_diff)
> +		done
> +		compute_average "${avg_arr[@]}"
> +		echo -e "Expected timeout(ns): ${residency_arr[$state]}" >> $LOG
> +		echo -e "Observed Average timeout diff(ns): $avg" >> $LOG
> +		op_state 1 $state
> +	done
> +}
> +

--
Thanks and Regards
gautham.
