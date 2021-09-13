Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AD0408D0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhIMNXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240291AbhIMNUz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC35061244;
        Mon, 13 Sep 2021 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539145;
        bh=AK5MU1Vtin6zPAr5TSyB+Mpt+EqnKSSIEA8U+75XCbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bqw7Wni5VRnrIcknq4q252Hr7TpA5iV8k6p/MDsCVykJ4evqYFlRMAtk4+uH5nJLj
         gZRYqYliXDcOoC0q8S94FV7IUVaXwfLKoNDbbZtQ4qhO9hCEYl2WiitD3iGJWSj75z
         FpEc0V6wwN4A/V7G07CJcsw3ECDCSRs/R5gA84icxxyvrH3uFYGpfHFkeSPKCha8QL
         PD0aaGaj53vqai1MnojBF9zC6UvAxPUSysSWRqDgdZ+NYR+hzv/w4O/2YoWS0bX2rp
         yu2Zr38aFoWysEXB/9SD4L7ZB813pPGKNXZ/HQTK1O5NPniUO+E6+v7XlwHhnhldI5
         z2L2H7OkvaFMg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 7/8] selftests: arm64: More comprehensively test the SVE ptrace interface
Date:   Mon, 13 Sep 2021 13:55:04 +0100
Message-Id: <20210913125505.52619-8-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13348; h=from:subject; bh=AK5MU1Vtin6zPAr5TSyB+Mpt+EqnKSSIEA8U+75XCbU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0onARW8FifMGIpjmcNioeHVa31VR4GF2WFGRGY4 OSbfIvCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KJwAKCRAk1otyXVSH0JXEB/ wKGkvW2tsfCuCQ1M551LqB985W32RX++UtCsP1KS5VrCjIUJtWmM9oLKFF2rfdpjFV1AlcnlgEp1xw UDoR4jfU6YCDK7vDdfC8HXnxhn6Cc4SNZvbGYZ/rYVvuVYdb4JAXTvxXNRM/mNdDyl+cjl2HAPwJ/s lKbnU4biMpZ1gmkMmi3o4EVjJ6rJyp1n/O7rG6TY0bhXrP/HP0k48G0UCXcE3XomeOtM4PB1KILatr h5V9ZuHrFUGiVG/Zda62LcSO54NfMzELO0PRGIFG+rsEbnsYykrYMD8HzyCjynbM4tHRE+PJgqMTPU 6unu4theEPUBKuWJYYVriHO9wrDOpS
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the selftest for the SVE register set is not quite as thorough
as is desirable - it only validates that the value of a single Z register
is not modified by a partial write to a lower numbered Z register after
having previously been set through the FPSIMD regset.

Make this more thorough:
 - Test the ability to set vector lengths and enumerate those supported in
   the system.
 - Validate data in all Z and P registers, plus FPSR and FPCR.
 - Test reads via the FPSIMD regset after set via the SVE regset.

There's still some oversights, the main one being that due to the need to
generate a pattern in FFR and the fact that this rewrite is primarily
motivated by SME's streaming SVE which doesn't have FFR we don't currently
test FFR. Update the TODO to reflect those that occurred to me (and fix an
adjacent typo in there).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/TODO         |   9 +-
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 327 +++++++++++++-----
 2 files changed, 254 insertions(+), 82 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/TODO b/tools/testing/selftests/arm64/fp/TODO
index b6b7ebfcf362..44004e53da33 100644
--- a/tools/testing/selftests/arm64/fp/TODO
+++ b/tools/testing/selftests/arm64/fp/TODO
@@ -1,4 +1,7 @@
 - Test unsupported values in the ABIs.
-- More coverage for ptrace (eg, vector length conversions).
-- Coverage for signals.
-- Test PR_SVE_VL_INHERITY after a double fork.
+- More coverage for ptrace:
+ - Get/set of FFR.
+ - Ensure ptraced processes actually see the register state visible through
+   the ptrace interface.
+ - Big endian.
+- Test PR_SVE_VL_INHERIT after a double fork.
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 31a2c2fc529d..199710ba65c7 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -1,15 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2015-2020 ARM Limited.
+ * Copyright (C) 2015-2021 ARM Limited.
  * Original author: Dave Martin <Dave.Martin@arm.com>
  */
 #include <errno.h>
+#include <stdbool.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <sys/auxv.h>
+#include <sys/prctl.h>
 #include <sys/ptrace.h>
 #include <sys/types.h>
 #include <sys/uio.h>
