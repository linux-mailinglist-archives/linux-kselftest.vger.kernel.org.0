Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06941E0B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353312AbhI3SRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353145AbhI3SRX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAEC461A02;
        Thu, 30 Sep 2021 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025740;
        bh=l6+JWYoEZiST/b/oaay4qqKgTm5vYAcRw9QxR4U0kzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8jjt/rYrg5E4Enptp8AGKSB2Hfu/b/N0w7SgXzQAQe+T7MF2et1Q9Z2Ax/kIQQco
         jMdXDp6Pczo+JZeabtikNyYRDl4k7D7032m3h1rxgrkaaADglUer8Xq+pC7X1jxJ4D
         OiS15xTiX+TJQjlaSWwQtBBo3N0/rVYINs8iwY9G7XvK4hJKk0vXxviykmyxFBBScy
         LnxQ0SegM2iH1P964k5k8psawWt4OPaY9rVWru1c18KBFyVagwrjN/zfzVC4eKqB+r
         r0PUUZTZXiNlHP7oJ94wA6RQvVRoHolcol52w+HvFwSqmnacQ7XxTaY4YUVpuctQCF
         pXYV/tIsWZWaA==
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
Subject: [PATCH v1 01/38] arm64/fp: Reindent fpsimd_save()
Date:   Thu, 30 Sep 2021 19:11:07 +0100
Message-Id: <20210930181144.10029-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=l6+JWYoEZiST/b/oaay4qqKgTm5vYAcRw9QxR4U0kzE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3C1BuzGrlbEpHu7U8KsHvx+MmjgKFRL5Kp84rp kIS632uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9wgAKCRAk1otyXVSH0JaAB/ 9B8LMpzFTruHCiTRLoZzXZuJZnXFBOjNlZ4sIRJ0lIfkRAbatV9tVaksXwZPJA9m1Ow4OY9guqujQp zQKLGF1pRnGobo2Maci8Sdm4miIBpIHciTzTqlsIiD+uCFS5zAZGT9aChH54/9e9tJsjIInwbSJqU1 MV1EEOBMdvqDH2xakIRPwFccJwhY1Ldlltc86kwWJCP5vicaQlcvJd1xEbOSCj1WTcKEU2yhMvNvgm BC2J4VU0erRkSHYEH1zDk8AYm4tfI5kBo+0PsXkBaxePENR0IoCfaDT4R65L5y+BG7dVxXzkaNgmXi Vl/m652RTMWBBZYREq+Ji5CNIGvHU/
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
2.20.1

