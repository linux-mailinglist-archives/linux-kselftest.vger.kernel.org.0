Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022715E088
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfGCJJV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 05:09:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfGCJJU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 05:09:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6397RDu3219284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 02:07:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6397RDu3219284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562144849;
        bh=aG0cLXm6JgAXZlLrFr5xOZobblrdZNjp2ipb1QP7J4s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=H/KxvKHoAFlp+KOoKYXaL+3E9o7pKUn+r9fbElRk6dl6cWk1/YmcaB8OR5f1ckwGd
         XZstieyNSuAu2isxNycZj7iV1Xs9hjmG6RWOyrBL5PQySeTJmV0Ci9CKPSY8c4z3SA
         Ya8jvZVAWQL7LEcI1NPTnDg0BCX9T3s18+MW5FhwzpiyqWJQLAmKeWtZsObPtsZjN8
         4Joy8lKi6U+DE6Bbh8CcrXkaeDLFOVs9fisxRFaDQzRV0ijuNNPqzA9sGRF4ZcnJux
         GfAj3DnStHWA/nz+lh65vcb54XQIiQEBu8pjbkmqx3YqdNIze+6WXiILF2EZMOZbSr
         iQ+VyYWjzAsdg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6397NU63219277;
        Wed, 3 Jul 2019 02:07:23 -0700
Date:   Wed, 3 Jul 2019 02:07:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-fd1fea6834d0f9f93062ae6685862908a9baed39@git.kernel.org>
Cc:     0x7f454c46@gmail.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, daniel.lezcano@linaro.org,
        linux-arch@vger.kernel.org, sashal@kernel.org,
        linux@rasmusvillemoes.dk, bp@alien8.de, pbonzini@redhat.com,
        linux-mips@vger.kernel.org, paul.burton@mips.com,
        mikelley@microsoft.com, marc.zyngier@arm.com,
        sunilmut@microsoft.com, jasowang@redhat.com,
        linux-kselftest@vger.kernel.org, mark.rutland@arm.com,
        huw@codeweavers.com, ralf@linux-mips.org, olaf@aepfle.de,
        rkrcmar@redhat.com, linux-hyperv@vger.kernel.org, arnd@arndb.de,
        kys@microsoft.com, linux@armlinux.org.uk, mingo@kernel.org,
        sfr@canb.auug.org.au, will.deacon@arm.com,
        gregkh@linuxfoundation.org, vincenzo.frascino@arm.com,
        tglx@linutronix.de, kvm@vger.kernel.org, shuah@kernel.org,
        pcc@google.com, vkuznets@redhat.com, marcelo.cerri@canonical.com,
        hpa@zytor.com, catalin.marinas@arm.com, salyzyn@android.com,
        linux-arm-kernel@lists.infradead.org
Reply-To: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
          pbonzini@redhat.com, sashal@kernel.org, linux@rasmusvillemoes.dk,
          bp@alien8.de, daniel.lezcano@linaro.org,
          linux-arch@vger.kernel.org, apw@canonical.com,
          linux-mips@vger.kernel.org, paul.burton@mips.com,
          mikelley@microsoft.com, sunilmut@microsoft.com,
          marc.zyngier@arm.com, linux-kselftest@vger.kernel.org,
          jasowang@redhat.com, huw@codeweavers.com, ralf@linux-mips.org,
          mark.rutland@arm.com, olaf@aepfle.de,
          linux-hyperv@vger.kernel.org, rkrcmar@redhat.com,
          linux@armlinux.org.uk, kys@microsoft.com, arnd@arndb.de,
          mingo@kernel.org, sfr@canb.auug.org.au,
          gregkh@linuxfoundation.org, vincenzo.frascino@arm.com,
          will.deacon@arm.com, tglx@linutronix.de, vkuznets@redhat.com,
          shuah@kernel.org, pcc@google.com, kvm@vger.kernel.org,
          marcelo.cerri@canonical.com, salyzyn@android.com,
          linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
          hpa@zytor.com
In-Reply-To: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
References: <1561955054-1838-2-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource/drivers: Make Hyper-V clocksource ISA
 agnostic
Git-Commit-ID: fd1fea6834d0f9f93062ae6685862908a9baed39
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

