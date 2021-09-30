Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F235C41E0C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353327AbhI3SRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414EB6140F;
        Thu, 30 Sep 2021 18:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025758;
        bh=TLjSCT33n1E+NvmAGesIbFthdnT+zAe7opnPr9O2TjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srqKHRhU/ilz5d+SgiTJO3BvXorLo8jGq0vn18cpnolFiTiEzunkf1nkb0vV55nTv
         qrgD2u/piaOEOrpz2UBzMClA2FnTnUqsmaQUd3E00AQtn0nDBZdbNbMWaBY+1gU7sS
         RR0fvvL3uYwD9i8XSIzKTavLDNjJiRAOecksaUjX6qB4bSyf17dd032eRjVz3j3+E1
         zOg6+ly4phHJdFLWMv8iiwhLRSFFekIQp5xUzY/96aXubYm1+ZbcHM2cwCRy1MtRjP
         p/PHr5bm3O2xc8F4QBAbXAjqjDII7EL5nooHeLrUbos/dqrTV1y0EJocjrvBChY/CE
         LUgxNFRumLWNw==
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
Subject: [PATCH v1 08/38] arm64/sve: Track vector lengths for tasks in an array
Date:   Thu, 30 Sep 2021 19:11:14 +0100
Message-Id: <20210930181144.10029-9-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7903; h=from:subject; bh=TLjSCT33n1E+NvmAGesIbFthdnT+zAe7opnPr9O2TjE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3IXIGglt/6LCUYQWpoJ8nTdmA8oLuVO+B1gAw5 R/+SLgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9yAAKCRAk1otyXVSH0MNPB/ wMaI51KuWFU2GP/UrpMULZ4/xQH5nFP5dQd8pHvCSAiRAfvMC44etOVqVZw37uRZXAAQyh0UTtdL4E ya63IfHC8BXfrqRvfCFjXZQZoaMZ8uYBQk1bEv+Q/p9GDbeWOGZYcLKghtdeVBrcrvGp+jkSOmE3D7 hqoGeUTSOIqIY5MuhGR8EW35Apfw0fX09uYAa7mT/Rc6LIJQ/phSw/hRCoOHoEIRr+5ruIPHBX7pXK 7p4J62C9JE8XQiQQ3x1tJrSDgXHxIKOSUIp1l06WuL2jGwHRh84rrdzhATw5PZMCfMGsEg7bQUMhI3 /e3wDSs/Bk89jvZrN1ddcN/fqjgZ93
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As for SVE we will track a per task SME vector length for tasks. Convert
the existing storage for the vector length into an array and update
fpsimd_flush_task() to initialise this in a function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/processor.h   | 44 +++++++++++--
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/kernel/fpsimd.c           | 97 ++++++++++++++++------------
 3 files changed, 95 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index fb0608fe9ded..9b854e8196df 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -152,8 +152,8 @@ struct thread_struct {
 
 	unsigned int		fpsimd_cpu;
 	void			*sve_state;	/* SVE registers, if any */
-	unsigned int		sve_vl;		/* SVE vector length */
-	unsigned int		sve_vl_onexec;	/* SVE vl after next exec */
+	unsigned int		vl[ARM64_VEC_MAX];	/* vector length */
+	unsigned int		vl_onexec[ARM64_VEC_MAX]; /* vl after next exec */
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
@@ -169,15 +169,45 @@ struct thread_struct {
 	u64			sctlr_user;
 };
 
+static inline unsigned int thread_get_vl(struct thread_struct *thread,
+					 enum vec_type type)
+{
+	return thread->vl[type];
+}
+
 static inline unsigned int thread_get_sve_vl(struct thread_struct *thread)
 {
-	return thread->sve_vl;
+	return thread_get_vl(thread, ARM64_VEC_SVE);
+}
+
+unsigned int task_get_vl(const struct task_struct *task, enum vec_type type);
+void task_set_vl(struct task_struct *task, enum vec_type type,
+		 unsigned long vl);
+void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
+			unsigned long vl);
+unsigned int task_get_vl_onexec(const struct task_struct *task,
+				enum vec_type type);
+
+static inline unsigned int task_get_sve_vl(const struct task_struct *task)
+{
+	return task_get_vl(task, ARM64_VEC_SVE);
 }
 
