Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E454226CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhJEMhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 08:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhJEMhc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 08:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82647615E3;
        Tue,  5 Oct 2021 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633437342;
        bh=XptJGijGzEfLNQW2tjMY2tG5+LCqmXAaDRM+0h+ZrvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pwtgo8TcMHQp2FoKMykPpxnkAvfS+52DGGOA/ILGURjOKONh7yJxKtQjzjs/znW4U
         ztSVlIyt3zV/LHotDIi3xyYrdeUM8OZbfPcNPW9Jw8/TW9yZ235V6TCPdhUCWcHIFV
         dZtmbURlWlbZrDCEkLdsmegmuoODH3WnCfGlE8uA4mEkcq7/a50kYPZJi+aFTII807
         Q0Jd7j9dOmKf5JViNwZfnwXWZXXECey41S6hpIfjhj5jPt2UxH2yUz71DtfbQrLBmB
         SD6SmPdT+GrYrHFdlBOjTeeDf2q2Yc786VFvM8LdCCuHtToM4MRuxUkwUw9NHgG6PJ
         rHT/MN60203CQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance
Date:   Tue,  5 Oct 2021 13:35:37 +0100
Message-Id: <20211005123537.976795-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; h=from:subject; bh=XptJGijGzEfLNQW2tjMY2tG5+LCqmXAaDRM+0h+ZrvQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhXEZZXPuy1DjTOAckAL7KkNP0jDWu8RsE7cPuJFdR vQ9IqryJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVxGWQAKCRAk1otyXVSH0OOxB/ 92JSZMTE22jl+0sBy810Ubuso8jBDxtaYmeOe2CdaN9sGgFQK3QaAnUiASfnzrjysJFn1woJhbKacn rq0NkdZvX1uDEMhhRtk1n7x5Q5XUHXn6QEUDDoomNOnKZ2PY3t14laBxAz3/Vp0NynwKwnkMMJcYpi tjhy43rItIoR1bEKDR2BOqRHntvAq3MeZ7rzYc1oPocO1vjdfDVCKUkQZtqdOZoMwkbKGqdJVK6cO0 F14vJuYyKKFsg3xcbiTLm4gh2qEWU8ZJYIE4TdkpEqGGEUvRnKMk66ndnepq771sd3sKAe1Uw1eXfb v04Bb7CJrAa4QaAmLLWKRhIuO3nlzo
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test that covers enabling and disabling of SVE vector length
inheritance via the ptrace interface.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 55 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index ac0629f05365..c4417bc48d4f 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -22,7 +22,7 @@
 #include "../../kselftest.h"
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
-#define FPSIMD_TESTS 3
+#define FPSIMD_TESTS 5
 
 #define EXPECTED_TESTS (VL_TESTS + FPSIMD_TESTS)
 
@@ -105,6 +105,56 @@ static int set_sve(pid_t pid, const struct user_sve_header *sve)
 	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_SVE, &iov);
 }
 
+/* Validate setting and getting the inherit flag */
+static void ptrace_set_get_inherit(pid_t child)
+{
+	struct user_sve_header sve;
+	struct user_sve_header *new_sve = NULL;
+	size_t new_sve_size = 0;
+	int ret;
+
+	/* First set the flag */
+	memset(&sve, 0, sizeof(sve));
+	sve.size = sizeof(sve);
+	sve.vl = sve_vl_from_vq(SVE_VQ_MIN);
+	sve.flags = SVE_PT_VL_INHERIT;
+	ret = set_sve(child, &sve);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set SVE_PT_VL_INHERIT\n");
+		return;
+	}
+
+	/*
+	 * Read back the new register state and verify that we have
+	 * set the flags we expected.
+	 */
+	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read SVE flags\n");
+		return;
+	}
+
+	ksft_test_result(new_sve->flags & SVE_PT_VL_INHERIT,
+			 "SVE_PT_VL_INHERIT set\n");
+
+	/* Now clear */
+	sve.flags &= ~SVE_PT_VL_INHERIT;
+	ret = set_sve(child, &sve);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to clear SVE_PT_VL_INHERIT\n");
+		return;
+	}
+
+	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read SVE flags\n");
+		return;
+	}
+
+	ksft_test_result(!(new_sve->flags & SVE_PT_VL_INHERIT),
+			 "SVE_PT_VL_INHERIT cleared\n");
+
+	free(new_sve);
+}
+
 /* Validate attempting to set the specfied VL via ptrace */
 static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
 {
@@ -452,6 +502,9 @@ static int do_parent(pid_t child)
 	/* FPSIMD via SVE regset */
 	ptrace_sve_fpsimd(child);
 
+	/* prctl() flags */
+	ptrace_set_get_inherit(child);
+
 	/* Step through every possible VQ */
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
 		vl = sve_vl_from_vq(vq);
-- 
2.30.2

