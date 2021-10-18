Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5915432722
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhJRTMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhJRTMR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:12:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E84261351;
        Mon, 18 Oct 2021 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584205;
        bh=EY66616TcCrNTtvlQ1iP/Mic6pteYvGPqPysSuGmeik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jp4La5q1kqkX05Dee/vpBQBvjpXDaDG/jHTaPvItsDkhtsc7CF9sA7JqVgs7zAX6o
         tb7nuIxTgk/hTFpRmgYz6jAZ0gb1IuLPlRxHVYGeVD2mHQ8i6PWCiQxV2IYkEvsWW3
         CVIHKkNt5iBoP9axPtop3hyxtA4QSarro8/syLAjuckwQPByT6/3istTIA8YO6nw5T
         pYUC9PG2HWVpEw3LKs34euClrGR0hsZ60gKKW+1YUP+d5msNWf9isPPBkw3BvYr32x
         yLeZMUZqWcgxpsOAukgONEmQaVW+JuQf3fTgJM/zKBvQ51CgykkTcZPj7EK/CdWMdX
         LRFduvtu+rGmg==
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
Subject: [PATCH v2 01/42] arm64/fp: Reindent fpsimd_save()
Date:   Mon, 18 Oct 2021 20:08:17 +0100
Message-Id: <20211018190858.2119209-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=EY66616TcCrNTtvlQ1iP/Mic6pteYvGPqPysSuGmeik=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcYoaS6xFJBpyZitL/aQgtPUEypvUI/1s4G82c6X Yc3PXHmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GKAAKCRAk1otyXVSH0EBAB/ 9lpCX0/lJzoEuOzLIfTqttk3GTFPfvFB4SqRgmsPeuLNaJzEeE5MB+EKDjd96GE+1bfLrRX/4fgvW+ RypqBYCvHpjnZE9jEZc6tAHgKkRCWR3AgrcJ7tDRibavv8PTilNRc0V8smxy+Rc5+6zsZq+mHW51Ya 10Pi+eLWFPQ5GywKEmmhc7nk2cJO8Tkj6IQXY5IoWlbaYk9yXo/vQFA8HQenDC7WfkHnl1CfQ0TGqC M7NuheHb9YZfyUZgcG3E54ci6yId7BC9OSTBHZXlXgjk/br9oRAw/3Hotd9INU6/oVPyLf1SZ9VIr1 IYvCByH0VJpgc0Dn9uLuuy/984PaKC
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

