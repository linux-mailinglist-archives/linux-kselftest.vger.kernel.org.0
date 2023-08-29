Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1057278C2DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Aug 2023 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjH2LAV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Aug 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjH2LAS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Aug 2023 07:00:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF0CE1;
        Tue, 29 Aug 2023 04:00:03 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TAZr7F017311;
        Tue, 29 Aug 2023 10:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=UnEPuqXCcxkFoafK36U0rpv6LykHOUb2/GhqdepPOi8=;
 b=Bgo2C0X1ryz5QhQ2YP9Yn+FxiVbRlSX8hmAWMLVWaqb9LSwgM0iAwqv9yJyB10M8Rm86
 4bppP5qhhZMKBQVN4Q1R7KTh39GexYN0oKL20dc0UyGoPD/I8Tp0DJETPGETDHDbA7Vr
 F5kQs45A6Js9bNVqE16KCjKemthnrIn4PuRlmz8unnrldiWFayL0ny9U4RBBDjagPM3t
 imrd2k5cxULs4yRXXoYLdT88BIGy37CYWDqlgOvShZ9YULQwfxjLdnCj6QFJAYnnVmBB
 2PuywVhgYKfv7jKmZKj+FXCOlzBfPfoLoODq6zOewU6p8m2QOOz0NTc4QNpVgYTK09oQ zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hsdtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 10:59:42 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TAtYqb002618;
        Tue, 29 Aug 2023 10:59:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr87hsdta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 10:59:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9jlJk014342;
        Tue, 29 Aug 2023 10:59:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn2syn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 10:59:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TAxdeX59965924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 10:59:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 584DE2004D;
        Tue, 29 Aug 2023 10:59:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3ACE20040;
        Tue, 29 Aug 2023 10:59:36 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue, 29 Aug 2023 10:59:36 +0000 (GMT)
Date:   Tue, 29 Aug 2023 16:29:36 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, rmclure@linux.ibm.com,
        arnd@arndb.de, joel@jms.id.au, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com,
        sshegde@linux.vnet.ibm.com
Subject: Re: [RFC v2 1/2] powerpc/cpuidle: cpuidle wakeup latency based on
 IPI and timer events
Message-ID: <20230829105936.GJ1694454@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230828061530.126588-1-aboorvad@linux.vnet.ibm.com>
 <20230828061530.126588-2-aboorvad@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230828061530.126588-2-aboorvad@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9QSNaTiH-W2jFATdER_OXVi_5i_FXapv
X-Proofpoint-GUID: c_w3t40jSMjbPIpcyCSKZMW1d-czUWBj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Aboorva Devarajan <aboorvad@linux.vnet.ibm.com> [2023-08-28 11:45:29]:

> From: Pratik R. Sampat <psampat@linux.ibm.com>
> 
> Introduce a mechanism to fire directed IPIs from a source CPU to a
> specified target CPU and measure the time incurred on waking up the
> target CPU in response.
> 
> Also, introduce a mechanism to queue a hrtimer on a specified CPU and
> subsequently measure the time taken to wakeup the CPU.
> 
> Define a simple debugfs interface that allows for adjusting the
> settings to trigger IPI and timer events on a designated CPU, and to
> observe the resulting cpuidle wakeup latencies.
> 
> Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig.debug                 |  10 ++
>  arch/powerpc/kernel/Makefile               |   1 +
>  arch/powerpc/kernel/test_cpuidle_latency.c | 156 +++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 arch/powerpc/kernel/test_cpuidle_latency.c
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 2a54fadbeaf5..e175fc3028ac 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -391,3 +391,13 @@ config KASAN_SHADOW_OFFSET
>  	default 0xe0000000 if PPC32
>  	default 0xa80e000000000000 if PPC_BOOK3S_64
>  	default 0xa8001c0000000000 if PPC_BOOK3E_64
> +
> +config CPUIDLE_LATENCY_SELFTEST
> +	tristate "Cpuidle latency selftests"
> +	depends on CPU_IDLE
> +	help
> +	  Provides a kernel module that run tests using the IPI and
> +	  timers to measure cpuidle latency.
> +
> +	  Say M if you want these self tests to build as a module.
> +	  Say N if you are unsure.
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 2919433be355..3205ecbd9d8f 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>  obj-$(CONFIG_PPC_DAWR)		+= dawr.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
> +obj-$(CONFIG_CPUIDLE_LATENCY_SELFTEST)  += test_cpuidle_latency.o

