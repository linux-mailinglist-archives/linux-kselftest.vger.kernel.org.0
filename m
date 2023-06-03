Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381907210FC
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjFCPiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjFCPiT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 11:38:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2416AC;
        Sat,  3 Jun 2023 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806668; x=1717342668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5T+pm8P+lISKQOFFGKzxYoaK4Ah8KfoJWohzT70QPTo=;
  b=lMLItlrRfzx8CrFcWva2uqo9TNEMOxvygbddjM1JX1FHUh+draeFmBXZ
   Pn9+heUNp2pn2wWOrWgbx7FmjMOYj/LfNdWaYdst9We+iRVi4NIrgJO3q
   1fQT+ONRqunHawO1J0YM1axJ/LYSE/WgdJkVhT9NOKn2k1Hi/eQv9HWqH
   3uSF9mG0X2wZuAvQ9zAP6Lp03LWyNh+C7u3f9zj9WKK5KaX7cG1PJ6qIl
   LYi9bSxKOaBRjj7qX2ftso0+F5TltLegi45bPLvS8Knm0V5fhbZNVmft2
   q/8amxdLl/w0srP9RFGrad7QnJd6Bv5NwtxFQYDzYuCYVOuSElxI4Zxvl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="359393541"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="359393541"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="1038278054"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="1038278054"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2023 08:37:30 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        attofari@amazon.de, chang.seok.bae@intel.com
Subject: [PATCH] selftests/x86/amx: Add a CPU hotplug test
Date:   Sat,  3 Jun 2023 08:24:55 -0700
Message-Id: <20230603152455.12444-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <42654300-67cb-254d-22c2-4642a4763ba5@intel.com>
References: <42654300-67cb-254d-22c2-4642a4763ba5@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adamos found the issue with the cached XFD state [1]. Although the XFD
state is reset on the CPU hotplug, the per-CPU XFD cache is missing
the reset. Then, running an AMX thread there, the staled value causes
the kernel crash to kill the thread.

This is reproducible when moving an AMX thread to the hot-plugged CPU.
So, add a test case to ensure no issue with that.

It repeats the test due to possible inconsistencies. Then, along with
the hotplug cost, it will bring a noticeable runtime increase. But,
the overall test has a quick turnaround time.

Link: https://lore.kernel.org/lkml/20230519112315.30616-1-attofari@amazon.de/ [1]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Adamos Ttofari <attofari@amazon.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
The overall x86 selftest via "$ make TARGETS='x86' kselftest" takes
about 3.5 -> 5.5 seconds. 'amx_64' itself took about 1.5 more seconds
over 0.x seconds.

But, this overall runtime still takes in a matter of some seconds,
which should be fine I thought.
---
 tools/testing/selftests/x86/amx.c | 133 ++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd69dd51..6f2f0598c706 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -3,6 +3,7 @@
 #define _GNU_SOURCE
 #include <err.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <pthread.h>
 #include <setjmp.h>
 #include <stdio.h>
@@ -25,6 +26,8 @@
 # error This test is 64-bit only
 #endif
 
+#define BUF_LEN			1000
+
 #define XSAVE_HDR_OFFSET	512
 #define XSAVE_HDR_SIZE		64
 
@@ -239,11 +242,10 @@ static inline uint64_t get_fpx_sw_bytes_features(void *buffer)
 }
 
 /* Work around printf() being unsafe in signals: */
-#define SIGNAL_BUF_LEN 1000
-char signal_message_buffer[SIGNAL_BUF_LEN];
+char signal_message_buffer[BUF_LEN];
 void sig_print(char *msg)
 {
-	int left = SIGNAL_BUF_LEN - strlen(signal_message_buffer) - 1;
+	int left = BUF_LEN - strlen(signal_message_buffer) - 1;
 
 	strncat(signal_message_buffer, msg, left);
 }
@@ -767,15 +769,15 @@ static int create_threads(int num, struct futex_info *finfo)
 	return 0;
 }
 
-static void affinitize_cpu0(void)
+static inline void affinitize_cpu(int cpu)
 {
 	cpu_set_t cpuset;
 
 	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
+	CPU_SET(cpu, &cpuset);
 
 	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
-		fatal_error("sched_setaffinity to CPU 0");
+		fatal_error("sched_setaffinity to CPU %d", cpu);
 }
 
 static void test_context_switch(void)
