Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF1470911
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbhLJSrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbhLJSrZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:47:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7520C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5474CB8294F
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB0BC341CD;
        Fri, 10 Dec 2021 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161827;
        bh=ci6/NBWhuJhkUbJiH/ilo5xeFYHP10Jd/hZMcWcV25I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MbmsjklZ/8B7SETtLdonwZxlLPh9aFIjiwGLtPKvjhW4eGdZbFqh8KliPhB3i9Ezt
         x3saVhwAO6XLyNZ/gZzkxteYE6a7G2ttO6o5jY8jPG6ongS8xj9hOylR4hcgWZBwS2
         SaDjGZgHuRHb4Deyh8Hv/kJx4EYym9vtIJOvxNcacjM28WeTdKYyTOTQZ1Q4Www+dd
         kRaZbCW8JuO6WGY3SYXJLE7xEnYneMJfvSLFlr3DucZk2YGBfFx6oNhEMe1yrcG6WA
         yuE7CeVsTe3qthwHydo027pPbtUg4CsfUPMMVlgRlVusywlLbq+ZTNvjZG6NLxNQS4
         1AePYk82fzE4A==
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
Subject: [PATCH v7 04/37] kselftest/arm64: Parameterise ptrace vector length information
Date:   Fri, 10 Dec 2021 18:41:00 +0000
Message-Id: <20211210184133.320748-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16333; h=from:subject; bh=ci6/NBWhuJhkUbJiH/ilo5xeFYHP10Jd/hZMcWcV25I=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59BN1kX0zV2AD0W02uhzR9AenC3rQMow1+Lf+xC 45I3qgGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfQQAKCRAk1otyXVSH0A1+B/ 9xtXp8cliPdk8DpYq1ZR0kNwzEtto3Nws3vA4Xp34dRx32vqhyEEKRiNI3fPU5UVTfNbFh4LIUD/hR 1d3f+zw1M2Xsbeu6+ChHKlMD0s0XRCjfHdn9NDIO6UHZg+7ZbWkoZqhvF9IcJLeNv3UczAZFbiAq54 0nyVTbONSRwOETqPECnw2wsLuORJlG9F3uOqLkevaBv4MuOdwbZheRea/EmmOFtaIfK6zVM8saEzKx +Vc6Hw1NfwZSX5Y8/RC5kqnRQdwO+DMphuLgHrpj+GFaFtOga3rnV2K+d8TAC6o6awu+rfk2dfwngK Ib3DCidRAPrXK9tA3hzVqqyyMdNWy3
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SME introduces a new mode called streaming mode in which the SVE registers
have a different vector length. Since the ptrace interface for this is
based on the existing SVE interface prepare for supporting this by moving
the regset specific configuration into  struct and passing that around,
allowing these tests to be reused for streaming mode. As we will also have
to verify the interoperation of the SVE and streaming SVE regsets don't
just iterate over an array.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 219 ++++++++++++------
 1 file changed, 142 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index c4417bc48d4f..af798b9d232c 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -21,16 +21,37 @@
 
 #include "../../kselftest.h"
 
-#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
-#define FPSIMD_TESTS 5
-
-#define EXPECTED_TESTS (VL_TESTS + FPSIMD_TESTS)
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
 #endif
 
+struct vec_type {
+	const char *name;
+	unsigned long hwcap_type;
+	unsigned long hwcap;
+	int regset;
+	int prctl_set;
+};
+
+static const struct vec_type vec_types[] = {
+	{
+		.name = "SVE",
+		.hwcap_type = AT_HWCAP,
+		.hwcap = HWCAP_SVE,
+		.regset = NT_ARM_SVE,
+		.prctl_set = PR_SVE_SET_VL,
+	},
+};
+
+#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
+#define FLAG_TESTS 2
+#define FPSIMD_TESTS 3
+
+#define EXPECTED_TESTS ((VL_TESTS + FLAG_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
+
 static void fill_buf(char *buf, size_t size)
 {
 	int i;
@@ -59,7 +80,8 @@ static int get_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
 	return ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
 }
 
-static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
+static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
+				       void **buf, size_t *size)
 {
 	struct user_sve_header *sve;
 	void *p;
@@ -80,7 +102,7 @@ static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
 
 		iov.iov_base = *buf;
 		iov.iov_len = sz;
-		if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_SVE, &iov))
+		if (ptrace(PTRACE_GETREGSET, pid, type->regset, &iov))
 			goto error;
 
 		sve = *buf;
@@ -96,17 +118,18 @@ static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
 	return NULL;
 }
 
-static int set_sve(pid_t pid, const struct user_sve_header *sve)
+static int set_sve(pid_t pid, const struct vec_type *type,
+		   const struct user_sve_header *sve)
 {
 	struct iovec iov;
 
 	iov.iov_base = (void *)sve;
 	iov.iov_len = sve->size;
-	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_SVE, &iov);
+	return ptrace(PTRACE_SETREGSET, pid, type->regset, &iov);
 }
 
 /* Validate setting and getting the inherit flag */
