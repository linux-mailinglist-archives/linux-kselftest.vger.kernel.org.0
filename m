Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF5433D43
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhJSRZu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhJSRZt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74FAA61212;
        Tue, 19 Oct 2021 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664217;
        bh=EY66616TcCrNTtvlQ1iP/Mic6pteYvGPqPysSuGmeik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrZYGmMJaMIJN3B16WWu8a4K0r1xL8IInvtwbChf67MT9mRuDy8iiQg0bNhox7pcv
         wTe0YmriFuIsrjrlTOW1qVXCGx5fDepGR263d4emKfq23JtjY6vlRE/HAhPxMgslWG
         Hrt2nmpO24lkMExhRwYKWdkpoejKjOe0iero+EMHjaTsVyXmCkwmcGegmDKfc8Yl+a
         ZY/TP+BuV8i28Cq3GwfXtbpOmhzww0VGvfsZspL+0ctEvC5jojE1iBLv8367SiaSez
         3eJsYe1pQ8Qq8ZBGPBOxD/y95rX4AMx+vNAekoeE7oEFvxGWcVsqOyNbeK1yh18956
         W55HPop797P9g==
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
Subject: [PATCH v3 01/42] arm64/fp: Reindent fpsimd_save()
Date:   Tue, 19 Oct 2021 18:22:06 +0100
Message-Id: <20211019172247.3045838-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=EY66616TcCrNTtvlQ1iP/Mic6pteYvGPqPysSuGmeik=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7EaS6xFJBpyZitL/aQgtPUEypvUI/1s4G82c6X Yc3PXHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+xAAKCRAk1otyXVSH0PI6B/ 4/PUYHFsj0uRKgWUHp+lVZRjoE1UNwp8A/2W0svZWjm/u5HDTbZxVNZYB2wmC7dyxRQCKDdFmQ0Sxg 1aH83K9Wxj1W6rJithjdZZHpxdMUeCMUov8Y0TSYYREeOqeDpn+p180Tqla8v7YiiLXQctwkbWYGRV 255pKB8orQwXtSYptefu+MDPsStqsHSwURThdk/cNk6psjgcBBGbh++xRPH9xIo0+F4xEuVjiQB3Ag sfXZEEUY54ZQISb069B8SwZ0Fu458zrqRum4f4cikym8IZM9NnVc97P3GiZVNJ27kdKhQ4pF0VYbSA XWViWRrmfvWJtl69qVxRLa0MRfUqAW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently all the active code in fpsimd_save() is inside a check for
TIF_FOREIGN_FPSTATE. Reduce the indentation level by changing to return
from the function if TIF_FOREIGN_FPSTATE is set.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ff4962750b3d..995f8801602b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -308,24 +308,26 @@ static void fpsimd_save(void)
 	WARN_ON(!system_supports_fpsimd());
 	WARN_ON(!have_cpu_fpsimd_context());
 
-	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
-		if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-		    test_thread_flag(TIF_SVE)) {
-			if (WARN_ON(sve_get_vl() != last->sve_vl)) {
-				/*
-				 * Can't save the user regs, so current would
-				 * re-enter user with corrupt state.
-				 * There's no way to recover, so kill it:
-				 */
-				force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
-				return;
-			}
-
-			sve_save_state((char *)last->sve_state +
-						sve_ffr_offset(last->sve_vl),
-				       &last->st->fpsr);
-		} else
-			fpsimd_save_state(last->st);
+	if (test_thread_flag(TIF_FOREIGN_FPSTATE))
+		return;
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    test_thread_flag(TIF_SVE)) {
+		if (WARN_ON(sve_get_vl() != last->sve_vl)) {
+			/*
+			 * Can't save the user regs, so current would
+			 * re-enter user with corrupt state.
+			 * There's no way to recover, so kill it:
+			 */
+			force_signal_inject(SIGKILL, SI_KERNEL, 0, 0);
+			return;
+		}
+
+		sve_save_state((char *)last->sve_state +
+					sve_ffr_offset(last->sve_vl),
+			       &last->st->fpsr);
+	} else {
+		fpsimd_save_state(last->st);
 	}
 }
 
-- 
2.30.2

