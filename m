Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DFD3DAA65
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhG2Rhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 13:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhG2Rhe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 13:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3053D60E9B;
        Thu, 29 Jul 2021 17:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627580250;
        bh=EKvkyVbCFIkHGIl1Aft6XfS6vxY/FRzv+NjTpqSFwTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHMCVlwOOi6ic4rDNNGx9Oij9pzaBizxzHf56Ne3u7QSlJpSpfDx9spyLrqYUmrmE
         uGJR6UqYWh5uAPLLcW0thvDsdYOdEvmYXXKOomsUpCxvWb8qKgq5XxbXAcOpUu//4j
         7In/Di1I54pXxppBW7bTzCMb/IqL8hUVuaO5L0cx9TX/3Xy1VeevGzF07bucJRTWda
         3c4QlAiHxwb4VpT54tuKRvCngrYPrA2IPq0XbKrDnNpAhEWWP4GfGW5HP7esPveeSd
         H3+u1WmVonOTjNzVkdja407Y7DmU1g4ZVReSL2DIolJ64YNTTyKrGu3I0KVEdSnips
         qhoodCh67jCJA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 2/4] kselftest/arm64: Validate vector lengths are set in sve-probe-vls
Date:   Thu, 29 Jul 2021 18:37:11 +0100
Message-Id: <20210729173713.4534-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729173713.4534-1-broonie@kernel.org>
References: <20210729173713.4534-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; h=from:subject; bh=EKvkyVbCFIkHGIl1Aft6XfS6vxY/FRzv+NjTpqSFwTM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhAudGyb4Ch9ouisizN+OUT44lVwHjZYwPWcERArhr KSPtigSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYQLnRgAKCRAk1otyXVSH0AjQB/ 9cy3Dhe8jQsatZLZOyh0podbS2Wvdb8brmBcdNtJuW/r4Jf+fSV2bZwrxK5JAt5U/f4HOGbrYOshRG nDaV5pY+pAW8vvsOzOGedeWF9YVTPnEbcvO7oUIO3Gd7EzBd6bgK2W595YV39V5wJ0fe7MFF9/a+B1 wS0ikGQl3Pa8CNTabL/O7KU9kijEShZ/9+pg0brFsklTEbcbJRxVDs1e3rorbxReZbHGe64AwgwomK t4Gm2nh71b7lxPuEQlGqpu/KdRKhYqIQcS3KnThHuTIxKLQ8ITkG7ku76rJcEhZlbFEZzUERfVLP4D s4VpWFHS5p5CtrTG1j9syExc+bbQCV
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

