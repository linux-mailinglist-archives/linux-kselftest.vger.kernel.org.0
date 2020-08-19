Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B1A249D90
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHSMOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 08:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSMOE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 08:14:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BF0207BB;
        Wed, 19 Aug 2020 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839243;
        bh=HR11PdYBvh2kcllXkA7X72cUQrugXv/fyUKLaDrD1NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIiwEtfVwOI1891Y3mg15Z62mKkn2wU8U4oDMyYAsM+LxmedSKVGWbsnbN6t7FWi1
         TyXxeu0E7sJrl9kF6zegPd7t5mQ3vVwjHNihK7hvU2yIVNu+uJa1EXVFioU+T2FLdX
         6Ak2O8wTP4fcOkBKhu2Sd6vBL1YsRWHtqUYRMwEY=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/5] arm64: vdso: Add per-CPU data
Date:   Wed, 19 Aug 2020 13:13:15 +0100
Message-Id: <20200819121318.52158-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819121318.52158-1-broonie@kernel.org>
References: <20200819121318.52158-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to support a vDSO getcpu() implementation add per-CPU data to
the vDSO data page. Do this by wrapping the generic vdso_data struct in
an arm64 specific one with an array of per-CPU data. The offset of the
per-CPU data applying to a CPU will be stored in TPIDRRO_EL0, this
allows us to get to the per-CPU data without doing any multiplications.

Since we currently only map a single data page for the vDSO but support
very large numbers of CPUs TPIDRRO may be set to zero for CPUs which don't
fit in the data page. This will also happen when KPTI is active since
kernel_ventry uses TPIDRRO_EL0 as a scratch register in that case, add a
comment to the code explaining this.

Acessors for the data are provided in the header since they will be needed
in multiple files and it seems neater to keep things together.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/processor.h     | 12 +-----
 arch/arm64/include/asm/vdso/datapage.h | 54 ++++++++++++++++++++++++++
 arch/arm64/kernel/process.c            | 26 ++++++++++++-
 arch/arm64/kernel/vdso.c               |  5 ++-
 4 files changed, 83 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/datapage.h

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 240fe5e5b720..db7a804030b3 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -207,17 +207,7 @@ static inline void set_compat_ssbs_bit(struct pt_regs *regs)
 	regs->pstate |= PSR_AA32_SSBS_BIT;
 }
 
-static inline void start_thread(struct pt_regs *regs, unsigned long pc,
-				unsigned long sp)
-{
-	start_thread_common(regs, pc);
-	regs->pstate = PSR_MODE_EL0t;
-
-	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
-		set_ssbs_bit(regs);
-
-	regs->sp = sp;
-}
+void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp);
 
 static inline bool is_ttbr0_addr(unsigned long addr)
 {
diff --git a/arch/arm64/include/asm/vdso/datapage.h b/arch/arm64/include/asm/vdso/datapage.h
new file mode 100644
index 000000000000..e88d97238c52
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/datapage.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 ARM Limited
+ */
+#ifndef __ASM_VDSO_DATAPAGE_H
+#define __ASM_VDSO_DATAPAGE_H
+
+#include <vdso/datapage.h>
+
+struct vdso_cpu_data {
+	unsigned int cpu;
+	unsigned int node;
+};
+
+struct arm64_vdso_data {
+	/* Must be first in struct, we cast to vdso_data */
+	struct vdso_data data[CS_BASES];
+	struct vdso_cpu_data cpu_data[];
+};
+
+#ifdef __VDSO__
+static inline struct vdso_cpu_data *__vdso_cpu_data(void)
+{
+	unsigned long offset;
+
+	asm volatile(
+		"mrs %0, tpidrro_el0\n"
+	: "=r" (offset)
+	:
+	: "cc");
+
+	if (offset)
+		return (void *)(_vdso_data) + offset;
+
+	return NULL;
+}
+#else
+static inline size_t vdso_cpu_offset(void)
+{
+	size_t offset, data_end;
+
+	offset = offsetof(struct arm64_vdso_data, cpu_data) +
+		smp_processor_id() * sizeof(struct vdso_cpu_data);
+	data_end = offset + sizeof(struct vdso_cpu_data) + 1;
+
+	/* We only map a single page for vDSO data currently */
+	if (data_end > PAGE_SIZE)
+		return 0;
+
+	return offset;
+}
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 84ec630b8ab5..89b400f9397d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -55,6 +55,7 @@
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
+#include <asm/vdso/datapage.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
@@ -309,6 +310,28 @@ void show_regs(struct pt_regs * regs)
 	dump_backtrace(regs, NULL, KERN_DEFAULT);
 }
 
+void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
+{
+	start_thread_common(regs, pc);
+	regs->pstate = PSR_MODE_EL0t;
+
+	if (arm64_get_ssbd_state() != ARM64_SSBD_FORCE_ENABLE)
+		set_ssbs_bit(regs);
+
+	regs->sp = sp;
+
+	/*
+	 * Store the vDSO per-CPU offset if supported. Disable
+	 * preemption to make sure we read the CPU offset on the CPU
+	 * we write it on.
+	 */
+	if (!arm64_kernel_unmapped_at_el0()) {
+		preempt_disable();
+		write_sysreg(vdso_cpu_offset(), tpidrro_el0);
+		preempt_enable();
+	}
+}
+
 static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
@@ -452,7 +475,8 @@ static void tls_thread_switch(struct task_struct *next)
 	if (is_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
 	else if (!arm64_kernel_unmapped_at_el0())
-		write_sysreg(0, tpidrro_el0);
+		/* Used as scratch in KPTI trampoline so don't set here. */
+		write_sysreg(vdso_cpu_offset(), tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index d4202a32abc9..2a8d7ab76bee 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -28,6 +28,7 @@
 #include <asm/cacheflush.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
+#include <asm/vdso/datapage.h>
 
 extern char vdso_start[], vdso_end[];
 #ifdef CONFIG_COMPAT_VDSO
@@ -77,10 +78,10 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
  * The vDSO data page.
  */
 static union {
-	struct vdso_data	data[CS_BASES];
+	struct arm64_vdso_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = vdso_data_store.data;
+struct vdso_data *vdso_data = vdso_data_store.data.data;
 
 static int __vdso_remap(enum vdso_abi abi,
 			const struct vm_special_mapping *sm,
-- 
2.20.1

