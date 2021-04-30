Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639B836F718
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhD3I3J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 04:29:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229567AbhD3I3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 04:29:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U8EQTl136402;
        Fri, 30 Apr 2021 04:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d4ejJtMn0li974lzolazyEfC6NO7uMkEjhIgsfZYdxI=;
 b=iobN7EWqcpeA6ES8K/TB/mnbl9KB+kdZmuvwiwhbzGo7ds6kP1KcI9XtzqOyvdkA8fcW
 JY/+Dj8wA4hfreyUPaOBlH+fRd0kJb3HvuPvmaD8Y3+RBu64pxN+1DF0L5xlO/lqYwee
 10/T2CH7xXainc7DGNt4Xc68XNgNS0p4QdVHBCl7Tm/lKQohyyf+KQRAHJBd6h9CU+57
 EEMXsU5ha0W6RHuoskc5HnVC6hc6jio30LflYsMUuGF66tUMYr4BjRbHMUi2CyM7tMD1
 kx83w25xhL8Dn7+GTLOx9XwYvZPkaCtBZZ0K6LF8BfAutIj3mhiMrfCfRkbWIae+FC8Z /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 388e730ckc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:15 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13U8EwlY137772;
        Fri, 30 Apr 2021 04:28:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 388e730cjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13U8JtDQ010928;
        Fri, 30 Apr 2021 08:28:13 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 384ay8jy9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 08:28:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13U8SAkf23986608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 08:28:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C715D5204E;
        Fri, 30 Apr 2021 08:28:10 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.87.236])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 84E1552057;
        Fri, 30 Apr 2021 08:28:08 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        dsmythies@telus.net, dedekind1@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com, psampat@linux.ibm.com
Subject: [PATCH v5 1/2] cpuidle: Extract IPI based and timer based wakeup latency from idle states
Date:   Fri, 30 Apr 2021 13:58:03 +0530
Message-Id: <20210430082804.38018-2-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210430082804.38018-1-psampat@linux.ibm.com>
References: <20210430082804.38018-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iiYTePqsirEd5dXaKiknQxiQjQM71FEG
X-Proofpoint-ORIG-GUID: n-tIih4FZnWReI6nJi5QaPj2zgyxXDb1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_05:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300056
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a mechanism to fire directed IPIs from a specified source CPU
to a specified target CPU and measure the difference in time incurred on
wakeup.

Also, introduce a mechanism to queue a HR timer on a specified CPU and
subsequently measure the time taken to wakeup the CPU.

Finally define a simple debugfs interface to control the knobs to fire
the IPI and Timer events on specified CPU and view their incurred idle
wakeup latencies.

CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpuidle/Makefile               |   1 +
 drivers/cpuidle/test-cpuidle_latency.c | 157 +++++++++++++++++++++++++
 lib/Kconfig.debug                      |  10 ++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c

diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 26bbc5e74123..3b4ee06a9164 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 obj-$(CONFIG_HALTPOLL_CPUIDLE)		  += cpuidle-haltpoll.o
+obj-$(CONFIG_IDLE_LATENCY_SELFTEST)	  += test-cpuidle_latency.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpuidle/test-cpuidle_latency.c b/drivers/cpuidle/test-cpuidle_latency.c
new file mode 100644
index 000000000000..f138011ac225
--- /dev/null
+++ b/drivers/cpuidle/test-cpuidle_latency.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module-based API test facility for cpuidle latency using IPIs and timers
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+/*
+ * IPI based wakeup latencies
+ * Measure time taken for a CPU to wakeup on a IPI sent from another CPU
+ * The latency measured also includes the latency of sending the IPI
+ */
+struct latency {
+	unsigned int src_cpu;
+	unsigned int dest_cpu;
+	ktime_t time_start;
+	ktime_t time_end;
+	u64 latency_ns;
+} ipi_wakeup;
+
+static void measure_latency(void *info)
+{
+	struct latency *v;
+	ktime_t time_diff;
+
+	v = (struct latency *)info;
+	v->time_end = ktime_get();
+	time_diff = ktime_sub(v->time_end, v->time_start);
+	v->latency_ns = ktime_to_ns(time_diff);
+}
+
+void run_smp_call_function_test(unsigned int cpu)
+{
+	ipi_wakeup.src_cpu = smp_processor_id();
+	ipi_wakeup.dest_cpu = cpu;
+	ipi_wakeup.time_start = ktime_get();
+	smp_call_function_single(cpu, measure_latency, &ipi_wakeup, 1);
+}
+
+/*
+ * Timer based wakeup latencies
+ * Measure time taken for a CPU to wakeup on a timer being armed and fired
+ */
+struct timer_data {
+	unsigned int src_cpu;
+	u64 timeout;
+	ktime_t time_start;
+	ktime_t time_end;
+	struct hrtimer timer;
+	u64 timeout_diff_ns;
+} timer_wakeup;
+
+static enum hrtimer_restart timer_called(struct hrtimer *hrtimer)
+{
+	struct timer_data *w;
+	ktime_t time_diff;
+
+	w = container_of(hrtimer, struct timer_data, timer);
+	w->time_end = ktime_get();
+
+	time_diff = ktime_sub(w->time_end, w->time_start);
+	time_diff = ktime_sub(time_diff, ns_to_ktime(w->timeout));
+	w->timeout_diff_ns = ktime_to_ns(time_diff);
+	return HRTIMER_NORESTART;
+}
+
+static void run_timer_test(unsigned int ns)
+{
+	hrtimer_init(&timer_wakeup.timer, CLOCK_MONOTONIC,
+		     HRTIMER_MODE_REL);
+	timer_wakeup.timer.function = timer_called;
+	timer_wakeup.src_cpu = smp_processor_id();
+	timer_wakeup.timeout = ns;
+	timer_wakeup.time_start = ktime_get();
+
+	hrtimer_start(&timer_wakeup.timer, ns_to_ktime(ns),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+static struct dentry *dir;
+
+static int cpu_read_op(void *data, u64 *dest_cpu)
+{
+	*dest_cpu = ipi_wakeup.dest_cpu;
+	return 0;
+}
+
+static int cpu_write_op(void *data, u64 value)
+{
+	run_smp_call_function_test(value);
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(ipi_ops, cpu_read_op, cpu_write_op, "%llu\n");
+
+static int timeout_read_op(void *data, u64 *timeout)
+{
+	*timeout = timer_wakeup.timeout;
+	return 0;
+}
+
+static int timeout_write_op(void *data, u64 value)
+{
+	run_timer_test(value);
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(timeout_ops, timeout_read_op, timeout_write_op, "%llu\n");
+
+static int __init latency_init(void)
+{
+	struct dentry *temp;
+
+	dir = debugfs_create_dir("latency_test", 0);
+	if (!dir) {
+		pr_alert("latency_test: failed to create /sys/kernel/debug/latency_test\n");
+		return -1;
+	}
+	temp = debugfs_create_file("ipi_cpu_dest",
+				   0666,
+				   dir,
+				   NULL,
+				   &ipi_ops);
+	if (!temp) {
+		pr_alert("latency_test: failed to create /sys/kernel/debug/ipi_cpu_dest\n");
+		return -1;
+	}
+	debugfs_create_u64("ipi_latency_ns", 0444, dir, &ipi_wakeup.latency_ns);
+	debugfs_create_u32("ipi_cpu_src", 0444, dir, &ipi_wakeup.src_cpu);
+
+	temp = debugfs_create_file("timeout_expected_ns",
+				   0666,
+				   dir,
+				   NULL,
+				   &timeout_ops);
+	if (!temp) {
+		pr_alert("latency_test: failed to create /sys/kernel/debug/timeout_expected_ns\n");
+		return -1;
+	}
+	debugfs_create_u64("timeout_diff_ns", 0444, dir, &timer_wakeup.timeout_diff_ns);
+	debugfs_create_u32("timeout_cpu_src", 0444, dir, &timer_wakeup.src_cpu);
+	pr_info("Latency Test module loaded\n");
+	return 0;
+}
+
+static void __exit latency_cleanup(void)
+{
+	pr_info("Cleaning up Latency Test module.\n");
+	debugfs_remove_recursive(dir);
+}
+
+module_init(latency_init);
+module_exit(latency_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("Measuring idle latency for IPIs and Timers");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 417c3d3e521b..70264687e0c2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1513,6 +1513,16 @@ config DEBUG_KOBJECT
 	  If you say Y here, some extra kobject debugging messages will be sent
 	  to the syslog.
 
+config IDLE_LATENCY_SELFTEST
+	tristate "Cpuidle latency selftests"
+	depends on CPU_IDLE
+	help
+	  This option provides a kernel module that runs tests using the IPI and
+	  timers to measure latency.
+
+	  Say M if you want these self tests to build as a module.
+	  Say N if you are unsure.
+
 config DEBUG_KOBJECT_RELEASE
 	bool "kobject release debugging"
 	depends on DEBUG_OBJECTS_TIMERS
-- 
2.17.1