@@ -19,20 +21,22 @@
 
 #include "../../kselftest.h"
 
-#define EXPECTED_TESTS 19
+#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
+#define FPSIMD_TESTS 3
+
+#define EXPECTED_TESTS (VL_TESTS + FPSIMD_TESTS)
 
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
 #endif
 
-static void dump(const void *buf, size_t size)
+static void fill_buf(char *buf, size_t size)
 {
-	size_t i;
-	const unsigned char *p = buf;
+	int i;
 
-	for (i = 0; i < size; ++i)
-		printf(" %.2x", *p++);
+	for (i = 0; i < size; i++)
+		buf[i] = random();
 }
 
 static int do_child(void)
@@ -101,25 +105,228 @@ static int set_sve(pid_t pid, const struct user_sve_header *sve)
 	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_SVE, &iov);
 }
 
-static void dump_sve_regs(const struct user_sve_header *sve, unsigned int num,
-			  unsigned int vlmax)
+/* Validate attempting to set the specfied VL via ptrace */
+static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
+{
+	struct user_sve_header sve;
+	struct user_sve_header *new_sve = NULL;
+	size_t new_sve_size = 0;
+	int ret, prctl_vl;
+
+	*supported = false;
+
+	/* Check if the VL is supported in this process */
+	prctl_vl = prctl(PR_SVE_SET_VL, vl);
+	if (prctl_vl == -1)
+		ksft_exit_fail_msg("prctl(PR_SVE_SET_VL) failed: %s (%d)\n",
+				   strerror(errno), errno);
+
+	/* If the VL is not supported then a supported VL will be returned */
+	*supported = (prctl_vl == vl);
+
+	/* Set the VL by doing a set with no register payload */
+	memset(&sve, 0, sizeof(sve));
+	sve.size = sizeof(sve);
+	sve.vl = vl;
+	ret = set_sve(child, &sve);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u\n", vl);
+		return;
+	}
+
+	/*
+	 * Read back the new register state and verify that we have the
+	 * same VL that we got from prctl() on ourselves.
+	 */
+	if (!get_sve(child, (void **)&new_sve, &new_sve_size)) {
+		ksft_test_result_fail("Failed to read VL %u\n", vl);
+		return;
+	}
+
+	ksft_test_result(new_sve->vl = prctl_vl, "Set VL %u\n", vl);
+
+	free(new_sve);
+}
+
+static void check_u32(unsigned int vl, const char *reg,
+		      uint32_t *in, uint32_t *out, int *errors)
+{
+	if (*in != *out) {
+		printf("# VL %d %s wrote %x read %x\n",
+		       vl, reg, *in, *out);
+		(*errors)++;
+	}
+}
+
+/* Validate attempting to set SVE data and read SVE data */
+static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
+{
+	void *write_buf;
+	void *read_buf = NULL;
+	struct user_sve_header *write_sve;
+	struct user_sve_header *read_sve;
+	size_t read_sve_size = 0;
+	unsigned int vq = sve_vq_from_vl(vl);
+	int ret, i;
+	size_t data_size;
+	int errors = 0;
+
+	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
+	write_buf = malloc(data_size);
+	if (!write_buf) {
+		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
+				      data_size, vl);
+		return;
+	}
+	write_sve = write_buf;
+
+	/* Set up some data and write it out */
+	memset(write_sve, 0, data_size);
+	write_sve->size = data_size;
+	write_sve->vl = vl;
+	write_sve->flags = SVE_PT_REGS_SVE;
+
+	for (i = 0; i < __SVE_NUM_ZREGS; i++)
+		fill_buf(write_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+			 SVE_PT_SVE_ZREG_SIZE(vq));
+
+	for (i = 0; i < __SVE_NUM_PREGS; i++)
+		fill_buf(write_buf + SVE_PT_SVE_PREG_OFFSET(vq, i),
+			 SVE_PT_SVE_PREG_SIZE(vq));
+
+	fill_buf(write_buf + SVE_PT_SVE_FPSR_OFFSET(vq), SVE_PT_SVE_FPSR_SIZE);
+	fill_buf(write_buf + SVE_PT_SVE_FPCR_OFFSET(vq), SVE_PT_SVE_FPCR_SIZE);
+
+	/* TODO: Generate a valid FFR pattern */
+
+	ret = set_sve(child, write_sve);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u data\n", vl);
+		goto out;
+	}
+
+	/* Read the data back */
+	if (!get_sve(child, (void **)&read_buf, &read_sve_size)) {
+		ksft_test_result_fail("Failed to read VL %u data\n", vl);
+		goto out;
+	}
+	read_sve = read_buf;
+
+	/* We might read more data if there's extensions we don't know */
+	if (read_sve->size < write_sve->size) {
+		ksft_test_result_fail("Wrote %d bytes, only read %d\n",
+				      write_sve->size, read_sve->size);
+		goto out_read;
+	}
+
+	for (i = 0; i < __SVE_NUM_ZREGS; i++) {
+		if (memcmp(write_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+			   read_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+			   SVE_PT_SVE_ZREG_SIZE(vq)) != 0) {
+			printf("# Mismatch in %u Z%d\n", vl, i);
+			errors++;
+		}
+	}
+
+	for (i = 0; i < __SVE_NUM_PREGS; i++) {
+		if (memcmp(write_buf + SVE_PT_SVE_PREG_OFFSET(vq, i),
+			   read_buf + SVE_PT_SVE_PREG_OFFSET(vq, i),
+			   SVE_PT_SVE_PREG_SIZE(vq)) != 0) {
+			printf("# Mismatch in %u P%d\n", vl, i);
+			errors++;
+		}
+	}
+
+	check_u32(vl, "FPSR", write_buf + SVE_PT_SVE_FPSR_OFFSET(vq),
+		  read_buf + SVE_PT_SVE_FPSR_OFFSET(vq), &errors);
+	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
+		  read_buf + SVE_PT_SVE_FPCR_OFFSET(vq), &errors);
+
+	ksft_test_result(errors == 0, "Set and get SVE data for VL %u\n", vl);
+
+out_read:
+	free(read_buf);
+out:
+	free(write_buf);
+}
+
+/* Validate attempting to set SVE data and read SVE data */
+static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 {
-	unsigned int vq;
-	unsigned int i;
+	void *write_buf;
+	struct user_sve_header *write_sve;
+	unsigned int vq = sve_vq_from_vl(vl);
+	struct user_fpsimd_state fpsimd_state;
+	int ret, i;
+	size_t data_size;
+	int errors = 0;
+
+	if (__BYTE_ORDER == __BIG_ENDIAN) {
+		ksft_test_result_skip("Big endian not supported\n");
+		return;
+	}
+
+	data_size = SVE_PT_SVE_OFFSET + SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
+	write_buf = malloc(data_size);
+	if (!write_buf) {
+		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
+				      data_size, vl);
+		return;
+	}
+	write_sve = write_buf;
 