Commit-ID:  fd1fea6834d0f9f93062ae6685862908a9baed39
Gitweb:     https://git.kernel.org/tip/fd1fea6834d0f9f93062ae6685862908a9baed39
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Mon, 1 Jul 2019 04:25:56 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 11:00:59 +0200

clocksource/drivers: Make Hyper-V clocksource ISA agnostic

Hyper-V clock/timer code and data structures are currently mixed
in with other code in the ISA independent drivers/hv directory as
well as the ISA dependent Hyper-V code under arch/x86.

Consolidate this code and data structures into a Hyper-V clocksource driver
to better follow the Linux model. In doing so, separate out the ISA
dependent portions so the new clocksource driver works for x86 and for the
in-process Hyper-V on ARM64 code.

To start, move the existing clockevents code to create the new clocksource
driver. Update the VMbus driver to call initialization and cleanup routines
since the Hyper-V synthetic timers are not independently enumerated in
ACPI.

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
Link: https://lkml.kernel.org/r/1561955054-1838-2-git-send-email-mikelley@microsoft.com

---
 MAINTAINERS                        |   2 +
 arch/x86/include/asm/hyperv-tlfs.h |   6 ++
 arch/x86/kernel/cpu/mshyperv.c     |   4 +-
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/hyperv_timer.c | 200 +++++++++++++++++++++++++++++++++++++
 drivers/hv/Kconfig                 |   3 +
 drivers/hv/hv.c                    | 156 +----------------------------
 drivers/hv/hyperv_vmbus.h          |   3 -
 drivers/hv/vmbus_drv.c             |  42 ++++----
 include/clocksource/hyperv_timer.h |  27 +++++
 10 files changed, 268 insertions(+), 176 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2812972b7b0..bfde42a76a95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7313,6 +7313,7 @@ F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
+F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
@@ -7323,6 +7324,7 @@ F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
 F:	drivers/iommu/hyperv_iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
