Return-Path: <linux-kselftest+bounces-39694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFFB31E6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED93B44D50
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81F23D7C6;
	Fri, 22 Aug 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PWl6d5HX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A31221254F;
	Fri, 22 Aug 2025 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875827; cv=none; b=iulj9A/w7hoAMkgtWvMTxxLKZrvg4KhwIlNadiA+NsILZuU0PSBV6U3uJyvEALX9Hc3SKyxGP+GqxyLGm9FlFy+VogcqWy4iK84OJqh8Wxbw/fX+SkdKvPJxd4IySWbG1Zl8NKCCFAv4x+34FXZ910YevhhI9IaMkAvBENMz7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875827; c=relaxed/simple;
	bh=DYIv+8O47AgXECoNN0D9qxENXd43XygJabRYMi9Zf2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKQVNAH/xYbA1Ja7TIdbpVsIZLqbTEPVjZ5LSRLXTt/z6w7uHDrdoTSELnTPl38Ruu0lbS+HXSbaUbSOe/Pe1bnD1u/vs3eN/QxVYKVIJBqLaWSXLImIuLpHFqgfx6HVflMbW2tGWFBdeS3FBtZpWpygvAeqt6n927GzYoM29ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PWl6d5HX; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2M
	64p6PzM6E+Ful7zBk13hxPItF7DaAAOT0U0YpEi50=; b=PWl6d5HXOioRCGLWcs
	gq/fMlCD+B/WMXWN8nYTj2mf1pG5eNnHw7B+cZnhEpkfJYgteSeJo6lZiwuGR1gD
	/dEu6W7g7WCLC43xGgDwIDoF1V9zAVB3uPMWB2VV6UvLCgCjWmbMkFQiAICLd60p
	bNqGRFrFwgIl+eeVYhbDoGw9E=
Received: from phoenix.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHTfm8iahoidrHAA--.29756S4;
	Fri, 22 Aug 2025 23:16:15 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v13 2/2] selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
Date: Fri, 22 Aug 2025 15:16:11 +0000
Message-ID: <20250822151611.1084244-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822151611.1084244-1-phoenix500526@163.com>
References: <20250822151611.1084244-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBHTfm8iahoidrHAA--.29756S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15Cry3JFW7ZFyfKr17Jrb_yoW7CrWfpa
	ykZ34xtryrt3WxG34fJr4jqw4rKFn2yrW5JFZrXryjvrWkGrs7Xrn7tw13KFnxX3ykX3W5
	ArZ0kan5Kw4xXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFBqxiGiogESwtQAAs2

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


