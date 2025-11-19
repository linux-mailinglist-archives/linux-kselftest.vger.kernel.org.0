Return-Path: <linux-kselftest+bounces-45940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF8C6C441
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E4B332C7EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CA2242D6C;
	Wed, 19 Nov 2025 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rJKJXVPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A72417E6
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516109; cv=none; b=kc9YHC4c+oeQ4Ld/1HrGvUw/0TdPwNOfP7iEczrdjO2qXP1hXFsDj44GUrN+iK4y0NnlonJh7qLs1H4hJBug/YB0uJ/TutCMovJj8WvZHlrkkJhzf01VUdf+A14uvbFXG0N8ahaY4j9/ENDg9m6bk7h/lEByJp+9Y1ovKaoCoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516109; c=relaxed/simple;
	bh=maViTfMIiS5GM7CVEAxKybSytdqSGW1ndoj9TRtUw1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNzbSKbV/bxTJ4kRVCJTV0N1UdgyUBJQWrld9lJeslMo9Bx+8jxbdoz/ayCZZFsEdYGG55EhQacajgL4K+mFmkEGUFZ9m/cBTxUur3R5uL8WDjiX/OHdfQnwV2p4pc2fyqvQWsACiZ3KsKBebVxHB4qQJk4Nm/dfbsted3+Sc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rJKJXVPq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763516106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APzUbJ1xJcLTN15RzI5Lt/FDUDhgt5Fbd2bTLMIMyeQ=;
	b=rJKJXVPqyQq5HjlvFiXrkhuluS7KlJTVwnsZHRW4cmL0e5TInZS9YpTGeQLiVFuBFboxuL
	ynaA07biE0TPd906lyYl19JS1eZgGAw6GuDGTYR+8SWz6fWPft/9epr8XY8KxPK63+d2Wu
	LDoZxauP/e5JFtJEM9a4z7HJVLmupOc=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH 2/3] selftests/bpf: add memcg eBPF struct ops test
Date: Wed, 19 Nov 2025 09:34:07 +0800
Message-ID: <0017945a4297a296c87a65d62cc4bd9948f6c20c.1763457705.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1763457705.git.zhuhui@kylinos.cn>
References: <cover.1763457705.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Add comprehensive selftest suite for memory controller eBPF
support. The tests validate the core functionality of the
memcg_ops struct ops implementation.

Test coverage includes:

1. test_memcg_ops_load: Validates that the eBPF object file
   can be successfully loaded by libbpf.

2. test_memcg_ops_attach: Tests attaching the memcg_ops struct
   ops to the kernel, verifying the basic attachment mechanism
   works correctly.

3. test_memcg_ops_double_attach: Validates that only one
   memcg_ops instance can be attached at a time. Attempts to
   attach a second program should fail, ensuring the
   single-handler design constraint is enforced.

The test suite includes:

- prog_tests/memcg_ops.c: Test entry point with individual
  test functions using standard BPF test framework helpers
  like ASSERT_OK_PTR and ASSERT_ERR_PTR
- progs/memcg_ops.bpf.c: Simple eBPF program implementing
  the struct ops interface

Uses standard test_progs framework macros for consistent error
reporting and handling. All tests properly clean up resources
in error paths.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                                   |   1 +
 .../selftests/bpf/prog_tests/memcg_ops.c      | 117 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c |  20 +++
 3 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 498d01c9a48e..dc3aa53d2346 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6356,6 +6356,7 @@ F:	mm/memcontrol_bpf.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
+F:	tools/testing/selftests/bpf/*/memcg_ops.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
new file mode 100644
index 000000000000..3f989bcfb8c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory controller eBPF struct ops test
+ */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+void test_memcg_ops_load(void)
+{
+	struct bpf_object *obj;
+	int err;
+
+	obj = bpf_object__open_file("memcg_ops.bpf.o", NULL);
+	err = libbpf_get_error(obj);
+	if (CHECK_FAIL(err)) {
+		obj = NULL;
+		goto out;
+	}
+
+	err = bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+out:
+	if (obj)
+		bpf_object__close(obj);
+}
+
+void test_memcg_ops_attach(void)
+{
+	struct bpf_object *obj;
+	struct bpf_map *map;
+	struct bpf_link *link = NULL;
+	int err;
+
+	obj = bpf_object__open_file("memcg_ops.bpf.o", NULL);
+	err = libbpf_get_error(obj);
+	if (CHECK_FAIL(err)) {
+		obj = NULL;
+		goto out;
+	}
+
+	err = bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	map = bpf_object__find_map_by_name(obj, "mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(map);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+out:
+	if (link)
+		bpf_link__destroy(link);
+	if (obj)
+		bpf_object__close(obj);
+}
+
+void test_memcg_ops_double_attach(void)
+{
+	struct bpf_object *obj, *obj2;
+	struct bpf_map *map, *map2;
+	struct bpf_link *link = NULL, *link2 = NULL;
+	int err;
+
+	obj = bpf_object__open_file("memcg_ops.bpf.o", NULL);
+	err = libbpf_get_error(obj);
+	if (CHECK_FAIL(err)) {
+		obj = NULL;
+		goto out;
+	}
+
+	err = bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	map = bpf_object__find_map_by_name(obj, "mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto out;
+
+	link = bpf_map__attach_struct_ops(map);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto out;
+
+	obj2 = bpf_object__open_file("memcg_ops.bpf.o", NULL);
+	err = libbpf_get_error(obj2);
+	if (CHECK_FAIL(err)) {
+		obj2 = NULL;
+		goto out;
+	}
+
+	err = bpf_object__load(obj2);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	map2 = bpf_object__find_map_by_name(obj2, "mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
+		goto out;
+
+	link2 = bpf_map__attach_struct_ops(map2);
+	if (!ASSERT_ERR_PTR(link2, "bpf_map__attach_struct_ops")) {
+		bpf_link__destroy(link2);
+		goto out;
+	}
+
+out:
+	if (link)
+		bpf_link__destroy(link);
+	if (obj)
+		bpf_object__close(obj);
+	if (obj2)
+		bpf_object__close(obj2);
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_ops.c b/tools/testing/selftests/bpf/progs/memcg_ops.c
new file mode 100644
index 000000000000..a21fbe859fd3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_ops.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/try_charge_memcg")
+int BPF_PROG(test_try_charge_memcg,
+	     struct try_charge_memcg *tcm)
+{
+	return 0;
+}
+
+SEC(".struct_ops")
+struct memcg_ops mcg_ops = {
+	.try_charge_memcg = (void *)test_try_charge_memcg,
+};
-- 
2.43.0