+F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
 F:	tools/hv/
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index cdf44aa9a501..af78cd72b8f3 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -401,6 +401,12 @@ enum HV_GENERIC_SET_FORMAT {
 #define HV_STATUS_INVALID_CONNECTION_ID		18
 #define HV_STATUS_INSUFFICIENT_BUFFERS		19
 
+/*
+ * The Hyper-V TimeRefCount register and the TSC
+ * page provide a guest VM clock with 100ns tick rate
+ */
+#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
+
 typedef struct _HV_REFERENCE_TSC_PAGE {
 	__u32 tsc_sequence;
 	__u32 res1;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 7df29f08871b..1e5f7a03ddf5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/i8253.h>
+#include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -80,6 +81,7 @@ __visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
 	inc_irq_stat(hyperv_stimer0_count);
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
+	add_interrupt_randomness(HYPERV_STIMER0_VECTOR, 0);
 	ack_APIC_irq();
 
 	exiting_irq();
@@ -89,7 +91,7 @@ __visible void __irq_entry hv_stimer0_vector_handler(struct pt_regs *regs)
 int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
 {
 	*vector = HYPERV_STIMER0_VECTOR;
-	*irq = 0;   /* Unused on x86/x64 */
+	*irq = -1;   /* Unused on x86/x64 */
 	hv_stimer0_handler = handler;
 	return 0;
 }
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5582252efb31..2e7936e7833f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -86,3 +86,4 @@ obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
+obj-$(CONFIG_HYPERV_TIMER)		+= hyperv_timer.o
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
new file mode 100644
index 000000000000..68a28af31561
--- /dev/null
+++ b/drivers/clocksource/hyperv_timer.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Clocksource driver for the synthetic counter and timers
+ * provided by the Hyper-V hypervisor to guest VMs, as described
+ * in the Hyper-V Top Level Functional Spec (TLFS). This driver
+ * is instruction set architecture independent.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author:  Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/clockchips.h>
+#include <linux/mm.h>
+#include <clocksource/hyperv_timer.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static struct clock_event_device __percpu *hv_clock_event;
+
+/*
+ * If false, we're using the old mechanism for stimer0 interrupts
+ * where it sends a VMbus message when it expires. The old
+ * mechanism is used when running on older versions of Hyper-V
+ * that don't support Direct Mode. While Hyper-V provides
+ * four stimer's per CPU, Linux uses only stimer0.
+ */
+static bool direct_mode_enabled;
+
+static int stimer0_irq;
+static int stimer0_vector;
+static int stimer0_message_sint;
+
+/*
+ * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
+ * does not use VMbus or any VMbus messages, so process here and not
+ * in the VMbus driver code.
+ */
+void hv_stimer0_isr(void)
+{
+	struct clock_event_device *ce;
+
+	ce = this_cpu_ptr(hv_clock_event);
+	ce->event_handler(ce);
+}
+EXPORT_SYMBOL_GPL(hv_stimer0_isr);
+
+static int hv_ce_set_next_event(unsigned long delta,
+				struct clock_event_device *evt)
+{
+	u64 current_tick;
+
+	current_tick = hyperv_cs->read(NULL);
+	current_tick += delta;
+	hv_init_timer(0, current_tick);
+	return 0;
+}
+
+static int hv_ce_shutdown(struct clock_event_device *evt)
+{
+	hv_init_timer(0, 0);
+	hv_init_timer_config(0, 0);
+	if (direct_mode_enabled)
+		hv_disable_stimer0_percpu_irq(stimer0_irq);
+
+	return 0;
+}
+
+static int hv_ce_set_oneshot(struct clock_event_device *evt)
+{
+	union hv_stimer_config timer_cfg;
+
+	timer_cfg.as_uint64 = 0;
+	timer_cfg.enable = 1;
+	timer_cfg.auto_enable = 1;
+	if (direct_mode_enabled) {
+		/*
+		 * When it expires, the timer will directly interrupt
+		 * on the specified hardware vector/IRQ.
+		 */
+		timer_cfg.direct_mode = 1;
+		timer_cfg.apic_vector = stimer0_vector;
+		hv_enable_stimer0_percpu_irq(stimer0_irq);
+	} else {
+		/*
+		 * When it expires, the timer will generate a VMbus message,
+		 * to be handled by the normal VMbus interrupt handler.
+		 */
+		timer_cfg.direct_mode = 0;
+		timer_cfg.sintx = stimer0_message_sint;
+	}
+	hv_init_timer_config(0, timer_cfg.as_uint64);
+	return 0;
+}
+
+/*
+ * hv_stimer_init - Per-cpu initialization of the clockevent
+ */
+void hv_stimer_init(unsigned int cpu)
+{
+	struct clock_event_device *ce;
+
+	/*
+	 * Synthetic timers are always available except on old versions of
+	 * Hyper-V on x86.  In that case, just return as Linux will use a
+	 * clocksource based on emulated PIT or LAPIC timer hardware.
+	 */
+	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
+		return;
+
+	ce = per_cpu_ptr(hv_clock_event, cpu);
+	ce->name = "Hyper-V clockevent";
+	ce->features = CLOCK_EVT_FEAT_ONESHOT;
+	ce->cpumask = cpumask_of(cpu);
+	ce->rating = 1000;
+	ce->set_state_shutdown = hv_ce_shutdown;
+	ce->set_state_oneshot = hv_ce_set_oneshot;
+	ce->set_next_event = hv_ce_set_next_event;
+
+	clockevents_config_and_register(ce,
+					HV_CLOCK_HZ,
+					HV_MIN_DELTA_TICKS,
+					HV_MAX_MAX_DELTA_TICKS);
+}
+EXPORT_SYMBOL_GPL(hv_stimer_init);
+
+/*
+ * hv_stimer_cleanup - Per-cpu cleanup of the clockevent
+ */
+void hv_stimer_cleanup(unsigned int cpu)
+{
+	struct clock_event_device *ce;
+
+	/* Turn off clockevent device */
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+		ce = per_cpu_ptr(hv_clock_event, cpu);
+		hv_ce_shutdown(ce);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_stimer_cleanup);
+
+/* hv_stimer_alloc - Global initialization of the clockevent and stimer0 */
+int hv_stimer_alloc(int sint)
+{
+	int ret;
+
+	hv_clock_event = alloc_percpu(struct clock_event_device);
+	if (!hv_clock_event)
+		return -ENOMEM;
+
+	direct_mode_enabled = ms_hyperv.misc_features &
+			HV_STIMER_DIRECT_MODE_AVAILABLE;
+	if (direct_mode_enabled) {
+		ret = hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
+				hv_stimer0_isr);
+		if (ret) {
+			free_percpu(hv_clock_event);
+			hv_clock_event = NULL;
+			return ret;
+		}
+	}
+
+	stimer0_message_sint = sint;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_stimer_alloc);
+
+/* hv_stimer_free - Free global resources allocated by hv_stimer_alloc() */
+void hv_stimer_free(void)
+{
+	if (direct_mode_enabled && (stimer0_irq != 0)) {
+		hv_remove_stimer0_irq(stimer0_irq);
+		stimer0_irq = 0;
+	}
+	free_percpu(hv_clock_event);
+	hv_clock_event = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_stimer_free);
+
+/*
+ * Do a global cleanup of clockevents for the cases of kexec and
+ * vmbus exit
+ */
+void hv_stimer_global_cleanup(void)
+{
+	int	cpu;
+	struct clock_event_device *ce;
+
+	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+		for_each_present_cpu(cpu) {
+			ce = per_cpu_ptr(hv_clock_event, cpu);
+			clockevents_unbind_device(ce, cpu);
+		}
+	}
+	hv_stimer_free();
+}
+EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a2514d6f3..c423e57ae888 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -10,6 +10,9 @@ config HYPERV
 	  Select this option to run Linux as a Hyper-V client operating
 	  system.
 