This line is now introduced in between CONFIG_PPC_BOOK3S_64 objects.
May be its better this was added such that CONFIG_PPC_BOOK3S_64 objects
are all together.

>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
>  obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_64e.o
> diff --git a/arch/powerpc/kernel/test_cpuidle_latency.c b/arch/powerpc/kernel/test_cpuidle_latency.c
> new file mode 100644
> index 000000000000..3c3c119389c1
> --- /dev/null
> +++ b/arch/powerpc/kernel/test_cpuidle_latency.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Module-based API test facility for cpuidle latency using IPIs and timers
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +/*
> + * IPI based wakeup latencies
> + * Measure time taken for a CPU to wakeup on a IPI sent from another CPU
> + * The latency measured also includes the latency of sending the IPI
> + */
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

NIT: The above line could have been part of the declaration itself.

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
> +/*
> + * Timer based wakeup latencies
> + * Measure time taken for a CPU to wakeup on a timer being armed and fired
> + */
> +struct timer_data {
> +	unsigned int src_cpu;
> +	u64 timeout;
> +	ktime_t time_start;
> +	ktime_t time_end;
> +	struct hrtimer timer;
> +	u64 timeout_diff_ns;
> +} timer_wakeup;
> +
> +static enum hrtimer_restart hrtimer_callback(struct hrtimer *hrtimer)
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

No need to break the above line.

> +	timer_wakeup.timer.function = hrtimer_callback;
> +	timer_wakeup.src_cpu = smp_processor_id();
> +	timer_wakeup.timeout = ns;
> +	timer_wakeup.time_start = ktime_get();
> +
> +	hrtimer_start(&timer_wakeup.timer, ns_to_ktime(ns),
> +		      HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static struct dentry *dir;
> +
> +static int cpu_read_op(void *data, u64 *dest_cpu)
> +{
> +	*dest_cpu = ipi_wakeup.dest_cpu;
> +	return 0;
> +}
> +
> +/*
> + * Send a directed IPI from the current CPU (source) to the destination CPU and
> + * measure the latency on wakeup.
> + */
> +static int cpu_write_op(void *data, u64 value)
> +{
> +	run_smp_call_function_test(value);
> +	return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(ipi_ops, cpu_read_op, cpu_write_op, "%llu\n");
> +
> +static int timeout_read_op(void *data, u64 *timeout)
> +{
> +	*timeout = timer_wakeup.timeout;
> +	return 0;
> +}
> +
> +/* Queue a hrtimer on a specified desitination CPU and measure the time taken to
> + * wakeup the CPU.
> + */
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
> +	dir = debugfs_create_dir("latency_test", arch_debugfs_dir);
> +	if (!dir) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/powerpc/latency_test\n");
> +		return -1;
> +	}
> +	temp = debugfs_create_file("ipi_cpu_dest", 0644, dir, NULL, &ipi_ops);
> +	if (!temp) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/powerpc/ipi_cpu_dest\n");
> +		return -1;
> +	}
> +	debugfs_create_u64("ipi_latency_ns", 0444, dir, &ipi_wakeup.latency_ns);
> +	debugfs_create_u32("ipi_cpu_src", 0444, dir, &ipi_wakeup.src_cpu);
> +
> +	temp = debugfs_create_file("timeout_expected_ns", 0644, dir, NULL, &timeout_ops);
> +	if (!temp) {
> +		pr_alert("latency_test: failed to create /sys/kernel/debug/powerpc/timeout_expected_ns\n");
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
> -- 
> 2.25.1
> 
Otherwise looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
