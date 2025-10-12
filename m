Return-Path: <linux-kselftest+bounces-42978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F9BD0195
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D3B3B656D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9232737EA;
	Sun, 12 Oct 2025 11:54:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F16214807;
	Sun, 12 Oct 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760270057; cv=none; b=hB1Ivlh/nLr6j/wAXhw8e/jisT6M16V62mTXCY26Zpk+aT9QTvDuhpkOzcu51tKptYaF2MkYEwNjDsbCOlYd9jeSSyAHt9z+xmCoMti6avpr83NIdKE/6C2N/1HaPidlyDsat5fttHHaxuhAqyuSJRI/jWPPFt1vGFQoqe9S5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760270057; c=relaxed/simple;
	bh=g/lsp42oyDVgXy4RMAqncFSNCkuiqBE+xgpVOAv+6cc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZnvYQIajnYRmJ9tWsqNfP0l+K7/Dg6bWUIqgTWYRlZ5KoCoFR+KBPycDLOLgy6JpveKbEnpLmtAQe7dyF2GbMofZ9gBgZLO9zfcNlZPx8ReLBDUQQyXOreJDSlf7lJWs5M9OybBIA4vpodwPsKmHTPRt+2sJ1fX1GggEpRZV9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>, "Jason A . Donenfeld"
	<Jason@zx2c4.com>, Shuah Khan <shuah@kernel.org>, "Paul E . McKenney"
	<paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>, Randy Dunlap
	<rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Kees Cook <kees@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Li RongQing <lirongqing@baidu.com>, Phil Auld
	<pauld@redhat.com>, Joel Granados <joel.granados@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, Anshuman Khandual
	<anshuman.khandual@arm.com>, Stanislav Fomichev <sdf@fomichev.me>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, Florian
 Westphal <fw@strlen.de>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
Date: Sun, 12 Oct 2025 19:50:35 +0800
Message-ID: <20251012115035.2169-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc11.internal.baidu.com (172.31.51.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently, when 'hung_task_panic' is enabled, the kernel panics
immediately upon detecting the first hung task. However, some hung
tasks are transient and the system can recover, while others are
persistent and may accumulate progressively.

This patch extends the 'hung_task_panic' sysctl to allow specifying
the number of hung tasks that must be detected before triggering
a kernel panic. This provides finer control for environments where
transient hangs may occur but persistent hangs should still be fatal.

The sysctl can be set to:
- 0: disabled (never panic)
- 1: original behavior (panic on first hung task)
- N: panic when N hung tasks are detected

This maintains backward compatibility while providing more flexibility
for handling different hang scenarios.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v2: not add new sysctl, extend hung_task_panic

 Documentation/admin-guide/kernel-parameters.txt      | 20 +++++++++++++-------
 Documentation/admin-guide/sysctl/kernel.rst          |  3 ++-
 arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
 kernel/configs/debug.config                          |  2 +-
 kernel/hung_task.c                                   | 16 +++++++++++-----
 lib/Kconfig.debug                                    | 10 ++++++----
 tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
 7 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a51ab46..7d9a8ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1992,14 +1992,20 @@
 			the added memory block itself do not be affected.
 
 	hung_task_panic=
-			[KNL] Should the hung task detector generate panics.
-			Format: 0 | 1
+			[KNL] Number of hung tasks to trigger kernel panic.
+			Format: <int>
+
+			Set this to the number of hung tasks that must be
+			detected before triggering a kernel panic.
+
+			0: don't panic
+			1: panic immediately on first hung task
+			N: panic after N hung tasks are detect
 
-			A value of 1 instructs the kernel to panic when a
-			hung task is detected. The default value is controlled
-			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
-			option. The value selected by this boot parameter can
-			be changed later by the kernel.hung_task_panic sysctl.
+			The default value is controlled by the
+			CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time option. The value
+			selected by this boot parameter can be changed later by the
+			kernel.hung_task_panic sysctl.
 
 	hvc_iucv=	[S390]	Number of z/VM IUCV hypervisor console (HVC)
 				terminal devices. Valid values: 0..8
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f3ee807..0a8dfab 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -397,7 +397,8 @@ a hung task is detected.
 hung_task_panic
 ===============
 
-Controls the kernel's behavior when a hung task is detected.
+When set to a non-zero value, a kernel panic will be triggered if the
+number of detected hung tasks reaches this value
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
 = =================================================
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 61cee1e..c3b0d5f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -308,7 +308,7 @@ CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_WQ_WATCHDOG=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_FUNCTION_TRACER=y
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e81327d..9f6ab7d 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -83,7 +83,7 @@ CONFIG_SLUB_DEBUG_ON=y
 #
 # Debug Oops, Lockups and Hangs
 #
-# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=0
 # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b2c1f14..3929ed9 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -81,7 +81,7 @@ static unsigned int __read_mostly sysctl_hung_task_all_cpu_backtrace;
  * hung task is detected:
  */
 static unsigned int __read_mostly sysctl_hung_task_panic =
-	IS_ENABLED(CONFIG_BOOTPARAM_HUNG_TASK_PANIC);
+	CONFIG_BOOTPARAM_HUNG_TASK_PANIC;
 
 static int
 hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
@@ -218,8 +218,11 @@ static inline void debug_show_blocker(struct task_struct *task, unsigned long ti
 }
 #endif
 
-static void check_hung_task(struct task_struct *t, unsigned long timeout)
+static void check_hung_task(struct task_struct *t, unsigned long timeout,
+		unsigned long prev_detect_count)
 {
+	unsigned long total_hung_task;
+
 	if (!task_is_hung(t, timeout))
 		return;
 
@@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 */
 	sysctl_hung_task_detect_count++;
 
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic) {
+	if (sysctl_hung_task_panic &&
+			(total_hung_task >= sysctl_hung_task_panic)) {
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
@@ -300,6 +305,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
+	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -320,7 +326,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout);
+		check_hung_task(t, timeout, prev_detect_count);
 	}
  unlock:
 	rcu_read_unlock();
@@ -389,7 +395,7 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "hung_task_check_count",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3034e294..077b9e4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1258,12 +1258,14 @@ config DEFAULT_HUNG_TASK_TIMEOUT
 	  Keeping the default should be fine in most cases.
 
 config BOOTPARAM_HUNG_TASK_PANIC
-	bool "Panic (Reboot) On Hung Tasks"
+	int "Number of hung tasks to trigger kernel panic"
 	depends on DETECT_HUNG_TASK
+	default 0
 	help
-	  Say Y here to enable the kernel to panic on "hung tasks",
-	  which are bugs that cause the kernel to leave a task stuck
-	  in uninterruptible "D" state.
+	  The number of hung tasks must be detected to trigger kernel panic.
+
+	  - 0: Don't trigger panic
+	  - N: Panic when N hung tasks are detected
 
 	  The panic can be used in combination with panic_timeout,
 	  to cause the system to reboot automatically after a
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 936b18b..0504c11 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -81,7 +81,7 @@ CONFIG_WQ_WATCHDOG=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_STACKTRACE=y
 CONFIG_EARLY_PRINTK=y
-- 
2.9.4