-	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_SVE)
-		ksft_exit_fail_msg("Dumping non-SVE register\n");
+	/* Set up some data and write it out */
+	memset(write_sve, 0, data_size);
+	write_sve->size = data_size;
+	write_sve->vl = vl;
+	write_sve->flags = SVE_PT_REGS_SVE;
 
-	if (vlmax > sve->vl)
-		vlmax = sve->vl;
+	for (i = 0; i < __SVE_NUM_ZREGS; i++)
+		fill_buf(write_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+			 SVE_PT_SVE_ZREG_SIZE(vq));
 
-	vq = sve_vq_from_vl(sve->vl);
-	for (i = 0; i < num; ++i) {
-		printf("# z%u:", i);
-		dump((const char *)sve + SVE_PT_SVE_ZREG_OFFSET(vq, i),
-		     vlmax);
-		printf("%s\n", vlmax == sve->vl ? "" : " ...");
+	fill_buf(write_buf + SVE_PT_SVE_FPSR_OFFSET(vq), SVE_PT_SVE_FPSR_SIZE);
+	fill_buf(write_buf + SVE_PT_SVE_FPCR_OFFSET(vq), SVE_PT_SVE_FPCR_SIZE);
+
+	ret = set_sve(child, write_sve);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u data\n", vl);
+		goto out;
+	}
+
+	/* Read the data back */
+	if (get_fpsimd(child, &fpsimd_state)) {
+		ksft_test_result_fail("Failed to read VL %u FPSIMD data\n",
+				      vl);
+		goto out;
+	}
+
+	for (i = 0; i < __SVE_NUM_ZREGS; i++) {
+		__uint128_t tmp = 0;
+
+		/*
+		 * Z regs are stored endianness invariant, this won't
+		 * work for big endian
+		 */
+		memcpy(&tmp, write_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+		       sizeof(tmp));
+
+		if (tmp != fpsimd_state.vregs[i]) {
+			printf("# Mismatch in FPSIMD for VL %u Z%d\n", vl, i);
+			errors++;
+		}
 	}
