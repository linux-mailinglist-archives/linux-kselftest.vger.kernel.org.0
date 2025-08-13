Return-Path: <linux-kselftest+bounces-38862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B29B24D6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C797BDB06
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADE272814;
	Wed, 13 Aug 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqrBM+4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127442727E0
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Aug 2025 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099051; cv=none; b=MABOydeWkwbG/IhS81j/XPOEkzrErJagoeRe+xTsmobADYFNnolvBb9GFRHifPmCR3meVmas0w6eLA72HAj1BPziMJkR5vOt8y3xnwVtb1UXC7JviYaSOkED67tQQK3/Dtq9CPjMxPhRUnUmm/XbsoRfJ+tnCFnKa9Jzx7X+sAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099051; c=relaxed/simple;
	bh=oBpG2Njdb/3sUKn2TUNTKNLeUonqd8QmP93MjbKGHbw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4tIWtl3QPGqVVD45no3lGqwdPHUUakJXYY21bYxvKitJq6YGeQo/D4gOw5w3xB4ikRFL4NTeqWDwXtMXaO2mM3J/v8rm6mB0/V85tarbcdel8pLA1yEJheIbidKCzi1lY1YKiMPH/w/PQL6XjjVzWX0fEJEYQgRtunDwB633VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqrBM+4r; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755099046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dg4Vf15U+E3Og15w4aN3q+dU4EFzVNfYMRDLB+8UxmM=;
	b=RqrBM+4rmnd7f7csAuy8+jSFgCq4RPvj3YzfAYTrYT19w8YqLd0wETIOIXqbB0VW5R2n6e
	nNj73wPxbzpzwRfzhbPjXw3SU5kCG8znJgh927XNgi/1O1/zdyC6AJiTgFwKacWxk5EcRN
	yyvz8SSRlDvkUhFP8tgAy6qVWPBhPmk=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	mrpre@163.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add socket filter attach test
Date: Wed, 13 Aug 2025 23:29:58 +0800
Message-ID: <20250813152958.3107403-3-kafai.wan@linux.dev>
In-Reply-To: <20250813152958.3107403-1-kafai.wan@linux.dev>
References: <20250813152958.3107403-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This test verifies socket filter attachment functionality on architectures
supporting either BPF JIT compilation or the interpreter.

It specifically validates the fallback to interpreter behavior when JIT fails,
particularly targeting ARMv6 devices with the following configuration:
  # CONFIG_BPF_JIT_ALWAYS_ON is not set
  CONFIG_BPF_JIT_DEFAULT_ON=y

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/prog_tests/socket_filter.c  | 124 ++++++++++++++++++
 .../selftests/bpf/progs/socket_filter.c       |  16 +++
 2 files changed, 140 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/socket_filter.c
 create mode 100644 tools/testing/selftests/bpf/progs/socket_filter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_filter.c b/tools/testing/selftests/bpf/prog_tests/socket_filter.c
new file mode 100644
index 000000000000..ee3a4cc1a992
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/socket_filter.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/utsname.h>
+#include <uapi/linux/filter.h>
+#include "socket_filter.skel.h"
+
+static int duration;
+
+void do_test(void)
+{
+	/* the filter below is the tcpdump filter:
+	 * tcpdump "not ether host 3c37121a2b3c and not ether host 184ecbca2a3a \
+	 * and not ether host 14130b4d3f47 and not ether host f0f61cf440b7 \
+	 * and not ether host a84b4dedf471 and not ether host d022be17e1d7 \
+	 * and not ether host 5c497967208b and not ether host 706655784d5b"
+	 */
+	struct sock_filter code[] = {
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x121a2b3c },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 60,  0, 0x00003c37 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0x121a2b3c },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 56,  0, 0x00003c37 },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0xcbca2a3a },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 52,  0, 0x0000184e },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0xcbca2a3a },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 48,  0, 0x0000184e },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x0b4d3f47 },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 44,  0, 0x00001413 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0x0b4d3f47 },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 40,  0, 0x00001413 },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x1cf440b7 },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 36,  0, 0x0000f0f6 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0x1cf440b7 },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 32,  0, 0x0000f0f6 },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x4dedf471 },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 28,  0, 0x0000a84b },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0x4dedf471 },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 24,  0, 0x0000a84b },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0xbe17e1d7 },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 20,  0, 0x0000d022 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0xbe17e1d7 },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15, 16,  0, 0x0000d022 },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x7967208b },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15, 12,  0, 0x00005c49 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  2, 0x7967208b },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15,  8,  0, 0x00005c49 },
+		{ 0x20,  0,  0, 0x00000008 },
+		{ 0x15,  0,  2, 0x55784d5b },
+		{ 0x28,  0,  0, 0x00000006 },
+		{ 0x15,  4,  0, 0x00007066 },
+		{ 0x20,  0,  0, 0x00000002 },
+		{ 0x15,  0,  3, 0x55784d5b },
+		{ 0x28,  0,  0, 0x00000000 },
+		{ 0x15,  0,  1, 0x00007066 },
+		{ 0x06,  0,  0, 0x00000000 },
+		{ 0x06,  0,  0, 0x00040000 },
+	};
+	struct sock_fprog bpf = {
+		.len = ARRAY_SIZE(code),
+		.filter = code,
+	};
+	int ret, sock = 0;
+
+	sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (CHECK(sock < 0, "create socket", "errno %d\n", errno))
+		return;
+
+	ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
+	CHECK(ret < 0, "attach filter", "errno %d\n", errno);
+
+	close(sock);
+}
+
+void test_socket_filter(void)
+{
+	struct socket_filter *skel;
+	struct utsname uts;
+	int err;
+
+	err = uname(&uts);
+	if (err < 0)
+		return;
+
+	skel = socket_filter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	/* The filter JIT fails on armv6 */
+	if (strncmp(uts.machine, "armv6", strlen("armv6")) == 0 &&
+	    skel->kconfig->CONFIG_BPF_JIT_ALWAYS_ON)
+		test__skip();
+	else
+		do_test();
+
+	socket_filter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/socket_filter.c b/tools/testing/selftests/bpf/progs/socket_filter.c
new file mode 100644
index 000000000000..f93623ec7ec0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/socket_filter.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern bool CONFIG_BPF_JIT_ALWAYS_ON __kconfig __weak;
+
+/* This function is here to have CONFIG_BPF_JIT_ALWAYS_ON
+ * used and added to object BTF.
+ */
+int unused(void)
+{
+	return CONFIG_BPF_JIT_ALWAYS_ON ? 0 : 1;
+}
-- 
2.43.0


