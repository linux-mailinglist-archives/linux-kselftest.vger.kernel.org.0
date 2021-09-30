Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BE41E0BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353325AbhI3SRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73E3461A02;
        Thu, 30 Sep 2021 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025753;
        bh=q1FA8H9m3b+rWqgMMgd+G0Kc9piB6hDob9CF3wlnLc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+53p/vzeOiWl+E3H+SNqNkaFmDf30og4jqobO9cwu2FgD+8l7Sb9wgEwAzwNS3xM
         9DgealadzXpUcGzHqgCboaOLupIwJy1wJu9KUl+0tuovNb8bi8x4mOdRc5tCvflI/I
         9rC5PjhBx3WfBMn3YBbsUu6YDi4TsKUrqvZS2HmcwCQ5eU6Iyv09Ga4HZggHtBOWfY
         zcuaE+37ztpAdmvisMwK0wQTEQqq1AsONoSu7Rry33IeSnzaXZeL9z+pabfT6Fbt6F
         jqhbQ+Gd6yJ5t5wUpkV5ZZ9g3YDNYh8/0+o3E0pOykxoJ1Tja7ARcAUqK2p7X473PP
         u/xZlpsKcWH9Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 06/38] arm64/sve: Put system wide vector length information into structs
Date:   Thu, 30 Sep 2021 19:11:12 +0100
Message-Id: <20210930181144.10029-7-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21499; h=from:subject; bh=q1FA8H9m3b+rWqgMMgd+G0Kc9piB6hDob9CF3wlnLc4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3GHQ9yLYlT7t69uAUrNzDbllZWryvk9NtUIRoN 91GfPZWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9xgAKCRAk1otyXVSH0MDbB/ 9tpo6Alp7Hxplv0nkwgutqtl9z88/NjNc6qzRrgAmMhPCSnLkI8gVor0HjpWiTYbczd8mJvaHK8+Wd qgCLxMeB3pRJnfKa1DwTGs/ClKxyUy3x8ae1MA6At3Dj6sO3TgRCKWj2FProBZgPXxhG5FoSJmpZIp TEN7oCM0IuWx3Sagm4juI4+AP9lBcEey9WnWYR2nVmHkbqWea8oCyhic2HMQ23DDXyvFjK8C4Xshn5 KlqVVuURvIEMRuw8qJPJUERruGQmWBnrXEJAf3HOgzGGN9OjVSDBXkcyvaqMoC7GdBgGL8D3kIMfzP J5Sti0QKThfRPflGmGAV3NR2cbLa+5
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the introduction of SME we will have a second vector length in the
system, enumerated and configured in a very similar fashion to the
existing SVE vector length.  While there are a few differences in how
things are handled this is a relatively small portion of the overall
code so in order to avoid code duplication we factor out

We create two structs, one vl_info for the static hardware properties
and one vl_config for the runtime configuration, with an array
instantiated for each and update all the users to reference these. Some
accessor functions are provided where helpful for readability, and the
write to set the vector length is put into a function since the system
register being updated needs to be chosen at compile time.

This is a mostly mechanical replacement, further work will be required
to actually make things generic, ensuring that we handle those places
where there are differences properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h    |  90 +++++++++++++---
 arch/arm64/include/asm/processor.h |   5 +
 arch/arm64/kernel/cpufeature.c     |   6 +-
 arch/arm64/kernel/fpsimd.c         | 163 ++++++++++++++++-------------
 arch/arm64/kernel/ptrace.c         |   2 +-
 arch/arm64/kernel/signal.c         |   2 +-
 arch/arm64/kvm/reset.c             |   6 +-
 7 files changed, 183 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 7d0204f77f90..02fa676d1a9a 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -77,10 +77,6 @@ extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern u64 read_zcr_features(void);
 
