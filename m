Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF741E0C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353333AbhI3SRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA2661A03;
        Thu, 30 Sep 2021 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025768;
        bh=z4BkFsnZQAiK4yXnYuJ0qRAF0/SGLRB90x5afGMHX7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLSuPDaRKnNGMnuAgc1B3s9bA/b3+Xsv+MGQ8/iQ178tuWRC4UvLwg2ifuICim6j5
         OJO7bn4HIWWayIEnQGglI2+vcnY7x9w+qB7KxNNubxHHgeu0xBOWQwWFYv2OwkMQZK
         YSwJUYn9BYPqGYolxGElFPQHVbsEMvy6vSdUGsVYt+y38jDjxTGz/rKNtGFPU0oX++
         cG0ReLJsumFS7D/+05HCHyPH7PnxdZH/C/ZelTlJ5bZouH/86CDFcmnlE/7070OcNi
         0iX3WLOAuo4bx+IjMISpYzCG8RyPu9yIygojHX1noLZQbgUy+xBeHuRnUD6wg9qzvp
         bKx5QSG9wmOQA==
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
Subject: [PATCH v1 11/38] selftests: arm64: Parameterise ptrace vector length information
Date:   Thu, 30 Sep 2021 19:11:17 +0100
Message-Id: <20210930181144.10029-12-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14254; h=from:subject; bh=z4BkFsnZQAiK4yXnYuJ0qRAF0/SGLRB90x5afGMHX7w=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3KmWkp/bZ4GzcCnR0KbjFPtzAmBg5rb3nedQ0b nAqg1+2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX9ygAKCRAk1otyXVSH0CsCB/ 0WCcdl7Tih1kSFgGFQ34FxBX48MepBUZIPAjN7t+An4OElIv8haDHdN782Dzh46NfYOCnMqu2/8Ka6 Klbdt+cEyq+1c1QsdEqyPhMF1L/dVEnG3LUxBWEIKfcHsnwAFGYqEJvxRDbIK3tVdvTIFoX/FBk0wU nLNt1j7LsG1+928y4VAEuMqsuIj3QBbMKfocyPLe6gD3yg7nsHIlcZ3EuvAEQJg7PfYdEN60PjVg2M Aqza3D8tMuZq+4Lm++3+VVdQ7p+rtGmBUBnYmCwKmOmu/DFJk/H2uIDyKom931PKF8dhKPNDk6JEH+ 0KK2VxPSxSCMH9CleUxsDriype9oJT
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
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 192 ++++++++++++------
 1 file changed, 129 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index ac0629f05365..e200f7ed9572 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -21,16 +21,36 @@
 
 #include "../../kselftest.h"
 
-#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
-#define FPSIMD_TESTS 3
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
+#define FPSIMD_TESTS 3
+
+#define EXPECTED_TESTS ((VL_TESTS + FPSIMD_TESTS) * ARRAY_SIZE(vec_types))
+
 static void fill_buf(char *buf, size_t size)
 {
 	int i;
@@ -59,7 +79,8 @@ static int get_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
 	return ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
 }
 
-static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
+static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
+				       void **buf, size_t *size)
 {
 	struct user_sve_header *sve;
 	void *p;
@@ -80,7 +101,7 @@ static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
 
 		iov.iov_base = *buf;
 		iov.iov_len = sz;
-		if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_SVE, &iov))
+		if (ptrace(PTRACE_GETREGSET, pid, type->regset, &iov))
 			goto error;
 
 		sve = *buf;
@@ -96,17 +117,19 @@ static struct user_sve_header *get_sve(pid_t pid, void **buf, size_t *size)
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
 
 /* Validate attempting to set the specfied VL via ptrace */
-static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
+static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
+			      unsigned int vl, bool *supported)
 {
 	struct user_sve_header sve;
 	struct user_sve_header *new_sve = NULL;
@@ -116,10 +139,10 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
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
@@ -128,9 +151,10 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
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
 
@@ -138,12 +162,14 @@ static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
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
@@ -159,7 +185,7 @@ static void check_u32(unsigned int vl, const char *reg,
 }
 
 /* Access the FPSIMD registers via the SVE regset */
-static void ptrace_sve_fpsimd(pid_t child)
+static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 {
 	void *svebuf = NULL;
 	size_t svebufsz = 0;
@@ -169,17 +195,18 @@ static void ptrace_sve_fpsimd(pid_t child)
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
 
@@ -193,9 +220,9 @@ static void ptrace_sve_fpsimd(pid_t child)
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
@@ -207,16 +234,20 @@ static void ptrace_sve_fpsimd(pid_t child)
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
@@ -231,8 +262,8 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
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
@@ -256,23 +287,26 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 
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
 
@@ -299,7 +333,8 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
 		  read_buf + SVE_PT_SVE_FPCR_OFFSET(vq), &errors);
 
-	ksft_test_result(errors == 0, "Set and get SVE data for VL %u\n", vl);
+	ksft_test_result(errors == 0, "Set and get %s data for VL %u\n",
+			 type->name, vl);
 
 out_read:
 	free(read_buf);
@@ -308,7 +343,9 @@ static void ptrace_set_sve_get_sve_data(pid_t child, unsigned int vl)
 }
 
 /* Validate attempting to set SVE data and read SVE data */
-static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
+static void ptrace_set_sve_get_fpsimd_data(pid_t child,
+					   const struct vec_type *type,
+					   unsigned int vl)
 {
 	void *write_buf;
 	struct user_sve_header *write_sve;
@@ -326,8 +363,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
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
@@ -345,16 +382,17 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
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
 
@@ -369,7 +407,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 		       sizeof(tmp));
 
 		if (tmp != fpsimd_state.vregs[i]) {
-			printf("# Mismatch in FPSIMD for VL %u Z%d\n", vl, i);
+			printf("# Mismatch in FPSIMD for %s VL %u Z%d\n",
+			       type->name, vl, i);
 			errors++;
 		}
 	}
@@ -379,8 +418,8 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child, unsigned int vl)
 	check_u32(vl, "FPCR", write_buf + SVE_PT_SVE_FPCR_OFFSET(vq),
 		  &fpsimd_state.fpcr, &errors);
 
-	ksft_test_result(errors == 0, "Set and get FPSIMD data for VL %u\n",
-			 vl);
+	ksft_test_result(errors == 0, "Set and get FPSIMD data for %s VL %u\n",
+			 type->name, vl);
 
 out:
 	free(write_buf);
@@ -390,7 +429,7 @@ static int do_parent(pid_t child)
 {
 	int ret = EXIT_FAILURE;
 	pid_t pid;
-	int status;
+	int status, i;
 	siginfo_t si;
 	unsigned int vq, vl;
 	bool vl_supported;
@@ -449,23 +488,50 @@ static int do_parent(pid_t child)
 		}
 	}
 
-	/* FPSIMD via SVE regset */
-	ptrace_sve_fpsimd(child);
-
-	/* Step through every possible VQ */
-	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
-		vl = sve_vl_from_vq(vq);
+	/*
+	 * Do all the FPSIMD tests before starting SVE so we know we
+	 * don't have SVE specific register state.
+	 */
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
+	}
 
-		/* First, try to set this vector length */
-		ptrace_set_get_vl(child, vl, &vl_supported);
+	for (i = 0; i < ARRAY_SIZE(vec_types); i++) {
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
2.20.1

