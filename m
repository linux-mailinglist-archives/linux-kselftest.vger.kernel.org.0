Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8A4E518
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 11:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFUJxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 05:53:20 -0400
Received: from foss.arm.com ([217.140.110.172]:55224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbfFUJxT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EB21478;
        Fri, 21 Jun 2019 02:53:18 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D613F246;
        Fri, 21 Jun 2019 02:53:15 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 04/25] arm64: Substitute gettimeofday with C implementation
Date:   Fri, 21 Jun 2019 10:52:31 +0100
Message-Id: <20190621095252.32307-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To take advantage of the commonly defined vdso interface for
gettimeofday the architectural code requires an adaptation.

Re-implement the gettimeofday vdso in C in order to use lib/vdso.

With the new implementation arm64 gains support for CLOCK_BOOTTIME
and CLOCK_TAI.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/Kconfig                         |   2 +
 arch/arm64/include/asm/vdso/gettimeofday.h |  86 ++++++
 arch/arm64/include/asm/vdso/vsyscall.h     |  53 ++++
 arch/arm64/include/asm/vdso_datapage.h     |  48 ---
 arch/arm64/kernel/asm-offsets.c            |  33 +-
 arch/arm64/kernel/vdso.c                   |  51 +---
 arch/arm64/kernel/vdso/Makefile            |  34 ++-
 arch/arm64/kernel/vdso/gettimeofday.S      | 334 ---------------------
 arch/arm64/kernel/vdso/vgettimeofday.c     |  28 ++
 9 files changed, 223 insertions(+), 446 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..952c9f8cf3b8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -107,6 +107,7 @@ config ARM64
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
@@ -160,6 +161,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..bc3cb6738051
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ARM Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+static __always_inline int gettimeofday_fallback(
+					struct __kernel_old_timeval *_tv,
+					struct timezone *_tz)
+{
+	register struct timezone *tz asm("x1") = _tz;
+	register struct __kernel_old_timeval *tv asm("x0") = _tv;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_gettimeofday;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (tv), "r" (tz), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline long clock_gettime_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_gettime;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int clock_getres_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("x1") = _ts;
+	register clockid_t clkid asm("x0") = _clkid;
+	register long ret asm ("x0");
+	register long nr asm("x8") = __NR_clock_getres;
+
+	asm volatile(
+	"       svc #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
+{
+	u64 res;
+
+	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
+
+	return res;
+}
+
+static __always_inline
+const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return _vdso_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..0c731bfc7c8c
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+
+#define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
+
+extern struct vdso_data *vdso_data;
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__arm64_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __arm64_get_k_vdso_data
+
+static __always_inline
+int __arm64_get_clock_mode(struct timekeeper *tk)
+{
+	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
+
+	return use_syscall;
+}
+#define __arch_get_clock_mode __arm64_get_clock_mode
+
+static __always_inline
+int __arm64_use_vsyscall(struct vdso_data *vdata)
+{
+	return !vdata[CS_HRES_COARSE].clock_mode;
+}
+#define __arch_use_vsyscall __arm64_use_vsyscall
+
+static __always_inline
+void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
+{
+	vdata[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
+	vdata[CS_RAW].mask		= VDSO_PRECISION_MASK;
+}
+#define __arch_update_vsyscall __arm64_update_vsyscall
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
deleted file mode 100644
index f89263c8e11a..000000000000
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-struct vdso_data {
-	__u64 cs_cycle_last;	/* Timebase at clocksource init */
-	__u64 raw_time_sec;	/* Raw time */
-	__u64 raw_time_nsec;
-	__u64 xtime_clock_sec;	/* Kernel time */
-	__u64 xtime_clock_nsec;
-	__u64 xtime_coarse_sec;	/* Coarse time */
-	__u64 xtime_coarse_nsec;
-	__u64 wtm_clock_sec;	/* Wall to monotonic time */
-	__u64 wtm_clock_nsec;
-	__u32 tb_seq_count;	/* Timebase sequence counter */
-	/* cs_* members must be adjacent and in this order (ldp accesses) */
-	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
-	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
-	__u32 tz_minuteswest;	/* Whacky timezone stuff */
-	__u32 tz_dsttime;
-	__u32 use_syscall;
-	__u32 hrtimer_res;
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 947e39896e28..9e4b7ccbab2f 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -25,13 +25,13 @@
 #include <linux/kvm_host.h>
 #include <linux/preempt.h>
 #include <linux/suspend.h>
+#include <vdso/datapage.h>
 #include <asm/cpufeature.h>
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
-#include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
 
@@ -100,17 +100,28 @@ int main(void)
   DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
   DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
   BLANK();
-  DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
-  DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
-  DEFINE(VDSO_XTIME_CLK_SEC,	offsetof(struct vdso_data, xtime_clock_sec));
-  DEFINE(VDSO_XTIME_CRS_SEC,	offsetof(struct vdso_data, xtime_coarse_sec));
-  DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
-  DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
-  DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
-  DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
-  DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
+  DEFINE(VDSO_SEQ,		offsetof(struct vdso_data, seq));
+  DEFINE(VDSO_CLK_MODE,		offsetof(struct vdso_data, clock_mode));
+  DEFINE(VDSO_CYCLE_LAST,	offsetof(struct vdso_data, cycle_last));
+  DEFINE(VDSO_MASK,		offsetof(struct vdso_data, mask));
+  DEFINE(VDSO_MULT,		offsetof(struct vdso_data, mult));
+  DEFINE(VDSO_SHIFT,		offsetof(struct vdso_data, shift));
+  DEFINE(VDSO_REALTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].sec));
+  DEFINE(VDSO_REALTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].nsec));
+  DEFINE(VDSO_MONO_SEC,		offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].sec));
+  DEFINE(VDSO_MONO_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].nsec));
+  DEFINE(VDSO_MONO_RAW_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].sec));
+  DEFINE(VDSO_MONO_RAW_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].nsec));
+  DEFINE(VDSO_BOOTTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].sec));
+  DEFINE(VDSO_BOOTTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].nsec));
+  DEFINE(VDSO_TAI_SEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].sec));
+  DEFINE(VDSO_TAI_NSEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].nsec));
+  DEFINE(VDSO_RT_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].sec));
+  DEFINE(VDSO_RT_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].nsec));
+  DEFINE(VDSO_MONO_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].sec));
+  DEFINE(VDSO_MONO_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].nsec));
   DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