-extern int __ro_after_init sve_max_vl;
-extern int __ro_after_init sve_max_virtualisable_vl;
-extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
-
 /*
  * Helpers to translate bit indices in sve_vq_map to VQ values (and
  * vice versa).  This allows find_next_bit() to be used to find the
@@ -96,11 +92,6 @@ static inline unsigned int __bit_to_vq(unsigned int bit)
 	return SVE_VQ_MAX - bit;
 }
 
-/* Ensure vq >= SVE_VQ_MIN && vq <= SVE_VQ_MAX before calling this function */
-static inline bool sve_vq_available(unsigned int vq)
-{
-	return test_bit(__vq_to_bit(vq), sve_vq_map);
-}
 
 #ifdef CONFIG_ARM64_SVE
 
@@ -141,11 +132,84 @@ static inline void sve_user_enable(void)
  * Probing and setup functions.
  * Calls to these functions must be serialised with one another.
  */
-extern void __init sve_init_vq_map(void);
-extern void sve_update_vq_map(void);
-extern int sve_verify_vq_map(void);
+enum vec_type;
+
+extern void __init vec_init_vq_map(enum vec_type type);
+extern void vec_update_vq_map(enum vec_type type);
+extern int vec_verify_vq_map(enum vec_type type);
 extern void __init sve_setup(void);
 
