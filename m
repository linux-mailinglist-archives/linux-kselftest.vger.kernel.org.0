Return-Path: <linux-kselftest+bounces-13342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4A92AD76
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C5E282A0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 01:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D792746F;
	Tue,  9 Jul 2024 01:00:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84924B4A;
	Tue,  9 Jul 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486814; cv=none; b=ZIYyVTlw2zxTxrXr6BXN5pjPcQUuW6MZL8N5rFyXLPWRtj6qaZUwz/UgZuIY3NqTFQOMcHBT+4GXuhWTCGRi6dUFcYPiOh7OjQuVP7V9F8XIdGxjBooBtweTj7evIZmqGVv+OoMn0N6xxeLRV2J9yqd7JI3eLv7BQIyMgT+P7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486814; c=relaxed/simple;
	bh=f8u+3jaw5EtE3CvyeAy6cdqI83Y22LA9WRWr9WpaZis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA2L/oodORMgUKlyd1rq6VrBn5ZxwVtWMIoHxvDOyNbjUqj9CrHu6HSJUyEZv3f0pleIKZgJ8iX4GEc6IUnSRr+8r8K/TOpH6z1riNr2X08xwahXjNOD3MPmgebpkQ9sAebKsyqeiKjBQKzJ1Zpw5K5Ct6Re4WJU8ujKYxxLqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WJ2bM4G4yz1T5q7;
	Tue,  9 Jul 2024 08:55:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4173F1402E1;
	Tue,  9 Jul 2024 09:00:08 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 9 Jul
 2024 09:00:07 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <mykolal@fb.com>, <shuah@kernel.org>,
	<liaochang1@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 2/2] selftests/bpf: Add uretprobe test for return_instance management
Date: Tue, 9 Jul 2024 00:51:42 +0000
Message-ID: <20240709005142.4044530-3-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709005142.4044530-1-liaochang1@huawei.com>
References: <20240709005142.4044530-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

This patch add three testcases to verify the proper management of
return_instance data by uretprobes:

- uretprobe_longjmp() verifies that longjmp() bypasses the uretprobe BPF
  program attached to the exit of instrumented function.

- uretprobe_cleanup_return_instance() verifies that uretprobe reclaim
  the return_instances data created before a longjmp(), which leads to
  kernel recount the nested depth of instrumented function.

- uretprobe_reach_nestedness_limit() confirms that the uretprobe doesn't
  reclaim the return_instances data created before longjmp() and hijack
  the return address of instrumented function upon the nestedness depth
  reache the limits (64).

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 .../bpf/prog_tests/uretprobe_depth.c          | 150 ++++++++++++++++++
 .../selftests/bpf/progs/uretprobe_depth.c     |  19 +++
 2 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uretprobe_depth.c
 create mode 100644 tools/testing/selftests/bpf/progs/uretprobe_depth.c

