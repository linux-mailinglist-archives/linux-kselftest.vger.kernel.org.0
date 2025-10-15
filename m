Return-Path: <linux-kselftest+bounces-43165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA87BDCC4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE193B0DF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 06:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE27A31326B;
	Wed, 15 Oct 2025 06:40:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD43126CE;
	Wed, 15 Oct 2025 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510434; cv=none; b=tlHskyFuxrX4PZESdCL6dlmdE174+WIHQoHv8H8TLjQ1ud1lLPqLdnS/vIe3x1nKIz9mHA+9Iq7o9Bb44cTBmGoooxRykBYpSvBeIgaOO3jLI7wlUH9gfmcJgs8fGGevTMqatQAW3gqc0OybcemLny0V98ZaSH/JEJG7fn7EPoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510434; c=relaxed/simple;
	bh=WKmoCAdhwJeXGa3LefrmfEnCthO+1fO4s7DJYsIMQTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S0tfa3xL5fsHoYl2XY2UiVb1jlWUq0lZzmwlCiep68kdBZLOD9DNeacLfYl3XR2RmpkewhcN37StpCwwb3vGrVoWqnzsCOCQz6Q5Z86a+x4sTRz5VZhkycsbOW2/ztYKcr7R9Czj+B51SMf1azFBJ9L2M1f0lMSCHib+5mrV+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
	<lance.yang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>, Jonathan
 Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
	<liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>, Phil
 Auld <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Russell King
	<linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt
	<rostedt@goodmis.org>
Subject: [PATCH][v4] hung_task: Panic when there are more than N hung tasks at the same time
Date: Wed, 15 Oct 2025 14:36:15 +0800
Message-ID: <20251015063615.2632-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc9.internal.baidu.com (172.31.3.19) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Currently, when 'hung_task_panic' is enabled, the kernel panics
immediately upon detecting the first hung task. However, some hung
tasks are transient and allow system recovery, while persistent hangs
should trigger a panic when accumulating beyond a threshold.

Extend the 'hung_task_panic' sysctl to accept a threshold value
specifying the number of hung tasks that must be detected before
triggering a kernel panic. This provides finer control for environments
where transient hangs may occur but persistent hangs should be fatal.

The sysctl now accepts:
- 0: don't panic (maintains original behavior)
- 1: panic on first hung task (maintains original behavior)
- N > 1: panic after N hung tasks are detected in a single scan

This maintains backward compatibility while providing flexibility for
different hang scenarios.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Florian Wesphal <fw@strlen.de>
Cc: Jakub Kacinski <kuba@kernel.org>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
diff with v3: comments modification, suggested by Lance, Masami, Randy and Petr
diff with v2: do not add a new sysctl, extend hung_task_panic, suggested by Kees Cook

 Documentation/admin-guide/kernel-parameters.txt      | 20 +++++++++++++-------
 Documentation/admin-guide/sysctl/kernel.rst          |  9 +++++----
 arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
 kernel/configs/debug.config                          |  2 +-
 kernel/hung_task.c                                   | 15 ++++++++++-----
 lib/Kconfig.debug                                    |  9 +++++----
 tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
 7 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a51ab46..492f0bc 100644
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
+			When set to a non-zero value, a kernel panic will be triggered if
+			the number of detected hung tasks reaches this value.
+
+			0: don't panic
+			1: panic immediately on first hung task
+			N: panic after N hung tasks are detected in a single scan
 
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
index f3ee807..0065a55 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -397,13 +397,14 @@ a hung task is detected.
 hung_task_panic
 ===============
 
-Controls the kernel's behavior when a hung task is detected.
+When set to a non-zero value, a kernel panic will be triggered if the
+number of hung tasks found during a single scan reaches this value.
 This file shows up if ``CONFIG_DETECT_HUNG_TASK`` is enabled.
 
-= =================================================
+= =======================================================
 0 Continue operation. This is the default behavior.
-1 Panic immediately.
-= =================================================
+N Panic when N hung tasks are found during a single scan.
+= =======================================================
 
 
 hung_task_check_count
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
index b2c1f14..84b4b04 100644
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
 
@@ -229,9 +232,10 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 */
 	sysctl_hung_task_detect_count++;
 
+	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
 	trace_sched_process_hang(t);
 
-	if (sysctl_hung_task_panic) {
+	if (sysctl_hung_task_panic && total_hung_task >= sysctl_hung_task_panic) {
 		console_verbose();
 		hung_task_show_lock = true;
 		hung_task_call_panic = true;
@@ -300,6 +304,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
 	struct task_struct *g, *t;
+	unsigned long prev_detect_count = sysctl_hung_task_detect_count;
 
 	/*
 	 * If the system crashed already then all bets are off,
@@ -320,7 +325,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 
-		check_hung_task(t, timeout);
+		check_hung_task(t, timeout, prev_detect_count);
 	}
  unlock:
 	rcu_read_unlock();
@@ -389,7 +394,7 @@ static const struct ctl_table hung_task_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "hung_task_check_count",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3034e294..3976c90 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1258,12 +1258,13 @@ config DEFAULT_HUNG_TASK_TIMEOUT
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
+	  When set to a non-zero value, a kernel panic will be triggered
+	  if the number of hung tasks found during a single scan reaches
+	  this value.
 
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


