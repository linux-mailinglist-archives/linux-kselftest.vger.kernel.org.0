Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8944E5E08A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGCJJj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 05:09:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40193 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGCJJj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 05:09:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6398F3d3219381
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 02:08:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6398F3d3219381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562144897;
        bh=DbGFRZVLaS9xFvO9dPl78BeGvQ6d15VnI8gJOJ15Jbw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=AV8z1A+Qm/NJ0iy4viCy9kFDUYa2xknI3Lnz6mrafQjQmyBhspERL4o7V96/9Rb3j
         xfj54+z5sYeBGJxdIlHrx8CiNtAy9vGgRTLky/IwM0goPW3yNsqEYYPq5joyq5WhWb
         iCk0NkSp7g3V/CCik2+JWv0i8O2ytQh3TIgHJcY7DOrH8Xb5up+sWhoji/YDjKAvEn
         OFdBwaKs6KYgfsT3x4hz6vWPc8eMWJVgmk3RlWUwVmfvxV/TPahb1abvp7D+jGnhwI
         OWI/L3Qvq6CgBYKhCV2uTD9GtI4BIRnej8UAcEXAoMonwEaRneoBBDqWGKCjA2nKNc
         TGc9wzsJcLZ2g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6398EGZ3219374;
        Wed, 3 Jul 2019 02:08:14 -0700
Date:   Wed, 3 Jul 2019 02:08:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-dd2cb348613b44f9d948b068775e159aad298599@git.kernel.org>
Cc:     sunilmut@microsoft.com, pcc@google.com, huw@codeweavers.com,
        vincenzo.frascino@arm.com, salyzyn@android.com, apw@canonical.com,
        vkuznets@redhat.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, olaf@aepfle.de, marcelo.cerri@canonical.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, ralf@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        kys@microsoft.com, shuah@kernel.org, mark.rutland@arm.com,
        paul.burton@mips.com, marc.zyngier@arm.com, mingo@kernel.org,
        bp@alien8.de, linux@rasmusvillemoes.dk, sashal@kernel.org,
        sfr@canb.auug.org.au, mikelley@microsoft.com,
        catalin.marinas@arm.com, 0x7f454c46@gmail.com,
        daniel.lezcano@linaro.org, linux-hyperv@vger.kernel.org,
        jasowang@redhat.com, linux-arch@vger.kernel.org, arnd@arndb.de
Reply-To: shuah@kernel.org, kys@microsoft.com, linux@armlinux.org.uk,
          rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
          marcelo.cerri@canonical.com, will.deacon@arm.com, olaf@aepfle.de,
          pbonzini@redhat.com, ralf@linux-mips.org,
          linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
          linux-mips@vger.kernel.org, vkuznets@redhat.com,
          gregkh@linuxfoundation.org, hpa@zytor.com,
          linux-kselftest@vger.kernel.org, tglx@linutronix.de,
          vincenzo.frascino@arm.com, huw@codeweavers.com,
          salyzyn@android.com, apw@canonical.com, pcc@google.com,
          sunilmut@microsoft.com, jasowang@redhat.com,
          linux-hyperv@vger.kernel.org, daniel.lezcano@linaro.org,
          linux-arch@vger.kernel.org, arnd@arndb.de,
          linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
          catalin.marinas@arm.com, sfr@canb.auug.org.au,
          mikelley@microsoft.com, sashal@kernel.org, bp@alien8.de,
          mingo@kernel.org, mark.rutland@arm.com, marc.zyngier@arm.com,
          paul.burton@mips.com
In-Reply-To: <1561955054-1838-3-git-send-email-mikelley@microsoft.com>
References: <1561955054-1838-3-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource/drivers: Continue making Hyper-V
 clocksource ISA agnostic
Git-Commit-ID: dd2cb348613b44f9d948b068775e159aad298599
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=2.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit-ID:  dd2cb348613b44f9d948b068775e159aad298599
Gitweb:     https://git.kernel.org/tip/dd2cb348613b44f9d948b068775e159aad298599
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Mon, 1 Jul 2019 04:26:06 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 11:00:59 +0200

clocksource/drivers: Continue making Hyper-V clocksource ISA agnostic

Continue consolidating Hyper-V clock and timer code into an ISA
independent Hyper-V clocksource driver.