-static void ptrace_set_get_inherit(pid_t child)
+static void ptrace_set_get_inherit(pid_t child, const struct vec_type *type)
 {
 	struct user_sve_header sve;
 	struct user_sve_header *new_sve = NULL;
@@ -118,9 +141,10 @@ static void ptrace_set_get_inherit(pid_t child)
 	sve.size = sizeof(sve);
 	sve.vl = sve_vl_from_vq(SVE_VQ_MIN);
 	sve.flags = SVE_PT_VL_INHERIT;
-	ret = set_sve(child, &sve);
+	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
-		ksft_test_result_fail("Failed to set SVE_PT_VL_INHERIT\n");
+		ksft_test_result_fail("Failed to set %s SVE_PT_VL_INHERIT\n",
+				      type->name);
 		return;
 	}
 
@@ -128,35 +152,39 @@ static void ptrace_set_get_inherit(pid_t child)
 	 * Read back the new register state and verify that we have
 	 * set the flags we expected.
 	 */
-	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
-		ksft_test_result_fail("Failed to read SVE flags\n");
+	if (!get_sve(child, type, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read %s SVE flags\n",
+				      type->name);
 		return;
 	}
 
 	ksft_test_result(new_sve->flags & SVE_PT_VL_INHERIT,
-			 "SVE_PT_VL_INHERIT set\n");
+			 "%s SVE_PT_VL_INHERIT set\n", type->name);
 
 	/* Now clear */
 	sve.flags &= ~SVE_PT_VL_INHERIT;
-	ret = set_sve(child, &sve);
+	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
-		ksft_test_result_fail("Failed to clear SVE_PT_VL_INHERIT\n");
+		ksft_test_result_fail("Failed to clear %s SVE_PT_VL_INHERIT\n",
+				      type->name);
 		return;
 	}
 
-	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
-		ksft_test_result_fail("Failed to read SVE flags\n");
+	if (!get_sve(child, type, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read %s SVE flags\n",
+				      type->name);
 		return;
 	}
 
 	ksft_test_result(!(new_sve->flags & SVE_PT_VL_INHERIT),
-			 "SVE_PT_VL_INHERIT cleared\n");
+			 "%s SVE_PT_VL_INHERIT cleared\n", type->name);
 
 	free(new_sve);
 }
 
 /* Validate attempting to set the specfied VL via ptrace */
-static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
+static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
+			      unsigned int vl, bool *supported)
 {
 	struct user_sve_header sve;
 	struct user_sve_header *new_sve = NULL;
@@ -166,10 +194,10 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
 	*supported = false;
 
 	/* Check if the VL is supported in this process */
-	prctl_vl = prctl(PR_SVE_SET_VL, vl);
+	prctl_vl = prctl(type->prctl_set, vl);
 	if (prctl_vl == -1)
-		ksft_exit_fail_msg("prctl(PR_SVE_SET_VL) failed: %s (%d)\n",
-				   strerror(errno), errno);
+		ksft_exit_fail_msg("prctl(PR_%s_SET_VL) failed: %s (%d)\n",
+				   type->name, strerror(errno), errno);
 
 	/* If the VL is not supported then a supported VL will be returned */
 	*supported = (prctl_vl == vl);
@@ -178,9 +206,10 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
 	memset(&sve, 0, sizeof(sve));
 	sve.size = sizeof(sve);
 	sve.vl = vl;
-	ret = set_sve(child, &sve);
+	ret = set_sve(child, type, &sve);
 	if (ret != 0) {
-		ksft_test_result_fail("Failed to set VL %u\n", vl);
+		ksft_test_result_fail("Failed to set %s VL %u\n",
+				      type->name, vl);
 		return;
 	}
 
@@ -188,12 +217,14 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
 	 * Read back the new register state and verify that we have the
 	 * same VL that we got from prctl() on ourselves.
 	 */
-	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
-		ksft_test_result_fail("Failed to read VL %u\n", vl);
+	if (!get_sve(child, type, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read %s VL %u\n",
+				      type->name, vl);
 		return;
 	}
 
-	ksft_test_result(new_sve->vl = prctl_vl, "Set VL %u\n", vl);
+	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
+			 type->name, vl);
 
 	free(new_sve);
 }
@@ -209,7 +240,7 @@ static void check_u32(unsigned int vl, const char *reg,
 }
 
 /* Access the FPSIMD registers via the SVE regset */
