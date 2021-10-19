Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C781433D64
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhJSR1R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhJSR1R (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:27:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2158610FC;
        Tue, 19 Oct 2021 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664304;
        bh=T5CMb4Dt9nykasXV00QWbu8b3O61lt3gO7Hpcpp7LhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTHxNMtzaS0aOS1VwQAHfB9ZrfUrEtPQEt1lALf+soDJ1FCDahqhIlwS48NtZXu/4
         jBAeP/SLYI6iwwKuURXBj98+Yr2P4n94hltXVYOsDvQGR8W+uZl9nigoelzFyVT9v9
         lWHeknWpvHxNdBGKDqXuwy2u0ajxHUfdfBTHTCMwuGmqkCpe4TL6wavV+0mataIijl
         OXj8gAY3qs8Jc91EsD5v5lHJjdgcTEvriDW9bQUBCTspUTfcuhch10Yycq54wUi7g9
         SmHVnKZYOuKsID7Kea+Upk+aER8eGs3M9Dw01zQj3IjPQ1mzooYTCtB5xrb2+1peKg
         iZGQIulNYz4vg==
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
Subject: [PATCH v3 32/42] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Tue, 19 Oct 2021 18:22:37 +0100
Message-Id: <20211019172247.3045838-33-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; h=from:subject; bh=T5CMb4Dt9nykasXV00QWbu8b3O61lt3gO7Hpcpp7LhI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7cMp18QaaTX3nq1cIkboNDsbQAHtGCMbFt+1zm MNfMW+mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+3AAKCRAk1otyXVSH0NVSB/ wOiXlukQ6SFXn3SnSew5EKxoydueJvbrvo+g/efNTR3cJfdHxAf/ScOGKXPZ3N3TZF+XhCNjdeU20v x+4j2vINLJ9j5cy3gPGqTgUnMlsnx1sX4whyWYLlmvPboB4Z0BbdumJo6Lw2ActItbuNZJnw4OR1vc 7+wOcDtEsACZHFf0VKcMOOIEjqIeCf6fdRxznCzjXIt2F6t3JM/tBnTdNHJCPO7mLnijrmB2vHe/VL jJ7VOe+xnUo4LqoXh5QlxdPJAEhqZK1R64JyJfkk1ecFyXNnm8sW4h7aUEOYtLdEz3HcOM8ApUCk9a eoElm3rl2xHO8d/S7v85Cl8B0a5k91
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
index 180548c13940..f1cd552ebb81 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -300,6 +300,12 @@ static inline void sme_smstop_sm(void)
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
@@ -322,6 +328,7 @@ static inline void sme_alloc(struct task_struct *task) { }
 
 static inline void sme_smstart_sm(void) { }
 static inline void sme_smstop_sm(void) { }
+static inline void sme_smstop(void) { }
 
 static inline int sme_set_current_vl(unsigned long arg)
 {
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 39f521dadd87..725343c1bc65 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1747,6 +1747,15 @@ static void fpsimd_flush_cpu_state(void)
 {
 	WARN_ON(!system_supports_fpsimd());
 	__this_cpu_write(fpsimd_last_state.st, NULL);
+
+	/*
+	 * Leaving streaming mode enabled will cause issues for any kernel
+	 * NEON and leaving streaming mode or ZA enabled may incrase power
+	 * consumption.
+	 */
+	if (system_supports_sme())
+		sme_smstop();
+
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
-- 
2.30.2