Move the existing clocksource code under drivers/hv and arch/x86 to the new
clocksource driver while separating out the ISA dependencies. Update
Hyper-V initialization to call initialization and cleanup routines since
the Hyper-V synthetic clock is not independently enumerated in ACPI.

Update Hyper-V clocksource users in KVM and VDSO to get definitions from
the new include file.

No behavior is changed and no new functionality is added.

Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "bp@alien8.de" <bp@alien8.de>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>
Cc: "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Cc: "ralf@linux-mips.org" <ralf@linux-mips.org>
Cc: "paul.burton@mips.com" <paul.burton@mips.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "salyzyn@android.com" <salyzyn@android.com>
Cc: "pcc@google.com" <pcc@google.com>
Cc: "shuah@kernel.org" <shuah@kernel.org>
Cc: "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>
Cc: "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>
Cc: "huw@codeweavers.com" <huw@codeweavers.com>
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Link: https://lkml.kernel.org/r/1561955054-1838-3-git-send-email-mikelley@microsoft.com

---
 arch/x86/entry/vdso/vma.c                |   2 +-
 arch/x86/hyperv/hv_init.c                |  91 +-------------------
 arch/x86/include/asm/mshyperv.h          |  81 +++---------------
 arch/x86/include/asm/vdso/gettimeofday.h |   2 +-
 arch/x86/kvm/x86.c                       |   1 +
 drivers/clocksource/hyperv_timer.c       | 139 +++++++++++++++++++++++++++++++
 drivers/hv/hv_util.c                     |   1 +
 include/clocksource/hyperv_timer.h       |  80 ++++++++++++++++++
 8 files changed, 237 insertions(+), 160 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 8db1f594e8b1..349a61d8bf34 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -22,7 +22,7 @@
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
-#include <asm/mshyperv.h>
+#include <clocksource/hyperv_timer.h>
 
 #if defined(CONFIG_X86_64)
 unsigned int __read_mostly vdso64_enabled = 1;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 1608050e9df9..0e033ef11a9f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -17,64 +17,13 @@
 #include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