+  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
   BLANK();
   DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
   DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 8074cbd3a3a8..23c38303a52a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -31,11 +31,13 @@
 #include <linux/slab.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
 
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
 
 extern char vdso_start[], vdso_end[];
 static unsigned long vdso_pages __ro_after_init;
@@ -44,10 +46,10 @@ static unsigned long vdso_pages __ro_after_init;
  * The vDSO data page.
  */
 static union {
-	struct vdso_data	data;
+	struct vdso_data	data[CS_BASES];
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+struct vdso_data *vdso_data = vdso_data_store.data;
 
 #ifdef CONFIG_COMPAT
 /*
@@ -280,46 +282,3 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	up_write(&mm->mmap_sem);
 	return PTR_ERR(ret);
 }
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-void update_vsyscall(struct timekeeper *tk)
-{
-	u32 use_syscall = !tk->tkr_mono.clock->archdata.vdso_direct;
-
-	++vdso_data->tb_seq_count;
-	smp_wmb();
-
-	vdso_data->use_syscall			= use_syscall;
-	vdso_data->xtime_coarse_sec		= tk->xtime_sec;
-	vdso_data->xtime_coarse_nsec		= tk->tkr_mono.xtime_nsec >>
-							tk->tkr_mono.shift;
-	vdso_data->wtm_clock_sec		= tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtm_clock_nsec		= tk->wall_to_monotonic.tv_nsec;
-
-	/* Read without the seqlock held by clock_getres() */
-	WRITE_ONCE(vdso_data->hrtimer_res, hrtimer_resolution);
-
-	if (!use_syscall) {
-		/* tkr_mono.cycle_last == tkr_raw.cycle_last */
-		vdso_data->cs_cycle_last	= tk->tkr_mono.cycle_last;
-		vdso_data->raw_time_sec         = tk->raw_sec;
-		vdso_data->raw_time_nsec        = tk->tkr_raw.xtime_nsec;
-		vdso_data->xtime_clock_sec	= tk->xtime_sec;
-		vdso_data->xtime_clock_nsec	= tk->tkr_mono.xtime_nsec;
-		vdso_data->cs_mono_mult		= tk->tkr_mono.mult;
-		vdso_data->cs_raw_mult		= tk->tkr_raw.mult;
-		/* tkr_mono.shift == tkr_raw.shift */
-		vdso_data->cs_shift		= tk->tkr_mono.shift;
-	}
-
-	smp_wmb();
-	++vdso_data->tb_seq_count;
-}
-
-void update_vsyscall_tz(void)
-{
-	vdso_data->tz_minuteswest	= sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime		= sys_tz.tz_dsttime;
-}
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index fa230ff09aa1..3acfc813e966 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -6,7 +6,12 @@
 # Heavily based on the vDSO Makefiles for other archs.
 #
 
