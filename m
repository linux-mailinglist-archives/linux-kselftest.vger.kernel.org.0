Return-Path: <linux-kselftest+bounces-47683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6607CCCAB8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EAA5300B823
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D92DF138;
	Thu, 18 Dec 2025 07:45:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E381A9F93;
	Thu, 18 Dec 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043929; cv=none; b=u8wQLbhkldpw44d3ZPvfyBDMuUmtHSVXRgsBb76xJw1vyJv9aO5XrSUqmtwQiBO6rIA9GBL/vj2lnbmkuCZMd4DWodS3hVWI2X42VTVcLVGGY9KkX/vOjbG3H+PJkPZZYWH2QfLg43R2FpbzRL73Q6QT/ut6EhRLYj0bmZGlCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043929; c=relaxed/simple;
	bh=lIrqEheH75dwIuIbwc3o2Y09PyH6CIX8B0Nts/uv3lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k6j+6BPgwU5z1IduEXTdTbKwgiPNamqD3W0fvjL/Ficm2ES3vGvOgGrBAHCpJhiNPFRd1zt6tPF7VC04LGFn9bDkrVDKJEDhET/VnTe8OUFFGic4+Y3RWZF1jl5vo9Rxg9Fo5PlAr6DPGrHROVvm5DmzGf7hueXTfbiiiQH5cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
	<lance.yang@linux.dev>
CC: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<chleroy@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-openrisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<dri-devel@lists.freedesktop.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <wireguard@lists.zx2c4.com>,
	<netdev@vger.kernel.org>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] watchdog: softlockup: panic when lockup duration exceeds N thresholds
Date: Thu, 18 Dec 2025 02:43:00 -0500
Message-ID: <20251218074300.4080-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

The softlockup_panic sysctl is currently a binary option: panic immediately
or never panic on soft lockups.

Panicking on any soft lockup, regardless of duration, can be overly
aggressive for brief stalls that may be caused by legitimate operations.
Conversely, never panicking may allow severe system hangs to persist
undetected.

Extend softlockup_panic to accept an integer threshold, allowing the kernel
to panic only when the normalized lockup duration exceeds N watchdog
threshold periods. This provides finer-grained control to distinguish
between transient delays and persistent system failures.

The accepted values are:
- 0: Don't panic (unchanged)
- 1: Panic when duration >= 1 * threshold (20s default, original behavior)
- N > 1: Panic when duration >= N * threshold (e.g., 2 = 40s, 3 = 60s.)

The original behavior is preserved for values 0 and 1, maintaining full
backward compatibility while allowing systems to tolerate brief lockups
while still catching severe, persistent hangs.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Diff with v1: add a temp variable thresh_count
              chang config to 0 in kernel/configs/debug.config 
 Documentation/admin-guide/kernel-parameters.txt      | 10 +++++-----
 arch/arm/configs/aspeed_g5_defconfig                 |  2 +-
 arch/arm/configs/pxa3xx_defconfig                    |  2 +-
 arch/openrisc/configs/or1klitex_defconfig            |  2 +-
 arch/powerpc/configs/skiroot_defconfig               |  2 +-
 drivers/gpu/drm/ci/arm.config                        |  2 +-
 drivers/gpu/drm/ci/arm64.config                      |  2 +-
 drivers/gpu/drm/ci/x86_64.config                     |  2 +-
 kernel/configs/debug.config                          |  2 +-
 kernel/watchdog.c                                    | 10 ++++++----
 lib/Kconfig.debug                                    | 13 +++++++------
 tools/testing/selftests/bpf/config                   |  2 +-
 tools/testing/selftests/wireguard/qemu/kernel.config |  2 +-
 13 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8d0afd..27c5f96 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6934,12 +6934,12 @@ Kernel parameters
 
 	softlockup_panic=
 			[KNL] Should the soft-lockup detector generate panics.
-			Format: 0 | 1
+			Format: <int>
 
-			A value of 1 instructs the soft-lockup detector
-			to panic the machine when a soft-lockup occurs. It is
-			also controlled by the kernel.softlockup_panic sysctl
-			and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
+			A value of non-zero instructs the soft-lockup detector
+			to panic the machine when a soft-lockup duration exceeds
+			N thresholds. It is also controlled by the kernel.softlockup_panic
+			sysctl and CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC, which is the
 			respective build-time switch to that functionality.
 
 	softlockup_all_cpu_backtrace=
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 2e6ea13..ec558e5 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -306,7 +306,7 @@ CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_WQ_WATCHDOG=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 07d422f..fb272e3 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -100,7 +100,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SHIRQ=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index fb1eb9a..984b0e3 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -52,5 +52,5 @@ CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,bpf"
 CONFIG_PRINTK_TIME=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BUG_ON_DATA_CORRUPTION=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 2b71a6d..a4114fc 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -289,7 +289,7 @@ CONFIG_SCHED_STACK_END_CHECK=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_WQ_WATCHDOG=y
