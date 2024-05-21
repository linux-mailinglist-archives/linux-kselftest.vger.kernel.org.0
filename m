Return-Path: <linux-kselftest+bounces-10482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035578CB36C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895391F22A5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA47581A;
	Tue, 21 May 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGLqrTqQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083A148FFA;
	Tue, 21 May 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315536; cv=none; b=VWyZcUBd41q/B2Nn0QnfTmr6NFk0Rb6SlGyHM2Tbpvi0dP8tmRmo5vwrPDPr2yWlnObLeOy6yz3MGpmFgZAlFO7jAYFc3tgRb+PuTMuqnmLPm3rQ2TjLQbWTDKaYOAf4QwdiGLxXrbYnG80oNqxkm9RkjhKuxYx76vZCQE0FuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315536; c=relaxed/simple;
	bh=2Kn/zQ8UGCer1u8bszUqcshJKZWfJxL62JLkYYC55KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mJ+zseokCu3qCeDdooJ+iiUuSqnzKwezx35a5U/T5EF7KjKv2lEQ5n5DtltT4WcLcFZcIBFpkGtj8Mv/3gOb049KSvDPD8wg6CcytVyq+Mysi7YeDdLU8uoVPb16z3Sz60g2OGeNd70Yz09iVR2W7nFCpDwiZhPzpTurv2od6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGLqrTqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6AAC4AF0C;
	Tue, 21 May 2024 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716315536;
	bh=2Kn/zQ8UGCer1u8bszUqcshJKZWfJxL62JLkYYC55KI=;
	h=From:Date:Subject:To:Cc:From;
	b=nGLqrTqQGiJlWGIEdqFds/XpgK52gVSm24J3tTId+9kbF2GT64uwDQSfaOTvaQNZc
	 4flltIfTKQ1AI+N/kd1rUrWPVvllNlhlOXeTpsFd3/+axrw6DsSErWAi0FmnkML4HB
	 4ctYcykKZrmoIQm5AuPCbUGjcWHmbYG5ZPEs4bIZvDDlJJQkqA0emFTvWB4LbkP3E/
	 Nb1lXEC3dH0wh4+B5erTv6EWaBM9FsHDO1LOdGeQtt9s9zbc7oQVvH5fbPl2AYxMia
	 4ldE2Et+8Ull09q6K5KQGTPcrRmLhI7HzoXGCtmuwbQJia0E6MAkTv5o8gIuGxAxQi
	 uF1wv5PCXqL+w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 21 May 2024 19:18:26 +0100
Subject: [PATCH] kselftest/arm64: Include kernel mode NEON in fp-stress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-arm64-fp-stress-kernel-v1-1-e38f107baad4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHHlTGYC/x3MQQrDIBBA0auEWXdAxRjSq5QuTDo2Q1IrMyUUx
 LtXunyL/ysoCZPCdaggdLLyO3fYywDrFvOTkB/d4IzzZrQTRnkFj6mgfoRUcSfJdGA0s7F2mUP
 yDnpchBJ//+PbvbUfhnSExGgAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Johannes Nixdorf <mixi@shadowice.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-621fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=12532; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Kn/zQ8UGCer1u8bszUqcshJKZWfJxL62JLkYYC55KI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmTOWMrKrZl1Xm1Eud4fivcWJpaLOJATDE50YxuAEZ
 mghYQh+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZkzljAAKCRAk1otyXVSH0L93B/
 0dOIJMXV2grCUQ8Ap+B1gBJ3Ig3hBLk8R26OVIMV8RsKMPNSokFSr9qZ7FhEMwlVKMKFWEtTb20Q1g
 zsUCqSKE619aypdfVHNR93hOHyZ0RpEC7uz6xv+xoF+b0F1DQQu58rKi7HjZ7hvg8uIjMcV0uzQCpl
 ZoekAAPecc0LZnF2iH7ynVBz+ARlZRKL+CAXO5mYdQ9vtkXdyhwgUKSKU6P3namC6QrCUEJBm38Ijo
 UQpg4OsydNKUZ4GPzcSwHJVs42s2AuoD+6tjR2u6T72vsheke89OLQfJUqigniMQZswxABg3nxgw29
 n1Pzf/9DgcEJ7QW/iZaFAL9rqHeAoz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently fp-stress only covers userspace use of floating point, it does