-obj-vdso := gettimeofday.o note.o sigreturn.o
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_AARCH64_JUMP_SLOT|R_AARCH64_GLOB_DAT|R_AARCH64_ABS64
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso := vgettimeofday.o note.o sigreturn.o
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg
@@ -15,6 +20,24 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
 		--build-id -n -T
 
+ccflags-y := -fno-common -fno-builtin -fno-stack-protector
+ccflags-y += -DDISABLE_BRANCH_PROFILING
+
+VDSO_LDFLAGS := -Bsymbolic
+
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
+KBUILD_CFLAGS			+= $(DISABLE_LTO)
+KASAN_SANITIZE			:= n
+UBSAN_SANITIZE			:= n
+OBJECT_FILES_NON_STANDARD	:= y
+KCOV_INSTRUMENT			:= n
+
+ifeq ($(c-gettimeofday-y),)
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny
+else
+CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
@@ -28,6 +51,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 # Link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,ld)
+	$(call if_changed,vdso_check)
 
 # Strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -42,13 +66,9 @@ quiet_cmd_vdsosym = VDSOSYM $@
 include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 	$(call if_changed,vdsosym)
 
-# Assembly rules for the .S files
-$(obj-vdso): %.o: %.S FORCE
-	$(call if_changed_dep,vdsoas)
-
 # Actual build commands
-quiet_cmd_vdsoas = VDSOA   $@
-      cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
+quiet_cmd_vdsocc = VDSOCC   $@
+      cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
 
 # Install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
