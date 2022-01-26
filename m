Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1349CE51
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiAZPbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiAZPbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:31:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16339C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:31:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB03AB81E71
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C35C340EE;
        Wed, 26 Jan 2022 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211073;
        bh=c5P3WzFe/myKJt98GT0tqU73tZQT7e7FvegzOnxWfIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knCFN/zBwHb+X6QtUTP9ed35KpLjx4NvBJx4oN9EaVHvUVdPsiZJhwpR+QR8eh4VD
         7YRlChRRwdxmarIUhpTKmAqQj0NOmZgcGhgG1MSRWxm/xpgosjgafl17MR4onCXu1L
         BhrczUSW++AxQIEBdJ+ynWgOnTTwzDDQQvfablu8yjAstjaBcz6VvpT1Ucn6dFurjd
         fRlI4xabpeNgOLPK58cR5CZcMWAXYbvSryKeOP8oQcj3LBB08wp81xeEUlv09mov5W
         A+p9FrB6dwAghyMs47iMJLsManv48umJ/WBVU/awsn/mHenE/1NEqHHBpRobLDb87a
         78Yb8VdgdtWZA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 13/39] arm64/sme: Implement support for TPIDR2
Date:   Wed, 26 Jan 2022 15:27:23 +0000
Message-Id: <20220126152749.233712-14-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; h=from:subject; bh=c5P3WzFe/myKJt98GT0tqU73tZQT7e7FvegzOnxWfIU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8Whcq7eZ7r91LceN+pOy5udpzbiaxzgFRcvUb03E Y2wAT9eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoXAAKCRAk1otyXVSH0MQVB/ 9IiwgfgSwIapAPCNYZpP8noQpk5hdT574lLKhsAduZNliLM9J66+5plGWi4f41CFJx8JmaynHjs22c cf9Bc5maIeCJj57bkP91go3oc3w7S/XClSfG86i33T68K2hE2FKCcCuPA2U2tJ1Vek4xe7eHODDybA BWIDo/WUZtPpW8Fw2GJseJIMwuoaMC4lYz3efgZHjp6d2O7tMPHmDWMn/qzssAYQmrU9Pr6saIT5dB ch8pZ7YwhEZ35URWbcYk91/wMoc0we4dU9wsn82OqtiLDTlW/Y4HvtykLaedVQfZWipPsUdcm7QSKy 7KvCwi0SvV9EkHRkmD8YeNvcN4/8/r
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Scalable Matrix Extension introduces support for a new thread specific
data register TPIDR2 intended for use by libc. The kernel must save the
value of TPIDR2 on context switch and should ensure that all new threads
start off with a default value of 0. Add a field to the thread_struct to
store TPIDR2 and context switch it with the other thread specific data.

In case there are future extensions which also use TPIDR2 we introduce
system_supports_tpidr2() and use that rather than system_supports_sme()
for TPIDR2 handling.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  5 +++++
 arch/arm64/include/asm/processor.h  |  1 +
 arch/arm64/kernel/fpsimd.c          |  4 ++++
 arch/arm64/kernel/process.c         | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9d36035acce3..12252352d2ee 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -747,6 +747,11 @@ static __always_inline bool system_supports_fa64(void)
 		cpus_have_const_cap(ARM64_SME_FA64);
 }
 
+static __always_inline bool system_supports_tpidr2(void)
+{
+	return system_supports_sme();
+}
+
 static __always_inline bool system_supports_cnp(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_CNP) &&
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f2c2ebd440e2..008a1767ebff 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -168,6 +168,7 @@ struct thread_struct {
 	u64			mte_ctrl;
 #endif
 	u64			sctlr_user;
+	u64			tpidr2_el0;
 };
 
 static inline unsigned int thread_get_vl(struct thread_struct *thread,
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1edb3996f9cf..40ef89120774 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1092,6 +1092,10 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 	/* Allow SME in kernel */
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_SMEN_EL1EN, CPACR_EL1);
 	isb();
+
+	/* Allow EL0 to access TPIDR2 */
+	write_sysreg(read_sysreg(SCTLR_EL1) | SCTLR_ELx_ENTP2, SCTLR_EL1);
+	isb();
 }
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..e69a3dcdb0d9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -250,6 +250,8 @@ void show_regs(struct pt_regs *regs)
 static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(0, SYS_TPIDR2_EL0);
 
 	if (is_compat_task()) {
 		current->thread.uw.tp_value = 0;
@@ -343,6 +345,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		 * out-of-sync with the saved value.
 		 */
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
+		if (system_supports_tpidr2())
+			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
@@ -353,10 +357,12 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
 		/*
 		 * If a TLS pointer was passed to clone, use it for the new
-		 * thread.
+		 * thread.  We also reset TPIDR2 if it's in use.
 		 */
-		if (clone_flags & CLONE_SETTLS)
+		if (clone_flags & CLONE_SETTLS) {
 			p->thread.uw.tp_value = tls;
+			p->thread.tpidr2_el0 = 0;
+		}
 	} else {
 		/*
 		 * A kthread has no context to ERET to, so ensure any buggy
@@ -387,6 +393,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 void tls_preserve_current_state(void)
 {
 	*task_user_tls(current) = read_sysreg(tpidr_el0);
+	if (system_supports_tpidr2() && !is_compat_task())
+		current->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static void tls_thread_switch(struct task_struct *next)
@@ -399,6 +407,8 @@ static void tls_thread_switch(struct task_struct *next)
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(next->thread.tpidr2_el0, SYS_TPIDR2_EL0);
 }
 
 /*
-- 
2.30.2

