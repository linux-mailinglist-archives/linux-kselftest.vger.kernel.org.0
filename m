Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD826470921
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbhLJSsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbhLJSsE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:48:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC5C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67114B8295A
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EC7C341C7;
        Fri, 10 Dec 2021 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161866;
        bh=5MdMiRt1aG0yuVgkBRRqIp6k6u5Uzij6IN3vmsTjwlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiQz+eOTLsdfjhsaeFQVARPsQcVjXFhKnbDHgIBhDCMPYXbSGW5ZwW0QcK4Mls+uK
         Yg3i0n1+8TMTAGoeOT4LaVTJpnyig/7Hw0zR8Sj3o4yiSOg1hVt+hrg4U7YWvj7rHe
         wfJ4J9LU78aKBXHjzXGDFnplLpYUDGGAcZDL4RZ2xuofqKciEjbWneLUEcmeuAiOHq
         xHf7qfytZ3wzOo68R6/+8IkZdpPasvj913a4hElFAS7B6kaJ835yOJi3jIjyjl0P0d
         ++3lTOy3SKgzksg07CvhMLi1A9gqo7+FLFxkIIqMnhx0v4mj8RH71Vve5yzD0hhPST
         4Tmt66ACBlsRQ==
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
Subject: [PATCH v7 17/37] arm64/sme: Implement support for TPIDR2
Date:   Fri, 10 Dec 2021 18:41:13 +0000
Message-Id: <20211210184133.320748-18-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; h=from:subject; bh=5MdMiRt1aG0yuVgkBRRqIp6k6u5Uzij6IN3vmsTjwlI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59LUzRCbuFpBGd7mTmJ+uPWg2NB4idlaoI1IbKj CYBsrnGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfSwAKCRAk1otyXVSH0ATyB/ 9vnldr8J0RhVvz583auyEWAmz2VeU+tGDvISD4F/ZMiOzsbgPUsIQIM9+kzRVIxNd6Uqijx4z2xlK5 SrLyHdHy+1KHdi5dXdx2F3MxFH1uik9x/e1tvpjaIQhK0DVdGxmeDgFhRfXPW8vNZoY/UlrtdCTDXr pla4tpmhQi+1wQTsGXjv0QrdblP3LZCF1YWuNM/JVoAS7AbVnV/PS2BIq6aWqCfvNTjM32lhY51mBS i5pvaWoNVFLBclQio/9yyBSrScdYrGktJmma4+zwiWcPp0ZEUpzaNStnHQUhCJerWsSYoUoG+tCf0+ 6/cWCyw+ZjKfBuxNs09NxskWGDO+kQ
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
index 20c889487193..0af82c518979 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1098,6 +1098,10 @@ void sme_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
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
index aacf2f5559a8..3adca0123943 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -249,6 +249,8 @@ void show_regs(struct pt_regs *regs)
 static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(0, SYS_TPIDR2_EL0);
 
 	if (is_compat_task()) {
 		current->thread.uw.tp_value = 0;
@@ -342,6 +344,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		 * out-of-sync with the saved value.
 		 */
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
+		if (system_supports_tpidr2())
+			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 
 		if (stack_start) {
 			if (is_compat_thread(task_thread_info(p)))
@@ -352,10 +356,12 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 
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
@@ -386,6 +392,8 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 void tls_preserve_current_state(void)
 {
 	*task_user_tls(current) = read_sysreg(tpidr_el0);
+	if (system_supports_tpidr2() && !is_compat_task())
+		current->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
 }
 
 static void tls_thread_switch(struct task_struct *next)
@@ -398,6 +406,8 @@ static void tls_thread_switch(struct task_struct *next)
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
+	if (system_supports_tpidr2())
+		write_sysreg_s(next->thread.tpidr2_el0, SYS_TPIDR2_EL0);
 }
 
 /*
-- 
2.30.2

