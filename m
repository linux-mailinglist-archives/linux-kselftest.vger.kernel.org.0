Return-Path: <linux-kselftest+bounces-4093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272F8485D9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 13:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6D1C206A8
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861665EE91;
	Sat,  3 Feb 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUOIA9nd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE696EB49;
	Sat,  3 Feb 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963510; cv=none; b=fj6wRn9oNpiwa60Yiky+H/zhv63L32jmgKUhoIeP/S0b6RBjQoPHNRLWdJ1G58LlNQ6EvHEqvlopzngvlj47Mb9l5uDWUhAvQoJ8h5SudRHYwGPkuhrQ0qG2A5apfiVXO14ZH09Xf4516sOCX+pZXq0C7RALKYiUuIzLrm7Ei2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963510; c=relaxed/simple;
	bh=LIgg9EoXLUqmc2NONgYIbWfk2OpP+a7HqWePlA8MwVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy6HleirpPGrjmD/93pJ1cpJx3o3ABbFLS+Eq9ig7YQQDmhXnmD9SHG87bENpkTiZ1im/fRHvR1tFHPbsxSW34Et97FNWFXPsC/ewbpTNKyTCtslhsj//6AlDDgOo5eAAJRiinYwcbAPmmP3ebNKVeicALNbhPGiqu+5hf4AiN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUOIA9nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFFEC43330;
	Sat,  3 Feb 2024 12:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963509;
	bh=LIgg9EoXLUqmc2NONgYIbWfk2OpP+a7HqWePlA8MwVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gUOIA9ndUINB2R/yJNvtN6eVwihasL3005KinxnSLiwpk0GxMBdKWGozutVVJklg3
	 wZ8ygQruhZ/pwNXoA0V3AFkBl+plMbl+00zVLDPu/2Ooc9gstY+9eIp9qwwPhBGTkD
	 eGbiE2bvHjwutwFf0iWe0xwvy1gtYv9tRGh4pxjJDMh+rWcxEsnmCVzY+SIpztgFyo
	 t1JXjYOVecnGx5gQhX0hyiLW7bynoAoum/y5tfiNBkIEqnn/Mdf4YHk0IG4qxgkSXO
	 Loiw5tzHOxj2GqXh4UA+3oogNkWzY9VXBMAESEAshhBkKlsuMqfzKzrfJQGfxuCIwd
	 Ti40XkH2BccVQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:45 +0000
Subject: [PATCH v8 19/38] arm64/gcs: Context switch GCS state for EL0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-19-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6699; i=broonie@kernel.org;
 h=from:subject:message-id; bh=LIgg9EoXLUqmc2NONgYIbWfk2OpP+a7HqWePlA8MwVc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDg71pKnNHZwjL83REQOHC73wjfzFbk5eebs5dp
 bg19mBaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w4AAKCRAk1otyXVSH0LkKB/
 0bnKzvF70bw/d4BodS7eaSl34KwfWWf1Ect1459rOEJNxs5uWJGgP8HzIVk5Rw5fGkLBHsxv8fOyUd
 ma29YJS6mSWJW4eeGoYhB8RS2dNPjudICQO76RD9pi2pHCgvbmri5dngn8TdZBzvlWEFbd2Hx2vduS
 fg3g9TvaF4Hp76hXwrwvqdj9MMs7fCG6Hg1euetOuvo4rYyhKyt7QfgEV8npXHf2B6fNAeCtpPOPMX
 O3GuVwS5gBFH5k0levGdB/GmuPYOYmYJ7o8OAaczf88LBa8imYcMx2pfTHf50pAkTeeiFYlDY4rvpj
 R0ZD8Bp4CFjm/TZDl0UFQ8RXVj5AId
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 24 ++++++++++++++++
 arch/arm64/include/asm/processor.h |  6 ++++
 arch/arm64/kernel/process.c        | 56 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/gcs.c                | 39 ++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)

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
index 5b0a04810b23..6fc6dcbd494c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -182,6 +182,12 @@ struct thread_struct {
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
index 7387b68c745b..fd80b43c2969 100644
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
@@ -474,6 +495,40 @@ static void entry_task_switch(struct task_struct *next)
 	__this_cpu_write(__entry_task, next);
 }
 
+#ifdef CONFIG_ARM64_GCS
+
+void gcs_preserve_current_state(void)
+{
+	if (task_gcs_el0_enabled(current))
+		current->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+}
+
+static void gcs_thread_switch(struct task_struct *next)
+{
+	if (!system_supports_gcs())
+		return;
+
+	gcs_preserve_current_state();
+
+	gcs_set_el0_mode(next);
+	write_sysreg_s(next->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	/*
+	 * Ensure that GCS changes are observable by/from other PEs in
+	 * case of migration.
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
@@ -533,6 +588,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	ssbs_thread_switch(next);
 	erratum_1418040_thread_switch(next);
 	ptrauth_thread_switch_user(next);
+	gcs_thread_switch(next);
 
 	/*
 	 * Complete any pending TLB or cache maintenance on this CPU in case
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index dbd1bc95967d..4e7cb2f02999 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
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
2.30.2


