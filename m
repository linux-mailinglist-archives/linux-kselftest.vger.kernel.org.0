Return-Path: <linux-kselftest+bounces-12643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F459167CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92979284879
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C1915CD64;
	Tue, 25 Jun 2024 12:25:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140715A85B;
	Tue, 25 Jun 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318317; cv=none; b=KSJZzjc9iozJNQ6bc1wMQRRrOTw9W0qHiY47Q6AKI6euQRJjct1CVK2eAjWsJ1TXEAsVThP3oU73MsbMWKx94gz6gBaTl4WbTABqqd6LR94F66nZG51NDRjJl4ozxp1/n26Fbp7263MoZpkJlGcfxvXTNKtElYTMLUThBKLDC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318317; c=relaxed/simple;
	bh=APogV9FZtDCsWPwBH6klc3BpkCkJIW4jO0JO4TfYsxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhwVuQaFXyuMi4RXRGUQwAJaU+EviI6ynQinsLQlySNfICciNjBN1FkZeziyucGV59cSMuCJktGRuEQpHyHCBToPp1r4W/yIGHWM1hTtzLvlmP7Oy/z1he9dUimYCD2hRRAd+7Okn8vLNju1zhH+BbHA+a4WG/p9D/1kMng8Ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ACA7339;
	Tue, 25 Jun 2024 05:25:40 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5FD33F766;
	Tue, 25 Jun 2024 05:25:10 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 8/9] selftests/arm: Add ptrace_64 test
Date: Tue, 25 Jun 2024 17:54:07 +0530
Message-Id: <20240625122408.1439097-9-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a 64-bit parent debugging a 32-bit child, add tests for reading the
TLS registers, and mangling with the mode bits in CPSR.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm/abi/ptrace_64.c   | 91 +++++++++++++++++++
 .../selftests/arm/abi/trivial_32bit_program.c | 14 +++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/arm/abi/ptrace_64.c
 create mode 100644 tools/testing/selftests/arm/abi/trivial_32bit_program.c

diff --git a/tools/testing/selftests/arm/abi/ptrace_64.c b/tools/testing/selftests/arm/abi/ptrace_64.c
new file mode 100644
index 000000000000..97398cf59052
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/ptrace_64.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited.
+ *
+ * Inspired from selftests/arm64/abi/ptrace.c
+ *
+ * Author: Dev Jain <dev.jain@arm.com>
+ *
+ */
+
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
+#include "ptrace.h"
+#include "../../kselftest.h"
+
+#define EXPECTED_TESTS	12
+#define NUM_TLS_REGS	2
+
+static void test_tpidr(pid_t child)
+{
+	unsigned int read_val[NUM_TLS_REGS];
+	struct iovec read_iov;
+	int ret;
+
+	memset(read_val, 0, sizeof(read_val));
+
+	read_iov.iov_base = read_val;
+
+	/* Should be able to read a single TLS register... */
+	read_iov.iov_len = 2 * sizeof(unsigned int);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+	ksft_test_result(ret == 0, "read_tls\n");
+
+	ksft_test_result(read_val[0], "read_tls_1\n");
+	ksft_test_result(!read_val[1], "cannot read_tls_2\n");
+}
+
+static void run_tests(pid_t child)
+{
+	test_tpidr(child);
+	test_user_regs(child);
+	test_hw_debug(child, NT_ARM_HW_WATCH, "NT_ARM_HW_WATCH");
+	test_hw_debug(child, NT_ARM_HW_BREAK, "NT_ARM_HW_BREAK");
+}
+
+static int do_child(void)
+{
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+		ksft_exit_fail_perror("PTRACE_TRACEME");
+
+	/* SIGTRAP makes the child stop after exec; do_parent() resumes it */
+	execv("trivial_32bit_program", NULL);
+	return EXIT_SUCCESS;
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
+
+	ksft_set_plan(EXPECTED_TESTS);
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
diff --git a/tools/testing/selftests/arm/abi/trivial_32bit_program.c b/tools/testing/selftests/arm/abi/trivial_32bit_program.c
new file mode 100644
index 000000000000..c5ad7abb23ed
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/trivial_32bit_program.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited.
+ */
+
+#include <stdio.h>
+#include <signal.h>
+
+int main(void)
+{
+	raise(SIGSTOP);
+	raise(SIGSTOP);
+	return 0;
+}
-- 
2.39.2


