Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C9432748
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhJRTNp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhJRTNo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:13:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7613561350;
        Mon, 18 Oct 2021 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584293;
        bh=K2UGqoIi1tRcY5BO1S66dABY8RTWmlnIQnUSZaS262E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i43yOIfFToG44pMGV1uZwolAzG7Mx1TESYnY/iCXJ3Nmp0qwzKePahsrePGozxn60
         jTEYS+XjJdhKu8vCqjHrx9uf3kAJE+WzyGN0px83Za083fQeGiE6kwVPbYKa6D2aZB
         F+ujXiTKDQCMetOC2OdrKJ7ahe/b/q0t91XHEI9nXSdQzv4TvlzYioMSVDRZDyUonI
         3xULgyB3JUA32iyDYG6NkMA7zbjBbQMgDbqaXdQNhDFSzpRbBffz1CVTPfN97/2wNj
         vKKQEiZ20NUN+j3UZmgc0h5CMBfKbc8wF6GYeo9qrTSsWzWWZIlxZe/oza7i61pVsr
         cBSvKV5HzqxlQ==
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
Subject: [PATCH v2 32/42] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Mon, 18 Oct 2021 20:08:48 +0100
Message-Id: <20211018190858.2119209-33-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; h=from:subject; bh=K2UGqoIi1tRcY5BO1S66dABY8RTWmlnIQnUSZaS262E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcZAYnUpkYoQ8hcFRi+0A7vAHilbG9lry6xTvx8q IZmqfPyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GQAAKCRAk1otyXVSH0Op1B/ wKTBjBNAw3ipypLEt6K1gX/RDH/3FYy6PiaugIhroJNDpQl974sS274mvuGUvNWCX5GPKpYlgc05N+ tmRMija6xY5Ly2jvfWYIN4mh7/uppeDg+Tj2KKiJbcVE8O5qlnbX3cv6hkcf7JJPKJHUThYoj2/jol DsOLxXDS+HmxrI7gSQHo00bq228f3LNPi6Plh4NNrxsc51vYTrXMfjT9vbt/tKe2iKKGmH4z6gnfIS lWk6lRjkam/I2Cfw02z5fo45EZGYs4mfOUZ90YrNpXSTzV9hSD2tF2PC54hXb08XNkyYfL2BDyyt7k 112CvAV35cPEay2BSSPKyWihOub7hX
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
index d664114d0661..d3665d7f6e78 100644
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