not cover any kernel mode uses.  Since currently kernel mode floating
point usage can't be preempted and there are explicit preemption points in
the existing implementations this isn't so important for fp-stress but
when we readd preemption it will be good to try to exercise it.

When the arm64 accelerated crypto operations are implemented we can
relatively straightforwardly trigger kernel mode floating point usage by
using the crypto userspace API to hash data, using the splice() support
in an effort to minimise copying.  We use /proc/crypto to check which
accelerated implementations are available, picking the first symmetric
hash we find.  We run the kernel mode test unconditionally, replacing the
second copy of the FPSIMD testcase for systems with FPSIMD only. If we
don't think there are any suitable kernel mode implementations we fall back
to running another copy of fpsimd-stress.

There are a number issues with this approach, we don't actually verify
that we are using an accelerated (or even CPU) implementation of the
algorithm being tested and even with attempting to use splice() to
minimise copying there are sizing limits on how much data gets spliced
at once.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
This is mainly focused on trying to reproduce the issues reported by
Asahi users with preemptable kernel mode floating point - as noted in
the commit log it needs reenablement of preemptable floating point and
removal of the preemption points in the current algorithm
implementations to really have anything to exercise directly.  There
also seem to be race conditions when AF_ALG is built as a module,
attempting to bind triggers module load but does not block.
---
 tools/testing/selftests/arm64/fp/.gitignore    |   1 +
 tools/testing/selftests/arm64/fp/Makefile      |   1 +
 tools/testing/selftests/arm64/fp/fp-stress.c   |  26 +-
 tools/testing/selftests/arm64/fp/kernel-test.c | 324 +++++++++++++++++++++++++
 4 files changed, 343 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 00e52c966281..8362e7ec35ad 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -2,6 +2,7 @@ fp-pidbench
 fp-ptrace
 fp-stress
 fpsimd-test
+kernel-test
 rdvl-sme
 rdvl-sve
 sve-probe-vls
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 55d4f00d9e8e..d171021e4cdd 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS := \
 	vec-syscfg \
 	za-fork za-ptrace
 TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
+	kernel-test \
 	rdvl-sme rdvl-sve \
 	sve-test \
 	ssve-test \
diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index dd31647b00a2..faac24bdefeb 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -319,6 +319,19 @@ static void start_fpsimd(struct child_data *child, int cpu, int copy)
 	ksft_print_msg("Started %s\n", child->name);
 }
 
