Return-Path: <linux-kselftest+bounces-40033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BC9B379DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 07:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA8220036C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 05:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABC6311595;
	Wed, 27 Aug 2025 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SxhGV5em"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902930F94A;
	Wed, 27 Aug 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272728; cv=none; b=AS34ywYzYdOlCnoZKoYgyaBpljo6ls4b8AYZsjpr4uw5F+JS3drylEuzEwjMt8MBK4NtOO1xKOf944BxXvLtYljOOqktbEQSyR45m7gTrEHKtqEVoT5Boxh+/WT62JkgXEiBbzndezs0oX+eGBtoQXu3AIIf8w+DJkTrNciPKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272728; c=relaxed/simple;
	bh=5Vpv1ExtYf4D2KVtB2QWCAUTZE9RP2CMEBeMd193E6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR23dj3vv0bWTA/wrtlAi4apnesM8nEBlAcuUe61rSS3rX0nZepfr9sqUoD2+Se2c65idmbc3dCq+s0ykcaoc55rtHXQE9nD8xB3xTNbx8j9yOFcoIbcECkk0WR8WR6Mfed1Ml5wbL0fTd03inF0sV0zc6AJ946ghRM2vlMVv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SxhGV5em; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9a
	e29hWzvhMgeOqPH2MWh3VLpeAtPN1QJ1PiRYJW+EA=; b=SxhGV5emhrNmQFauY2
	H9TOqRIKuxjz5+XmTrrvLQBgGRAwtr2RAsFxEQOQnxwcqrKmR5KLLpfEo1ILJXD9
	PBkwf1Meu9q6tZZOMpk9tBMmIQLOJp9pJvceZVrHXKqY/JQkAr5mU1HUI3IlDlMv
	AcPlahoCFZQb4PxOPD8H0tP68=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXH3YxmK5oLPk1Ew--.15805S4;
	Wed, 27 Aug 2025 13:31:32 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v16 2/2] selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
Date: Wed, 27 Aug 2025 05:31:28 +0000
Message-ID: <20250827053128.1301287-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827053128.1301287-1-phoenix500526@163.com>
References: <20250827053128.1301287-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH3YxmK5oLPk1Ew--.15805S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15Gw1DZrW8GrWfJw4xZwb_yoWxZFyDpa
	ykZ34xtFy5t3WfGw1xJr4jqw4fKFn2yrW5ArZ7XrWjyrWkGrZ7Xrn7Kw17KFnxX3ykX3W5
	ArZIkan5Kw4xXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgBS2iGiui+TTvQAAst

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array, e.g. "1@-96(%rbp,%rax,8)".

In this patch:
- enrich subtest_basic_usdt test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 84 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 31 +++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 9057e983cc54..9df2827991c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -25,6 +25,7 @@ unsigned short test_usdt0_semaphore SEC(".probes");
 unsigned short test_usdt3_semaphore SEC(".probes");
 unsigned short test_usdt12_semaphore SEC(".probes");
 
+
 static void __always_inline trigger_func(int x) {
 	long y = 42;
 
@@ -40,12 +41,72 @@ static void __always_inline trigger_func(int x) {
 	}
 }
 
