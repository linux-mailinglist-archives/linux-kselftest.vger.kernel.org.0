Return-Path: <linux-kselftest+bounces-43756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E0BFBA80
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 13:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 741054EEF5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFE33DEC5;
	Wed, 22 Oct 2025 11:34:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99530CDB6;
	Wed, 22 Oct 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132884; cv=none; b=Ia3D+jJLNBufi4wJZrgQ/ctIs9FTJUBZkLddgD8mT8ZOo9FfP//uJuVGLLCU3wNzJdh5uB+Zhn6UgmZIhp4ObChQmbC+pmfm08GJLNnhGqj92ZeUtbTYKWZaySBLg/u/+lmuHEyJDs7kni5SKnqo8QjQT6vJg+b525hgSh7MNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132884; c=relaxed/simple;
	bh=EFLTxYn/t3qvVUjg05TyQt+35aYS6vx75JWI4UEGH6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB6Egu6RLQxcFfuwqF9PUa6xHhpvO1+8+0XzyjoOFqHMMB6k3WCFKfWFFc6VYgIM1OHeqPhEwgX4zSeFeDLmgj4GOP3Qwq22Z73uwSJHzxgzZ+WjsExCqp3utvx94OHVgSQUPTN7HS/dVlwXm68AtpYo5fwcoQq2phIkXunsRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id BBA718B2A0E; Wed, 22 Oct 2025 19:34:41 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add selftests for context detection kfuncs
Date: Wed, 22 Oct 2025 19:33:33 +0800
Message-ID: <20251022113412.352307-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022113412.352307-1-jiayuan.chen@linux.dev>
References: <20251022113412.352307-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the newly introduced context detection kfuncs.

The tests verify that each kfunc correctly identifies its respective
execution context by triggering different contexts

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../selftests/bpf/prog_tests/context.c        | 32 ++++++++++++++++++
 .../selftests/bpf/progs/context_prog.c        | 33 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/context.c
 create mode 100644 tools/testing/selftests/bpf/progs/context_prog.c

diff --git a/tools/testing/selftests/bpf/prog_tests/context.c b/tools/testing/selftests/bpf/prog_tests/context.c
new file mode 100644
index 000000000000..f09d24069941
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/context.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <error.h>
+#include <test_progs.h>
+#include "context_prog.skel.h"
+
+void test_context(void)
+{
+	struct context_prog *skel = NULL;
+
+	skel = context_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "loading prog fail"))
+		return;
+
+	context_prog__attach(skel);
+	getuid();
+	sleep(5);
+
+	if (!ASSERT_EQ(1, skel->bss->in_hardirq, "hardirq not triggered"))
+		goto out;
+	if (!ASSERT_EQ(1, skel->bss->in_softriq, "softirq not triggered"))
+		goto out;
+	if (!ASSERT_EQ(1, skel->bss->in_task, "task context not triggered"))
+		goto out;
+out:
+	context_prog__destroy(skel);
+}
+
+void test_bpf_context(void)
+{
+	if (test__start_subtest("context"))
+		test_context();
+}
diff --git a/tools/testing/selftests/bpf/progs/context_prog.c b/tools/testing/selftests/bpf/progs/context_prog.c
new file mode 100644
index 000000000000..81e21f684a84
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/context_prog.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+int in_hardirq = 0;
+int in_softriq = 0;
+int in_task = 0;
+
+SEC("tp/irq/irq_handler_entry")
+int trace_irq_handler_entry(const void *ctx)
+{
+	in_hardirq = bpf_in_hardirq_context();
+	return 0;
+}
+
+SEC("tp/irq/softirq_entry")
+int trace_softirq_entry(const void *ctx)
+{
+	in_softriq = bpf_in_softirq_context();
+	return 0;
+}
+
+SEC("tp/syscalls/sys_enter_getuid")
+int trace_syscall(const void *ctx)
+{
+	in_task = bpf_in_task_context();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


