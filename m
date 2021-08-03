Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA66F3DEFBA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhHCOHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 10:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhHCOHR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5938660EE7;
        Tue,  3 Aug 2021 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999626;
        bh=EKvkyVbCFIkHGIl1Aft6XfS6vxY/FRzv+NjTpqSFwTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ooq1d1wq9OpuQC5QvktC8CdDA8/IqoX2jf25b4/phsUanbnSW4cgv115hVzMqlnOG
         4T167GiFTkYtgJwn6OWIEGnSnO4RfRIm1NDiuUQ7if9SqwNUyJw0XLRJo3tXr2kuyv
         NiA5bY/zi8ZVMRuo1vewlp+4Yz6xZLbmUBXmnQcuCbKSpRJJstdAzKr407xx7wfRAN
         EMntfHkAFII2dvssLPImOCmaWCaWithAu2bJiClxwpCzi1sKvbk1StiG9YleNouL4J
         dLr32Eglhbhjb4B9No6/ySU8BqoBQ1XkMZTKqFWRcVySFcmO/AG/Y5Da1ShqsT1Lsg
         LlNnSqiA2dgYA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 2/4] kselftest/arm64: Validate vector lengths are set in sve-probe-vls
Date:   Tue,  3 Aug 2021 15:04:48 +0100
Message-Id: <20210803140450.46624-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803140450.46624-1-broonie@kernel.org>
References: <20210803140450.46624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; h=from:subject; bh=EKvkyVbCFIkHGIl1Aft6XfS6vxY/FRzv+NjTpqSFwTM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhCUz+yb4Ch9ouisizN+OUT44lVwHjZYwPWcERArhr KSPtigSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQlM/gAKCRAk1otyXVSH0LJZB/ 9Z5f4wgiwSMPzOIt5LyYqJU+yMz7rCb0HOEABAfK/dBg8ouHLEBXTg4pWpsHqCZCxQwYYI0IQe6o16 BpA5VpOiGKsHC0/Bbu+pEFbf5W7aTCGHr2aHtuWFBRrPvgx/5gNSHIUkLwNwvNWky9avYVXeeYRqwy UcUcOsQUK7l4vIQ/e+rVPYqfG2cgnb041Y5GWo38+hSa7wY4K+EdghNze5598ZH7FS2kL+GFxo3yTn neRAT7Bn2GAgAyxSfi3s/3DNea6VnFPrX2Fj0ieePKfUFS3livhrSPQe+i/4W0n4Www/0Fnt8tLn6I prTA+iao5xdsPtO5wO7MUEWYhSlTKF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently sve-probe-vls does not verify that the vector lengths reported
by the prctl() interface are actually what is reported by the architecture,
use the rdvl_sve() helper to validate this.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/Makefile        | 2 +-
 tools/testing/selftests/arm64/fp/sve-probe-vls.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index ed62e7003b96..fa3a0167db2d 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -13,7 +13,7 @@ fpsimd-test: fpsimd-test.o
 	$(CC) -nostdlib $^ -o $@
 rdvl-sve: rdvl-sve.o rdvl.o
 sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
-sve-probe-vls: sve-probe-vls.o
+sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o
 	$(CC) -nostdlib $^ -o $@
 vlset: vlset.o
diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
index 76e138525d55..a24eca7a4ecb 100644
--- a/tools/testing/selftests/arm64/fp/sve-probe-vls.c
+++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
@@ -13,6 +13,7 @@
 #include <asm/sigcontext.h>
 
 #include "../../kselftest.h"
+#include "rdvl.h"
 
 int main(int argc, char **argv)
 {
@@ -38,6 +39,10 @@ int main(int argc, char **argv)
 
 		vl &= PR_SVE_VL_LEN_MASK;
 
+		if (rdvl_sve() != vl)
+			ksft_exit_fail_msg("PR_SVE_SET_VL reports %d, RDVL %d\n",
+					   vl, rdvl_sve());
+
 		if (!sve_vl_valid(vl))
 			ksft_exit_fail_msg("VL %d invalid\n", vl);
 		vq = sve_vq_from_vl(vl);
-- 
2.20.1