-#include <linux/clockchips.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
-
-#ifdef CONFIG_HYPERV_TSCPAGE
-
-static struct ms_hyperv_tsc_page *tsc_pg;
-
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return tsc_pg;
-}
-EXPORT_SYMBOL_GPL(hv_get_tsc_page);
-
-static u64 read_hv_clock_tsc(struct clocksource *arg)
-{
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
-
-	if (current_tick == U64_MAX)
-		rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_tsc = {
-		.name		= "hyperv_clocksource_tsc_page",
-		.rating		= 400,
-		.read		= read_hv_clock_tsc,
-		.mask		= CLOCKSOURCE_MASK(64),
-		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-#endif
-
-static u64 read_hv_clock_msr(struct clocksource *arg)
-{
-	u64 current_tick;
-	/*
-	 * Read the partition counter to get the current tick count. This count
-	 * is set to 0 when the partition is created and is incremented in
-	 * 100 nanosecond units.
-	 */
-	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
-	return current_tick;
-}
-
-static struct clocksource hyperv_cs_msr = {
-	.name		= "hyperv_clocksource_msr",
-	.rating		= 400,
-	.read		= read_hv_clock_msr,
-	.mask		= CLOCKSOURCE_MASK(64),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
+#include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
-struct clocksource *hyperv_cs;
-EXPORT_SYMBOL_GPL(hyperv_cs);
 
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
@@ -343,42 +292,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
-	/*
-	 * Register Hyper-V specific clocksource.
-	 */
-#ifdef CONFIG_HYPERV_TSCPAGE
-	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
-		union hv_x64_msr_hypercall_contents tsc_msr;
-
-		tsc_pg = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
-		if (!tsc_pg)
-			goto register_msr_cs;
-
-		hyperv_cs = &hyperv_cs_tsc;
-
-		rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		tsc_msr.enable = 1;
-		tsc_msr.guest_physical_address = vmalloc_to_pfn(tsc_pg);
-
-		wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
-
-		hyperv_cs_tsc.archdata.vclock_mode = VCLOCK_HVCLOCK;
-
-		clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
-		return;
-	}
-register_msr_cs:
-#endif
-	/*
-	 * For 32 bit guests just use the MSR based mechanism for reading
-	 * the partition counter.
-	 */
-
-	hyperv_cs = &hyperv_cs_msr;
-	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
-		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
-
+	/* Register Hyper-V specific clocksource */
+	hv_init_clocksource();
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..f4fa8a9d5d0b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -105,6 +105,17 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 #define hv_get_crash_ctl(val) \
 	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
 
+#define hv_get_time_ref_count(val) \
+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
+
+#define hv_get_reference_tsc(val) \
+	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_reference_tsc(val) \
+	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
+#define hv_set_clocksource_vdso(val) \
+	((val).archdata.vclock_mode = VCLOCK_HVCLOCK)
+#define hv_get_raw_timer() rdtsc_ordered()
+
 void hyperv_callback_vector(void);
 void hyperv_reenlightenment_vector(void);
 #ifdef CONFIG_TRACING
@@ -133,7 +144,6 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 
 
 #if IS_ENABLED(CONFIG_HYPERV)
-extern struct clocksource *hyperv_cs;
 extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
 
@@ -387,73 +397,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 }
 #endif /* CONFIG_HYPERV */
 
-#ifdef CONFIG_HYPERV_TSCPAGE
-struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	u64 scale, offset;
-	u32 sequence;
-
-	/*
-	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
-	 * Top-Level Functional Specification ver. 3.0 and above. To get the
-	 * reference time we must do the following:
-	 * - READ ReferenceTscSequence
-	 *   A special '0' value indicates the time source is unreliable and we
-	 *   need to use something else. The currently published specification
-	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
-	 * - ReferenceTime =
-	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
-	 * - READ ReferenceTscSequence again. In case its value has changed
-	 *   since our first reading we need to discard ReferenceTime and repeat
-	 *   the whole sequence as the hypervisor was updating the page in
-	 *   between.
-	 */
-	do {
-		sequence = READ_ONCE(tsc_pg->tsc_sequence);
-		if (!sequence)
-			return U64_MAX;
-		/*
-		 * Make sure we read sequence before we read other values from
-		 * TSC page.
-		 */
-		smp_rmb();
-
-		scale = READ_ONCE(tsc_pg->tsc_scale);
-		offset = READ_ONCE(tsc_pg->tsc_offset);
-		*cur_tsc = rdtsc_ordered();
-
-		/*
-		 * Make sure we read sequence after we read all other values
-		 * from TSC page.
-		 */
-		smp_rmb();
-
-	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
-
-	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
-}
-
-static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
-{
-	u64 cur_tsc;
-
-	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
-}
-
-#else
-static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
-{
-	return NULL;
-}
-
-static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
-				       u64 *cur_tsc)
-{
-	BUG();
-	return U64_MAX;
-}
-#endif
 #endif
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index a14039a59abd..ae91429129a6 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -18,7 +18,7 @@
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
-#include <asm/mshyperv.h>
+#include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8ec676029365..5e1db26b5e15 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -67,6 +67,7 @@
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/intel_pt.h>
+#include <clocksource/hyperv_timer.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 68a28af31561..ba2c79e6a0ee 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -14,6 +14,8 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/hyperv-tlfs.h>
@@ -198,3 +200,140 @@ void hv_stimer_global_cleanup(void)
 	hv_stimer_free();
 }
 EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
