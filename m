Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68C22EDC2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jul 2020 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgG0Nm6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jul 2020 09:42:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgG0Nm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jul 2020 09:42:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id 12so14365526oir.4;
        Mon, 27 Jul 2020 06:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvPzBZVgDAopAS1lI3CQpjCsa8HFcE1uN9uVOKEOSpk=;
        b=CbhG+KFzJTp0GNyOaNgadj1KHsv/FYrggg4LMPQ8+DP9k3+KCwsjyqinyq8922mSAK
         kOuFLIFPTIy6QottnYqKqVccdMe3A9Wv0lAaVogyVCYaZN286d844MBwmZ7JjEfzD4Sz
         8Ml1j2JTBJESG0eMsYJHje7kEO3PHfD0QB9eOveMm8E5L5VyzGTtmeapVfyUZYvcQuIE
         pOumPoLdLbc+cOd35fcYNENW+gAaom9CGqGSwQXL+NXEkDKhwW0tlaCnmOnRluNYMUZV
         Xw6Ak5aZ6jEdiVkVFuR1TSUOIFPNHK+baUHUgAtNeN3H7mdPSz0Vr7imt/aoPRD3mi7B
         DURQ==
X-Gm-Message-State: AOAM531mZ3aU/yvcBMtVUxPQIAJFcQS26gv1GSkZonU5BpqC3Ru717mo
        yZSYwsMWgBQnSIHx1cmSoOpqTpyQXeBRlNXPCbb6kA==
X-Google-Smtp-Source: ABdhPJz0TvSVaNc8ulOS2JvmYwwhi/DIqKubE/aaIFsIH15FU8fiOFKiVgnLscHnh52p8XsoInOL/jOpCFJUMU7AFHE=
X-Received: by 2002:aca:3646:: with SMTP id d67mr6786735oia.68.1595857376945;
 Mon, 27 Jul 2020 06:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200721124300.65615-1-psampat@linux.ibm.com> <20200721124300.65615-2-psampat@linux.ibm.com>
In-Reply-To: <20200721124300.65615-2-psampat@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 15:42:46 +0200
Message-ID: <CAJZ5v0j3ip77opkaW3Rtn0cqT7VTL_8goctFBDVehWoZowDY0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cpuidle: Trace IPI based and timer based wakeup
 latency from idle states
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, srivatsa@csail.mit.edu,
        Shuah Khan <shuah@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        pratik.r.sampat@gmail.com, Linux PM <linux-pm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 21, 2020 at 2:43 PM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
> Fire directed smp_call_function_single IPIs from a specified source
> CPU to the specified target CPU to reduce the noise we have to wade
> through in the trace log.

And what's the purpose of it?

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
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
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
>  obj-$(CONFIG_DT_IDLE_STATES)             += dt_idle_states.o
>  obj-$(CONFIG_ARCH_HAS_CPU_RELAX)         += poll_state.o
>  obj-$(CONFIG_HALTPOLL_CPUIDLE)           += cpuidle-haltpoll.o
> +obj-$(CONFIG_IDLE_LATENCY_SELFTEST)      += test-cpuidle_latency.o
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

I'd like to see a more detailed description of what it does and how it
works here.

> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +/* IPI based wakeup latencies */
> +struct latency {
> +       unsigned int src_cpu;
> +       unsigned int dest_cpu;
> +       ktime_t time_start;
> +       ktime_t time_end;
> +       u64 latency_ns;
> +} ipi_wakeup;
> +
> +static void measure_latency(void *info)
> +{
> +       struct latency *v;
> +       ktime_t time_diff;
> +
> +       v = (struct latency *)info;
> +       v->time_end = ktime_get();
> +       time_diff = ktime_sub(v->time_end, v->time_start);
> +       v->latency_ns = ktime_to_ns(time_diff);
> +}
> +
> +void run_smp_call_function_test(unsigned int cpu)
> +{
> +       ipi_wakeup.src_cpu = smp_processor_id();
> +       ipi_wakeup.dest_cpu = cpu;
> +       ipi_wakeup.time_start = ktime_get();
> +       smp_call_function_single(cpu, measure_latency, &ipi_wakeup, 1);
> +}
> +
> +/* Timer based wakeup latencies */
> +struct timer_data {
> +       unsigned int src_cpu;
> +       u64 timeout;
> +       ktime_t time_start;
> +       ktime_t time_end;
> +       struct hrtimer timer;
> +       u64 timeout_diff_ns;
> +} timer_wakeup;
> +
> +static enum hrtimer_restart timer_called(struct hrtimer *hrtimer)
> +{
> +       struct timer_data *w;
> +       ktime_t time_diff;
> +
> +       w = container_of(hrtimer, struct timer_data, timer);
> +       w->time_end = ktime_get();
> +
> +       time_diff = ktime_sub(w->time_end, w->time_start);
> +       time_diff = ktime_sub(time_diff, ns_to_ktime(w->timeout));
> +       w->timeout_diff_ns = ktime_to_ns(time_diff);
> +       return HRTIMER_NORESTART;
> +}
> +
> +static void run_timer_test(unsigned int ns)
> +{
> +       hrtimer_init(&timer_wakeup.timer, CLOCK_MONOTONIC,
> +                    HRTIMER_MODE_REL);
> +       timer_wakeup.timer.function = timer_called;
> +       timer_wakeup.time_start = ktime_get();
> +       timer_wakeup.src_cpu = smp_processor_id();
> +       timer_wakeup.timeout = ns;
> +
> +       hrtimer_start(&timer_wakeup.timer, ns_to_ktime(ns),
> +                     HRTIMER_MODE_REL_PINNED);
> +}
> +
> +static struct dentry *dir;
> +
> +static int cpu_read_op(void *data, u64 *value)
> +{
> +       *value = ipi_wakeup.dest_cpu;
> +       return 0;
> +}
> +
> +static int cpu_write_op(void *data, u64 value)
> +{
> +       run_smp_call_function_test(value);
> +       return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(ipi_ops, cpu_read_op, cpu_write_op, "%llu\n");
> +
> +static int timeout_read_op(void *data, u64 *value)
> +{
> +       *value = timer_wakeup.timeout;
> +       return 0;
> +}
> +
> +static int timeout_write_op(void *data, u64 value)
> +{
> +       run_timer_test(value);
> +       return 0;
> +}
> +DEFINE_SIMPLE_ATTRIBUTE(timeout_ops, timeout_read_op, timeout_write_op, "%llu\n");
> +
> +static int __init latency_init(void)
> +{
> +       struct dentry *temp;
> +
> +       dir = debugfs_create_dir("latency_test", 0);
> +       if (!dir) {
> +               pr_alert("latency_test: failed to create /sys/kernel/debug/latency_test\n");
> +               return -1;
> +       }
> +       temp = debugfs_create_file("ipi_cpu_dest",
> +                                  0666,
> +                                  dir,
> +                                  NULL,
> +                                  &ipi_ops);
> +       if (!temp) {
> +               pr_alert("latency_test: failed to create /sys/kernel/debug/ipi_cpu_dest\n");
> +               return -1;
> +       }
> +       debugfs_create_u64("ipi_latency_ns", 0444, dir, &ipi_wakeup.latency_ns);
> +       debugfs_create_u32("ipi_cpu_src", 0444, dir, &ipi_wakeup.src_cpu);
> +
> +       temp = debugfs_create_file("timeout_expected_ns",
> +                                  0666,
> +                                  dir,
> +                                  NULL,
> +                                  &timeout_ops);
> +       if (!temp) {
> +               pr_alert("latency_test: failed to create /sys/kernel/debug/timeout_expected_ns\n");
> +               return -1;
> +       }
> +       debugfs_create_u64("timeout_diff_ns", 0444, dir, &timer_wakeup.timeout_diff_ns);
> +       debugfs_create_u32("timeout_cpu_src", 0444, dir, &timer_wakeup.src_cpu);
> +       pr_info("Latency Test module loaded\n");
> +       return 0;
> +}
> +
> +static void __exit latency_cleanup(void)
> +{
> +       pr_info("Cleaning up Latency Test module.\n");
> +       debugfs_remove_recursive(dir);
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
>           If you say Y here, some extra kobject debugging messages will be sent
>           to the syslog.
>
> +config IDLE_LATENCY_SELFTEST
> +       tristate "Cpuidle latency selftests"
> +       depends on CPU_IDLE
> +       help
> +         This option provides a kernel module that runs tests using the IPI and
> +         timers to measure latency.

What latency does it measure?

> +
> +         Say M if you want these self tests to build as a module.
> +         Say N if you are unsure.
> +
>  config DEBUG_KOBJECT_RELEASE
>         bool "kobject release debugging"
>         depends on DEBUG_OBJECTS_TIMERS
> --
> 2.25.4
>
