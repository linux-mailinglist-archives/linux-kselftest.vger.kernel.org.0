Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD52436A2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJUSL2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232381AbhJUSL2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 877F461AFC;
        Thu, 21 Oct 2021 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839752;
        bh=3HBBdjxYt3UpQgqgq0efMDkZStc8OofbR/SIbqk3WCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKt16FQsUY6LTDncsfqwcNlcdzTRFk0sQwK9KHmTmOAQIqJljj0ucwBK1Lm8fBEPA
         N43XZH32mN1PL2V5jQ2hHavjAXWrfTl/P7F/daqo0G8yE+2esWJo4dlGK80h5waN/b
         Xad2xk19DSCvxq6UP69QRYAD5RXj/yl9syK992lG2eOxorAS6GyoUu1HxAzZ0/E4Rj
         w8Ta1NZGr5zAjXgnu1LNdlq43vcEVj9vSemWAaVnxGq8s7c8WbwP/fg1GXydzoWTiO
         I2m6DTry2fK3lKCSpgaoJGTvwUsHtX40HRvnWnJ3bxA4LwiZa/aBvl3nuaPY2qiIKa
         VODJP6qXMeDJA==
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
Subject: [PATCH v4 23/33] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Thu, 21 Oct 2021 19:07:12 +0100
Message-Id: <20211021180722.3699248-24-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; h=from:subject; bh=3HBBdjxYt3UpQgqgq0efMDkZStc8OofbR/SIbqk3WCg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxQIhNlUvYK9Ff3HRgB4U32ndcoPpo2DZ62wdRY KWxZ0gSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsUAAKCRAk1otyXVSH0BqhB/ sEiS1x6Mv1GuBXjhNptL0Mcpxo0UUeXooE9W1+Yjy3K4u9bj+NnF2bxVD6lUgSsRzUl8OD57zcQfxT Kpil1FuOqD+g5ozDVrbPtw7YDKQ7Wzg/QHI0WlQIo1wbVv+co5sBYjVEr/7XbvA23m9PqtjXLGMKFj 4cWoEcX1FuLa8y1dWZO1WTZ6DtsWi0dxvdTQ/buGIwmYxVza3O9Fze8Wm9ebBoXRZ4VJQKPrEDTdWR KTvcRrRK+mOGFHiKrwIsxkcRRW5SKJ17cMenPNMfLcjwgF/Bn0AnbY1mhC/rLgbXvSlUKh1rNKWzLx NmFO76dFzn8M+NJABKpQ9Tgn9KzFPn
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
index af46db99ec82..cdbc1fd8fde2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1744,6 +1744,15 @@ static void fpsimd_flush_cpu_state(void)
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