+#if defined(__x86_64__) || defined(__i386__)
+/*
+ * SIB (Scale-Index-Base) addressing format:
+ *   "size@(base_reg, index_reg, scale)"
+ * - 'size' is the size in bytes of the array element, and its sign indicates
+ *		whether the type is signed (negative) or unsigned (positive).
+ * - 'base_reg' is the register holding the base address, normally rdx or edx
+ * - 'index_reg' is the register holding the index, normally rax or eax
+ * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which matches the
+ *		size of the element type.
+ *
+ * For example, for an array of 'short' (signed 2-byte elements), the SIB spec would be:
+ *	- size: -2 (negative because 'short' is signed)
+ *	- scale: 2 (since sizeof(short) == 2)
+ *	The resulting SIB format: "-2@(%%rdx,%%rax,2)" for x86_64, "-2@(%%edx,%%eax,2)" for i386
+ */
+static volatile short array[] = {-1, -2, -3, -4};
+
+#if defined(__x86_64__)
+#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)
+#else
+#define USDT_SIB_ARG_SPEC -2@(%%edx,%%eax,2)
+#endif
+
+unsigned short test_usdt_sib_semaphore SEC(".probes");
+
+static void trigger_sib_spec(void)
+{
+	/*
+	 * Force SIB addressing with inline assembly.
+	 *
+	 * You must compile with -std=gnu99 or -std=c99 to use the
+	 * STAP_PROBE_ASM macro.
+	 *
+	 * The STAP_PROBE_ASM macro generates a quoted string that gets
+	 * inserted between the surrounding assembly instructions. In this
+	 * case, USDT_SIB_ARG_SPEC is embedded directly into the instruction
+	 * stream, creating a probe point between the asm statement boundaries.
+	 * It works fine with gcc/clang.
+	 *
+	 * Register constraints:
+	 * - "d"(array): Binds the 'array' variable to %rdx or %edx register
+	 * - "a"(0): Binds the constant 0 to %rax or %eax register
+	 * These ensure that when USDT_SIB_ARG_SPEC references %%rdx(%edx) and
+	 * %%rax(%eax), they contain the expected values for SIB addressing.
+	 *
+	 * The "memory" clobber prevents the compiler from reordering memory
+	 * accesses around the probe point, ensuring that the probe behavior
+	 * is predictable and consistent.
+	 */
+	asm volatile(
+		STAP_PROBE_ASM(test, usdt_sib, USDT_SIB_ARG_SPEC)
+		:
+		: "d"(array), "a"(0)
+		: "memory"
+	);
+}
+#endif
+
 static void subtest_basic_usdt(void)
 {
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
 	struct test_usdt *skel;
 	struct test_usdt__bss *bss;
 	int err, i;
+	const __u64 expected_cookie = 0xcafedeadbeeffeed;
 
 	skel = test_usdt__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -59,20 +120,29 @@ static void subtest_basic_usdt(void)
 		goto cleanup;
 
 	/* usdt0 won't be auto-attached */
-	opts.usdt_cookie = 0xcafedeadbeeffeed;
+	opts.usdt_cookie = expected_cookie;
 	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
 						     0 /*self*/, "/proc/self/exe",
 						     "test", "usdt0", &opts);
 	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
 		goto cleanup;
 
+#if defined(__x86_64__) || defined(__i386__)
+	opts.usdt_cookie = expected_cookie;
+	skel->links.usdt_sib = bpf_program__attach_usdt(skel->progs.usdt_sib,
+							 0 /*self*/, "/proc/self/exe",
+							 "test", "usdt_sib", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt_sib, "usdt_sib_link"))
+		goto cleanup;
+#endif
+
 	trigger_func(1);
 
 	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
 	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
 	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
 
-	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
+	ASSERT_EQ(bss->usdt0_cookie, expected_cookie, "usdt0_cookie");
 	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
 	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
 	ASSERT_EQ(bss->usdt0_arg_size, -ENOENT, "usdt0_arg_size");
@@ -156,6 +226,16 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
 	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
 
+#if defined(__x86_64__) || defined(__i386__)
+	trigger_sib_spec();
+	ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
+	ASSERT_EQ(bss->usdt_sib_cookie, expected_cookie, "usdt_sib_cookie");
+	ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
+	ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
+	ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
+	ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_size");
+#endif
+
 cleanup:
 	test_usdt__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index 096488f47fbc..a78c87537b07 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -107,4 +107,35 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
 	return 0;
 }
 
+int usdt_sib_called;
+u64 usdt_sib_cookie;
+int usdt_sib_arg_cnt;
+int usdt_sib_arg_ret;
+short usdt_sib_arg;
+int usdt_sib_arg_size;
+
+/*
+ * usdt_sib is only tested on x86-related architectures, so it requires
+ * manual attach since auto-attach will panic tests under other architectures
+ */
+SEC("usdt")
+int usdt_sib(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt_sib_called, 1);
+
+	usdt_sib_cookie = bpf_usdt_cookie(ctx);
+	usdt_sib_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt_sib_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
+	usdt_sib_arg = (short)tmp;
+	usdt_sib_arg_size = bpf_usdt_arg_size(ctx, 0);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


