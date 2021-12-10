Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630447092E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhLJSsh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbhLJSsb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:48:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D2EC061A72
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:44:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F22AB8294F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FECC341CF;
        Fri, 10 Dec 2021 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161892;
        bh=bkBYT4k3ZBuYZ8y2fivhAQZeTAtf+sRlywstAAKtKAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vie496r+Le5KbRmSA4DhUczcT81KaXsgK/oKqf24sLJTgAg/SoAC3SWI7Ne/svESM
         2nc60GDANp5C2HpKCBLvf3qD7EXQpRoRn+/3E+LY2GLHpI51lzNVPdI2MvthP5K+Oo
         JQQ5YYDQkpovdRgT1so7AZyCxkQb4L2ieoDLXnkBTOTDn6FZLE0rvhwFwf0RPmddNI
         VNBgOZYbJvuaDUq4rhR6CtjSCUAUHerp+OZ1V9d7VDetjIOSPhzD+ylX48DUDjrkqY
         kbRnVyEpM7xcMgC6GeGJi8zTkUhdA/2fBUnIWfgxovJV4+HTLHhf3+IZs6vzNFDGtA
         g9UkLIbKGBfFA==
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
Subject: [PATCH v7 26/37] arm64/sme: Disable streaming mode and ZA when flushing CPU state
Date:   Fri, 10 Dec 2021 18:41:22 +0000
Message-Id: <20211210184133.320748-27-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; h=from:subject; bh=bkBYT4k3ZBuYZ8y2fivhAQZeTAtf+sRlywstAAKtKAw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59SF7IRoTtmIhOBN87ihEgbe/Qa6QjrTf127RPC la4ME1iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfUgAKCRAk1otyXVSH0KZGB/ 9ghnvNGWa5guiA6StYSHxrVnWZzTmcrO5eLcyirSqX/xiCT7b4OsuHqsRB2kljDua60QdasaPqJ1q2 FwgoGJncOSt7kNB/p6jawba4n7wbFGrXPqIsoqqBlVoXsocBrqmjT19M6Mi7mHYAQEhIRYa4/ba5bR af71FFq9G28tytXml6XY7kQib7US/nyOtDW1YpcZRKa19KES7KolV4D5ZMEHUbDem4z7WRww6eUa52 3cEVqGSKa04ksxS5PWsSNY8jiq9LEPHqHDBIoVx5YUZ9iiqwOvwRAA2H10lGKO6FkSv6y0uWcu0479 ueNpvoo1SPHReWGMLBE74qt5zxhtk7
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
index fde9f4ee81ac..bb174c1b8ae0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1771,6 +1771,15 @@ static void fpsimd_flush_cpu_state(void)
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