+
+	check_u32(vl, "FPSR", write_buf + SVE_PT_SVE_FPSR_OFFSET(vq),
+		  &fpsimd_state.fpsr, &errors);
+	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
+		  &fpsimd_state.fpcr, &errors);
+
+	ksft_test_result(errors == 0, "Set and get FPSIMD data for VL %u\n",
+			 vl);
+
+out:
+	free(write_buf);
 }
 
 static int do_parent(pid_t child)
@@ -128,13 +335,14 @@ static int do_parent(pid_t child)
 	pid_t pid;
 	int status;
 	siginfo_t si;
-	void *svebuf = NULL, *newsvebuf;
-	size_t svebufsz = 0, newsvebufsz;
-	struct user_sve_header *sve, *new_sve;
+	void *svebuf = NULL;
+	size_t svebufsz = 0;
+	struct user_sve_header *sve;
 	struct user_fpsimd_state *fpsimd, new_fpsimd;
 	unsigned int i, j;
 	unsigned char *p;
-	unsigned int vq;
+	unsigned int vq, vl;
+	bool vl_supported;
 
 	/* Attach to the child */
 	while (1) {
@@ -246,62 +454,21 @@ static int do_parent(pid_t child)
 	else
 		ksft_test_result_fail("get_fpsimd() gave different state\n");
 
-	vq = sve_vq_from_vl(sve->vl);
-
-	newsvebufsz = SVE_PT_SVE_ZREG_OFFSET(vq, 1);
-	new_sve = newsvebuf = malloc(newsvebufsz);
-	if (!new_sve) {
-		errno = ENOMEM;
-		perror(NULL);
-		goto error;
-	}
-
-	*new_sve = *sve;
-	new_sve->flags &= ~SVE_PT_REGS_MASK;
-	new_sve->flags |= SVE_PT_REGS_SVE;
-	memset((char *)new_sve + SVE_PT_SVE_ZREG_OFFSET(vq, 0),
-	       0, SVE_PT_SVE_ZREG_SIZE(vq));
-	new_sve->size = SVE_PT_SVE_ZREG_OFFSET(vq, 1);
-	if (set_sve(pid, new_sve)) {
-		int e = errno;
-
-		ksft_test_result_fail("set_sve(ZREG): %s\n", strerror(errno));
-		if (e == ESRCH)
-			goto disappeared;
-
-		goto error;
-	}
-
-	/* Try to read back the value we just set */
-	new_sve = get_sve(pid, &newsvebuf, &newsvebufsz);
-	if (!new_sve) {
-		int e = errno;
-
-		ksft_test_result_fail("get_sve(ZREG): %s\n", strerror(errno));
-		if (e == ESRCH)
-			goto disappeared;
+	/* Step through every possible VQ */
+	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+		vl = sve_vl_from_vq(vq);
 
-		goto error;
-	}
-
-	ksft_test_result((new_sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_SVE,
-			 "Get SVE registers\n");
-	if ((new_sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_SVE)
-		goto error;
-
-	dump_sve_regs(new_sve, 3, sizeof fpsimd->vregs[0]);
+		/* First, try to set this vector length */
+		ptrace_set_get_vl(child, vl, &vl_supported);
 
-	/* Verify that the register we set has the value we expected */
-	p = (unsigned char *)new_sve + SVE_PT_SVE_ZREG_OFFSET(vq, 1);
-	for (i = 0; i < sizeof fpsimd->vregs[0]; ++i) {
-		unsigned char expected = i;
-
-		if (__BYTE_ORDER == __BIG_ENDIAN)
-			expected = sizeof fpsimd->vregs[0] - 1 - expected;
-
-		ksft_test_result(p[i] == expected, "buf[%d] == expected\n", i);
-		if (p[i] != expected)
-			goto error;
+		/* If the VL is supported validate data set/get */
+		if (vl_supported) {
+			ptrace_set_sve_get_sve_data(child, vl);
+			ptrace_set_sve_get_fpsimd_data(child, vl);
+		} else {
+			ksft_test_result_skip("set SVE get SVE for VL %d\n", vl);
+			ksft_test_result_skip("set SVE get FPSIMD for VL %d\n", vl);
+		}
 	}
 
 	ret = EXIT_SUCCESS;
@@ -318,6 +485,8 @@ int main(void)
 	int ret = EXIT_SUCCESS;
 	pid_t child;
 
+	srandom(getpid());
+
 	ksft_print_header();
 	ksft_set_plan(EXPECTED_TESTS);
 
-- 
2.20.1