+
+/*
+ * Code and definitions for the Hyper-V clocksources.  Two
+ * clocksources are defined: one that reads the Hyper-V defined MSR, and
+ * the other that uses the TSC reference page feature as defined in the
+ * TLFS.  The MSR version is for compatibility with old versions of
+ * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
+ */
+
+struct clocksource *hyperv_cs;
+EXPORT_SYMBOL_GPL(hyperv_cs);
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+
+static struct ms_hyperv_tsc_page *tsc_pg;
+
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
+
+static u64 notrace read_hv_sched_clock_tsc(void)
+{
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick == U64_MAX)
+		hv_get_time_ref_count(current_tick);
+
+	return current_tick;
+}
+
+static u64 read_hv_clock_tsc(struct clocksource *arg)
+{
+	return read_hv_sched_clock_tsc();
+}
+
+static struct clocksource hyperv_cs_tsc = {
+	.name	= "hyperv_clocksource_tsc_page",
+	.rating	= 400,
+	.read	= read_hv_clock_tsc,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+#endif
+
+static u64 notrace read_hv_sched_clock_msr(void)
+{
+	u64 current_tick;
+	/*
+	 * Read the partition counter to get the current tick count. This count
+	 * is set to 0 when the partition is created and is incremented in
+	 * 100 nanosecond units.
+	 */
+	hv_get_time_ref_count(current_tick);
+	return current_tick;
+}
+
+static u64 read_hv_clock_msr(struct clocksource *arg)
+{
+	return read_hv_sched_clock_msr();
+}
+
+static struct clocksource hyperv_cs_msr = {
+	.name	= "hyperv_clocksource_msr",
+	.rating	= 400,
+	.read	= read_hv_clock_msr,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+static bool __init hv_init_tsc_clocksource(void)
+{
+	u64		tsc_msr;
+	phys_addr_t	phys_addr;
+
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return false;
+
+	tsc_pg = vmalloc(PAGE_SIZE);
+	if (!tsc_pg)
+		return false;
+
+	hyperv_cs = &hyperv_cs_tsc;
+	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
+
+	/*
+	 * The Hyper-V TLFS specifies to preserve the value of reserved
+	 * bits in registers. So read the existing value, preserve the
+	 * low order 12 bits, and add in the guest physical address
+	 * (which already has at least the low 12 bits set to zero since
+	 * it is page aligned). Also set the "enable" bit, which is bit 0.
+	 */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+
+	hv_set_clocksource_vdso(hyperv_cs_tsc);
+	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
+
+	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
+	sched_clock_register(read_hv_sched_clock_tsc, 64, HV_CLOCK_HZ);
+	return true;
+}
+#else
+static bool __init hv_init_tsc_clocksource(void)
+{
+	return false;
+}
+#endif
+
+
+void __init hv_init_clocksource(void)
+{
+	/*
+	 * Try to set up the TSC page clocksource. If it succeeds, we're
+	 * done. Otherwise, set up the MSR clocksoruce.  At least one of
+	 * these will always be available except on very old versions of
+	 * Hyper-V on x86.  In that case we won't have a Hyper-V
+	 * clocksource, but Linux will still run with a clocksource based
+	 * on the emulated PIT or LAPIC timer.
+	 */
+	if (hv_init_tsc_clocksource())
+		return;
+
+	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
+		return;
+
+	hyperv_cs = &hyperv_cs_msr;
+	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+
+	/* sched_clock_register is needed on ARM64 but is a no-op on x86 */
+	sched_clock_register(read_hv_sched_clock_msr, 64, HV_CLOCK_HZ);
+}
+EXPORT_SYMBOL_GPL(hv_init_clocksource);
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 7d3d31f099ea..e32681ee7b9f 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -17,6 +17,7 @@
 #include <linux/hyperv.h>
 #include <linux/clockchips.h>
 #include <linux/ptp_clock_kernel.h>
+#include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 0cd73f7bc992..a821deb8ecb2 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -13,6 +13,10 @@
 #ifndef __CLKSOURCE_HYPERV_TIMER_H
 #define __CLKSOURCE_HYPERV_TIMER_H
 
+#include <linux/clocksource.h>
+#include <linux/math64.h>
+#include <asm/mshyperv.h>
+
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
 
@@ -24,4 +28,80 @@ extern void hv_stimer_cleanup(unsigned int cpu);
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
+#if IS_ENABLED(CONFIG_HYPERV)
+extern struct clocksource *hyperv_cs;
+extern void hv_init_clocksource(void);
+#endif /* CONFIG_HYPERV */
+
+#ifdef CONFIG_HYPERV_TSCPAGE
+extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+
+static inline notrace u64
+hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
+{
+	u64 scale, offset;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	do {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			return U64_MAX;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		*cur_tsc = hv_get_raw_timer();
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
+
+	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
+}
+
+static inline notrace u64
+hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 cur_tsc;
+
+	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
+}
+
+#else /* CONFIG_HYPERV_TSC_PAGE */
+static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return NULL;
+}
+
+static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
+				       u64 *cur_tsc)
+{
+	return U64_MAX;
+}
+#endif /* CONFIG_HYPERV_TSCPAGE */
+
 #endif
