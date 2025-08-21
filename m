Return-Path: <linux-kselftest+bounces-39521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19DAB2FED4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E16D644878
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FDE33A016;
	Thu, 21 Aug 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F4NVOt5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943D9338F29;
	Thu, 21 Aug 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790077; cv=none; b=IjhwZexgkOk4sQdwnl9ZZhOXxWQQko8MEYKXpo0KqyDtnoxm/C8SITGkLC40fm67J3txN+fQlXttPU7bQ3tJLOQzxGuIajNK0rTPBdcwREjOMiLF5aurGsNEyWZjVBqkFLttxf6G7blrIcrh6Z8Dzo50HLrqgsPRmD14Yr625wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790077; c=relaxed/simple;
	bh=DYIv+8O47AgXECoNN0D9qxENXd43XygJabRYMi9Zf2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsYTdRlxUtoNQc3f+k9vdo+pWwTN8Ueay/s1bEGNJhflAw8ZfF7wwN4fJ6TX/hAQkLe6uHMJIja+Pqyr61M3unIXpY5OS1cA/C5hHg8CsyGxlgbRGr6IDGkafuudixalaQcKkFgLvJMy5Y3GUwN28Aa9fK0I3OV/SINfTHQttHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F4NVOt5l; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2M
	64p6PzM6E+Ful7zBk13hxPItF7DaAAOT0U0YpEi50=; b=F4NVOt5lbRNxtZSMkm
	C/apxh+REHsK9QkI+Nwn8WLDs+U0mk/sgegx6gy8SFxd43/CQqAorm/7gZcKt2NN
	yWWjq4hunEUv1azE3TZcLt+8XuCQtOmQeb0u7dEf6Vwf2eci/BMySXA5RyHxJn0s
	p2RMI2IGxH4y7me/HCIaBi7Wk=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnLGHROqdon1G_DQ--.32608S4;
	Thu, 21 Aug 2025 23:27:16 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 2/2] selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
Date: Thu, 21 Aug 2025 15:27:12 +0000
Message-ID: <20250821152713.1024982-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821152713.1024982-1-phoenix500526@163.com>
References: <20250821152713.1024982-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnLGHROqdon1G_DQ--.32608S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15Cry3JFW7ZFyfKr17Jrb_yoW7CrWfpa
	ykZ34xtryrt3WxG34fJr4jqw4rKFn2yrW5JFZrXryjvrWkGrs7Xrn7tw13KFnxX3ykX3W5
	ArZ0kan5Kw4xXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFAGwiGinMrOWNQAAsA

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- enrich subtest_basic_usdt test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 44 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_usdt.c | 30 +++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 9057e983cc54..c04b416aa4a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -25,6 +25,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
 unsigned short test_usdt3_semaphore SEC(".probes");
 unsigned short test_usdt12_semaphore SEC(".probes");
 
+#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && !defined(__clang__))
+unsigned short test_usdt_sib_semaphore SEC(".probes");
+#endif
+
 static void __always_inline trigger_func(int x) {
 	long y = 42;
 
@@ -40,12 +44,29 @@ static void __always_inline trigger_func(int x) {
 	}
 }
 
+#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && !defined(__clang__))
+static __attribute__((optimize("O1"))) void trigger_sib_spec(void)
+{
+	/* Base address + offset + (index * scale) */
+	/* Force SIB addressing with inline assembly */
+	asm volatile(
+		"# probe point with memory access\n"
+		STAP_PROBE_ASM(test, usdt_sib, -2@(%%rdx,%%rax,2))
+		"# end probe point"
+		:
+		: "d"(nums), "a"(0)
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
@@ -59,20 +80,29 @@ static void subtest_basic_usdt(void)
 		goto cleanup;
 
 	/* usdt0 won't be auto-attached */
-	opts.usdt_cookie = 0xcafedeadbeeffeed;
+	opts.usdt_cookie = expected_cookie;
 	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
 						     0 /*self*/, "/proc/self/exe",
 						     "test", "usdt0", &opts);
 	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
 		goto cleanup;
 
+#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && !defined(__clang__))
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
@@ -156,6 +186,16 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
 	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
 
+#if ((defined(__x86_64__) || defined(__i386__)) && defined(__GNUC__) && !defined(__clang__))
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
index 096488f47fbc..b5f883bca66b 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -107,4 +107,34 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
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
+// Note: usdt_sib is only tested on x86-related architectures, so it requires
+// manual attach since auto-attach will panic tests under other architectures
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


