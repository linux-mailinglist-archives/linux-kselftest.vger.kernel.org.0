Return-Path: <linux-kselftest+bounces-39780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF188B32721
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 08:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9301BC458F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Aug 2025 06:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A632248A8;
	Sat, 23 Aug 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CKa9ISHX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5122259D;
	Sat, 23 Aug 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931847; cv=none; b=iiNwFMn+AohWBj5Mwpb3wILp7IQTIJswgJulJubxBG4XtRYvBHbFfQMEk5+yx9vwZ2qV5Gb6T/lK7y7Sid8MKaIfQTGO4560/eFxFAhV/e+QT2+IkVocp13HBW56x1G4qrY3XCk1Po7X9t/A+Wb9X7ChSHZ6+rFEzxZZ/d762rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931847; c=relaxed/simple;
	bh=QukoYCtjW4waH+Id5rp8ZqCUjlvR6HYBYHosM6VD1LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbv2HUR3tP13qAQYOit5CXaXWQCMx6n3ZnRCxe5Wq7M98BpQnEfqQndK2k3tA0sYNg9bWOCTLCGI989gtc6ZGPUPViUk9/IA537szb9nUoTeHJRY/wnN0ivPn0+/0E4O+bGwF1JYmXJruQvqF8cmA7GW1QFeIzcR+gXwwdqnJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CKa9ISHX; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8p
	O9xe2lXuwQ1Fp2+vvEgmLZFoddmipbcHTTsOk6d3k=; b=CKa9ISHXtmcnlv3F+W
	UMOn1SFFm77WO2mGKq7FwKICcnoyau1qxZkYyjgcu7Qq2ZVQRPRszXgcjnxN8l+l
	h8tG8O8HZAinubNF2qJ5xrzjCE9d/2Tl1VXB8iik0pNC420WjWuLOU8CNYl4u4fb
	Fb1CakZNFUBo4R6zcVPrnU/Ck=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAn8USdZKlohCriDQ--.20793S4;
	Sat, 23 Aug 2025 14:50:09 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v14 2/2] selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
Date: Sat, 23 Aug 2025 06:50:04 +0000
Message-ID: <20250823065005.1187181-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823065005.1187181-1-phoenix500526@163.com>
References: <20250823065005.1187181-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn8USdZKlohCriDQ--.20793S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15Cry3JFW7ZFWkWw4DArb_yoWxGFyUpa
	ykZ34xtFy5t3WxGw4xJr4jqw4rKFn2yrW5AFZrXry2yrWkGrs7Xrn7K3W3KFnIqaykX3W5
	ArZ0kan5tw4xXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAqyiGipWPbE8QACs8

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- enrich subtest_basic_usdt test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 62 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 32 ++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 9057e983cc54..0d5e40eca0d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -10,6 +10,26 @@
 
 int lets_test_this(int);
 
+#if defined(__x86_64__) || defined(__i386__)
+/*
+ * SIB (Scale-Index-Base) addressing format:
+ *   "size@(base_reg, index_reg, scale)"
+ * - 'size' is the size in bytes of the array element, and its sign indicates
+ *   	whether the type is signed (negative) or unsigned (positive).
+ * - 'base_reg' is the register holding the base address, normally rdx or edx
+ * - 'index_reg' is the register holding the index, normally rax or eax
+ * - 'scale' is the scaling factor (typically 1, 2, 4, or 8), which matches the
+ *   size of the element type.
+ *
+ * For example, for an array of 'short' (signed 2-byte elements), the SIB spec would be:
+ *   - size: -2 (negative because 'short' is signed)
+ *   - scale: 2 (since sizeof(short) == 2)
+ *   The resulting SIB format: "-2@(%%rdx,%%rax,2)"
+ */
+static volatile short array[] = {-1, -2, -3, -4};
+#define USDT_SIB_ARG_SPEC -2@(%%rdx,%%rax,2)
+#endif
+
 static volatile int idx = 2;
 static volatile __u64 bla = 0xFEDCBA9876543210ULL;
 static volatile short nums[] = {-1, -2, -3, -4};
@@ -25,6 +45,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
 unsigned short test_usdt3_semaphore SEC(".probes");
 unsigned short test_usdt12_semaphore SEC(".probes");
 
+#if defined(__x86_64__) || defined(__i386__)
+unsigned short test_usdt_sib_semaphore SEC(".probes");
+#endif
+
 static void __always_inline trigger_func(int x) {
 	long y = 42;
 
@@ -40,12 +64,27 @@ static void __always_inline trigger_func(int x) {
 	}
 }
 
+#if defined(__x86_64__) || defined(__i386__)
+static void trigger_sib_spec(void)
+{
+	/* Base address + offset + (index * scale) */
+	/* Force SIB addressing with inline assembly */
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
@@ -59,20 +98,29 @@ static void subtest_basic_usdt(void)
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
+								0 /*self*/, "/proc/self/exe",
+								"test", "usdt_sib", &opts);
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
@@ -156,6 +204,16 @@ static void subtest_basic_usdt(void)
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
index 096488f47fbc..63db72253316 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -107,4 +107,36 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
 	return 0;
 }
 
+
+int usdt_sib_called;
+u64 usdt_sib_cookie;
+int usdt_sib_arg_cnt;
+int usdt_sib_arg_ret;
+u64 usdt_sib_arg;
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