@@ -784,7 +786,7 @@ static void test_context_switch(void)
 	int i;
 
 	/* Affinitize to one CPU to force context switches */
-	affinitize_cpu0();
+	affinitize_cpu(0);
 
 	req_xtiledata_perm();
 
@@ -926,6 +928,121 @@ static void test_ptrace(void)
 		err(1, "ptrace test");
 }
 
+/* CPU Hotplug test */
+
+static void __hotplug_cpu(int online, int cpu)
+{
+	char buf[BUF_LEN] = {};
+	int fd, rc;
+
+	strncat(buf, "/sys/devices/system/cpu/cpu", BUF_LEN);
+	snprintf(buf + strlen(buf), BUF_LEN - strlen(buf), "%d", cpu);
+	strncat(buf, "/online", BUF_LEN - strlen(buf));
+
+	fd = open(buf, O_RDWR);
+	if (fd == -1)
+		fatal_error("open()");
+
+	snprintf(buf, BUF_LEN, "%d", online);
+	rc = write(fd, buf, strlen(buf));
+	if (rc == -1)
+		fatal_error("write()");
+
+	rc = close(fd);
+	if (rc == -1)
+		fatal_error("close()");
+}
+
+static void offline_cpu(int cpu)
+{
+	__hotplug_cpu(0, cpu);
+}
+
+static void online_cpu(int cpu)
+{
+	__hotplug_cpu(1, cpu);
+}
+
+static jmp_buf jmpbuf;
+
+static void handle_sigsegv(int sig, siginfo_t *si, void *ctx_void)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+#define RETRY 5
+
+/*
+ * Sanity-check the hotplug CPU for its (re-)initialization.
+ *
+ * Create an AMX thread on a CPU, while the hotplug CPU went offline.
+ * Then, plug the offlined back, and move the thread to run on it.
+ *
+ * Repeat this multiple times to ensure no inconsistent failure.
+ * If something goes wrong, the thread will get a signal or killed.
+ */
+static void *switch_cpus(void *arg)
+{
+	int *result = (int *)arg;
+	int i = 0;
+
+	affinitize_cpu(0);
+	offline_cpu(1);
+	load_rand_tiledata(stashed_xsave);
+
+	sethandler(SIGSEGV, handle_sigsegv, SA_ONSTACK);
+	for (i = 0; i < RETRY; i++) {
+		if (i > 0) {
+			affinitize_cpu(0);
+			offline_cpu(1);
+		}
+		if (sigsetjmp(jmpbuf, 1) == 0) {
+			online_cpu(1);
+			affinitize_cpu(1);
+		} else {
+			*result = 1;
+			goto out;
+		}
+	}
+	*result = 0;
+out:
+	clearhandler(SIGSEGV);
+	return result;
+}
+
+static void test_cpuhp(void)
+{
+	int max_cpu_num = sysconf(_SC_NPROCESSORS_ONLN) - 1;
+	void *thread_retval;
+	pthread_t thread;
+	int result, rc;
+
+	if (!max_cpu_num) {
+		printf("[SKIP]\tThe running system has no more CPU for the hotplug test.\n");
+		return;
+	}
+
+	printf("[RUN]\tTest AMX use with the CPU hotplug.\n");
+
+	if (pthread_create(&thread, NULL, switch_cpus, &result))
+		fatal_error("pthread_create()");
+
+	rc = pthread_join(thread, &thread_retval);
+
+	if (rc)
+		fatal_error("pthread_join()");
+
+	/*
+	 * Either an invalid retval or a failed result indicates
+	 * the test failure.
+	 */
+	if (thread_retval != &result || result != 0)
+		printf("[FAIL]\tThe AMX thread had an issue (%s).\n",
+		       thread_retval != &result ? "killed" : "signaled");
+	else
+		printf("[OK]\tThe AMX thread had no issue.\n");
+}
+
 int main(void)
 {
 	/* Check hardware availability at first */
@@ -948,6 +1065,8 @@ int main(void)
 
 	test_ptrace();
 
+	test_cpuhp();
+
 	clearhandler(SIGILL);
 	free_stashed_xsave();
 

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.17.1

