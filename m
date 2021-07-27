Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327783D7D33
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhG0SMa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 14:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhG0SM3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 14:12:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71D9B6056B;
        Tue, 27 Jul 2021 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627409549;
        bh=Yogziv8PBor2Z+LTr480PcDONcJAPIutmJu/cs7cZNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohDamLSvQj4DYIQYad/tLVBerRQWMe69569RKqwxKQbkVh6ByFqHom9jhbOY2jGD5
         LD3bJpG6EEK2ZE9nrBqOfd4K9nGeij8sqZ6UIM/19ErJLiWCYUWlBVhdiJRnNg6slC
         67QU4PUpz9KE2YgVpNHNyKU38VEgpJ4C8On6jFbixWayv2n+fR7kvbnMrcMVfBN1C9
         cJahCyCuJI9qrCJFZhftfeOYnLOvUNFCzUlYAl1X0M0mCICrP2oJNi4wFOwoiAzV/Z
         VwUbdxdOfY3XPWbaLwaa0whgXpzl0SxsInNAYR0AYFBF1R31RclxvgoMreYGNoj9HQ
         cXxgHzDotIEqw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/3] kselftest/arm64: Validate vector lengths are set in sve-probe-vls
Date:   Tue, 27 Jul 2021 19:06:48 +0100
Message-Id: <20210727180649.12943-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727180649.12943-1-broonie@kernel.org>
References: <20210727180649.12943-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1670; h=from:subject; bh=Yogziv8PBor2Z+LTr480PcDONcJAPIutmJu/cs7cZNo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAEs3KQJ/yaogg10mK29zjdVxMAETaLlSzXfmk+GF siJf8J6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQBLNwAKCRAk1otyXVSH0MULB/ 0ZSdCFGTQsIEQZPmYE3sLhSdwynr3ZUYEinmcduIVnXelz+95fe4ntXlScZ8nZRbPdoZuNs2s1rS8t oG9+snltXTGkqDjPEEgvk4xn4vFYJzhbyGJ5OW5YUYioKEmYqSYULGJ2ScbU/MwbNlWGF3GX2x2BZp vRgY9oZ+gZE9/+mJVkUk3yFVmq6U24WTzK5KTMyINQztqx+ugHNB+OMD458WB+xN34+/jliTK3/pGY 4S7zarAyO+7LSWSnaaWOp6sY/fpIy0C5yuRYRpUp5iaV+Xkam6lVvTvSpHqEQexufatIqdYGGQT+W/ +n3PMqYe9sGcFCA8DyzkfLGvcHuHPu
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently sve-probe-vls does not verify that the vector lengths reported
by the prctl() interface are actually what is reported by the architecture,
use the rdvl_sve() helper to validate this.

Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 76e138525d55..a6cd1bd6e515 100644
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
+			ksft_exit_fail_msg("Set VL %d, RDVL %d\n",
+					   vl, rdvl_sve());
+
 		if (!sve_vl_valid(vl))
 			ksft_exit_fail_msg("VL %d invalid\n", vl);
 		vq = sve_vq_from_vl(vl);
-- 
2.20.1

