Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D1436A36
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJUSMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJUSMG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:12:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AB9161B00;
        Thu, 21 Oct 2021 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839789;
        bh=ZO2Nlxhc8pcrLTNv8YBuKfBn0744AE3LcV31TeMER6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u4NOb7MVICr9P0PVYeIXu0bP5mDXRmUrBLqyNBFD3KoRyczjJAu94XUjAnvzQ0O4m
         v2zzKMfVXc3ozjkQsvc9vBJmvFORz0hUxtdqf4LWTkbDCB87NKt+JPhj6GmEuCslfQ
         YfurmYYXEOFJCEVYwwidEK5QkNl5vvaQn3+ZjTjAeC8gNlszSoIDMbAMjJnx23WmBh
         dHe4PCzAXmYKmSxUmqigNMaZTqHG69QCPJVRWrLHsuPXkbnumrEDNEBoW9FwnU9fIM
         DEAjR3XWRsyPK9d3z+G1fHstKJKe3jhzcKeTW1gaMe97KDbRRm5n4XGMwVai+SLkDD
         QVPNm/NmWA43w==
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
Subject: [PATCH v4 33/33] kselftest/arm64: Add coverage for the ZA ptrace interface
Date:   Thu, 21 Oct 2021 19:07:22 +0100
Message-Id: <20211021180722.3699248-34-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10074; h=from:subject; bh=ZO2Nlxhc8pcrLTNv8YBuKfBn0744AE3LcV31TeMER6g=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxYvX3bITXncNU9wi3pjkJIG7yLQbwBNxzqWOVy 0XPd4HGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsWAAKCRAk1otyXVSH0NcGB/ 9prM5EgjiKSSDPrtDWOq0pDpM0Rx+VuGdPVjD90rg1eoqvEFjiSsLB5tsjoEGjHLWGWDMJUX5SpVu7 jf3lO5SP8dwTJykBAMUB4llZhjEkkDqqnI3lzxcNZ7ekAvlFHzojNBdVhfTVwFXnnHCd/+z6gUPB4Q z1dD6m0TnANHN9JuOGA5W6aGFo97pP+oG5CM9KBu85jj3abUE5B96VXVbIRrErSSmZq5/9e9dOUgm1 z1c2QY8SeSZQV7v0t1lmCaGV4gayWSIk1B2mUm88ZtxPS7tcWQlSkZmfEaPiXEE8jaeZYblEcokXlg 1RzQGLF1zjQki1Hzj47LBbZr0z5x5K
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic coverage for the ZA ptrace interface, including walking
through all the vector lengths supported in the system. As with SVE we do
not currently validate the data all the way through to the running process.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore  |   1 +
 tools/testing/selftests/arm64/fp/Makefile    |   3 +-
 tools/testing/selftests/arm64/fp/za-ptrace.c | 353 +++++++++++++++++++
 3 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/za-ptrace.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 1178fecc7aa1..59afc01f2019 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -7,4 +7,5 @@ sve-test
 ssve-test
 vec-syscfg
 vlset
+za-ptrace
 za-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index d77e9903116b..d7fb200d0794 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../../usr/include/
-TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
+TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg za-ptrace
 TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
@@ -25,5 +25,6 @@ vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
 za-test: za-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