+struct vl_info {
+	enum vec_type type;
+	const char *name;		/* For display purposes */
+
+	/* Minimum supported vector length across all CPUs */
+	int min_vl;
+
+	/* Maximum supported vector length across all CPUs */
+	int max_vl;
+	int max_virtualisable_vl;
+
+	/*
+	 * Set of available vector lengths,
+	 * where length vq encoded as bit __vq_to_bit(vq):
+	 */
+	DECLARE_BITMAP(vq_map, SVE_VQ_MAX);
+
+	/* Set of vector lengths present on at least one cpu: */
+	DECLARE_BITMAP(vq_partial_map, SVE_VQ_MAX);
+};
+
+extern __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX];
+
+static inline void write_vl(enum vec_type type, u64 val)
+{
+	u64 tmp;
+
+	switch (type) {
+#ifdef CONFIG_ARM64_SVE
+	case ARM64_VEC_SVE:
+		tmp = read_sysreg_s(SYS_ZCR_EL1) & ~ZCR_ELx_LEN_MASK;
+		write_sysreg_s(tmp | val, SYS_ZCR_EL1);
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
+static inline int vec_max_vl(enum vec_type type)
+{
+	return vl_info[type].max_vl;
+}
+
+static inline int vec_max_virtualisable_vl(enum vec_type type)
+{
+	return vl_info[type].max_virtualisable_vl;
+}
+
+static inline int sve_max_vl(void)
+{
+	return vec_max_vl(ARM64_VEC_SVE);
+}
+
+static inline int sve_max_virtualisable_vl(void)
+{
+	return vec_max_virtualisable_vl(ARM64_VEC_SVE);
+}
+
+/* Ensure vq >= SVE_VQ_MIN && vq <= SVE_VQ_MAX before calling this function */
+static inline bool vq_available(enum vec_type type, unsigned int vq)
+{
+	return test_bit(__vq_to_bit(vq), vl_info[type].vq_map);
+}
+
+static inline bool sve_vq_available(unsigned int vq)
+{
+	return vq_available(ARM64_VEC_SVE, vq);
+}
+
 #else /* ! CONFIG_ARM64_SVE */
 
 static inline void sve_alloc(struct task_struct *task) { }
@@ -163,6 +227,8 @@ static inline int sve_get_current_vl(void)
 	return -EINVAL;
 }
 
+static inline bool sve_vq_available(unsigned int vq) { return false; }
+
 static inline void sve_user_disable(void) { BUILD_BUG(); }
 static inline void sve_user_enable(void) { BUILD_BUG(); }
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index adb6a46a1fae..fb0608fe9ded 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -115,6 +115,11 @@ struct debug_info {
 #endif
 };
 
+enum vec_type {
+	ARM64_VEC_SVE = 0,
+	ARM64_VEC_MAX,
+};
+
 struct cpu_context {
 	unsigned long x19;
 	unsigned long x20;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ec7036ef7e1..405a65d7e618 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -941,7 +941,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
-		sve_init_vq_map();
+		vec_init_vq_map(ARM64_VEC_SVE);
 	}
 
 	if (id_aa64pfr1_mte(info->reg_id_aa64pfr1))
@@ -1175,7 +1175,7 @@ void update_cpu_features(int cpu,
 		/* Probe vector lengths, unless we already gave up on SVE */
 		if (id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) &&
 		    !system_capabilities_finalized())
-			sve_update_vq_map();
+			vec_update_vq_map(ARM64_VEC_SVE);
 	}
 
 	/*
@@ -2739,7 +2739,7 @@ static void verify_sve_features(void)
 	unsigned int safe_len = safe_zcr & ZCR_ELx_LEN_MASK;
 	unsigned int len = zcr & ZCR_ELx_LEN_MASK;
 
-	if (len < safe_len || sve_verify_vq_map()) {
+	if (len < safe_len || vec_verify_vq_map(ARM64_VEC_SVE)) {
 		pr_crit("CPU%d: SVE: vector length support mismatch\n",
 			smp_processor_id());
 		cpu_die_early();
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b0acaa20457c..d45f14a68b9c 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -121,40 +121,51 @@ struct fpsimd_last_state_struct {
 
 static DEFINE_PER_CPU(struct fpsimd_last_state_struct, fpsimd_last_state);
 
-/* Default VL for tasks that don't set it explicitly: */
-static int __sve_default_vl = -1;
+__ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
+#ifdef CONFIG_ARM64_SVE
+	[ARM64_VEC_SVE] = {
+		.type			= ARM64_VEC_SVE,
+		.name			= "SVE",
+		.min_vl			= SVE_VL_MIN,
+		.max_vl			= SVE_VL_MIN,
+		.max_virtualisable_vl	= SVE_VL_MIN,
+	},
+#endif
+};
+
+struct vl_config {
+	int __default_vl;		/* Default VL for tasks */
+};
+
+static struct vl_config vl_config[ARM64_VEC_MAX];
+
+static int get_default_vl(enum vec_type type)
+{
+	return READ_ONCE(vl_config[type].__default_vl);
+}
+
+static void set_default_vl(enum vec_type type, int val)
+{
+	WRITE_ONCE(vl_config[type].__default_vl, val);
+}
 
 static int get_sve_default_vl(void)
 {
-	return READ_ONCE(__sve_default_vl);
+	return get_default_vl(ARM64_VEC_SVE);
 }
 
 #ifdef CONFIG_ARM64_SVE
 
 static void set_sve_default_vl(int val)
 {
-	WRITE_ONCE(__sve_default_vl, val);
+	set_default_vl(ARM64_VEC_SVE, val);
 }
 
-/* Maximum supported vector length across all CPUs (initially poisoned) */
-int __ro_after_init sve_max_vl = SVE_VL_MIN;
-int __ro_after_init sve_max_virtualisable_vl = SVE_VL_MIN;
-
-/*
- * Set of available vector lengths,
- * where length vq encoded as bit __vq_to_bit(vq):
- */
-__ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
-/* Set of vector lengths present on at least one cpu: */
-static __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
-
 static void __percpu *efi_sve_state;
 
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declaration for code that will be optimised out: */
-extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
-extern __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
 extern void __percpu *efi_sve_state;
 
 #endif /* ! CONFIG_ARM64_SVE */
@@ -357,21 +368,23 @@ static void fpsimd_save(void)
  * If things go wrong there's a bug somewhere, but try to fall back to a
  * safe choice.
  */