-static void ptrace_sve_fpsimd(pid_t child)
+static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 {
 	void *svebuf = NULL;
 	size_t svebufsz = 0;
@@ -219,17 +250,18 @@ static void ptrace_sve_fpsimd(pid_t child)
 	unsigned char *p;
 
 	/* New process should start with FPSIMD registers only */
-	sve = get_sve(child, &svebuf, &svebufsz);
+	sve = get_sve(child, type, &svebuf, &svebufsz);
 	if (!sve) {
-		ksft_test_result_fail("get_sve: %s\n", strerror(errno));
+		ksft_test_result_fail("get_sve(%s): %s\n",
+				      type->name, strerror(errno));
 
 		return;
 	} else {
-		ksft_test_result_pass("get_sve(FPSIMD)\n");
+		ksft_test_result_pass("get_sve(%s FPSIMD)\n", type->name);
 	}
 
 	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "Set FPSIMD registers\n");
+			 "Set FPSIMD registers via %s\n", type->name);
 	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
 		goto out;
 
@@ -243,9 +275,9 @@ static void ptrace_sve_fpsimd(pid_t child)
 			p[j] = j;
 	}
 
-	if (set_sve(child, sve)) {
-		ksft_test_result_fail("set_sve(FPSIMD): %s\n",
-				      strerror(errno));
+	if (set_sve(child, type, sve)) {
+		ksft_test_result_fail("set_sve(%s FPSIMD): %s\n",
+				      type->name, strerror(errno));
 
 		goto out;
 	}
@@ -257,16 +289,20 @@ static void ptrace_sve_fpsimd(pid_t child)
 		goto out;
 	}
 	if (memcmp(fpsimd, &new_fpsimd, sizeof(*fpsimd)) == 0)
-		ksft_test_result_pass("get_fpsimd() gave same state\n");
+		ksft_test_result_pass("%s get_fpsimd() gave same state\n",
+				      type->name);
 	else
-		ksft_test_result_fail("get_fpsimd() gave different state\n");
+		ksft_test_result_fail("%s get_fpsimd() gave different state\n",
+				      type->name);
 
 out:
 	free(svebuf);
 }
 
 /* Validate attempting to set SVE data and read SVE data */
-static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
+static void ptrace_set_sve_get_sve_data(pid_t child,
+					const struct vec_type *type,
+					unsigned int vl)
 {
 	void *write_buf;
 	void *read_buf = NULL;
@@ -281,8 +317,8 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 	write_buf = malloc(data_size);
 	if (!write_buf) {
-		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
-				      data_size, vl);
+		ksft_test_result_fail("Error allocating %d byte buffer for %s VL %u\n",
+				      data_size, type->name, vl);
 		return;
 	}
 	write_sve = write_buf;
@@ -306,23 +342,26 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 
 	/* TODO: Generate a valid FFR pattern */
 
-	ret = set_sve(child, write_sve);
+	ret = set_sve(child, type, write_sve);
 	if (ret != 0) {
-		ksft_test_result_fail("Failed to set VL %u data\n", vl);
+		ksft_test_result_fail("Failed to set %s VL %u data\n",
+				      type->name, vl);
 		goto out;
 	}
 
 	/* Read the data back */
-	if (!get_sve(child, (void **)&read_buf, &read_sve_size)) {
-		ksft_test_result_fail("Failed to read VL %u data\n", vl);
+	if (!get_sve(child, type, (void **)&read_buf, &read_sve_size)) {
+		ksft_test_result_fail("Failed to read %s VL %u data\n",
+				      type->name, vl);
 		goto out;
 	}
 	read_sve = read_buf;
 
 	/* We might read more data if there's extensions we don't know */
 	if (read_sve->size < write_sve->size) {
-		ksft_test_result_fail("Wrote %d bytes, only read %d\n",
-				      write_sve->size, read_sve->size);
+		ksft_test_result_fail("%s wrote %d bytes, only read %d\n",
+				      type->name, write_sve->size,
+				      read_sve->size);
 		goto out_read;
 	}
 
@@ -349,7 +388,8 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
 		  read_buf + SVE_PT_SVE_FPCR_OFFSET(vq), &errors);
 
-	ksft_test_result(errors == 0, "Set and get SVE data for VL %u\n", vl);
+	ksft_test_result(errors == 0, "Set and get %s data for VL %u\n",
+			 type->name, vl);
 
 out_read:
 	free(read_buf);
@@ -358,7 +398,9 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 }
 
 /* Validate attempting to set SVE data and read SVE data */
-static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
+static void ptrace_set_sve_get_fpsimd_data(pid_t child,
+					   const struct vec_type *type,
+					   unsigned int vl)
 {
 	void *write_buf;
 	struct user_sve_header *write_sve;
@@ -376,8 +418,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
 	write_buf = malloc(data_size);
 	if (!write_buf) {
-		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
-				      data_size, vl);
+		ksft_test_result_fail("Error allocating %d byte buffer for %s VL %u\n",
+				      data_size, type->name, vl);
 		return;
 	}
 	write_sve = write_buf;
