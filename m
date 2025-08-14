Return-Path: <linux-kselftest+bounces-38976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF1B269A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 16:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB122602E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B356A920;
	Thu, 14 Aug 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o0wqxcXr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA51D321427;
	Thu, 14 Aug 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181095; cv=none; b=LlWO0VuZEE/elZbKkFuEDNXDLV276xGTSazJSgTGjyEgEN1Ayg1J0L7bSzCc0e38wbWQiKeWwXJKPdZRIBLOBVtEwZXMWqnkmkGRuCXNYp2QsZNErbGsUhovan21rWr/XuD43nPbUYXf8qPiCfn+2fUIyCq37mR5KLiKAzOhz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181095; c=relaxed/simple;
	bh=l4RpZEZEyFuGtuV7W4a26EQUDXnqU+r9rXYOKFw33+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at5KR5sdr2UDJUA+o7AKiozd6i8Lzy4X8nA/21FlHJt3D7kUxR39V2A5rxrATFV7tsyC2yup+6Ft0hgijvd3DMpsMpdukMNjQV3foo4HQSmTLIIaIqZ6Nn/cvLDTXZV7/kvm5reisAogcETeYtNeY3chyUihURrt5fVm4jcJ5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o0wqxcXr; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6l
	zJrqnywi6rrLDFjSoml0wlX8+SiyR25gUueMYiFr8=; b=o0wqxcXrbNp84RGFnn
	tal29lcIHl/q3F5XIwcR9jIuKSXH7IOMBQMUT7TzRW7OI2z2Bgyc3Js6liWzXXTT
	UUbAZAwyWIQMpjVrreUagouUScAeqQJb1O5A5rTHs9YcM19wLi3v71Dh5vDfLExw
	zLnMipUswsQO0ptSC4fqce/vM=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAXt8QG8J1otxnOBw--.45910S4;
	Thu, 14 Aug 2025 22:17:45 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 2/3] selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB handling logic
Date: Thu, 14 Aug 2025 14:17:39 +0000
Message-ID: <20250814141741.77698-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814141741.77698-1-phoenix500526@163.com>
References: <20250814141741.77698-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXt8QG8J1otxnOBw--.45910S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktF4fAF15uFyUZw1UKFg_yoWrtrW5pa
	48X348KFWIqF13K3Wftr4Utr4rKanayrW8JFykXryavr48JryIqr1xKr17tasxG395XF1r
	A39xtan8Gr48JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg4SOUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAupiGid6YWhYwAAsx

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- add usdt_o2 test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../selftests/bpf/prog_tests/usdt_o2.c        | 69 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..24ff1a329625 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -760,6 +760,7 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
+
 # Define test_verifier test runner.
 # It is much simpler than test_maps/test_progs and sufficiently different from
 # them (e.g., test.h is using completely pattern), that it's worth just
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
new file mode 100644
index 000000000000..f02dcf5188ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
+#include <test_progs.h>
+
+#include "../sdt.h"
+#include "test_usdt_o2.skel.h"
+
+#if defined(__GNUC__) && !defined(__clang__)
+__attribute__((optimize("O2")))
+#endif
+
+#define test_value 0xFEDCBA9876543210ULL
+#define SEC(name) __attribute__((section(name), used))
+
+int lets_test_this(int);
+static volatile __u64 array[1] = {test_value};
+
+static __always_inline void trigger_func(void)
+{
+	/* Base address + offset + (index * scale) */
+	for (volatile int i = 0; i <= 0; i++)
+		STAP_PROBE1(test, usdt1, array[i]);
+}
+
+static void basic_sib_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt_o2 *skel;
+	struct test_usdt_o2__bss *bss;
+	int err;
+
+	skel = test_usdt_o2__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_usdt_o2__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* usdt1 won't be auto-attached */
+	opts.usdt_cookie = 0xcafedeadbeeffeed;
+	skel->links.usdt1 = bpf_program__attach_usdt(skel->progs.usdt1,
+						     0 /*self*/, "/proc/self/exe",
+						     "test", "usdt1", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt1, "usdt1_link"))
+		goto cleanup;
+
+	trigger_func();
+
+	ASSERT_EQ(bss->usdt1_called, 1, "usdt1_called");
+	ASSERT_EQ(bss->usdt1_cookie, 0xcafedeadbeeffeed, "usdt1_cookie");
+	ASSERT_EQ(bss->usdt1_arg_cnt, 1, "usdt1_arg_cnt");
+	ASSERT_EQ(bss->usdt1_arg, test_value, "usdt1_arg");
+	ASSERT_EQ(bss->usdt1_arg_ret, 0, "usdt1_arg_ret");
+	ASSERT_EQ(bss->usdt1_arg_size, sizeof(array[0]), "usdt1_arg_size");
+
+cleanup:
+	test_usdt_o2__destroy(skel);
+}
+
+
+
+void test_usdt_o2(void)
+{
+	basic_sib_usdt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_o2.c b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
new file mode 100644
index 000000000000..14602aa54578
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+int my_pid;
+
+int usdt1_called;
+u64 usdt1_cookie;
+int usdt1_arg_cnt;
+int usdt1_arg_ret;
+u64 usdt1_arg;
+int usdt1_arg_size;
+
+SEC("usdt")
+int usdt1(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt1_called, 1);
+
+	usdt1_cookie = bpf_usdt_cookie(ctx);
+	usdt1_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt1_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
+	usdt1_arg = (u64)tmp;
+	usdt1_arg_size = bpf_usdt_arg_size(ctx, 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


