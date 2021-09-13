Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAC408CF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbhIMNW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240371AbhIMNUz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753C46121E;
        Mon, 13 Sep 2021 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539148;
        bh=19LgCb0jNuyXWq8SS9WLfTnJwPtwQWgyfCl8AU5M2vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAbtVzUmx1iUkdV/v3oNuS7K9gsBnwC6mmcdeFX7d/rmWwA/58ZEoAx925pq178N3
         l28tz0iU+/CgcDKutgycjYmwv1HT0rvJSifVxJmlLpcX2F7wSRdf2Z79RG8w90F+dQ
         O8uE02193sRslJM11jdVBsJpUXkMAcWAlJgRO/16H+FJVxrk63lge/Lik9dApMBwJY
         8iEom3leKHjXt2X/Z6nLkm1naXy6hKz77pzpp8p/yY4nC60Mfk5RFK+tOX63+7QIN6
         /21dWSL42g5XCQzp7S94xi4ktE42Sl1b/3LnJ2X5MJLMdFg0n9DSH6VdC8lfCQudZO
         pdVBjpVW430mg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 8/8] selftests: arm64: Move FPSIMD in SVE ptrace test into a function
Date:   Mon, 13 Sep 2021 13:55:05 +0100
Message-Id: <20210913125505.52619-9-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; h=from:subject; bh=19LgCb0jNuyXWq8SS9WLfTnJwPtwQWgyfCl8AU5M2vw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0ooWOgJwwkTSHtiHMRDt9lwHtGMZLxP9rmNDEjB E8ksnFOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KKAAKCRAk1otyXVSH0JIqB/ 4tJv0ZPlsao1/1W57eiGm/csE8cjOsTPyt8h5+XC2LWHjXC5H8/06uJdqogPHzBY4ufqN0T5iK7eK/ vYDwIzSYqBcEhwkzcRWXj88YVpgI2HnFZCJFFAq0NuxWLalcfmT1nKdnTNcRu+d86Q274bCKl06Ivl 9bHtLz64Ed+1hXE9iH6LHKPeeh8tgyxVI3FncFAmsbpzYQ8zcEyNG2seNV+KNLVBzoJdVqYWuuSuG7 tT9KPqEPHQ+A0VjrH9w3s53p/zKpi4eMgalVJAGUIAX/KWbE+Xue03H9D4Atk0yX1olehD5VSRoUsD sQlPleuu6hCjKeijDSvpegnFjnSQ2z
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that all the other tests are in functions rather than inline in the
main parent process function also move the test for accessing the FPSIMD
registers via the SVE regset out into their own function.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 120 +++++++++---------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 199710ba65c7..ac0629f05365 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -158,6 +158,63 @@ static void check_u32(unsigned int vl, const char *reg,
 	}
 }
 
+/* Access the FPSIMD registers via the SVE regset */
+static void ptrace_sve_fpsimd(pid_t child)
+{
+	void *svebuf = NULL;
+	size_t svebufsz = 0;
+	struct user_sve_header *sve;
+	struct user_fpsimd_state *fpsimd, new_fpsimd;
+	unsigned int i, j;
+	unsigned char *p;
+
+	/* New process should start with FPSIMD registers only */
+	sve = get_sve(child, &svebuf, &svebufsz);
+	if (!sve) {
+		ksft_test_result_fail("get_sve: %s\n", strerror(errno));
+
+		return;
+	} else {
+		ksft_test_result_pass("get_sve(FPSIMD)\n");
+	}
+
+	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
+			 "Set FPSIMD registers\n");
+	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
+		goto out;
+
+	/* Try to set a known FPSIMD state via PT_REGS_SVE */
+	fpsimd = (struct user_fpsimd_state *)((char *)sve +
+					      SVE_PT_FPSIMD_OFFSET);
+	for (i = 0; i < 32; ++i) {
+		p = (unsigned char *)&fpsimd->vregs[i];
+
+		for (j = 0; j < sizeof(fpsimd->vregs[i]); ++j)
+			p[j] = j;
+	}
+
+	if (set_sve(child, sve)) {
+		ksft_test_result_fail("set_sve(FPSIMD): %s\n",
+				      strerror(errno));
+
+		goto out;
+	}
+
+	/* Verify via the FPSIMD regset */
+	if (get_fpsimd(child, &new_fpsimd)) {
+		ksft_test_result_fail("get_fpsimd(): %s\n",
+				      strerror(errno));
+		goto out;
+	}
+	if (memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0)
+		ksft_test_result_pass("get_fpsimd() gave same state\n");
+	else
+		ksft_test_result_fail("get_fpsimd() gave different state\n");
+
+out:
+	free(svebuf);
+}
+
 /* Validate attempting to set SVE data and read SVE data */
 static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 {
@@ -335,12 +392,6 @@ static int do_parent(pid_t child)
 	pid_t pid;
 	int status;
 	siginfo_t si;
-	void *svebuf = NULL;
-	size_t svebufsz = 0;
-	struct user_sve_header *sve;
-	struct user_fpsimd_state *fpsimd, new_fpsimd;
-	unsigned int i, j;
-	unsigned char *p;
 	unsigned int vq, vl;
 	bool vl_supported;
 
@@ -398,61 +449,8 @@ static int do_parent(pid_t child)
 		}
 	}
 
-	/* New process should start with FPSIMD registers only */
-	sve = get_sve(pid, &svebuf, &svebufsz);
-	if (!sve) {
-		int e = errno;
-
-		ksft_test_result_fail("get_sve: %s\n", strerror(errno));
-		if (e == ESRCH)
-			goto disappeared;
-
-		goto error;
-	} else {
-		ksft_test_result_pass("get_sve(FPSIMD)\n");
-	}
-
-	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "Set FPSIMD registers\n");
-	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
-		goto error;
-
-	/* Try to set a known FPSIMD state via PT_REGS_SVE */
-	fpsimd = (struct user_fpsimd_state *)((char *)sve +
-					      SVE_PT_FPSIMD_OFFSET);
-	for (i = 0; i < 32; ++i) {
-		p = (unsigned char *)&fpsimd->vregs[i];
-
-		for (j = 0; j < sizeof fpsimd->vregs[i]; ++j)
-			p[j] = j;
-	}
-
-	if (set_sve(pid, sve)) {
-		int e = errno;
-
-		ksft_test_result_fail("set_sve(FPSIMD): %s\n",
-				      strerror(errno));
-		if (e == ESRCH)
-			goto disappeared;
-
-		goto error;
-	}
-
-	/* Verify via the FPSIMD regset */
-	if (get_fpsimd(pid, &new_fpsimd)) {
-		int e = errno;
-
-		ksft_test_result_fail("get_fpsimd(): %s\n",
-				      strerror(errno));
-		if (e == ESRCH)
-			goto disappeared;
-
-		goto error;
-	}
-	if (memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0)
-		ksft_test_result_pass("get_fpsimd() gave same state\n");
-	else
-		ksft_test_result_fail("get_fpsimd() gave different state\n");
+	/* FPSIMD via SVE regset */
+	ptrace_sve_fpsimd(child);
 
 	/* Step through every possible VQ */
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
-- 
2.20.1

