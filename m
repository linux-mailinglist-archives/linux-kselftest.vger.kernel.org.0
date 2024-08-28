Return-Path: <linux-kselftest+bounces-16618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A129635CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 01:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A531B25FAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F671B5337;
	Wed, 28 Aug 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otQuTQdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52F1AE867;
	Wed, 28 Aug 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887859; cv=none; b=Igr2Mob6RsSn3WgCyByce98aQGlpm9+aNQwNj1+BGBSwj7BLWdGHmgoCoOlCigcXtCgkChqRlTbZAVK0Posn7jcrY/elItp1qUowAGyPeQcgEEI+FbX3zXMKwxE9tSAFKfw8o3uooN2XrdgmqZ7Mgrua9WBxB692/Yc0WRKxhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887859; c=relaxed/simple;
	bh=sydLriD9HWAooq5yd+cFzuUdkx2R+cx9auWZHUCA7fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbancr+ShbLxbjqdLL6ngkZD2VtOD71vaHrH8XMlN3K+QoWG4BG+KCRikhAhm3yPUtFrYtIhdHu5ksRTzzyCq+eMHVdK+XYS11Z5vVcefXpN/qthd7g0dEUN8mrtAcTof/IcoDyHfLm2l5+O2i1CPBkqxoLFrKS/XA7ik7io27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otQuTQdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33925C4CEC5;
	Wed, 28 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887858;
	bh=sydLriD9HWAooq5yd+cFzuUdkx2R+cx9auWZHUCA7fY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=otQuTQdp3wk4hcDOpjNnIrsQg9KwhgaBu5nx/u8HDL40Y7pR+jwHY9XxR7ZEWI1NU
	 NRRvw9nWhLQGps7I7wTBCL9a4JyiewgCme094HrHD/rbMJ9nUSr2fBWGMwSgMwJgPA
	 z4HXz91hU69poRSngzfP+0sDDBbh6yG3aLEVdY+LoYb/5zZPUpm4OY0Lu0HZ31ZC3W
	 vv2AQd1cOVqNYUN/GO+VPnymTlwZXqzN70XnQzAVhseCYLdPW5EqiguurR2SqhPTGu
	 44udrqET8WA/QduW7M/ojCL8+5xJpTZtWNaLehopKUxmyXauNsX48h4RCD1uH7QFA5
	 1QcvwBWd7x28Q==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:36 +0100
Subject: [PATCH v12 20/39] arm64/gcs: Context switch GCS state for EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-20-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=7225; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sydLriD9HWAooq5yd+cFzuUdkx2R+cx9auWZHUCA7fY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KIKy2R7h93FkcxSJ/JfAGC1aobAQmoB1N96ecE
 blTmFraJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yiAAKCRAk1otyXVSH0GSaB/
 9gxycINt4jGEeumEzdfCbt1p9bcOTP7yN85Ty0JiwmkCl9PI+CjA8zGVZph/94PzIc5flRKldAYMqf
 hCBFkL0f+/lxgMmZ5gUQS7U+FGEwCAHAcw9L+4mtP0sqt6SGcbriQEHK8FpJkBwE41vHrjO+LEEoug
 jJEGciaeFVePAaCgtS4Ngbi325zdvvfp3ADSjEtispU3e+oWL0ZF8yxPXlBlm9xSy/doD5IoP4tfET
 XGytk6FbkXpLtqCteSaV9DSybym1c4aqlEsaWmwlYo3GoEjHwHnF+z7Ej1h0fCtEyw1Z6UnFEtVL66
 AvC2vr7F6fs0bTjLe+ljshUsfu+8oq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are two registers controlling the GCS state of EL0, GCSPR_EL0 which
is the current GCS pointer and GCSCRE0_EL1 which has enable bits for the
specific GCS functionality enabled for EL0. Manage these on context switch
and process lifetime events, GCS is reset on exec().  Also ensure that
any changes to the GCS memory are visible to other PEs and that changes
from other PEs are visible on this one by issuing a GCSB DSYNC when
moving to or from a thread with GCS.

Since the current GCS configuration of a thread will be visible to
userspace we store the configuration in the format used with userspace
and provide a helper which configures the system register as needed.