+config HYPERV_TIMER
+	def_bool HYPERV
+
 config HYPERV_TSCPAGE
        def_bool HYPERV && X86_64
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a1ea482183e8..6188fb7dda42 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -16,27 +16,13 @@
 #include <linux/version.h>
 #include <linux/random.h>
 #include <linux/clockchips.h>
+#include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
 
 /* The one and only */
 struct hv_context hv_context;
 
-/*
- * If false, we're using the old mechanism for stimer0 interrupts
- * where it sends a VMbus message when it expires. The old
- * mechanism is used when running on older versions of Hyper-V
- * that don't support Direct Mode. While Hyper-V provides
- * four stimer's per CPU, Linux uses only stimer0.
- */
-static bool direct_mode_enabled;
-static int stimer0_irq;
-static int stimer0_vector;
-
-#define HV_TIMER_FREQUENCY (10 * 1000 * 1000) /* 100ns period */
-#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
-#define HV_MIN_DELTA_TICKS 1
-
 /*
  * hv_init - Main initialization routine.
  *
@@ -47,9 +33,6 @@ int hv_init(void)
 	hv_context.cpu_context = alloc_percpu(struct hv_per_cpu_context);
 	if (!hv_context.cpu_context)
 		return -ENOMEM;
-
-	direct_mode_enabled = ms_hyperv.misc_features &
-			HV_STIMER_DIRECT_MODE_AVAILABLE;
 	return 0;
 }
 
@@ -88,89 +71,6 @@ int hv_post_message(union hv_connection_id connection_id,
 	return status & 0xFFFF;
 }
 
-/*
- * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
- * does not use VMbus or any VMbus messages, so process here and not
- * in the VMbus driver code.
- */
-
-static void hv_stimer0_isr(void)
-{
-	struct hv_per_cpu_context *hv_cpu;
-
-	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
-	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
-	add_interrupt_randomness(stimer0_vector, 0);
-}
-
-static int hv_ce_set_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	u64 current_tick;
-
-	WARN_ON(!clockevent_state_oneshot(evt));
-
-	current_tick = hyperv_cs->read(NULL);
-	current_tick += delta;
-	hv_init_timer(0, current_tick);
-	return 0;
-}
-
-static int hv_ce_shutdown(struct clock_event_device *evt)
-{
-	hv_init_timer(0, 0);
-	hv_init_timer_config(0, 0);
-	if (direct_mode_enabled)
-		hv_disable_stimer0_percpu_irq(stimer0_irq);
-
-	return 0;
-}
-
-static int hv_ce_set_oneshot(struct clock_event_device *evt)
-{
-	union hv_stimer_config timer_cfg;
-
-	timer_cfg.as_uint64 = 0;
-	timer_cfg.enable = 1;
-	timer_cfg.auto_enable = 1;
-	if (direct_mode_enabled) {
-		/*
-		 * When it expires, the timer will directly interrupt
-		 * on the specified hardware vector/IRQ.
-		 */
-		timer_cfg.direct_mode = 1;
-		timer_cfg.apic_vector = stimer0_vector;
-		hv_enable_stimer0_percpu_irq(stimer0_irq);
-	} else {
-		/*
-		 * When it expires, the timer will generate a VMbus message,
-		 * to be handled by the normal VMbus interrupt handler.
-		 */
-		timer_cfg.direct_mode = 0;
-		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
-	}
-	hv_init_timer_config(0, timer_cfg.as_uint64);
-	return 0;
-}
-
-static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
-{
-	dev->name = "Hyper-V clockevent";
-	dev->features = CLOCK_EVT_FEAT_ONESHOT;
-	dev->cpumask = cpumask_of(cpu);
-	dev->rating = 1000;
-	/*
-	 * Avoid settint dev->owner = THIS_MODULE deliberately as doing so will
-	 * result in clockevents_config_and_register() taking additional
-	 * references to the hv_vmbus module making it impossible to unload.
-	 */
-
-	dev->set_state_shutdown = hv_ce_shutdown;
-	dev->set_state_oneshot = hv_ce_set_oneshot;
-	dev->set_next_event = hv_ce_set_next_event;
-}
-
-
 int hv_synic_alloc(void)
 {
 	int cpu;
@@ -199,14 +99,6 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
-					  GFP_KERNEL);
-		if (hv_cpu->clk_evt == NULL) {
-			pr_err("Unable to allocate clock event device\n");
-			goto err;
-		}
-		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
-
 		hv_cpu->synic_message_page =
 			(void *)get_zeroed_page(GFP_ATOMIC);
 		if (hv_cpu->synic_message_page == NULL) {
@@ -229,11 +121,6 @@ int hv_synic_alloc(void)
 		INIT_LIST_HEAD(&hv_cpu->chan_list);
 	}
 