deleted file mode 100644
index 856fee6d3512..000000000000
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ /dev/null
@@ -1,334 +0,0 @@
-/*
- * Userspace implementations of gettimeofday() and friends.
- *
- * Copyright (C) 2012 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: Will Deacon <will.deacon@arm.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-#include <asm/unistd.h>
-
-#define NSEC_PER_SEC_LO16	0xca00
-#define NSEC_PER_SEC_HI16	0x3b9a
-
-vdso_data	.req	x6
-seqcnt		.req	w7
-w_tmp		.req	w8
-x_tmp		.req	x8
-
-/*
- * Conventions for macro arguments:
- * - An argument is write-only if its name starts with "res".
- * - All other arguments are read-only, unless otherwise specified.
- */
-
-	.macro	seqcnt_acquire
-9999:	ldr	seqcnt, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	tbnz	seqcnt, #0, 9999b
-	dmb	ishld
-	.endm
-
-	.macro	seqcnt_check fail
-	dmb	ishld
-	ldr	w_tmp, [vdso_data, #VDSO_TB_SEQ_COUNT]
-	cmp	w_tmp, seqcnt
-	b.ne	\fail
-	.endm
-
-	.macro	syscall_check fail
-	ldr	w_tmp, [vdso_data, #VDSO_USE_SYSCALL]
-	cbnz	w_tmp, \fail
-	.endm
-
-	.macro get_nsec_per_sec res
-	mov	\res, #NSEC_PER_SEC_LO16
-	movk	\res, #NSEC_PER_SEC_HI16, lsl #16
-	.endm
-
-	/*
-	 * Returns the clock delta, in nanoseconds left-shifted by the clock
-	 * shift.
-	 */
-	.macro	get_clock_shifted_nsec res, cycle_last, mult
-	/* Read the virtual counter. */
-	isb
-	mrs	x_tmp, cntvct_el0
-	/* Calculate cycle delta and convert to ns. */
-	sub	\res, x_tmp, \cycle_last
-	/* We can only guarantee 56 bits of precision. */
-	movn	x_tmp, #0xff00, lsl #48
-	and	\res, x_tmp, \res
-	mul	\res, \res, \mult
-	/*
-	 * Fake address dependency from the value computed from the counter
-	 * register to subsequent data page accesses so that the sequence
-	 * locking also orders the read of the counter.
-	 */
-	and	x_tmp, \res, xzr
-	add	vdso_data, vdso_data, x_tmp
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the REALTIME timespec, based on the
-	 * "wall time" (xtime) and the clock_mono delta.
-	 */
-	.macro	get_ts_realtime res_sec, res_nsec, \
-			clock_nsec, xtime_sec, xtime_nsec, nsec_to_sec
-	add	\res_nsec, \clock_nsec, \xtime_nsec
-	udiv	x_tmp, \res_nsec, \nsec_to_sec
-	add	\res_sec, \xtime_sec, x_tmp
-	msub	\res_nsec, x_tmp, \nsec_to_sec, \res_nsec
-	.endm
-
-	/*
-	 * Returns in res_{sec,nsec} the timespec based on the clock_raw delta,
-	 * used for CLOCK_MONOTONIC_RAW.
-	 */
-	.macro	get_ts_clock_raw res_sec, res_nsec, clock_nsec, nsec_to_sec
-	udiv	\res_sec, \clock_nsec, \nsec_to_sec
-	msub	\res_nsec, \res_sec, \nsec_to_sec, \clock_nsec
-	.endm
-
-	/* sec and nsec are modified in place. */
-	.macro add_ts sec, nsec, ts_sec, ts_nsec, nsec_to_sec
-	/* Add timespec. */
-	add	\sec, \sec, \ts_sec
-	add	\nsec, \nsec, \ts_nsec
-
-	/* Normalise the new timespec. */
-	cmp	\nsec, \nsec_to_sec
-	b.lt	9999f
-	sub	\nsec, \nsec, \nsec_to_sec
-	add	\sec, \sec, #1
-9999:
-	cmp	\nsec, #0
-	b.ge	9998f
-	add	\nsec, \nsec, \nsec_to_sec
-	sub	\sec, \sec, #1
-9998:
-	.endm
-
-	.macro clock_gettime_return, shift=0
-	.if \shift == 1
-	lsr	x11, x11, x12
-	.endif
-	stp	x10, x11, [x1, #TSPEC_TV_SEC]
-	mov	x0, xzr
-	ret
-	.endm
-
-	.macro jump_slot jumptable, index, label
-	.if (. - \jumptable) != 4 * (\index)
-	.error "Jump slot index mismatch"
-	.endif
-	b	\label
-	.endm
-
-	.text
-
-/* int __kernel_gettimeofday(struct timeval *tv, struct timezone *tz); */
-ENTRY(__kernel_gettimeofday)
-	.cfi_startproc
-	adr	vdso_data, _vdso_data
-	/* If tv is NULL, skip to the timezone code. */
-	cbz	x0, 2f
-
-	/* Compute the time of day. */
-1:	seqcnt_acquire
-	syscall_check fail=4f
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=1b
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	/* Convert ns to us. */
-	mov	x13, #1000
-	lsl	x13, x13, x12
-	udiv	x11, x11, x13
-	stp	x10, x11, [x0, #TVAL_TV_SEC]
-2:
-	/* If tz is NULL, return 0. */
-	cbz	x1, 3f
-	ldp	w4, w5, [vdso_data, #VDSO_TZ_MINWEST]
-	stp	w4, w5, [x1, #TZ_MINWEST]
-3:
-	mov	x0, xzr
-	ret
-4:
-	/* Syscall fallback. */
-	mov	x8, #__NR_gettimeofday
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_gettimeofday)
-
-#define JUMPSLOT_MAX CLOCK_MONOTONIC_COARSE
-
-/* int __kernel_clock_gettime(clockid_t clock_id, struct timespec *tp); */
-ENTRY(__kernel_clock_gettime)
-	.cfi_startproc
-	cmp	w0, #JUMPSLOT_MAX
-	b.hi	syscall
-	adr	vdso_data, _vdso_data
-	adr	x_tmp, jumptable
-	add	x_tmp, x_tmp, w0, uxtw #2
-	br	x_tmp
-
-	ALIGN
-jumptable:
-	jump_slot jumptable, CLOCK_REALTIME, realtime
-	jump_slot jumptable, CLOCK_MONOTONIC, monotonic
-	b	syscall
-	b	syscall
-	jump_slot jumptable, CLOCK_MONOTONIC_RAW, monotonic_raw
-	jump_slot jumptable, CLOCK_REALTIME_COARSE, realtime_coarse
-	jump_slot jumptable, CLOCK_MONOTONIC_COARSE, monotonic_coarse
-
-	.if (. - jumptable) != 4 * (JUMPSLOT_MAX + 1)
-	.error	"Wrong jumptable size"
-	.endif
-
-	ALIGN
-realtime:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=realtime
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_mono_mult, w12 = cs_shift */
-	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
-	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	lsl	x4, x4, x12
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=monotonic
-	get_ts_realtime res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x3, ts_nsec=x4, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-monotonic_raw:
-	seqcnt_acquire
-	syscall_check fail=syscall
-	ldr	x10, [vdso_data, #VDSO_CS_CYCLE_LAST]
-	/* w11 = cs_raw_mult, w12 = cs_shift */
-	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
-	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-
-	/* All computations are done with left-shifted nsecs. */
-	get_nsec_per_sec res=x9
-	lsl	x9, x9, x12
-
-	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
-	seqcnt_check fail=monotonic_raw
-	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
-		clock_nsec=x15, nsec_to_sec=x9
-
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return, shift=1
-
-	ALIGN
-realtime_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	seqcnt_check fail=realtime_coarse
-	clock_gettime_return
-
-	ALIGN
-monotonic_coarse:
-	seqcnt_acquire
-	ldp	x10, x11, [vdso_data, #VDSO_XTIME_CRS_SEC]
-	ldp	x13, x14, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic_coarse
-
-	/* Computations are done in (non-shifted) nsecs. */
-	get_nsec_per_sec res=x9
-	add_ts sec=x10, nsec=x11, ts_sec=x13, ts_nsec=x14, nsec_to_sec=x9
-	clock_gettime_return
-
-	ALIGN
-syscall: /* Syscall fallback. */
-	mov	x8, #__NR_clock_gettime
-	svc	#0
-	ret
-	.cfi_endproc
-ENDPROC(__kernel_clock_gettime)
-
-/* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
-ENTRY(__kernel_clock_getres)
-	.cfi_startproc
-	cmp	w0, #CLOCK_REALTIME
-	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
-	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
-
-	adr	vdso_data, _vdso_data
-	ldr	w2, [vdso_data, #CLOCK_REALTIME_RES]
-	b	2f
-1:
-	cmp	w0, #CLOCK_REALTIME_COARSE
-	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
-	ldr	x2, 5f
-2:
-	cbz	x1, 3f
-	stp	xzr, x2, [x1]
-
-3:	/* res == NULL. */
-	mov	w0, wzr
-	ret
-
-4:	/* Syscall fallback. */
-	mov	x8, #__NR_clock_getres
-	svc	#0
-	ret
-5:
-	.quad	CLOCK_COARSE_RES
-	.cfi_endproc
-ENDPROC(__kernel_clock_getres)
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..3c58f19dbdf4
--- /dev/null
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM64 userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2018 ARM Limited
+ *
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __kernel_clock_gettime(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
+			  struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __kernel_clock_getres(clockid_t clock_id,
+			  struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
-- 
2.21.0

