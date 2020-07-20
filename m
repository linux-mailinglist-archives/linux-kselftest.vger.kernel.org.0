Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B612256E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 07:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgGTFBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 01:01:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgGTFBV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 01:01:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K4WqDN159661;
        Mon, 20 Jul 2020 01:00:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32buddgyqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 01:00:53 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06K50HTU036012;
        Mon, 20 Jul 2020 01:00:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32buddgyq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 01:00:52 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06K4oqWC009851;
        Mon, 20 Jul 2020 05:00:51 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 32brq8pbt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 05:00:51 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06K50oPr31457780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 05:00:50 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D256A05A;
        Mon, 20 Jul 2020 05:00:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D9876A063;
        Mon, 20 Jul 2020 05:00:49 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.23.82])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 05:00:49 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 9A6F42E3225; Mon, 20 Jul 2020 10:30:43 +0530 (IST)
Date:   Mon, 20 Jul 2020 10:30:43 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpuidle: Trace IPI based and timer based wakeup
 latency from idle states
Message-ID: <20200720050043.GA31497@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200717091801.29289-1-psampat@linux.ibm.com>
 <20200717091801.29289-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717091801.29289-2-psampat@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_01:2020-07-17,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200029
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 17, 2020 at 02:48:00PM +0530, Pratik Rajesh Sampat wrote:
> Fire directed smp_call_function_single IPIs from a specified source
> CPU to the specified target CPU to reduce the noise we have to wade
> through in the trace log.
> The module is based on the idea written by Srivatsa Bhat and maintained
> by Vaidyanathan Srinivasan internally.
> 
> Queue HR timer and measure jitter. Wakeup latency measurement for idle
> states using hrtimer.  Echo a value in ns to timer_test_function and
> watch trace. A HRtimer will be queued and when it fires the expected
> wakeup vs actual wakeup is computes and delay printed in ns.
> 
> Implemented as a module which utilizes debugfs so that it can be
> integrated with selftests.
> 
> To include the module, check option and include as module
> kernel hacking -> Cpuidle latency selftests
> 
> [srivatsa.bhat@linux.vnet.ibm.com: Initial implementation in
>  cpidle/sysfs]
> 
> [svaidy@linux.vnet.ibm.com: wakeup latency measurements using hrtimer
>  and fix some of the time calculation]
> 
> [ego@linux.vnet.ibm.com: Fix some whitespace and tab errors and
>  increase the resolution of IPI wakeup]
> 
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>


The debugfs module looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