-unsigned int task_get_sve_vl(const struct task_struct *task);
-void task_set_sve_vl(struct task_struct *task, unsigned long vl);
-unsigned int task_get_sve_vl_onexec(const struct task_struct *task);
-void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl);
+static inline void task_set_sve_vl(struct task_struct *task, unsigned long vl)
+{
+	task_set_vl(task, ARM64_VEC_SVE, vl);
+}
+
+static inline unsigned int task_get_sve_vl_onexec(const struct task_struct *task)
+{
+	return task_get_vl_onexec(task, ARM64_VEC_SVE);
+}
+
+static inline void task_set_sve_vl_onexec(struct task_struct *task,
+					  unsigned long vl)
+{
+	task_set_vl_onexec(task, ARM64_VEC_SVE, vl);
+}
 
 #define SCTLR_USER_MASK                                                        \
 	(SCTLR_ELx_ENIA | SCTLR_ELx_ENIB | SCTLR_ELx_ENDA | SCTLR_ELx_ENDB |   \
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6623c99f0984..d5c8ac81ce11 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -78,7 +78,7 @@ int arch_dup_task_struct(struct task_struct *dst,
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* 32bit process */
 #define TIF_SVE			23	/* Scalable Vector Extension in use */
-#define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
+#define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 44bb3203c9d1..814080209093 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -133,6 +133,17 @@ __ro_after_init struct vl_info vl_info[ARM64_VEC_MAX] = {
 #endif
 };
 
+static unsigned int vec_vl_inherit_flag(enum vec_type type)
+{
+	switch (type) {
+	case ARM64_VEC_SVE:
+		return TIF_SVE_VL_INHERIT;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
 struct vl_config {
 	int __default_vl;		/* Default VL for tasks */
 };
@@ -239,24 +250,27 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-unsigned int task_get_sve_vl(const struct task_struct *task)
+unsigned int task_get_vl(const struct task_struct *task, enum vec_type type)
 {
-	return task->thread.sve_vl;
+	return task->thread.vl[type];
 }
 
-void task_set_sve_vl(struct task_struct *task, unsigned long vl)
+void task_set_vl(struct task_struct *task, enum vec_type type,
+		 unsigned long vl)
 {
-	task->thread.sve_vl = vl;
+	task->thread.vl[type] = vl;
 }
 
-unsigned int task_get_sve_vl_onexec(const struct task_struct *task)
+unsigned int task_get_vl_onexec(const struct task_struct *task,
+				enum vec_type type)
 {
-	return task->thread.sve_vl_onexec;
+	return task->thread.vl_onexec[type];
 }
 
-void task_set_sve_vl_onexec(struct task_struct *task, unsigned long vl)
+void task_set_vl_onexec(struct task_struct *task, enum vec_type type,
+			unsigned long vl)
 {
-	task->thread.sve_vl_onexec = vl;
+	task->thread.vl_onexec[type] = vl;
 }
 
 /*
@@ -1074,10 +1088,43 @@ void fpsimd_thread_switch(struct task_struct *next)
 	__put_cpu_fpsimd_context();
 }
 
-void fpsimd_flush_thread(void)
+static void fpsimd_flush_thread_vl(enum vec_type type)
 {
 	int vl, supported_vl;
 
+	/*
+	 * Reset the task vector length as required.  This is where we
+	 * ensure that all user tasks have a valid vector length
+	 * configured: no kernel task can become a user task without
+	 * an exec and hence a call to this function.  By the time the
+	 * first call to this function is made, all early hardware
+	 * probing is complete, so __sve_default_vl should be valid.
+	 * If a bug causes this to go wrong, we make some noise and
+	 * try to fudge thread.sve_vl to a safe value here.
+	 */
+	vl = task_get_vl_onexec(current, type);
+	if (!vl)
+		vl = get_default_vl(type);
+
+	if (WARN_ON(!sve_vl_valid(vl)))
+		vl = SVE_VL_MIN;
+
+	supported_vl = find_supported_vector_length(type, vl);
+	if (WARN_ON(supported_vl != vl))
+		vl = supported_vl;
+
+	task_set_vl(current, type, vl);
+
+	/*
+	 * If the task is not set to inherit, ensure that the vector
+	 * length will be reset by a subsequent exec:
+	 */
+	if (!test_thread_flag(vec_vl_inherit_flag(type)))
+		task_set_vl_onexec(current, type, 0);
+}
+
+void fpsimd_flush_thread(void)
+{
 	if (!system_supports_fpsimd())
 		return;
 
@@ -1090,37 +1137,7 @@ void fpsimd_flush_thread(void)
 	if (system_supports_sve()) {
 		clear_thread_flag(TIF_SVE);
 		sve_free(current);
-
-		/*
-		 * Reset the task vector length as required.
-		 * This is where we ensure that all user tasks have a valid
-		 * vector length configured: no kernel task can become a user
-		 * task without an exec and hence a call to this function.
-		 * By the time the first call to this function is made, all
-		 * early hardware probing is complete, so __sve_default_vl
-		 * should be valid.
-		 * If a bug causes this to go wrong, we make some noise and
-		 * try to fudge thread.sve_vl to a safe value here.
-		 */
-		vl = task_get_sve_vl_onexec(current);
-		if (!vl)
-			vl = get_sve_default_vl();
-
-		if (WARN_ON(!sve_vl_valid(vl)))
-			vl = SVE_VL_MIN;
-
-		supported_vl = find_supported_vector_length(ARM64_VEC_SVE, vl);
-		if (WARN_ON(supported_vl != vl))
-			vl = supported_vl;
-
-		task_set_sve_vl(current, vl);
-
-		/*
-		 * If the task is not set to inherit, ensure that the vector
-		 * length will be reset by a subsequent exec:
-		 */
-		if (!test_thread_flag(TIF_SVE_VL_INHERIT))
-			task_set_sve_vl_onexec(current, 0);
+		fpsimd_flush_thread_vl(ARM64_VEC_SVE);
 	}
 
 	put_cpu_fpsimd_context();
-- 
2.20.1

