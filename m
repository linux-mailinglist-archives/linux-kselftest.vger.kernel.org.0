Return-Path: <linux-kselftest+bounces-19877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016949A13E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259EA1C22529
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96360218D94;
	Wed, 16 Oct 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aWmlBbcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5076218334
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110512; cv=none; b=lo9ztMytt7ffShsT7mHJZxKVO80TYT2yOHWoILpVxB1vZeXMRqXev4nr/Z5iOFYDLe/6KuMX0MydEAAcT94w8/KnVxYYTWVVtHIfwPXEI7Bhverq0w6esXGg1xC729H2Ybsm64yomKgsSXb94htZSawHrK9bOrqxOhWdi5cJS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110512; c=relaxed/simple;
	bh=PxC5tkDZylcs6ZZ0cfqQyJOQ0Ag3geVK5qboHm2WPZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdEWfgjYRB0G5wfHYN3XSgg/L5s6UiptAR+KtmZ9neD64ht9xCaGOzFEaH4aGrmJ4uGEj8oWr1f4B5x2vesgGCyZ5/OLf6F5jdRWMCERAmbAGN+KlVL3DgRXH3/hMs0PlaFklWXVvb0fwesh3mcSddgebgNSQAkMk8D82oPmyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aWmlBbcl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so172413a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110510; x=1729715310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv10ipSUZUspRTnhL9JfvW8gxx9UoZi8WAdsMyxYUqw=;
        b=aWmlBbcl3l+lLhxivfec6iEuU4lnJIA/KZjDs78MD4SrtzuLJ38CRy3GybDp3vDfIp
         iYdd7zZv/zNqGr53UH9PuPBmATaX/q5THcCohvGNGyNQa8NDclNxegmW8kEUFoeAd2P4
         BkUoi+8hCSiHIX0DaIbnxXlWB+y5hJgADuQ3rAjmLyyxvuny8AQSjgLdnV2Cc36ybEq2
         5S6mm5opsoB0Hh0BcqZSyjXGT7HKexPTCtdq26Yez8AbqutMxRZgfDjfYtg/6EXpKDOt
         +EAdLY6SYzvTixvPNrYBANLgEsz36boewbHscdkOYGRxdGu1WMAtBZMXGzlrCOG8vnxr
         2HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110510; x=1729715310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv10ipSUZUspRTnhL9JfvW8gxx9UoZi8WAdsMyxYUqw=;
        b=oau7tx0pdgoVKqJVG4qnYLqlkNSHc1EitHIPOpm+Bk+GRcygYj7l+0dRYhVw2PBXpW
         0QHTejBBEqAzbRGJhuGRyrI05Eyx7MbPpKCehDT4WKdyi60KqVihtxEfV0G04pYr1r1I
         +zq064l+ZA4jK1cXPbmGXeHXVxJRqnFi13PggQecTbu/Ui49B0Dq8r0bXOf+rxATog8Z
         1U+bGmizObrgbQxI0CScpBD6w8ojcLYBQMHI1eeK0s4XPz1iAEOHrp0znTtX6/wp1CX3
         Oxfxx+xiEecaIlgMUpCu/ia+smPPVeQDeFBrEPkZkglXhbp+u1aY9ZAXFZnmBMaM0vzY
         7cjg==
X-Forwarded-Encrypted: i=1; AJvYcCXBKW9cl4w0szurIrpjOdwDZfgPfVKxLzxc1rShLqF9mfYg50frqvA1i/fdZw/5I4P/uHHwn4rdBH9YblM0wOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWyQqAa4rfRR423Y9bpmn4QUoKce1V44BuEWbgZF4/pGBhVYX
	XsrIHTvEO2FgLne6/VRPwbHlNPq/kuP/Wp+Mt9R9HC8qfuKVQQ9jQZQbAyVzWMo=
X-Google-Smtp-Source: AGHT+IGaiYFJi4BfGAG9jrWM284vA5S4OqwgtBN43JGCqc62clhyQgvBW9PSUIVXg22ufDQI5d1qjQ==
X-Received: by 2002:a17:90b:4c8c:b0:2e2:ad29:11a4 with SMTP id 98e67ed59e1d1-2e3ab8bc829mr5746417a91.25.1729110509973;
        Wed, 16 Oct 2024 13:28:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:29 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 07/10] riscv: selftests: Add a pointer masking test