On systems that support GCS we always allow access to GCSPR_EL0, this
facilitates reporting of GCS faults if userspace implements disabling of
GCS on error - the GCS can still be discovered and examined even if GCS
has been disabled.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 24 +++++++++++++++
 arch/arm64/include/asm/processor.h |  6 ++++
 arch/arm64/kernel/process.c        | 62 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/gcs.c                | 39 ++++++++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 7c5e95218db6..04594ef59dad 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -48,4 +48,28 @@ static inline u64 gcsss2(void)
 	return Xt;
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE;
+}
+
+void gcs_set_el0_mode(struct task_struct *task);
+void gcs_free(struct task_struct *task);
+void gcs_preserve_current_state(void);
+
+#else
+
+static inline bool task_gcs_el0_enabled(struct task_struct *task)
+{
+	return false;
+}
+
+static inline void gcs_set_el0_mode(struct task_struct *task) { }
+static inline void gcs_free(struct task_struct *task) { }
+static inline void gcs_preserve_current_state(void) { }
+
+#endif
+
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f77371232d8c..c55e3600604a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -184,6 +184,12 @@ struct thread_struct {
 	u64			sctlr_user;
 	u64			svcr;
 	u64			tpidr2_el0;
+#ifdef CONFIG_ARM64_GCS
+	unsigned int		gcs_el0_mode;
+	u64			gcspr_el0;
+	u64			gcs_base;
+	u64			gcs_size;
+#endif
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 4ae31b7af6c3..3622956b6515 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
+#include <asm/gcs.h>
 #include <asm/mmu_context.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
@@ -271,12 +272,32 @@ static void flush_tagged_addr_state(void)
 		clear_thread_flag(TIF_TAGGED_ADDR);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+static void flush_gcs(void)
+{
+	if (!system_supports_gcs())
+		return;
+
+	gcs_free(current);
+	current->thread.gcs_el0_mode = 0;
+	write_sysreg_s(0, SYS_GCSCRE0_EL1);
+	write_sysreg_s(0, SYS_GCSPR_EL0);
+}
+
+#else
+
+static void flush_gcs(void) { }
+
+#endif
+
 void flush_thread(void)
 {
 	fpsimd_flush_thread();
 	tls_thread_flush();
 	flush_ptrace_hw_breakpoint(current);
 	flush_tagged_addr_state();
+	flush_gcs();
 }
 
 void arch_release_task_struct(struct task_struct *tsk)
@@ -471,6 +492,46 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+void gcs_preserve_current_state(void)
+{
+	current->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+}
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+	if (!system_supports_gcs())
+		return;
+
+	/* GCSPR_EL0 is always readable */
+	gcs_preserve_current_state();
+	write_sysreg_s(next->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	if (current->thread.gcs_el0_mode != next->thread.gcs_el0_mode)
+		gcs_set_el0_mode(next);
+
+	/*
+	 * Ensure that GCS memory effects of the 'prev' thread are
+	 * ordered before other memory accesses with release semantics
+	 * (or preceded by a DMB) on the current PE. In addition, any
+	 * memory accesses with acquire semantics (or succeeded by a
+	 * DMB) are ordered before GCS memory effects of the 'next'
+	 * thread. This will ensure that the GCS memory effects are
+	 * visible to other PEs in case of migration.
+	 */
+	if (task_gcs_el0_enabled(current) || task_gcs_el0_enabled(next))
+		gcsb_dsync();
+}
+
+#else
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+}
+
+#endif
+
 /*
  * ARM erratum 1418040 handling, affecting the 32bit view of CNTVCT.
  * Ensure access is disabled when switching to a 32bit task, ensure
@@ -530,6 +591,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	gcs_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 60454256945b..1a7b3a2f21e6 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
 obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
+obj-$(CONFIG_ARM64_GCS)		+= gcs.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
new file mode 100644
index 000000000000..b0a67efc522b
--- /dev/null
+++ b/arch/arm64/mm/gcs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+
+#include <asm/cpufeature.h>
+#include <asm/page.h>
+
+/*
+ * Apply the GCS mode configured for the specified task to the
+ * hardware.
+ */
+void gcs_set_el0_mode(struct task_struct *task)
+{
+	u64 gcscre0_el1 = GCSCRE0_EL1_nTR;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
+		gcscre0_el1 |= GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRSEL;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_WRITE)
+		gcscre0_el1 |= GCSCRE0_EL1_STREn;
+
+	if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_PUSH)
+		gcscre0_el1 |= GCSCRE0_EL1_PUSHMEn;
+
+	write_sysreg_s(gcscre0_el1, SYS_GCSCRE0_EL1);
+}
+
+void gcs_free(struct task_struct *task)
+{
+	if (task->thread.gcs_base)
+		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
+
+	task->thread.gcspr_el0 = 0;
+	task->thread.gcs_base = 0;
+	task->thread.gcs_size = 0;
+}

-- 
2.39.2


