Return-Path: <linux-kselftest+bounces-12642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C69167C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBD4283DAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01315A87A;
	Tue, 25 Jun 2024 12:25:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD97A15A85B;
	Tue, 25 Jun 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318312; cv=none; b=Nve7xP/2iAvoVXwZssi78WLpzP2A1zzE1hIQ9eunSlkshDqrOdwQ2k2Ua9mCGY74WlRjjNspKxlEVbWup0irDzl3GI8/lPZX1NthrtxtZY7gkpusT/RN3oyjRtp2WNubBjMczLAod3b3a0zvAa89hg+iSJaP2rXWTjtQoua3DbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318312; c=relaxed/simple;
	bh=OS+oG8hagHM3ro0Lo1ETW7m/q1ZvXOye43hTaulyPk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V82L7hZdy3C54BVy7KFDxszXIjTebKTda6M1VjOCXUU8E6KIpHWHAIcNJwQ6ILgC9+o5Nl0gHXveQ3zE4NoHSYy/qPJVtaPqFlrNKF4Gdr9OWsDw9WSPid6QmCmsbuGpGNMfVhFt4CaPM0SjvdDK1lc1t1X6I0mOUMICphHUeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40833339;
	Tue, 25 Jun 2024 05:25:35 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 898A83F766;
	Tue, 25 Jun 2024 05:25:05 -0700 (PDT)
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
Subject: [PATCH v3 7/9] selftests/arm: Add ptrace test
Date: Tue, 25 Jun 2024 17:54:06 +0530
Message-Id: <20240625122408.1439097-8-dev.jain@arm.com>
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

For a 32-bit parent debugging a 32-bit child, add tests for reading the
TLS registers, and mangling with the mode bits in CPSR.
 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm/abi/ptrace.c | 82 ++++++++++++++++++++++++
 tools/testing/selftests/arm/abi/ptrace.h | 57 ++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/arm/abi/ptrace.c
 create mode 100644 tools/testing/selftests/arm/abi/ptrace.h

diff --git a/tools/testing/selftests/arm/abi/ptrace.c b/tools/testing/selftests/arm/abi/ptrace.c
new file mode 100644
index 000000000000..2079065c48fd
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/ptrace.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited.
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
+#include "ptrace.h"
+#include "../../kselftest.h"
+
+#define EXPECTED_TESTS	6
+#define NUM_TLS_REGS	2
+
+static void test_tpidr(pid_t child)
+{
+	unsigned long read_val[NUM_TLS_REGS];
+	struct iovec read_iov;
+	int ret;
+
+	read_iov.iov_base = read_val;
+
+	/* TLS registers must not be accessible */
+	read_iov.iov_len = 2 * sizeof(unsigned long);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+	ksft_test_result(ret != 0, "cannot read TLS\n");
+}
+
+static void run_tests(pid_t child)
+{
+	test_tpidr(child);
+	test_user_regs(child);
+}
+
+static int do_child(void)
+{
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+		ksft_exit_fail_perror("PTRACE_TRACEME");
+
+	if (raise(SIGSTOP))
+		ksft_exit_fail_perror("raise(SIGSTOP)");
+
+	if (raise(SIGSTOP))
+		ksft_exit_fail_perror("raise(SIGSTOP)");
+
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
diff --git a/tools/testing/selftests/arm/abi/ptrace.h b/tools/testing/selftests/arm/abi/ptrace.h
new file mode 100644
index 000000000000..17ba8aa32726
--- /dev/null
+++ b/tools/testing/selftests/arm/abi/ptrace.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../arm64/abi/ptrace.h"
+
+/* Do not pull from asm/ptrace.h since the macro names change for 32-bit */
+#define PSR_MODE32_BIT	0x00000010
+#define PSR_MODE_EL1t	0x00000004
+
+static void test_user_regs(pid_t child)
+{
+	unsigned int read_val[18];
+	struct iovec read_iov;
+	int status;
+	int ret;
+
+	read_iov.iov_base = read_val;
+	read_iov.iov_len = 18 * sizeof(unsigned int);
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PRSTATUS, &read_iov);
+	ksft_test_result(!ret, "read general-purpose registers\n");
+
+	/* Change a random user register */
+	read_val[2] = read_val[2] + 1;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS, &read_iov);
+	ksft_test_result(!ret, "set user register\n");
+
+	/* 16th register is the CPSR */
+	read_val[16] &= (~PSR_MODE32_BIT);
+
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS,  &read_iov);
+	ksft_test_result(ret, "cannot toggle MODE32 bit\n");
+
+	ret = ptrace(PTRACE_CONT, child, NULL, 0);
+	if (ret) {
+		perror("ptrace");
+		goto error;
+	}
+
+	if (wait(&status) == -1) {
+		perror("wait");
+		goto error;
+	}
+
+	read_val[16] = 0;
+
+	ret = ptrace(PTRACE_GETREGSET, child, NT_PRSTATUS, &read_iov);
+	ksft_test_result(!ret, "read general-purpose registers again\n");
+
+	read_val[16] |= PSR_MODE_EL1t;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS, &read_iov);
+	ksft_test_result(ret, "cannot escalate privilege\n");
+	return;
+
+error:
+	kill(child, SIGKILL);
+}
+
+
-- 
2.39.2