Date: Wed, 16 Oct 2024 13:27:48 -0700
Message-ID: <20241016202814.4061541-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test covers the behavior of the PR_SET_TAGGED_ADDR_CTRL and
PR_GET_TAGGED_ADDR_CTRL prctl() operations, their effects on the
userspace ABI, and their effects on the system call ABI.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Rename "pm" selftests directory to "abi" to be more generic
 - Fix -Wparentheses warnings
 - Fix order of operations when writing via the tagged pointer

Changes in v2:
 - Rename "tags" directory to "pm" to avoid .gitignore rules
 - Add .gitignore file to ignore the compiled selftest binary
 - Write to a pipe to force dereferencing the user pointer
 - Handle SIGSEGV in the child process to reduce dmesg noise

 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore  |   1 +
 tools/testing/selftests/riscv/abi/Makefile    |  10 +
 .../selftests/riscv/abi/pointer_masking.c     | 332 ++++++++++++++++++
 4 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/pointer_masking.c

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 7ce03d832b64..099b8c1f46f8 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
+RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
new file mode 100644
index 000000000000..b38358f91c4d
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/.gitignore
@@ -0,0 +1 @@
+pointer_masking
diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
new file mode 100644
index 000000000000..ed82ff9c664e
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := pointer_masking
+
+include ../../lib.mk
+
+$(OUTPUT)/pointer_masking: pointer_masking.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
new file mode 100644
index 000000000000..dee41b7ee3e3
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <errno.h>
+#include <fcntl.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../../kselftest.h"
+
+#ifndef PR_PMLEN_SHIFT
+#define PR_PMLEN_SHIFT			24
+#endif
+#ifndef PR_PMLEN_MASK
+#define PR_PMLEN_MASK			(0x7fUL << PR_PMLEN_SHIFT)
+#endif
+
+static int dev_zero;
+
+static int pipefd[2];
+
+static sigjmp_buf jmpbuf;
+
+static void sigsegv_handler(int sig)
+{
+	siglongjmp(jmpbuf, 1);
+}
+
+static int min_pmlen;
+static int max_pmlen;
+
+static inline bool valid_pmlen(int pmlen)
+{
+	return pmlen == 0 || pmlen == 7 || pmlen == 16;
+}
+
+static void test_pmlen(void)
+{
+	ksft_print_msg("Testing available PMLEN values\n");
+
+	for (int request = 0; request <= 16; request++) {
+		int pmlen, ret;
+
+		ret = prctl(PR_SET_TAGGED_ADDR_CTRL, request << PR_PMLEN_SHIFT, 0, 0, 0);
+		if (ret)
+			goto pr_set_error;
+
+		ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
+		ksft_test_result(ret >= 0, "PMLEN=%d PR_GET_TAGGED_ADDR_CTRL\n", request);
+		if (ret < 0)
+			goto pr_get_error;
+
+		pmlen = (ret & PR_PMLEN_MASK) >> PR_PMLEN_SHIFT;
+		ksft_test_result(pmlen >= request, "PMLEN=%d constraint\n", request);
+		ksft_test_result(valid_pmlen(pmlen), "PMLEN=%d validity\n", request);
+
+		if (min_pmlen == 0)
+			min_pmlen = pmlen;
+		if (max_pmlen < pmlen)
+			max_pmlen = pmlen;
+
+		continue;
+
+pr_set_error:
+		ksft_test_result_skip("PMLEN=%d PR_GET_TAGGED_ADDR_CTRL\n", request);
+pr_get_error:
+		ksft_test_result_skip("PMLEN=%d constraint\n", request);
+		ksft_test_result_skip("PMLEN=%d validity\n", request);
+	}
+
+	if (max_pmlen == 0)
+		ksft_exit_fail_msg("Failed to enable pointer masking\n");
+}
+
+static int set_tagged_addr_ctrl(int pmlen, bool tagged_addr_abi)
+{
+	int arg, ret;
+
+	arg = pmlen << PR_PMLEN_SHIFT | tagged_addr_abi;
+	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, arg, 0, 0, 0);
+	if (!ret) {
+		ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
+		if (ret == arg)
+			return 0;
+	}
+
+	return ret < 0 ? -errno : -ENODATA;
+}
+
+static void test_dereference_pmlen(int pmlen)
+{
+	static volatile int i;
+	volatile int *p;
+	int ret;
+
+	ret = set_tagged_addr_ctrl(pmlen, false);
+	if (ret)
+		return ksft_test_result_error("PMLEN=%d setup (%d)\n", pmlen, ret);
+
+	i = pmlen;
+
+	if (pmlen) {
+		p = (volatile int *)((uintptr_t)&i | 1UL << (__riscv_xlen - pmlen));
+
+		/* These dereferences should succeed. */
+		if (sigsetjmp(jmpbuf, 1))
+			return ksft_test_result_fail("PMLEN=%d valid tag\n", pmlen);
+		if (*p != pmlen)
+			return ksft_test_result_fail("PMLEN=%d bad value\n", pmlen);
+		++*p;
+	}
+
+	p = (volatile int *)((uintptr_t)&i | 1UL << (__riscv_xlen - pmlen - 1));
+
+	/* These dereferences should raise SIGSEGV. */
+	if (sigsetjmp(jmpbuf, 1))
+		return ksft_test_result_pass("PMLEN=%d dereference\n", pmlen);
+	++*p;
+	ksft_test_result_fail("PMLEN=%d invalid tag\n", pmlen);
+}
+
+static void test_dereference(void)
+{
+	ksft_print_msg("Testing userspace pointer dereference\n");
+
+	signal(SIGSEGV, sigsegv_handler);
+
+	test_dereference_pmlen(0);
+	test_dereference_pmlen(min_pmlen);
+	test_dereference_pmlen(max_pmlen);
+
+	signal(SIGSEGV, SIG_DFL);
+}
+
+static void execve_child_sigsegv_handler(int sig)
+{
+	exit(42);
+}
+
+static int execve_child(void)
+{
+	static volatile int i;
+	volatile int *p = (volatile int *)((uintptr_t)&i | 1UL << (__riscv_xlen - 7));
+
+	signal(SIGSEGV, execve_child_sigsegv_handler);
+
+	/* This dereference should raise SIGSEGV. */
+	return *p;
+}
+
+static void test_fork_exec(void)
+{
+	int ret, status;
+
+	ksft_print_msg("Testing fork/exec behavior\n");
+
+	ret = set_tagged_addr_ctrl(min_pmlen, false);
+	if (ret)
+		return ksft_test_result_error("setup (%d)\n", ret);
+
+	if (fork()) {
+		wait(&status);
+		ksft_test_result(WIFEXITED(status) && WEXITSTATUS(status) == 42,
+				 "dereference after fork\n");
+	} else {
+		static volatile int i = 42;
+		volatile int *p;
+
+		p = (volatile int *)((uintptr_t)&i | 1UL << (__riscv_xlen - min_pmlen));
+
+		/* This dereference should succeed. */
+		exit(*p);
+	}
+
+	if (fork()) {
+		wait(&status);
+		ksft_test_result(WIFEXITED(status) && WEXITSTATUS(status) == 42,
+				 "dereference after fork+exec\n");
+	} else {
+		/* Will call execve_child(). */
+		execve("/proc/self/exe", (char *const []) { "", NULL }, NULL);
+	}
+}
+
+static void test_tagged_addr_abi_sysctl(void)
+{
+	char value;
+	int fd;
+
+	ksft_print_msg("Testing tagged address ABI sysctl\n");
+
+	fd = open("/proc/sys/abi/tagged_addr_disabled", O_WRONLY);
+	if (fd < 0) {
+		ksft_test_result_skip("failed to open sysctl file\n");
+		ksft_test_result_skip("failed to open sysctl file\n");
+		return;
+	}
+
+	value = '1';
+	pwrite(fd, &value, 1, 0);
+	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
+			 "sysctl disabled\n");
+
+	value = '0';
+	pwrite(fd, &value, 1, 0);
+	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
+			 "sysctl enabled\n");
+
+	set_tagged_addr_ctrl(0, false);
+
+	close(fd);
+}
+
+static void test_tagged_addr_abi_pmlen(int pmlen)
+{
+	int i, *p, ret;
+
+	i = ~pmlen;
+
+	if (pmlen) {
+		p = (int *)((uintptr_t)&i | 1UL << (__riscv_xlen - pmlen));
+
+		ret = set_tagged_addr_ctrl(pmlen, false);
+		if (ret)
+			return ksft_test_result_error("PMLEN=%d ABI disabled setup (%d)\n",
+						      pmlen, ret);
+
+		ret = write(pipefd[1], p, sizeof(*p));
+		if (ret >= 0 || errno != EFAULT)
+			return ksft_test_result_fail("PMLEN=%d ABI disabled write\n", pmlen);
+
+		ret = read(dev_zero, p, sizeof(*p));
+		if (ret >= 0 || errno != EFAULT)
+			return ksft_test_result_fail("PMLEN=%d ABI disabled read\n", pmlen);
+
+		if (i != ~pmlen)
+			return ksft_test_result_fail("PMLEN=%d ABI disabled value\n", pmlen);
+
+		ret = set_tagged_addr_ctrl(pmlen, true);
+		if (ret)
+			return ksft_test_result_error("PMLEN=%d ABI enabled setup (%d)\n",
+						      pmlen, ret);
+
+		ret = write(pipefd[1], p, sizeof(*p));
+		if (ret != sizeof(*p))
+			return ksft_test_result_fail("PMLEN=%d ABI enabled write\n", pmlen);
+
+		ret = read(dev_zero, p, sizeof(*p));
+		if (ret != sizeof(*p))
+			return ksft_test_result_fail("PMLEN=%d ABI enabled read\n", pmlen);
+
+		if (i)
+			return ksft_test_result_fail("PMLEN=%d ABI enabled value\n", pmlen);
+
+		i = ~pmlen;
+	} else {
+		/* The tagged address ABI cannot be enabled when PMLEN == 0. */
+		ret = set_tagged_addr_ctrl(pmlen, true);
+		if (ret != -EINVAL)
+			return ksft_test_result_error("PMLEN=%d ABI setup (%d)\n",
+						      pmlen, ret);
+	}
+
+	p = (int *)((uintptr_t)&i | 1UL << (__riscv_xlen - pmlen - 1));
+
+	ret = write(pipefd[1], p, sizeof(*p));
+	if (ret >= 0 || errno != EFAULT)
+		return ksft_test_result_fail("PMLEN=%d invalid tag write (%d)\n", pmlen, errno);
+
+	ret = read(dev_zero, p, sizeof(*p));
+	if (ret >= 0 || errno != EFAULT)
+		return ksft_test_result_fail("PMLEN=%d invalid tag read\n", pmlen);
+
+	if (i != ~pmlen)
+		return ksft_test_result_fail("PMLEN=%d invalid tag value\n", pmlen);
+
+	ksft_test_result_pass("PMLEN=%d tagged address ABI\n", pmlen);
+}
+
+static void test_tagged_addr_abi(void)
+{
+	ksft_print_msg("Testing tagged address ABI\n");
+
+	test_tagged_addr_abi_pmlen(0);
+	test_tagged_addr_abi_pmlen(min_pmlen);
+	test_tagged_addr_abi_pmlen(max_pmlen);
+}
+
+static struct test_info {
+	unsigned int nr_tests;
+	void (*test_fn)(void);
+} tests[] = {
+	{ .nr_tests = 17 * 3, test_pmlen },
+	{ .nr_tests = 3, test_dereference },
+	{ .nr_tests = 2, test_fork_exec },
+	{ .nr_tests = 2, test_tagged_addr_abi_sysctl },
+	{ .nr_tests = 3, test_tagged_addr_abi },
+};
+
+int main(int argc, char **argv)
+{
+	unsigned int plan = 0;
+	int ret;
+
+	/* Check if this is the child process after execve(). */
+	if (!argv[0][0])
+		return execve_child();
+
+	dev_zero = open("/dev/zero", O_RDWR);
+	if (dev_zero < 0)
+		return 1;
+
+	/* Write to a pipe so the kernel must dereference the buffer pointer. */
+	ret = pipe(pipefd);
+	if (ret)
+		return 1;
+
+	ksft_print_header();
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		plan += tests[i].nr_tests;
+
+	ksft_set_plan(plan);
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		tests[i].test_fn();
+
+	ksft_finished();
+}
-- 
2.45.1