-	if (direct_mode_enabled &&
-	    hv_setup_stimer0_irq(&stimer0_irq, &stimer0_vector,
-				hv_stimer0_isr))
-		goto err;
-
 	return 0;
 err:
 	/*
@@ -252,7 +139,6 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		kfree(hv_cpu->clk_evt);
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
@@ -311,36 +197,9 @@ int hv_synic_init(unsigned int cpu)
 
 	hv_set_synic_state(sctrl.as_uint64);
 
-	/*
-	 * Register the per-cpu clockevent source.
-	 */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE)
-		clockevents_config_and_register(hv_cpu->clk_evt,
-						HV_TIMER_FREQUENCY,
-						HV_MIN_DELTA_TICKS,
-						HV_MAX_MAX_DELTA_TICKS);
-	return 0;
-}
-
-/*
- * hv_synic_clockevents_cleanup - Cleanup clockevent devices
- */
-void hv_synic_clockevents_cleanup(void)
-{
-	int cpu;
+	hv_stimer_init(cpu);
 
-	if (!(ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE))
-		return;
-
-	if (direct_mode_enabled)
-		hv_remove_stimer0_irq(stimer0_irq);
-
-	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
-
-		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
-	}
+	return 0;
 }
 
 /*
@@ -388,14 +247,7 @@ int hv_synic_cleanup(unsigned int cpu)
 	if (channel_found && vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
-	/* Turn off clockevent device */
-	if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
-		struct hv_per_cpu_context *hv_cpu
-			= this_cpu_ptr(hv_context.cpu_context);
-
-		clockevents_unbind_device(hv_cpu->clk_evt, cpu);
-		hv_ce_shutdown(hv_cpu->clk_evt);
-	}
+	hv_stimer_cleanup(cpu);
 
 	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b8e1ff05f110..362e70e9d145 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -138,7 +138,6 @@ struct hv_per_cpu_context {
 	 * per-cpu list of the channels based on their CPU affinity.
 	 */
 	struct list_head chan_list;
-	struct clock_event_device *clk_evt;
 };
 
 struct hv_context {
@@ -176,8 +175,6 @@ extern int hv_synic_init(unsigned int cpu);
 
 extern int hv_synic_cleanup(unsigned int cpu);
 
-extern void hv_synic_clockevents_cleanup(void);
-
 /* Interface */
 
 void hv_ringbuffer_pre_init(struct vmbus_channel *channel);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 92b1874b3eb3..72d5a7cde7ea 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -30,6 +30,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
 
 struct vmbus_dynid {
@@ -955,17 +956,6 @@ static void vmbus_onmessage_work(struct work_struct *work)
 	kfree(ctx);
 }
 
-static void hv_process_timer_expiration(struct hv_message *msg,
-					struct hv_per_cpu_context *hv_cpu)
-{
-	struct clock_event_device *dev = hv_cpu->clk_evt;
-
-	if (dev->event_handler)
-		dev->event_handler(dev);
-
-	vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
-}
-
 void vmbus_on_msg_dpc(unsigned long data)
 {
 	struct hv_per_cpu_context *hv_cpu = (void *)data;
@@ -1159,9 +1149,10 @@ static void vmbus_isr(void)
 
 	/* Check if there are actual msgs to be processed */
 	if (msg->header.message_type != HVMSG_NONE) {
-		if (msg->header.message_type == HVMSG_TIMER_EXPIRED)
-			hv_process_timer_expiration(msg, hv_cpu);
-		else
+		if (msg->header.message_type == HVMSG_TIMER_EXPIRED) {
+			hv_stimer0_isr();
+			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
+		} else
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
@@ -1263,14 +1254,19 @@ static int vmbus_bus_init(void)
 	ret = hv_synic_alloc();
 	if (ret)
 		goto err_alloc;
+
+	ret = hv_stimer_alloc(VMBUS_MESSAGE_SINT);
+	if (ret < 0)
+		goto err_alloc;
+
 	/*
-	 * Initialize the per-cpu interrupt state and
-	 * connect to the host.
+	 * Initialize the per-cpu interrupt state and stimer state.
+	 * Then connect to the host.
 	 */
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_alloc;
+		goto err_cpuhp;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1318,6 +1314,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
+err_cpuhp:
+	hv_stimer_free();
 err_alloc:
 	hv_synic_free();
 	hv_remove_vmbus_irq();
@@ -2064,7 +2062,7 @@ static struct acpi_driver vmbus_acpi_driver = {
 
 static void hv_kexec_handler(void)
 {
-	hv_synic_clockevents_cleanup();
+	hv_stimer_global_cleanup();
 	vmbus_initiate_unload(false);
 	vmbus_connection.conn_state = DISCONNECTED;
 	/* Make sure conn_state is set as hv_synic_cleanup checks for it */
@@ -2075,6 +2073,8 @@ static void hv_kexec_handler(void)
 
 static void hv_crash_handler(struct pt_regs *regs)
 {
+	int cpu;
+
 	vmbus_initiate_unload(true);
 	/*
 	 * In crash handler we can't schedule synic cleanup for all CPUs,
@@ -2082,7 +2082,9 @@ static void hv_crash_handler(struct pt_regs *regs)
 	 * for kdump.
 	 */
 	vmbus_connection.conn_state = DISCONNECTED;
-	hv_synic_cleanup(smp_processor_id());
+	cpu = smp_processor_id();
+	hv_stimer_cleanup(cpu);
+	hv_synic_cleanup(cpu);
 	hyperv_cleanup();
 };
 
@@ -2131,7 +2133,7 @@ static void __exit vmbus_exit(void)
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
 	vmbus_connection.conn_state = DISCONNECTED;
-	hv_synic_clockevents_cleanup();
+	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	hv_remove_vmbus_irq();
 	for_each_online_cpu(cpu) {
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
new file mode 100644
index 000000000000..0cd73f7bc992
--- /dev/null
+++ b/include/clocksource/hyperv_timer.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Definitions for the clocksource provided by the Hyper-V
+ * hypervisor to guest VMs, as described in the Hyper-V Top
+ * Level Functional Spec (TLFS).
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author:  Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef __CLKSOURCE_HYPERV_TIMER_H
+#define __CLKSOURCE_HYPERV_TIMER_H
+
+#define HV_MAX_MAX_DELTA_TICKS 0xffffffff
+#define HV_MIN_DELTA_TICKS 1
+
+/* Routines called by the VMbus driver */
+extern int hv_stimer_alloc(int sint);
+extern void hv_stimer_free(void);
+extern void hv_stimer_init(unsigned int cpu);
+extern void hv_stimer_cleanup(unsigned int cpu);
+extern void hv_stimer_global_cleanup(void);
+extern void hv_stimer0_isr(void);
+
+#endif
