Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799AB408D10
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhIMNXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239450AbhIMNUy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A07461242;
        Mon, 13 Sep 2021 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539142;
        bh=X8xv6IhDmCpAV7VXVZkOxAjGP99z74IVeoo0V7Z/c4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyDiVMfplM+huBEwD5Gz+t7NEZTlXDQixdBZ8jShbeWuMTTV1zRPp5btB9EBQ2QwM
         j7JiHamYQw+BuYlYhiBGXzf0va+twpvEOrvBwIWPAQYMsru1qw5y4k7dxdU8KQ73Yq
         ySuWf/vWT5VpKrhR/DXw5aXWDIpXdKcAzeddH93Mh2LG1fdaDanYs6GASB9F/M4ToL
         0W+HNlUpi2V7OwNrsk+U1Fsd0uTVxT2rzkfalylSR43DI9866ZKuXl1HtyO5ieYz0l
         dnaPHhh5BquFQVlWO3XkSdMS8PxZ/oUv2FD0vjBKiP8+EjPuxzeGb94XSoSLA/a3ST
         w4h6/7FVTYBSQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 6/8] selftests: arm64: Verify interoperation of SVE and FPSIMD register sets
Date:   Mon, 13 Sep 2021 13:55:03 +0100
Message-Id: <20210913125505.52619-7-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; h=from:subject; bh=X8xv6IhDmCpAV7VXVZkOxAjGP99z74IVeoo0V7Z/c4g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0on4TOj9LdR5rFhDpLxeddoMFb9MuRaFRBSTZIZ Ck4OLe2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KJwAKCRAk1otyXVSH0NEOB/ 9+M2GNcWCemczC/iZISUMtVAYSzRtNnOoqzXXznP1P2vTa2ZiXQDfPJQWAKVlnicYwSHuIpwQPv7Te 1pe+K15xcfaMXehSoJ0ri9SppRS/w7tIqLMI5qObFsccXDtJHEHnwg5x7DStbclIDBLVsveSHFn+EV UU2CovngjVOxtU5jNBVc/3uazsoJSV0OZvWPKuHVH6T2VgFgB+EYU1/ha0aUEfUKtAoZk+N7SN7M3A 5qMtJI07OrVkIYheNPR3miA5GVUhFES31TNuc6gNvgfChJc8JititdjpaLUOxKnM8xu4GznjwwC2HE VYo4rHsfITeNwdEmG91fQOmjbUv0UO
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After setting the FPSIMD registers via the SVE register set read them back
via the FPSIMD register set, validating that the two register sets are
interoperating and that the values we thought we set made it into the
child process.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 2d130fedc019..31a2c2fc529d 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -46,6 +46,15 @@ static int do_child(void)
 	return EXIT_SUCCESS;
 }
 
+static int get_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
+{
+	struct iovec iov;
+
+	iov.iov_base = fpsimd;
+	iov.iov_len = sizeof(*fpsimd);
+	return ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
+}
+
 static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
 {
 	struct user_sve_header *sve;
@@ -122,7 +131,7 @@ static int do_parent(pid_t child)
 	void *svebuf = NULL, *newsvebuf;
 	size_t svebufsz = 0, newsvebufsz;
 	struct user_sve_header *sve, *new_sve;
-	struct user_fpsimd_state *fpsimd;
+	struct user_fpsimd_state *fpsimd, new_fpsimd;
 	unsigned int i, j;
 	unsigned char *p;
 	unsigned int vq;
@@ -221,7 +230,22 @@ static int do_parent(pid_t child)
 		goto error;
 	}
 
-	/* Zero the first SVE Z register */
+	/* Verify via the FPSIMD regset */
+	if (get_fpsimd(pid, &new_fpsimd)) {
+		int e = errno;
+
+		ksft_test_result_fail("get_fpsimd(): %s\n",
+				      strerror(errno));
+		if (e == ESRCH)
+			goto disappeared;
+
+		goto error;
+	}
+	if (memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0)
+		ksft_test_result_pass("get_fpsimd() gave same state\n");
+	else
+		ksft_test_result_fail("get_fpsimd() gave different state\n");
+
 	vq = sve_vq_from_vl(sve->vl);
 
 	newsvebufsz = SVE_PT_SVE_ZREG_OFFSET(vq, 1);
-- 
2.20.1