@@ -395,16 +437,17 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 	fill_buf(write_buf + SVE_PT_SVE_FPSR_OFFSET(vq), SVE_PT_SVE_FPSR_SIZE);
 	fill_buf(write_buf + SVE_PT_SVE_FPCR_OFFSET(vq), SVE_PT_SVE_FPCR_SIZE);
 
-	ret = set_sve(child, write_sve);
+	ret = set_sve(child, type, write_sve);
 	if (ret != 0) {
-		ksft_test_result_fail("Failed to set VL %u data\n", vl);
+		ksft_test_result_fail("Failed to set %s VL %u data\n",
+				      type->name, vl);
 		goto out;
 	}
 
 	/* Read the data back */
 	if (get_fpsimd(child, &fpsimd_state)) {
-		ksft_test_result_fail("Failed to read VL %u FPSIMD data\n",
-				      vl);
+		ksft_test_result_fail("Failed to read %s VL %u FPSIMD data\n",
+				      type->name, vl);
 		goto out;
 	}
 
@@ -419,7 +462,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 		       sizeof(tmp));
 
 		if (tmp != fpsimd_state.vregs[i]) {
-			printf("# Mismatch in FPSIMD for VL %u Z%d\n", vl, i);
+			printf("# Mismatch in FPSIMD for %s VL %u Z%d\n",
+			       type->name, vl, i);
 			errors++;
 		}
 	}
@@ -429,8 +473,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
 		  &fpsimd_state.fpcr, &errors);
 
-	ksft_test_result(errors == 0, "Set and get FPSIMD data for VL %u\n",
-			 vl);
+	ksft_test_result(errors == 0, "Set and get FPSIMD data for %s VL %u\n",
+			 type->name, vl);
 
 out:
 	free(write_buf);
@@ -440,7 +484,7 @@ static int do_parent(pid_t child)
 {
 	int ret = EXIT_FAILURE;
 	pid_t pid;
-	int status;
+	int status, i;
 	siginfo_t si;
 	unsigned int vq, vl;
 	bool vl_supported;
@@ -499,26 +543,47 @@ static int do_parent(pid_t child)
 		}
 	}
 
-	/* FPSIMD via SVE regset */
-	ptrace_sve_fpsimd(child);
-
-	/* prctl() flags */
-	ptrace_set_get_inherit(child);
-
-	/* Step through every possible VQ */
-	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
-		vl = sve_vl_from_vq(vq);
+	for (i = 0; i < ARRAY_SIZE(vec_types); i++) {
+		/* FPSIMD via SVE regset */
+		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
+			ptrace_sve_fpsimd(child, &vec_types[i]);
+		} else {
+			ksft_test_result_skip("%s FPSIMD get via SVE\n",
+					      vec_types[i].name);
+			ksft_test_result_skip("%s FPSIMD set via SVE\n",
+					      vec_types[i].name);
+			ksft_test_result_skip("%s set read via FPSIMD\n",
+					      vec_types[i].name);
+		}
 
-		/* First, try to set this vector length */
-		ptrace_set_get_vl(child, vl, &vl_supported);
+		/* prctl() flags */
+		ptrace_set_get_inherit(child, &vec_types[i]);
+
+		/* Step through every possible VQ */
+		for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+			vl = sve_vl_from_vq(vq);
+
+			/* First, try to set this vector length */
+			if (getauxval(vec_types[i].hwcap_type) &
+			    vec_types[i].hwcap) {
+				ptrace_set_get_vl(child, &vec_types[i], vl,
+						  &vl_supported);
+			} else {
+				ksft_test_result_skip("%s get/set VL %d\n",
+						      vec_types[i].name, vl);
+				vl_supported = false;
+			}
 
-		/* If the VL is supported validate data set/get */
-		if (vl_supported) {
-			ptrace_set_sve_get_sve_data(child, vl);
-			ptrace_set_sve_get_fpsimd_data(child, vl);
-		} else {
-			ksft_test_result_skip("set SVE get SVE for VL %d\n", vl);
-			ksft_test_result_skip("set SVE get FPSIMD for VL %d\n", vl);
+			/* If the VL is supported validate data set/get */
+			if (vl_supported) {
+				ptrace_set_sve_get_sve_data(child, &vec_types[i], vl);
+				ptrace_set_sve_get_fpsimd_data(child, &vec_types[i], vl);
+			} else {
+				ksft_test_result_skip("%s set SVE get SVE for VL %d\n",
+						      vec_types[i].name, vl);
+				ksft_test_result_skip("%s set SVE get FPSIMD for VL %d\n",
+						      vec_types[i].name, vl);
+			}
 		}
 	}
 
-- 
2.30.2