-static unsigned int find_supported_sve_vector_length(unsigned int vl)
+static unsigned int find_supported_vector_length(enum vec_type type,
+						 unsigned int vl)
 {
+	struct vl_info *info = &vl_info[type];
 	int bit;
-	int max_vl = sve_max_vl;
+	int max_vl = info->max_vl;
 
 	if (WARN_ON(!sve_vl_valid(vl)))
-		vl = SVE_VL_MIN;
+		vl = info->min_vl;
 
 	if (WARN_ON(!sve_vl_valid(max_vl)))
-		max_vl = SVE_VL_MIN;
+		max_vl = info->min_vl;
 
 	if (vl > max_vl)
 		vl = max_vl;
 
-	bit = find_next_bit(sve_vq_map, SVE_VQ_MAX,
+	bit = find_next_bit(info->vq_map, SVE_VQ_MAX,
 			    __vq_to_bit(sve_vq_from_vl(vl)));
 	return sve_vl_from_vq(__bit_to_vq(bit));
 }
@@ -381,6 +394,7 @@ static unsigned int find_supported_sve_vector_length(unsigned int vl)
 static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
 	int ret;
 	int vl = get_sve_default_vl();
 	struct ctl_table tmp_table = {
@@ -394,12 +408,12 @@ static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 
 	/* Writing -1 has the special meaning "set to max": */
 	if (vl == -1)
-		vl = sve_max_vl;
+		vl = info->max_vl;
 
 	if (!sve_vl_valid(vl))
 		return -EINVAL;
 
-	set_sve_default_vl(find_supported_sve_vector_length(vl));
+	set_sve_default_vl(find_supported_vector_length(ARM64_VEC_SVE, vl));
 	return 0;
 }
 
@@ -618,7 +632,7 @@ int sve_set_vector_length(struct task_struct *task,
 	if (vl > SVE_VL_ARCH_MAX)
 		vl = SVE_VL_ARCH_MAX;
 
-	vl = find_supported_sve_vector_length(vl);
+	vl = find_supported_vector_length(ARM64_VEC_SVE, vl);
 
 	if (flags & (PR_SVE_VL_INHERIT |
 		     PR_SVE_SET_VL_ONEXEC))
@@ -716,18 +730,15 @@ int sve_get_current_vl(void)
 	return sve_prctl_status(0);
 }
 
-static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
+static void vec_probe_vqs(struct vl_info *info,
+			  DECLARE_BITMAP(map, SVE_VQ_MAX))
 {
 	unsigned int vq, vl;
-	unsigned long zcr;
 
 	bitmap_zero(map, SVE_VQ_MAX);
 
-	zcr = ZCR_ELx_LEN_MASK;
-	zcr = read_sysreg_s(SYS_ZCR_EL1) & ~zcr;
-
 	for (vq = SVE_VQ_MAX; vq >= SVE_VQ_MIN; --vq) {
-		write_sysreg_s(zcr | (vq - 1), SYS_ZCR_EL1); /* self-syncing */
+		write_vl(info->type, vq - 1); /* self-syncing */
 		vl = sve_get_vl();
 		vq = sve_vq_from_vl(vl); /* skip intervening lengths */
 		set_bit(__vq_to_bit(vq), map);
@@ -738,10 +749,11 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
  * Initialise the set of known supported VQs for the boot CPU.
  * This is called during kernel boot, before secondary CPUs are brought up.
  */
-void __init sve_init_vq_map(void)
+void __init vec_init_vq_map(enum vec_type type)
 {
-	sve_probe_vqs(sve_vq_map);
-	bitmap_copy(sve_vq_partial_map, sve_vq_map, SVE_VQ_MAX);
+	struct vl_info *info = &vl_info[type];
+	vec_probe_vqs(info, info->vq_map);
+	bitmap_copy(info->vq_partial_map, info->vq_map, SVE_VQ_MAX);
 }
 
 /*
@@ -749,30 +761,33 @@ void __init sve_init_vq_map(void)
  * those not supported by the current CPU.
  * This function is called during the bring-up of early secondary CPUs only.
  */
-void sve_update_vq_map(void)
+void vec_update_vq_map(enum vec_type type)
 {
+	struct vl_info *info = &vl_info[type];
 	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
 
-	sve_probe_vqs(tmp_map);
-	bitmap_and(sve_vq_map, sve_vq_map, tmp_map, SVE_VQ_MAX);
-	bitmap_or(sve_vq_partial_map, sve_vq_partial_map, tmp_map, SVE_VQ_MAX);
+	vec_probe_vqs(info, tmp_map);
+	bitmap_and(info->vq_map, info->vq_map, tmp_map, SVE_VQ_MAX);
+	bitmap_or(info->vq_partial_map, info->vq_partial_map, tmp_map,
+		  SVE_VQ_MAX);
 }
 
 /*
  * Check whether the current CPU supports all VQs in the committed set.
  * This function is called during the bring-up of late secondary CPUs only.
  */
-int sve_verify_vq_map(void)
+int vec_verify_vq_map(enum vec_type type)
 {
+	struct vl_info *info = &vl_info[type];
 	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
 	unsigned long b;
 
-	sve_probe_vqs(tmp_map);
+	vec_probe_vqs(info, tmp_map);
 
 	bitmap_complement(tmp_map, tmp_map, SVE_VQ_MAX);
-	if (bitmap_intersects(tmp_map, sve_vq_map, SVE_VQ_MAX)) {
-		pr_warn("SVE: cpu%d: Required vector length(s) missing\n",
-			smp_processor_id());
+	if (bitmap_intersects(tmp_map, info->vq_map, SVE_VQ_MAX)) {
+		pr_warn("%s: cpu%d: Required vector length(s) missing\n",
+			info->name, smp_processor_id());
 		return -EINVAL;
 	}
 
@@ -788,7 +803,7 @@ int sve_verify_vq_map(void)
 	/* Recover the set of supported VQs: */
 	bitmap_complement(tmp_map, tmp_map, SVE_VQ_MAX);
 	/* Find VQs supported that are not globally supported: */
-	bitmap_andnot(tmp_map, tmp_map, sve_vq_map, SVE_VQ_MAX);
+	bitmap_andnot(tmp_map, tmp_map, info->vq_map, SVE_VQ_MAX);
 
 	/* Find the lowest such VQ, if any: */
 	b = find_last_bit(tmp_map, SVE_VQ_MAX);
@@ -799,9 +814,9 @@ int sve_verify_vq_map(void)
 	 * Mismatches above sve_max_virtualisable_vl are fine, since
 	 * no guest is allowed to configure ZCR_EL2.LEN to exceed this:
 	 */
-	if (sve_vl_from_vq(__bit_to_vq(b)) <= sve_max_virtualisable_vl) {
-		pr_warn("SVE: cpu%d: Unsupported vector length(s) present\n",
-			smp_processor_id());
+	if (sve_vl_from_vq(__bit_to_vq(b)) <= info->max_virtualisable_vl) {
+		pr_warn("%s: cpu%d: Unsupported vector length(s) present\n",
+			info->name, smp_processor_id());
 		return -EINVAL;
 	}
 
@@ -810,6 +825,8 @@ int sve_verify_vq_map(void)
 
 static void __init sve_efi_setup(void)
 {
+	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
+
 	if (!IS_ENABLED(CONFIG_EFI))
 		return;
 
@@ -818,11 +835,11 @@ static void __init sve_efi_setup(void)
 	 * This is evidence of a crippled system and we are returning void,
 	 * so no attempt is made to handle this situation here.
 	 */
-	if (!sve_vl_valid(sve_max_vl))
+	if (!sve_vl_valid(info->max_vl))
 		goto fail;
 
 	efi_sve_state = __alloc_percpu(
-		SVE_SIG_REGS_SIZE(sve_vq_from_vl(sve_max_vl)), SVE_VQ_BYTES);
+		SVE_SIG_REGS_SIZE(sve_vq_from_vl(info->max_vl)), SVE_VQ_BYTES);
 	if (!efi_sve_state)
 		goto fail;
 
@@ -871,6 +888,7 @@ u64 read_zcr_features(void)
 
 void __init sve_setup(void)
 {
+	struct vl_info *info = &vl_info[ARM64_VEC_SVE];
 	u64 zcr;
 	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
 	unsigned long b;
@@ -883,49 +901,52 @@ void __init sve_setup(void)
 	 * so sve_vq_map must have at least SVE_VQ_MIN set.
 	 * If something went wrong, at least try to patch it up:
 	 */
-	if (WARN_ON(!test_bit(__vq_to_bit(SVE_VQ_MIN), sve_vq_map)))
-		set_bit(__vq_to_bit(SVE_VQ_MIN), sve_vq_map);
+	if (WARN_ON(!test_bit(__vq_to_bit(SVE_VQ_MIN), info->vq_map)))
+		set_bit(__vq_to_bit(SVE_VQ_MIN), info->vq_map);
 
 	zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
-	sve_max_vl = sve_vl_from_vq((zcr & ZCR_ELx_LEN_MASK) + 1);
+	info->max_vl = sve_vl_from_vq((zcr & ZCR_ELx_LEN_MASK) + 1);
 
 	/*
 	 * Sanity-check that the max VL we determined through CPU features
 	 * corresponds properly to sve_vq_map.  If not, do our best:
 	 */
-	if (WARN_ON(sve_max_vl != find_supported_sve_vector_length(sve_max_vl)))
-		sve_max_vl = find_supported_sve_vector_length(sve_max_vl);
+	if (WARN_ON(info->max_vl != find_supported_vector_length(ARM64_VEC_SVE,
+								 info->max_vl)))
+		info->max_vl = find_supported_vector_length(ARM64_VEC_SVE,
+							    info->max_vl);
 
 	/*
 	 * For the default VL, pick the maximum supported value <= 64.
 	 * VL == 64 is guaranteed not to grow the signal frame.
 	 */
-	set_sve_default_vl(find_supported_sve_vector_length(64));
+	set_sve_default_vl(find_supported_vector_length(ARM64_VEC_SVE, 64));
 
-	bitmap_andnot(tmp_map, sve_vq_partial_map, sve_vq_map,
+	bitmap_andnot(tmp_map, info->vq_partial_map, info->vq_map,
 		      SVE_VQ_MAX);
 
 	b = find_last_bit(tmp_map, SVE_VQ_MAX);
 	if (b >= SVE_VQ_MAX)
 		/* No non-virtualisable VLs found */
-		sve_max_virtualisable_vl = SVE_VQ_MAX;
+		info->max_virtualisable_vl = SVE_VQ_MAX;
 	else if (WARN_ON(b == SVE_VQ_MAX - 1))
 		/* No virtualisable VLs?  This is architecturally forbidden. */
-		sve_max_virtualisable_vl = SVE_VQ_MIN;
+		info->max_virtualisable_vl = SVE_VQ_MIN;
 	else /* b + 1 < SVE_VQ_MAX */
-		sve_max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b + 1));
+		info->max_virtualisable_vl = sve_vl_from_vq(__bit_to_vq(b + 1));
 
-	if (sve_max_virtualisable_vl > sve_max_vl)
-		sve_max_virtualisable_vl = sve_max_vl;
+	if (info->max_virtualisable_vl > info->max_vl)
+		info->max_virtualisable_vl = info->max_vl;
 
-	pr_info("SVE: maximum available vector length %u bytes per vector\n",
-		sve_max_vl);
-	pr_info("SVE: default vector length %u bytes per vector\n",
-		get_sve_default_vl());
+	pr_info("%s: maximum available vector length %u bytes per vector\n",
+		info->name, info->max_vl);
+	pr_info("%s: default vector length %u bytes per vector\n",
+		info->name, get_sve_default_vl());
 
 	/* KVM decides whether to support mismatched systems. Just warn here: */
-	if (sve_max_virtualisable_vl < sve_max_vl)
-		pr_warn("SVE: unvirtualisable vector lengths present\n");
+	if (sve_max_virtualisable_vl() < sve_max_vl())
+		pr_warn("%s: unvirtualisable vector lengths present\n",
+			info->name);
 
 	sve_efi_setup();
 }
@@ -1087,7 +1108,7 @@ void fpsimd_flush_thread(void)
 		if (WARN_ON(!sve_vl_valid(vl)))
 			vl = SVE_VL_MIN;
 
-		supported_vl = find_supported_sve_vector_length(vl);
+		supported_vl = find_supported_vector_length(ARM64_VEC_SVE, vl);
 		if (WARN_ON(supported_vl != vl))
 			vl = supported_vl;
 
@@ -1376,7 +1397,7 @@ void __efi_fpsimd_begin(void)
 
 			__this_cpu_write(efi_sve_state_used, true);
 
-			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl),
+			sve_save_state(sve_state + sve_ffr_offset(sve_max_vl()),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
 				       true);
 		} else {
@@ -1402,7 +1423,7 @@ void __efi_fpsimd_end(void)
 		    likely(__this_cpu_read(efi_sve_state_used))) {
 			char const *sve_state = this_cpu_ptr(efi_sve_state);
 
-			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl),
+			sve_load_state(sve_state + sve_ffr_offset(sve_max_vl()),
 				       &this_cpu_ptr(&efi_fpsimd_state)->fpsr,
 				       true,
 				       sve_vq_from_vl(sve_get_vl()) - 1);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 95ff03a1b077..88a9034fb9b5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -728,7 +728,7 @@ static void sve_init_header_from_task(struct user_sve_header *header,
 	header->vl = task_get_sve_vl(target);
 	vq = sve_vq_from_vl(header->vl);
 
-	header->max_vl = sve_max_vl;
+	header->max_vl = sve_max_vl();
 	header->size = SVE_PT_SIZE(vq, header->flags);
 	header->max_size = SVE_PT_SIZE(sve_vq_from_vl(header->max_vl),
 				      SVE_PT_REGS_SVE);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index aa1d9d7918da..8f6372b44b65 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -594,7 +594,7 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		unsigned int vq = 0;
 
 		if (add_all || test_thread_flag(TIF_SVE)) {
-			int vl = sve_max_vl;
+			int vl = sve_max_vl();
 
 			if (!add_all)
 				vl = task_get_sve_vl(current);
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 5ce36b0a3343..09cd30a9aafb 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -46,7 +46,7 @@ unsigned int kvm_sve_max_vl;
 int kvm_arm_init_sve(void)
 {
 	if (system_supports_sve()) {
-		kvm_sve_max_vl = sve_max_virtualisable_vl;
+		kvm_sve_max_vl = sve_max_virtualisable_vl();
 
 		/*
 		 * The get_sve_reg()/set_sve_reg() ioctl interface will need
@@ -61,7 +61,7 @@ int kvm_arm_init_sve(void)
 		 * Don't even try to make use of vector lengths that
 		 * aren't available on all CPUs, for now:
 		 */
-		if (kvm_sve_max_vl < sve_max_vl)
+		if (kvm_sve_max_vl < sve_max_vl())
 			pr_warn("KVM: SVE vector length for guests limited to %u bytes\n",
 				kvm_sve_max_vl);
 	}
@@ -102,7 +102,7 @@ static int kvm_vcpu_finalize_sve(struct kvm_vcpu *vcpu)
 	 * kvm_arm_init_arch_resources(), kvm_vcpu_enable_sve() and
 	 * set_sve_vls().  Double-check here just to be sure:
 	 */
-	if (WARN_ON(!sve_vl_valid(vl) || vl > sve_max_virtualisable_vl ||
+	if (WARN_ON(!sve_vl_valid(vl) || vl > sve_max_virtualisable_vl() ||
 		    vl > SVE_VL_ARCH_MAX))
 		return -EIO;
 
-- 
2.20.1

