Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC843D12B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbhJ0Syf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240514AbhJ0Sye (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6B78610A0;
        Wed, 27 Oct 2021 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360729;
        bh=MvW9YmbwdSKvZy91EB10bm/z+/YnB9fBK/BxCYa/vCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BxFOCUzOrlYOuoB+xcqMvuB7Gw3DM3n+wOIlK299MxGkd2a+K9NdCTUl6LOCwG5Wa
         4pZijTPx0N5syiTpx7af1F45/aiGKJCyNpAPREKDfZOtK18pU78rxZTecQ38/1wrVb
         RNEUhbj/Jyb/P6cbUd3a0FKyxajeVkBfI8B0uz1PkRrJXpbmYEg7rsZp/o/XATGWxL
         VUx9GVVqxvR+erpex0LVmwQQq+7krfHARw088POcMSmP2TpVvXc7/JfIgdL/vI1TAh
         1J/UNnvy8aDKmviyEurBbfRzoVPFFtjSib8t+Zai0aGuZg3/6H3lZiIzMYNbGFQ7YR
         ENv8/Gkl+CuIg==
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
Subject: [PATCH v5 27/38] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Wed, 27 Oct 2021 19:44:13 +0100
Message-Id: <20211027184424.166237-28-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; h=from:subject; bh=MvW9YmbwdSKvZy91EB10bm/z+/YnB9fBK/BxCYa/vCA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ37RwMjdv8RXvz3kW2jKu00+sVuHDY7a3IV/eeL e4Kv9R+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd+wAKCRAk1otyXVSH0FzZB/ 9u9JImSAUPFHoF6GcTv0XaH+t8pG8LgI6M0P7qkzqnTm1QeqafeE9IlXZGZObzKrJiornskElvJakG N/1SEpSmG4BFkf+uaqRsMVG1yfXlEH921yMt8p0S2PsFD8S2U7S2NbSRFwZsnSinnoTjhfziHmUIct CRfKPICsKX+qFp5tCYuzsv5pwK9mtx6CgoXHZJNl58nPBWak2alPe4hlbsVdXwmYAJN2n3xwsMGbJM gaiU4VPPI1aFbevQRf3Ik4p13px7k69fmt2l2pNLWdUAtgwnOfAxgi0uvMmEKha4YrhK1ixvwj8mzA 8SHtAdm0POHa7rLC0qxohFDSIUHLiD
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both streaming mode and ZA may increase power consumption when they are
enabled and streaming mode makes many FPSIMD and SVE instructions undefined
which will cause problems for any kernel mode floating point so disable
both when we flush the CPU state. This covers both kernel_neon_begin() and
idle and after flushing the state a reload is always required anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimd.h | 7 +++++++
 arch/arm64/kernel/fpsimd.c      | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 99b5b822c47f..a7291917218c 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -306,6 +306,12 @@ static inline void sme_smstop_sm(void)
 	asm volatile(".inst 0xd503427f");
 }
 
+static inline void sme_smstop(void)
+{
+	/* SMSTOP SM is an alias for MSR SVCRSMZA, #0 */
+	asm volatile(".inst 0x7f4603d5");
+}
+
 static inline int sme_max_vl(void)
 {
 	return vec_max_vl(ARM64_VEC_SME);
@@ -328,6 +334,7 @@ static inline void sme_alloc(struct task_struct *task) { }
 
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
+static inline void sme_smstop(void) { }
 
 static inline int sme_set_current_vl(unsigned long arg)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 69f76df08ee8..ebaf174bdf82 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1755,6 +1755,15 @@ static void fpsimd_flush_cpu_state(void)
 {
 	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may increase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
2.30.2

