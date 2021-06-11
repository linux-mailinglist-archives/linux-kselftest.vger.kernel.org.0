Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB13A422B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFKMoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:44:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231272AbhFKMoP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:44:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BCXbCi013278;
        Fri, 11 Jun 2021 08:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JhedSqjiHJno7nFv+Mq6xGFzMxPYJSPj48RO97RHbFM=;
 b=lwXL1U1RJxTNN7wpeg8jseEM5Zrm11Rbk1tXTzjC++mH9GH92khEHrkzEjx8hok/WQmV
 UH1ZRiPGUTU98FwhHHkYSksIb06ib6WUe56hRfeBz5a8BY/lprDK6PuXVX17ikM5lapF
 G0XK0RS9aAkIK5l1tyVJW4jLK/G/Ku1NzIIPaGVIx05YROkX4vnnDLvUu/qKpJCWZqrV
 d955k0Iz8Xu3lyA505w0AEUIl2tVDjn4c+YAofxa7cSbItwlrGz4wkWsMPvlSUfFSdVj
 G35EFtjbeL8Txrk7MupFd4Qt+8a2xqSHhw2crhCYK+x1M2kg69L4JhxCUK6E/xLdD2x1 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3947pcgq04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:10 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15BCY43W016082;
        Fri, 11 Jun 2021 08:42:10 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3947pcgpy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BCWbUQ004792;
        Fri, 11 Jun 2021 12:42:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w8becw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 12:42:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BCf7fR35652026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:41:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F36252067;
        Fri, 11 Jun 2021 12:41:59 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.83.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 982735205A;
        Fri, 11 Jun 2021 12:41:57 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [RFC 1/2] powerpc/cpuidle: Extract IPI based and timer based wakeup latency from idle states
Date:   Fri, 11 Jun 2021 18:11:53 +0530
Message-Id: <20210611124154.56427-2-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611124154.56427-1-psampat@linux.ibm.com>
References: <20210611124154.56427-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4rLkOiwQ1o7QlAmkhVGHrnTpQtroRNa1
X-Proofpoint-ORIG-GUID: -FGEv8xzENIjBrC_GDqSohzEYwtQ_UsR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110080
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

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/kernel/Makefile               |   1 +
 arch/powerpc/kernel/test-cpuidle_latency.c | 157 +++++++++++++++++++++
 lib/Kconfig.debug                          |  10 ++
 3 files changed, 168 insertions(+)
 create mode 100644 arch/powerpc/kernel/test-cpuidle_latency.c

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index f66b63e81c3b..56e36e797dd4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_DAWR)		+= dawr.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
+obj-$(CONFIG_IDLE_LATENCY_SELFTEST)	  += test-cpuidle_latency.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
diff --git a/arch/powerpc/kernel/test-cpuidle_latency.c b/arch/powerpc/kernel/test-cpuidle_latency.c
new file mode 100644
index 000000000000..f138011ac225
--- /dev/null
+++ b/arch/powerpc/kernel/test-cpuidle_latency.c
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