diff --git a/drivers/gpu/drm/ci/arm.config b/drivers/gpu/drm/ci/arm.config
index 411e814..d7c5167 100644
--- a/drivers/gpu/drm/ci/arm.config
+++ b/drivers/gpu/drm/ci/arm.config
@@ -52,7 +52,7 @@ CONFIG_TMPFS=y
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_LOCKDEP=n
 CONFIG_SOFTLOCKUP_DETECTOR=n
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=n
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=0
 
 CONFIG_FW_LOADER_COMPRESS=y
 
diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index fddfbd4..ea0e307 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -161,7 +161,7 @@ CONFIG_TMPFS=y
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_LOCKDEP=n
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 
 CONFIG_DETECT_HUNG_TASK=y
 
diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
index 8eaba388..7ac98a7 100644
--- a/drivers/gpu/drm/ci/x86_64.config
+++ b/drivers/gpu/drm/ci/x86_64.config
@@ -47,7 +47,7 @@ CONFIG_TMPFS=y
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_LOCKDEP=n
 CONFIG_SOFTLOCKUP_DETECTOR=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 
 CONFIG_DETECT_HUNG_TASK=y
 
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index 9f6ab7d..774702591 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -84,7 +84,7 @@ CONFIG_SLUB_DEBUG_ON=y
 # Debug Oops, Lockups and Hangs
 #
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=0
-# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=0
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 0685e3a..8168e0d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -363,7 +363,7 @@ static struct cpumask watchdog_allowed_mask __read_mostly;
 
 /* Global variables, exported for sysctl */
 unsigned int __read_mostly softlockup_panic =
-			IS_ENABLED(CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC);
+			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC;
 
 static bool softlockup_initialized __read_mostly;
 static u64 __read_mostly sample_period;
@@ -774,8 +774,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 {
 	unsigned long touch_ts, period_ts, now;
 	struct pt_regs *regs = get_irq_regs();
-	int duration;
 	int softlockup_all_cpu_backtrace;
+	int duration, thresh_count;
 	unsigned long flags;
 
 	if (!watchdog_enabled)
@@ -879,7 +879,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		sys_info(softlockup_si_mask & ~SYS_INFO_ALL_BT);
-		if (softlockup_panic)
+		thresh_count = duration / get_softlockup_thresh();
+
+		if (softlockup_panic && thresh_count >= softlockup_panic)
 			panic("softlockup: hung tasks");
 	}
 
@@ -1228,7 +1230,7 @@ static const struct ctl_table watchdog_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "softlockup_sys_info",
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939..17a7a77 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1110,13 +1110,14 @@ config SOFTLOCKUP_DETECTOR_INTR_STORM
 	  the CPU stats and the interrupt counts during the "soft lockups".
 
 config BOOTPARAM_SOFTLOCKUP_PANIC
-	bool "Panic (Reboot) On Soft Lockups"
+	int "Panic (Reboot) On Soft Lockups"
 	depends on SOFTLOCKUP_DETECTOR
+	default 0
 	help
-	  Say Y here to enable the kernel to panic on "soft lockups",
-	  which are bugs that cause the kernel to loop in kernel
-	  mode for more than 20 seconds (configurable using the watchdog_thresh
-	  sysctl), without giving other tasks a chance to run.
+	  Set to a non-zero value N to enable the kernel to panic on "soft
+	  lockups", which are bugs that cause the kernel to loop in kernel
+	  mode for more than (N * 20 seconds) (configurable using the
+	  watchdog_thresh sysctl), without giving other tasks a chance to run.
 
 	  The panic can be used in combination with panic_timeout,
 	  to cause the system to reboot automatically after a
@@ -1124,7 +1125,7 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
 	  high-availability systems that have uptime guarantees and
 	  where a lockup must be resolved ASAP.
 
-	  Say N if unsure.
+	  Say 0 if unsure.
 
 config HAVE_HARDLOCKUP_DETECTOR_BUDDY
 	bool
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e..2485538 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,6 +1,6 @@
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
 CONFIG_BPF_EVENTS=y
 CONFIG_BPF_JIT=y
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0504c11..bb89d2d 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -80,7 +80,7 @@ CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_WQ_WATCHDOG=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BOOTPARAM_HUNG_TASK_PANIC=1
 CONFIG_PANIC_TIMEOUT=-1
 CONFIG_STACKTRACE=y
-- 
2.9.4