> ---
>  drivers/cpuidle/Makefile               |   1 +
>  drivers/cpuidle/test-cpuidle_latency.c | 150 +++++++++++++++++++++++++
>  lib/Kconfig.debug                      |  10 ++
>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
> 
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index f07800cbb43f..2ae05968078c 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
>  obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
>  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
>  obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
> +obj-$(CONFIG_IDLE_LATENCY_SELFTEST)	  += test-cpuidle_latency.o
> 
>  ##################################################################################
>  # ARM SoC drivers
> diff --git a/drivers/cpuidle/test-cpuidle_latency.c b/drivers/cpuidle/test-cpuidle_latency.c
> new file mode 100644
> index 000000000000..61574665e972
> --- /dev/null
> +++ b/drivers/cpuidle/test-cpuidle_latency.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Module-based API test facility for cpuidle latency using IPIs and timers
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +/* IPI based wakeup latencies */
> +struct latency {
> +	unsigned int src_cpu;
> +	unsigned int dest_cpu;
> +	ktime_t time_start;
> +	ktime_t time_end;
> +	u64 latency_ns;
> +} ipi_wakeup;
> +
> +static void measure_latency(void *info)
> +{
> +	struct latency *v;
> +	ktime_t time_diff;
> +
> +	v = (struct latency *)info;
> +	v->time_end = ktime_get();
> +	time_diff = ktime_sub(v->time_end, v->time_start);
> +	v->latency_ns = ktime_to_ns(time_diff);
> +}
> +
> +void run_smp_call_function_test(unsigned int cpu)
> +{
> +	ipi_wakeup.src_cpu = smp_processor_id();
> +	ipi_wakeup.dest_cpu = cpu;
> +	ipi_wakeup.time_start = ktime_get();
> +	smp_call_function_single(cpu, measure_latency, &ipi_wakeup, 1);
> +}
> +
> +/* Timer based wakeup latencies */
> +struct timer_data {
> +	unsigned int src_cpu;
> +	u64 timeout;
> +	ktime_t time_start;
> +	ktime_t time_end;
> +	struct hrtimer timer;
> +	u64 timeout_diff_ns;
> +} timer_wakeup;
> +
> +static enum hrtimer_restart timer_called(struct hrtimer *hrtimer)
> +{
> +	struct timer_data *w;
> +	ktime_t time_diff;
> +
> +	w = container_of(hrtimer, struct timer_data, timer);
> +	w->time_end = ktime_get();
> +
> +	time_diff = ktime_sub(w->time_end, w->time_start);
> +	time_diff = ktime_sub(time_diff, ns_to_ktime(w->timeout));
> +	w->timeout_diff_ns = ktime_to_ns(time_diff);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void run_timer_test(unsigned int ns)
> +{
> +	hrtimer_init(&timer_wakeup.timer, CLOCK_MONOTONIC,
> +		     HRTIMER_MODE_REL);
> +	timer_wakeup.timer.function = timer_called;
> +	timer_wakeup.time_start = ktime_get();
> +	timer_wakeup.src_cpu = smp_processor_id();
> +	timer_wakeup.timeout = ns;
> +
> +	hrtimer_start(&timer_wakeup.timer, ns_to_ktime(ns),
> +		      HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static struct dentry *dir;
> +
> +static int cpu_read_op(void *data, u64 *value)
> +{
> +	*value = ipi_wakeup.dest_cpu;
> +	return 0;
> +}
> +
> +static int cpu_write_op(void *data, u64 value)
> +{
> +	run_smp_call_function_test(value);
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(ipi_ops, cpu_read_op, cpu_write_op, "%llu\n");
> +
> +static int timeout_read_op(void *data, u64 *value)
> +{
> +	*value = timer_wakeup.timeout;
> +	return 0;
> +}
> +
> +static int timeout_write_op(void *data, u64 value)
> +{
> +	run_timer_test(value);
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(timeout_ops, timeout_read_op, timeout_write_op, "%llu\n");
> +
> +static int __init latency_init(void)
> +{
> +	struct dentry *temp;
> +
> +	dir = debugfs_create_dir("latency_test", 0);
> +	if (!dir) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/latency_test\n");
> +		return -1;
> +	}
> +	temp = debugfs_create_file("ipi_cpu_dest",
> +				   0666,
> +				   dir,
> +				   NULL,
> +				   &ipi_ops);
> +	if (!temp) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/ipi_cpu_dest\n");
> +		return -1;
> +	}
> +	debugfs_create_u64("ipi_latency_ns", 0444, dir, &ipi_wakeup.latency_ns);
> +	debugfs_create_u32("ipi_cpu_src", 0444, dir, &ipi_wakeup.src_cpu);
> +
> +	temp = debugfs_create_file("timeout_expected_ns",
> +				   0666,
> +				   dir,
> +				   NULL,
> +				   &timeout_ops);
> +	if (!temp) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/timeout_expected_ns\n");
> +		return -1;
> +	}
> +	debugfs_create_u64("timeout_diff_ns", 0444, dir, &timer_wakeup.timeout_diff_ns);
> +	debugfs_create_u32("timeout_cpu_src", 0444, dir, &timer_wakeup.src_cpu);
> +	pr_info("Latency Test module loaded\n");
> +	return 0;
> +}
> +
> +static void __exit latency_cleanup(void)
> +{
> +	pr_info("Cleaning up Latency Test module.\n");
> +	debugfs_remove_recursive(dir);
> +}
> +
> +module_init(latency_init);
> +module_exit(latency_cleanup);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_DESCRIPTION("Measuring idle latency for IPIs and Timers");
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d74ac0fd6b2d..e2283790245a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1375,6 +1375,16 @@ config DEBUG_KOBJECT
>  	  If you say Y here, some extra kobject debugging messages will be sent
>  	  to the syslog.
> 
> +config IDLE_LATENCY_SELFTEST
> +	tristate "Cpuidle latency selftests"
> +	depends on CPU_IDLE
> +	help
> +	  This option provides a kernel module that runs tests using the IPI and
> +	  timers to measure latency.
> +
> +	  Say M if you want these self tests to build as a module.
> +	  Say N if you are unsure.
> +
>  config DEBUG_KOBJECT_RELEASE
>  	bool "kobject release debugging"
>  	depends on DEBUG_OBJECTS_TIMERS
> -- 
> 2.25.4
> 