+static void start_kernel(struct child_data *child, int cpu, int copy)
+{
+	int ret;
+
+	ret = asprintf(&child->name, "KERNEL-%d-%d", cpu, copy);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	child_start(child, "./kernel-test");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
 static void start_sve(struct child_data *child, int vl, int cpu)
 {
 	int ret;
@@ -438,7 +451,7 @@ int main(int argc, char **argv)
 	int ret;
 	int timeout = 10;
 	int cpus, i, j, c;
-	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
+	int sve_vl_count, sme_vl_count;
 	bool all_children_started = false;
 	int seen_children;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
@@ -482,12 +495,7 @@ int main(int argc, char **argv)
 		have_sme2 = false;
 	}
 
-	/* Force context switching if we only have FPSIMD */
-	if (!sve_vl_count && !sme_vl_count)
-		fpsimd_per_cpu = 2;
-	else
-		fpsimd_per_cpu = 1;
-	tests += cpus * fpsimd_per_cpu;
+	tests += cpus * 2;
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -542,8 +550,8 @@ int main(int argc, char **argv)
 				   tests);
 
 	for (i = 0; i < cpus; i++) {
-		for (j = 0; j < fpsimd_per_cpu; j++)
-			start_fpsimd(&children[num_children++], i, j);
+		start_fpsimd(&children[num_children++], i, 0);
+		start_kernel(&children[num_children++], i, 0);
 
 		for (j = 0; j < sve_vl_count; j++)
 			start_sve(&children[num_children++], sve_vls[j], i);
diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
new file mode 100644
index 000000000000..50db26a3ed79
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/kernel-test.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+
+#include <linux/kernel.h>
+#include <linux/if_alg.h>
+
+#define DATA_SIZE (16 * 4096)
+
+static int base, sock;
+
+static int digest_len;
+static char *ref;
+static char *digest;
+static char *alg_name;
+
+static struct iovec data_iov;
+static int zerocopy[2];
+static int sigs;
+static int iter;
+
+static void handle_exit_signal(int sig, siginfo_t *info, void *context)
+{
+	printf("Terminated by signal %d, iterations=%d, signals=%d\n",
+	       sig, iter, sigs);
+	exit(0);
+}
+
+static void handle_kick_signal(int sig, siginfo_t *info, void *context)
+{
+	sigs++;
+}
+
+static char *drivers[] = {
+	"crct10dif-arm64-ce",
+	/* "crct10dif-arm64-neon", - Same priority as generic */
+	"sha1-ce",
+	"sha224-arm64",
+	"sha224-arm64-neon",
+	"sha224-ce",
+	"sha256-arm64",
+	"sha256-arm64-neon",
+	"sha256-ce",
+	"sha384-ce",
+	"sha512-ce",
+	"sha3-224-ce",
+	"sha3-256-ce",
+	"sha3-384-ce",
+	"sha3-512-ce",
+	"sm3-ce",
+	"sm3-neon",
+};
+
+static bool create_socket(void)
+{
+	FILE *proc;
+	struct sockaddr_alg addr;
+	char buf[1024];
+	char *c, *driver_name;
+	bool is_shash, match;
+	int ret, i;
+
+	ret = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (ret < 0) {
+		if (errno == EAFNOSUPPORT) {
+			printf("AF_ALG not supported\n");
+			return false;
+		}
+
+		printf("Failed to create AF_ALG socket: %s (%d)\n",
+		       strerror(errno), errno);
+		return false;
+	}
+	base = ret;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.salg_family = AF_ALG;
+	strncpy((char *)addr.salg_type, "hash", sizeof(addr.salg_type));
+
+	proc = fopen("/proc/crypto", "r");
+	if (!proc) {
+		printf("Unable to open /proc/crypto\n");
+		return false;
+	}
+
+	driver_name = NULL;
+	is_shash = false;
+	match = false;
+
+	/* Look through /proc/crypto for a driver with kernel mode FP usage */
+	while (!match) {
+		c = fgets(buf, sizeof(buf), proc);
+		if (!c) {
+			if (feof(proc)) {
+				printf("Nothing found in /proc/crypto\n");
+				return false;
+			}
+			continue;
+		}
+
+		/* Algorithm descriptions are separated by a blank line */
+		if (*c == '\n') {
+			if (is_shash && driver_name) {
+				for (i = 0; i < ARRAY_SIZE(drivers); i++) {
+					if (strcmp(drivers[i],
+						   driver_name) == 0) {
+						match = true;
+					}
+				}
+			}
+
+			if (!match) {
+				digest_len = 0;
+
+				free(driver_name);
+				driver_name = NULL;
+
+				free(alg_name);
+				alg_name = NULL;
+
+				is_shash = false;
+			}
+			continue;
+		}
+
+		/* Remove trailing newline */
+		c = strchr(buf, '\n');
+		if (c)
+			*c = '\0';
+
+		/* Find the field/value separator and start of the value */
+		c = strchr(buf, ':');
+		if (!c)
+			continue;
+		c += 2;
+
+		if (strncmp(buf, "digestsize", strlen("digestsize")) == 0)
+			sscanf(c, "%d", &digest_len);
+
+		if (strncmp(buf, "name", strlen("name")) == 0)
+			alg_name = strdup(c);
+
+		if (strncmp(buf, "driver", strlen("driver")) == 0)
+			driver_name = strdup(c);
+
+		if (strncmp(buf, "type", strlen("type")) == 0)
+			if (strncmp(c, "shash", strlen("shash")) == 0)
+				is_shash = true;
+	}
+
+	strncpy((char *)addr.salg_name, alg_name,
+		sizeof(addr.salg_name) - 1);
+
+	ret = bind(base, (struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0) {
+		printf("Failed to bind %s: %s (%d)\n",
+		       addr.salg_name, strerror(errno), errno);
+		return false;
+	}
+
+	ret = accept(base, NULL, 0);
+	if (ret < 0) {
+		printf("Failed to accept %s: %s (%d)\n",
+		       addr.salg_name, strerror(errno), errno);
+		return false;
+	}
+
+	sock = ret;
+
+	ret = pipe(zerocopy);
+	if (ret != 0) {
+		printf("Failed to create zerocopy pipe: %s (%d)\n",
+		       strerror(errno), errno);
+		return false;
+	}
+
+	ref = malloc(digest_len);
+	if (!ref) {
+		printf("Failed to allocated %d byte reference\n", digest_len);
+		return false;
+	}
+
+	digest = malloc(digest_len);
+	if (!digest) {
+		printf("Failed to allocated %d byte digest\n", digest_len);
+		return false;
+	}
+
+	return true;
+}
+
+static bool compute_digest(void *buf)
+{
+	struct iovec iov;
+	int ret, wrote;
+
+	iov = data_iov;
+	while (iov.iov_len) {
+		ret = vmsplice(zerocopy[1], &iov, 1, SPLICE_F_GIFT);
+		if (ret < 0) {
+			printf("Failed to send buffer: %s (%d)\n",
+			       strerror(errno), errno);
+			return false;
+		}
+
+		wrote = ret;
+		ret = splice(zerocopy[0], NULL, sock, NULL, wrote, 0);
+		if (ret < 0) {
+			printf("Failed to splice buffer: %s (%d)\n",
+			       strerror(errno), errno);
+		} else if (ret != wrote) {
+			printf("Short splice: %d < %d\n", ret, wrote);
+		}
+
+		iov.iov_len -= wrote;
+		iov.iov_base += wrote;
+	}
+
+reread:
+	ret = recv(sock, buf, digest_len, 0);
+	if (ret == 0) {
+		printf("No disgest returned\n");
+		return false;
+	}
+	if (ret != digest_len) {
+		if (errno == -EAGAIN)
+			goto reread;
+		printf("Failed to get digest: %s (%d)\n",
+		       strerror(errno), errno);
+		return false;
+	}
+
+	return true;
+}
+
+int main(void)
+{
+	char *data;
+	struct sigaction sa;
+	int ret;
+
+	/* Ensure we have unbuffered output */
+	setvbuf(stdout, NULL, _IOLBF, 0);
+
+	/* The parent will communicate with us via signals */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handle_exit_signal;
+	sa.sa_flags = SA_RESTART | SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGTERM, &sa, NULL);
+	if (ret < 0)
+		printf("Failed to install SIGTERM handler: %s (%d)\n",
+		       strerror(errno), errno);
+
+	sa.sa_sigaction = handle_kick_signal;
+	ret = sigaction(SIGUSR2, &sa, NULL);
+	if (ret < 0)
+		printf("Failed to install SIGUSR2 handler: %s (%d)\n",
+		       strerror(errno), errno);
+
+	data = malloc(DATA_SIZE);
+	if (!data) {
+		printf("Failed to allocate data buffer\n");
+		return EXIT_FAILURE;
+	}
+	memset(data, 0, DATA_SIZE);
+
+	data_iov.iov_base = data;
+	data_iov.iov_len = DATA_SIZE;
+
+	/*
+	 * If we can't create a socket assume it's a lack of system
+	 * support and fall back to a basic FPSIMD test for the
+	 * benefit of fp-stress.
+	 */
+	if (!create_socket()) {
+		execl("./fpsimd-test", "./fpsimd-test", NULL);
+		printf("Failed to fall back to fspimd-test: %d (%s)\n",
+			errno, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	/*
+	 * Compute a reference digest we hope is repeatable, we do
+	 * this at runtime partly to make it easier to play with
+	 * parameters.
+	 */
+	if (!compute_digest(ref)) {
+		printf("Failed to compute reference digest\n");
+		return EXIT_FAILURE;
+	}
+
+	printf("AF_ALG using %s\n", alg_name);
+
+	while (true) {
+		if (!compute_digest(digest)) {
+			printf("Failed to coempute digest, iter=%d\n", iter);
+			return EXIT_FAILURE;
+		}
+
+		if (memcmp(ref, digest, digest_len) != 0) {
+			printf("Digest mismatch, iter=%d\n", iter);
+			return EXIT_FAILURE;
+		}
+
+		iter++;
+	}
+
+	return EXIT_FAILURE;
+}

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240517-arm64-fp-stress-kernel-a09011b96f42

Best regards,
-- 
Mark Brown <broonie@kernel.org>


