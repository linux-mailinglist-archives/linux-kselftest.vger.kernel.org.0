Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABAE3DEFBC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Aug 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhHCOHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Aug 2021 10:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236506AbhHCOHU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB7CA60F58;
        Tue,  3 Aug 2021 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627999629;
        bh=vUki7JpvO0satyYvlCRxQEkFKABdY2bN8GBJV5TGxas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGCn+iP4izoTqSYy0zNcKOrLIL1qH+gRtHtYvusChEu723M1A9J4AC24daDZrF3wW
         7uesJID8X+60NhhA61YERFrQ0LxKll6B7WENGYU7BmyrwGGKHDOBY1G5U7239K3aGK
         PEBsiMKJ74NyidBhGIhLWbwGSUmn5Jkpuw8nStq390TxsW0/aIkeR9UJVBy9VJggOh
         9Tk6nbRxrKJRE9sBb7p1k20qdyH4Yz5bwRfxJNgojARpZdlJmMdJcMtydqYtV/0v3P
         07f8MSn9xjgwWS88nXeoVktdaFLX2sKboVg8dfbPCZUMKl/svM5KZO/Kt8mvfiVTRs
         Y8BPP0JETDkrg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 3/4] kselftest/arm64: Add tests for SVE vector configuration
Date:   Tue,  3 Aug 2021 15:04:49 +0100
Message-Id: <20210803140450.46624-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803140450.46624-1-broonie@kernel.org>
References: <20210803140450.46624-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17623; h=from:subject; bh=vUki7JpvO0satyYvlCRxQEkFKABdY2bN8GBJV5TGxas=; b=owGbwMvMwMWocq27KDak/QLjabUkhkROn/+MIftirv6bpxNayRRxz7R+PheL5bq/Xz+lat6N9ZVW Ew/tZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmsluC/X9C2K7e+qVG7XIVW0X2Kz xZNjHXW6V9Zknkz1y18JYNgqpx+pLsf8JiE/pyply05XnJevPJ77jS5TdWMBwRnZiZWrPW1fvx9sPK 3FW5jX8CXm+Yu+vOU3WhWOekayxOmnuUF3PE/wpmfbr38uVC3iOXHAqLazeEzE96VVEjqWZZ7lkamd d45Ndpr37vB1LfDbQ9pBZcVheYeyph5v6E6+kHuvsfi9foRqqnmt7/c/xyv2h6FaPXbBumpZsZZ+/f YHM76Midi0bFsjG+b7cr3PwWH/B4a6/OLKH4bYEBL1JbbadLq9SW3J86jUPCep71nkO968uYgpfx7p 33mc96XZV0Y2X6DgVn3VvbDD3jAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We provide interfaces for configuring the SVE vector length seen by
processes using prctl and also via /proc for configuring the default
values. Provide tests that exercise all these interfaces and verify that
they take effect as expected, though at present no test fully enumerates
all the possible vector lengths.

A subset of this is already tested via sve-probe-vls but the /proc
interfaces are not currently covered at all.

In preparation for the forthcoming support for SME, the Scalable Matrix
Extension, which has separately but similarly configured vector lengths
which we expect to offer similar userspace interfaces for, all the actual
files and prctls used are parameterised and we don't validate that the
architectural minimum vector length is the minimum we see.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/testing/selftests/arm64/fp/.gitignore   |   1 +
 tools/testing/selftests/arm64/fp/Makefile     |   3 +-
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 593 ++++++++++++++++++
 3 files changed, 596 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 6b53a7b60fee..b67395903b9b 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -3,4 +3,5 @@ rdvl-sve
 sve-probe-vls
 sve-ptrace
 sve-test
+vec-syscfg
 vlset
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index fa3a0167db2d..f2abdd6ba12e 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I../../../../../usr/include/
-TEST_GEN_PROGS := sve-ptrace sve-probe-vls
+TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
 	rdvl-sve \
 	sve-test sve-stress \
@@ -16,6 +16,7 @@ sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o
 	$(CC) -nostdlib $^ -o $@
+vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
new file mode 100644
index 000000000000..c02071dcb563
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -0,0 +1,593 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 ARM Limited.
+ * Original author: Mark Brown <broonie@kernel.org>
+ */
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <asm/sigcontext.h>
+#include <asm/hwcap.h>
+
+#include "../../kselftest.h"
+#include "rdvl.h"
+
+#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
+
+#define ARCH_MIN_VL SVE_VL_MIN
+
+struct vec_data {
+	const char *name;
+	unsigned long hwcap_type;
+	unsigned long hwcap;
+	const char *rdvl_binary;
+	int (*rdvl)(void);
+
+	int prctl_get;
+	int prctl_set;
+	const char *default_vl_file;
+
+	int default_vl;
+	int min_vl;
+	int max_vl;
+};
+
+
+static struct vec_data vec_data[] = {
+	{
+		.name = "SVE",
+		.hwcap_type = AT_HWCAP,
+		.hwcap = HWCAP_SVE,
+		.rdvl = rdvl_sve,
+		.rdvl_binary = "./rdvl-sve",
+		.prctl_get = PR_SVE_GET_VL,
+		.prctl_set = PR_SVE_SET_VL,
+		.default_vl_file = "/proc/sys/abi/sve_default_vector_length",
+	},
+};
+
+static int stdio_read_integer(FILE *f, const char *what, int *val)
+{
+	int n = 0;
+	int ret;
+
+	ret = fscanf(f, "%d%*1[\n]%n", val, &n);
+	if (ret < 1 || n < 1) {
+		ksft_print_msg("failed to parse integer from %s\n", what);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Start a new process and return the vector length it sees */
+static int get_child_rdvl(struct vec_data *data)
+{
+	FILE *out;
+	int pipefd[2];
+	pid_t pid, child;
+	int read_vl, ret;
+
+	ret = pipe(pipefd);
+	if (ret == -1) {
+		ksft_print_msg("pipe() failed: %d (%s)\n",
+			       errno, strerror(errno));
+		return -1;
+	}
+
+	fflush(stdout);
+
+	child = fork();
+	if (child == -1) {
+		ksft_print_msg("fork() failed: %d (%s)\n",
+			       errno, strerror(errno));
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return -1;
+	}
+
+	/* Child: put vector length on the pipe */
+	if (child == 0) {
+		/*
+		 * Replace stdout with the pipe, errors to stderr from
+		 * here as kselftest prints to stdout.
+		 */
+		ret = dup2(pipefd[1], 1);
+		if (ret == -1) {
+			fprintf(stderr, "dup2() %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
+		/* exec() a new binary which puts the VL on stdout */
+		ret = execl(data->rdvl_binary, data->rdvl_binary, NULL);
+		fprintf(stderr, "execl(%s) failed: %d\n",
+			data->rdvl_binary, errno, strerror(errno));
+
+		exit(EXIT_FAILURE);
+	}
+
+	close(pipefd[1]);
+
+	/* Parent; wait for the exit status from the child & verify it */
+	do {
+		pid = wait(&ret);
+		if (pid == -1) {
+			ksft_print_msg("wait() failed: %d (%s)\n",
+				       errno, strerror(errno));
+			close(pipefd[0]);
+			return -1;
+		}
+	} while (pid != child);
+
+	assert(pid == child);
+
+	if (!WIFEXITED(ret)) {
+		ksft_print_msg("child exited abnormally\n");
+		close(pipefd[0]);
+		return -1;
+	}
+
+	if (WEXITSTATUS(ret) != 0) {
+		ksft_print_msg("child returned error %d\n",
+			       WEXITSTATUS(ret));
+		close(pipefd[0]);
+		return -1;
+	}
+
+	out = fdopen(pipefd[0], "r");
+	if (!out) {
+		ksft_print_msg("failed to open child stdout\n");
+		close(pipefd[0]);
+		return -1;
+	}
+
+	ret = stdio_read_integer(out, "child", &read_vl);
+	fclose(out);
+	if (ret != 0)
+		return ret;
+
+	return read_vl;
+}
+
+static int file_read_integer(const char *name, int *val)
+{
+	FILE *f;
+	int ret;
+
+	f = fopen(name, "r");
+	if (!f) {
+		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
+				      name, errno,
+				      strerror(errno));
+		return -1;
+	}
+
+	ret = stdio_read_integer(f, name, val);
+	fclose(f);
+
+	return ret;
+}
+
+static int file_write_integer(const char *name, int val)
+{
+	FILE *f;
+	int ret;
+
+	f = fopen(name, "w");
+	if (!f) {
+		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
+				      name, errno,
+				      strerror(errno));
+		return -1;
+	}
+
+	fprintf(f, "%d", val);
+	fclose(f);
+	if (ret < 0) {
+		ksft_test_result_fail("Error writing %d to %s\n",
+				      val, name);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Verify that we can read the default VL via proc, checking that it
+ * is set in a freshly spawned child.
+ */
+static void proc_read_default(struct vec_data *data)
+{
+	int default_vl, child_vl, ret;
+
+	ret = file_read_integer(data->default_vl_file, &default_vl);
+	if (ret != 0)
+		return;
+
+	/* Is this the actual default seen by new processes? */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != default_vl) {
+		ksft_test_result_fail("%s is %d but child VL is %d\n",
+				      data->default_vl_file,
+				      default_vl, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s default vector length %d\n", data->name,
+			      default_vl);
+	data->default_vl = default_vl;
+}
+
+/* Verify that we can write a minimum value and have it take effect */
+static void proc_write_min(struct vec_data *data)
+{
+	int ret, new_default, child_vl;
+
+	if (geteuid() != 0) {
+		ksft_test_result_skip("Need to be root to write to /proc\n");
+		return;
+	}
+
+	ret = file_write_integer(data->default_vl_file, ARCH_MIN_VL);
+	if (ret != 0)
+		return;
+
+	/* What was the new value? */
+	ret = file_read_integer(data->default_vl_file, &new_default);
+	if (ret != 0)
+		return;
+
+	/* Did it take effect in a new process? */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != new_default) {
+		ksft_test_result_fail("%s is %d but child VL is %d\n",
+				      data->default_vl_file,
+				      new_default, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s minimum vector length %d\n", data->name,
+			      new_default);
+	data->min_vl = new_default;
+
+	file_write_integer(data->default_vl_file, data->default_vl);
+}
+
+/* Verify that we can write a maximum value and have it take effect */
+static void proc_write_max(struct vec_data *data)
+{
+	int ret, new_default, child_vl;
+
+	if (geteuid() != 0) {
+		ksft_test_result_skip("Need to be root to write to /proc\n");
+		return;
+	}
+
+	/* -1 is accepted by the /proc interface as the maximum VL */
+	ret = file_write_integer(data->default_vl_file, -1);
+	if (ret != 0)
+		return;
+
+	/* What was the new value? */
+	ret = file_read_integer(data->default_vl_file, &new_default);
+	if (ret != 0)
+		return;
+
+	/* Did it take effect in a new process? */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != new_default) {
+		ksft_test_result_fail("%s is %d but child VL is %d\n",
+				      data->default_vl_file,
+				      new_default, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s maximum vector length %d\n", data->name,
+			      new_default);
+	data->max_vl = new_default;
+
+	file_write_integer(data->default_vl_file, data->default_vl);
+}
+
+/* Can we read back a VL from prctl? */
+static void prctl_get(struct vec_data *data)
+{
+	int ret;
+
+	ret = prctl(data->prctl_get);
+	if (ret == -1) {
+		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
+				      data->name, errno, strerror(errno));
+		return;
+	}
+
+	/* Mask out any flags */
+	ret &= PR_SVE_VL_LEN_MASK;
+
+	/* Is that what we can read back directly? */
+	if (ret == data->rdvl())
+		ksft_test_result_pass("%s current VL is %d\n",
+				      data->name, ret);
+	else
+		ksft_test_result_fail("%s prctl() VL %d but RDVL is %d\n",
+				      data->name, ret, data->rdvl());
+}
+
+/* Does the prctl let us set the VL we already have? */
+static void prctl_set_same(struct vec_data *data)
+{
+	int cur_vl = data->rdvl();
+	int ret;
+
+	ret = prctl(data->prctl_set, cur_vl);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed: %d (%s)\n",
+				      data->name, errno, strerror(errno));
+		return;
+	}
+
+	if (cur_vl != data->rdvl())
+		ksft_test_result_pass("%s current VL is %d\n",
+				      data->name, ret);
+	else
+		ksft_test_result_fail("%s prctl() VL %d but RDVL is %d\n",
+				      data->name, ret, data->rdvl());
+}
+
+/* Can we set a new VL for this process? */
+static void prctl_set(struct vec_data *data)
+{
+	int ret;
+
+	if (data->min_vl == data->max_vl) {
+		ksft_test_result_skip("%s only one VL supported\n",
+				      data->name);
+		return;
+	}
+
+	/* Try to set the minimum VL */
+	ret = prctl(data->prctl_set, data->min_vl);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->min_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	if ((ret & PR_SVE_VL_LEN_MASK) != data->min_vl) {
+		ksft_test_result_fail("%s prctl set %d but return value is %d\n",
+				      data->name, data->min_vl, data->rdvl());
+		return;
+	}
+
+	if (data->rdvl() != data->min_vl) {
+		ksft_test_result_fail("%s set %d but RDVL is %d\n",
+				      data->name, data->min_vl, data->rdvl());
+		return;
+	}
+
+	/* Try to set the maximum VL */
+	ret = prctl(data->prctl_set, data->max_vl);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->max_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	if ((ret & PR_SVE_VL_LEN_MASK) != data->max_vl) {
+		ksft_test_result_fail("%s prctl() set %d but return value is %d\n",
+				      data->name, data->max_vl, data->rdvl());
+		return;
+	}
+
+	/* The _INHERIT flag should not be present when we read the VL */
+	ret = prctl(data->prctl_get);
+	if (ret == -1) {
+		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
+				      data->name, errno, strerror(errno));
+		return;
+	}
+
+	if (ret & PR_SVE_VL_INHERIT) {
+		ksft_test_result_fail("%s prctl() reports _INHERIT\n",
+				      data->name);
+		return;
+	}
+
+	ksft_test_result_pass("%s prctl() set min/max\n", data->name);
+}
+
+/* If we didn't request it a new VL shouldn't affect the child */
+static void prctl_set_no_child(struct vec_data *data)
+{
+	int ret, child_vl;
+
+	if (data->min_vl == data->max_vl) {
+		ksft_test_result_skip("%s only one VL supported\n",
+				      data->name);
+		return;
+	}
+
+	ret = prctl(data->prctl_set, data->min_vl);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->min_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	/* Ensure the default VL is different */
+	ret = file_write_integer(data->default_vl_file, data->max_vl);
+	if (ret != 0)
+		return;
+
+	/* Check that the child has the default we just set */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != data->max_vl) {
+		ksft_test_result_fail("%s is %d but child VL is %d\n",
+				      data->default_vl_file,
+				      data->max_vl, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s vector length used default\n", data->name);
+
+	file_write_integer(data->default_vl_file, data->default_vl);
+}
+
+/* If we didn't request it a new VL shouldn't affect the child */
+static void prctl_set_for_child(struct vec_data *data)
+{
+	int ret, child_vl;
+
+	if (data->min_vl == data->max_vl) {
+		ksft_test_result_skip("%s only one VL supported\n",
+				      data->name);
+		return;
+	}
+
+	ret = prctl(data->prctl_set, data->min_vl | PR_SVE_VL_INHERIT);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->min_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	/* The _INHERIT flag should be present when we read the VL */
+	ret = prctl(data->prctl_get);
+	if (ret == -1) {
+		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
+				      data->name, errno, strerror(errno));
+		return;
+	}
+	if (!(ret & PR_SVE_VL_INHERIT)) {
+		ksft_test_result_fail("%s prctl() does not report _INHERIT\n",
+				      data->name);
+		return;
+	}
+
+	/* Ensure the default VL is different */
+	ret = file_write_integer(data->default_vl_file, data->max_vl);
+	if (ret != 0)
+		return;
+
+	/* Check that the child inherited our VL */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != data->min_vl) {
+		ksft_test_result_fail("%s is %d but child VL is %d\n",
+				      data->default_vl_file,
+				      data->min_vl, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s vector length was inherited\n", data->name);
+
+	file_write_integer(data->default_vl_file, data->default_vl);
+}
+
+/* _ONEXEC takes effect only in the child process */
+static void prctl_set_onexec(struct vec_data *data)
+{
+	int ret, child_vl;
+
+	if (data->min_vl == data->max_vl) {
+		ksft_test_result_skip("%s only one VL supported\n",
+				      data->name);
+		return;
+	}
+
+	/* Set a known value for the default and our current VL */
+	ret = file_write_integer(data->default_vl_file, data->max_vl);
+	if (ret != 0)
+		return;
+
+	ret = prctl(data->prctl_set, data->max_vl);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->min_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	/* Set a different value for the child to have on exec */
+	ret = prctl(data->prctl_set, data->min_vl | PR_SVE_SET_VL_ONEXEC);
+	if (ret < 0) {
+		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
+				      data->name, data->min_vl,
+				      errno, strerror(errno));
+		return;
+	}
+
+	/* Our current VL should stay the same */
+	if (data->rdvl() != data->max_vl) {
+		ksft_test_result_fail("%s VL changed by _ONEXEC prctl()\n",
+				      data->name);
+		return;
+	}
+
+	/* Check that the child inherited our VL */
+	child_vl = get_child_rdvl(data);
+	if (child_vl != data->min_vl) {
+		ksft_test_result_fail("Set %d _ONEXEC but child VL is %d\n",
+				      data->min_vl, child_vl);
+		return;
+	}
+
+	ksft_test_result_pass("%s vector length set on exec\n", data->name);
+
+	file_write_integer(data->default_vl_file, data->default_vl);
+}
+
+typedef void (*test_type)(struct vec_data *);
+
+static const test_type tests[] = {
+	/*
+	 * The default/min/max tests must be first and in this order
+	 * to provide data for other tests.
+	 */
+	proc_read_default,
+	proc_write_min,
+	proc_write_max,
+
+	prctl_get,
+	prctl_set,
+	prctl_set_no_child,
+	prctl_set_for_child,
+	prctl_set_onexec,
+};
+
+int main(void)
+{
+	int i, j;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests) * ARRAY_SIZE(vec_data));
+
+	for (i = 0; i < ARRAY_SIZE(vec_data); i++) {
+		struct vec_data *data = &vec_data[i];
+		unsigned long supported;
+
+		supported = getauxval(data->hwcap_type) & data->hwcap;
+
+		for (j = 0; j < ARRAY_SIZE(tests); j++) {
+			if (supported)
+				tests[j](data);
+			else
+				ksft_test_result_skip("%s not supported\n",
+						      data->name);
+		}
+	}
+
+	ksft_exit_pass();
+}
-- 
2.20.1