+za-ptrace: za-ptrace.o
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/za-ptrace.c b/tools/testing/selftests/arm64/fp/za-ptrace.c
new file mode 100644
index 000000000000..6c172a5629dc
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/za-ptrace.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 ARM Limited.
+ */
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <asm/sigcontext.h>
+#include <asm/ptrace.h>
+
+#include "../../kselftest.h"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+
+/* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
+#ifndef NT_ARM_ZA
+#define NT_ARM_ZA 0x40c
+#endif
+
+#define EXPECTED_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
+
+static void fill_buf(char *buf, size_t size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		buf[i] = random();
+}
+
+static int do_child(void)
+{
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+
+	if (raise(SIGSTOP))
+		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+
+	return EXIT_SUCCESS;
+}
+
+static struct user_za_header *get_za(pid_t pid, void **buf, size_t *size)
+{
+	struct user_za_header *za;
+	void *p;
+	size_t sz = sizeof(*za);
+	struct iovec iov;
+
+	while (1) {
+		if (*size < sz) {
+			p = realloc(*buf, sz);
+			if (!p) {
+				errno = ENOMEM;
+				goto error;
+			}
+
+			*buf = p;
+			*size = sz;
+		}
+
+		iov.iov_base = *buf;
+		iov.iov_len = sz;
+		if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_ZA, &iov))
+			goto error;
+
+		za = *buf;
+		if (za->size <= sz)
+			break;
+
+		sz = za->size;
+	}
+
+	return za;
+
+error:
+	return NULL;
+}
+
+static int set_za(pid_t pid, const struct user_za_header *za)
+{
+	struct iovec iov;
+
+	iov.iov_base = (void *)za;
+	iov.iov_len = za->size;
+	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_ZA, &iov);
+}
+
+/* Validate attempting to set the specfied VL via ptrace */
+static void ptrace_set_get_vl(pid_t child, unsigned int vl, bool *supported)
+{
+	struct user_za_header za;
+	struct user_za_header *new_za = NULL;
+	size_t new_za_size = 0;
+	int ret, prctl_vl;
+
+	*supported = false;
+
+	/* Check if the VL is supported in this process */
+	prctl_vl = prctl(PR_SME_SET_VL, vl);
+	if (prctl_vl == -1)
+		ksft_exit_fail_msg("prctl(PR_SME_SET_VL) failed: %s (%d)\n",
+				   strerror(errno), errno);
+
+	/* If the VL is not supported then a supported VL will be returned */
+	*supported = (prctl_vl == vl);
+
+	/* Set the VL by doing a set with no register payload */
+	memset(&za, 0, sizeof(za));
+	za.size = sizeof(za);
+	za.vl = vl;
+	ret = set_za(child, &za);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u\n", vl);
+		return;
+	}
+
+	/*
+	 * Read back the new register state and verify that we have the
+	 * same VL that we got from prctl() on ourselves.
+	 */
+	if (!get_za(child, (void **)&new_za, &new_za_size)) {
+		ksft_test_result_fail("Failed to read VL %u\n", vl);
+		return;
+	}
+
+	ksft_test_result(new_za->vl = prctl_vl, "Set VL %u\n", vl);
+
+	free(new_za);
+}
+
+/* Validate attempting to set no ZA data and read it back */
+static void ptrace_set_no_data(pid_t child, unsigned int vl)
+{
+	void *read_buf = NULL;
+	struct user_za_header write_za;
+	struct user_za_header *read_za;
+	size_t read_za_size = 0;
+	int ret;
+
+	/* Set up some data and write it out */
+	memset(&write_za, 0, sizeof(write_za));
+	write_za.size = ZA_PT_ZA_OFFSET;
+	write_za.vl = vl;
+
+	ret = set_za(child, &write_za);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u no data\n", vl);
+		return;
+	}
+
+	/* Read the data back */
+	if (!get_za(child, (void **)&read_buf, &read_za_size)) {
+		ksft_test_result_fail("Failed to read VL %u no data\n", vl);
+		return;
+	}
+	read_za = read_buf;
+
+	/* We might read more data if there's extensions we don't know */
+	if (read_za->size < write_za.size) {
+		ksft_test_result_fail("VL %u wrote %d bytes, only read %d\n",
+				      vl, write_za.size, read_za->size);
+		goto out_read;
+	}
+
+	ksft_test_result(read_za->size == write_za.size,
+			 "Disabled ZA for VL %u\n", vl);
+
+out_read:
+	free(read_buf);
+}
+
+/* Validate attempting to set data and read it back */
+static void ptrace_set_get_data(pid_t child, unsigned int vl)
+{
+	void *write_buf;
+	void *read_buf = NULL;
+	struct user_za_header *write_za;
+	struct user_za_header *read_za;
+	size_t read_za_size = 0;
+	unsigned int vq = sve_vq_from_vl(vl);
+	int ret;
+	size_t data_size;
+
+	data_size = ZA_PT_SIZE(vq);
+	write_buf = malloc(data_size);
+	if (!write_buf) {
+		ksft_test_result_fail("Error allocating %d byte buffer for VL %u\n",
+				      data_size, vl);
+		return;
+	}
+	write_za = write_buf;
+
+	/* Set up some data and write it out */
+	memset(write_za, 0, data_size);
+	write_za->size = data_size;
+	write_za->vl = vl;
+
+	fill_buf(write_buf + ZA_PT_ZA_OFFSET, ZA_PT_ZA_SIZE(vq));
+
+	ret = set_za(child, write_za);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set VL %u data\n", vl);
+		goto out;
+	}
+
+	/* Read the data back */
+	if (!get_za(child, (void **)&read_buf, &read_za_size)) {
+		ksft_test_result_fail("Failed to read VL %u data\n", vl);
+		goto out;
+	}
+	read_za = read_buf;
+
+	/* We might read more data if there's extensions we don't know */
+	if (read_za->size < write_za->size) {
+		ksft_test_result_fail("VL %u wrote %d bytes, only read %d\n",
+				      vl, write_za->size, read_za->size);
+		goto out_read;
+	}
+
+	ksft_test_result(memcmp(write_buf + ZA_PT_ZA_OFFSET,
+				read_buf + ZA_PT_ZA_OFFSET,
+				ZA_PT_ZA_SIZE(vq)) == 0,
+			 "Data match for VL %u\n", vl);
+
+out_read:
+	free(read_buf);
+out:
+	free(write_buf);
+}
+
+static int do_parent(pid_t child)
+{
+	int ret = EXIT_FAILURE;
+	pid_t pid;
+	int status;
+	siginfo_t si;
+	unsigned int vq, vl;
+	bool vl_supported;
+
+	/* Attach to the child */
+	while (1) {
+		int sig;
+
+		pid = wait(&status);
+		if (pid == -1) {
+			perror("wait");
+			goto error;
+		}
+
+		/*
+		 * This should never happen but it's hard to flag in
+		 * the framework.
+		 */
+		if (pid != child)
+			continue;
+
+		if (WIFEXITED(status) || WIFSIGNALED(status))
+			ksft_exit_fail_msg("Child died unexpectedly\n");
+
+		if (!WIFSTOPPED(status))
+			goto error;
+
+		sig = WSTOPSIG(status);
+
+		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
+			if (errno == ESRCH)
+				goto disappeared;
+
+			if (errno == EINVAL) {
+				sig = 0; /* bust group-stop */
+				goto cont;
+			}
+
+			ksft_test_result_fail("PTRACE_GETSIGINFO: %s\n",
+					      strerror(errno));
+			goto error;
+		}
+
+		if (sig == SIGSTOP && si.si_code == SI_TKILL &&
+		    si.si_pid == pid)
+			break;
+
+	cont:
+		if (ptrace(PTRACE_CONT, pid, NULL, sig)) {
+			if (errno == ESRCH)
+				goto disappeared;
+
+			ksft_test_result_fail("PTRACE_CONT: %s\n",
+					      strerror(errno));
+			goto error;
+		}
+	}
+
+	/* Step through every possible VQ */
+	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+		vl = sve_vl_from_vq(vq);
+
+		/* First, try to set this vector length */
+		ptrace_set_get_vl(child, vl, &vl_supported);
+
+		/* If the VL is supported validate data set/get */
+		if (vl_supported) {
+			ptrace_set_no_data(child, vl);
+			ptrace_set_get_data(child, vl);
+		} else {
+			ksft_test_result_skip("Disabled ZA for VL %u\n", vl);
+			ksft_test_result_skip("Get and set data for VL %u\n",
+					      vl);
+		}
+	}
+
+	ret = EXIT_SUCCESS;
+
+error:
+	kill(child, SIGKILL);
+
+disappeared:
+	return ret;
+}
+
+int main(void)
+{
+	int ret = EXIT_SUCCESS;
+	pid_t child;
+
+	srandom(getpid());
+
+	ksft_print_header();
+	ksft_set_plan(EXPECTED_TESTS);
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME))
+		ksft_exit_skip("SME not available\n");
+
+	child = fork();
+	if (!child)
+		return do_child();
+
+	if (do_parent(child))
+		ret = EXIT_FAILURE;
+
+	ksft_print_cnts();
+
+	return ret;
+}
-- 
2.30.2