diff --git a/tools/testing/selftests/bpf/prog_tests/uretprobe_depth.c b/tools/testing/selftests/bpf/prog_tests/uretprobe_depth.c
new file mode 100644
index 000000000000..ba03b1868e37
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uretprobe_depth.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include <unistd.h>
+#include <setjmp.h>
+#include <asm/ptrace.h>
+#include <linux/compiler.h>
+#include <linux/stringify.h>
+#include "uretprobe_depth.skel.h"
+
+#define RETVAL			0xFFFF
+#define JMPVAL			0x4B1D
+#define MAX_URETPROBE_DEPTH	64 // See include/linux/uprobes.h
+#define NR_OMITTED_URETPROBE	16
+static jmp_buf jmp;
+
+unsigned long __uretprobe_longjmp(int nest, int jmpval, int retval)
+{
+	if (nest) {
+		nest = ++retval < MAX_URETPROBE_DEPTH + NR_OMITTED_URETPROBE;
+		return __uretprobe_longjmp(nest, jmpval, retval);
+	}
+
+	if (jmpval == JMPVAL) {
+		longjmp(jmp, jmpval);
+		return 0;
+	} else
+		return retval;
+}
+
+static void uretprobe_longjmp(void)
+{
+	if (setjmp(jmp) == JMPVAL) {
+		__uretprobe_longjmp(0, 0, JMPVAL);
+		return;
+	}
+
+	__uretprobe_longjmp(0, JMPVAL, RETVAL);
+}
+
+static void uretprobe_cleanup_return_instances(void)
+{
+	if (setjmp(jmp) == JMPVAL) {
+		/*
+		 * Cleanup these return instance data created before longjmp
+		 * firstly. Then create 16 new return_instance data from here.
+		 */
+		__uretprobe_longjmp(1, 0, MAX_URETPROBE_DEPTH);
+		return;
+	}
+
+	/* Create 8 return_instance data from here. */
+	__uretprobe_longjmp(1, JMPVAL,
+			    MAX_URETPROBE_DEPTH + NR_OMITTED_URETPROBE / 2);
+}
+
+static void uretprobe_reach_nestedness_limit(void)
+{
+	if (setjmp(jmp) == JMPVAL) {
+		/*
+		 * Due to uretprobe reach to the nestedness limit, it doesn't
+		 * cleanup the return instance created before longjmp.
+		 */
+		__uretprobe_longjmp(1, 0, MAX_URETPROBE_DEPTH);
+		return;
+	}
+
+	/* Create 64 return_instance from here. */
+	__uretprobe_longjmp(1, JMPVAL, 0);
+}
+
+static void test_uretprobe_longjmp(void)
+{
+	struct uretprobe_depth *skel = NULL;
+	int err;
+
+	skel = uretprobe_depth__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uretprobe_depth__open_and_load"))
+		goto cleanup;
+
+	err = uretprobe_depth__attach(skel);
+	if (!ASSERT_OK(err, "uretprobe_depth__attach"))
+		goto cleanup;
+
+	skel->bss->retval = -1;
+
+	uretprobe_longjmp();
+
+	ASSERT_EQ(skel->bss->retval, JMPVAL, "return value");
+
+cleanup:
+	uretprobe_depth__destroy(skel);
+}
+
+static void test_uretprobe_reach_nestedness_limit(void)
+{
+	struct uretprobe_depth *skel = NULL;
+	int err;
+
+	skel = uretprobe_depth__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uretprobe_depth__open_and_load"))
+		goto cleanup;
+
+	err = uretprobe_depth__attach(skel);
+	if (!ASSERT_OK(err, "uretprobe_depth__attach"))
+		goto cleanup;
+
+	skel->bss->depth = 0;
+
+	uretprobe_reach_nestedness_limit();
+
+	ASSERT_EQ(skel->bss->depth, 0, "nest depth");
+
+cleanup:
+	uretprobe_depth__destroy(skel);
+}
+
+static void test_uretprobe_cleanup_return_instances(void)
+{
+	struct uretprobe_depth *skel = NULL;
+	int err;
+
+	skel = uretprobe_depth__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uretprobe_depth__open_and_load"))
+		goto cleanup;
+
+	err = uretprobe_depth__attach(skel);
+	if (!ASSERT_OK(err, "uretprobe_depth__attach"))
+		goto cleanup;
+
+	skel->bss->depth = 0;
+
+	uretprobe_cleanup_return_instances();
+
+	ASSERT_EQ(skel->bss->depth, NR_OMITTED_URETPROBE + 1, "nest depth");
+
+cleanup:
+	uretprobe_depth__destroy(skel);
+}
+
+void test_uretprobe_return_instance(void)
+{
+	if (test__start_subtest("uretprobe_longjmp"))
+		test_uretprobe_longjmp();
+	if (test__start_subtest("uretprobe_cleanup_return_instances"))
+		test_uretprobe_cleanup_return_instances();
+	if (test__start_subtest("uretprobe_reach_nestedness_limit"))
+		test_uretprobe_reach_nestedness_limit();
+}
diff --git a/tools/testing/selftests/bpf/progs/uretprobe_depth.c b/tools/testing/selftests/bpf/progs/uretprobe_depth.c
new file mode 100644
index 000000000000..b71f2de52b5e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uretprobe_depth.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <string.h>
+
+int depth;
+unsigned long retval;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("uretprobe//proc/self/exe:__uretprobe_longjmp")
+int uretprobe(struct pt_regs *ctx)
+{
+	depth++;
+#if defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+	retval = ctx->regs[0];
+#endif
+	return 0;
+}
-- 
2.34.1


