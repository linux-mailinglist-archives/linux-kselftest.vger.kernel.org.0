Return-Path: <linux-kselftest+bounces-45941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98809C6C447
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6FC9B2CA20
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AAD25B1DA;
	Wed, 19 Nov 2025 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l0cWAGhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7F253F07
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516119; cv=none; b=jwULHdWjKvAOarR3OltA6NOsyg8HNOA39DBOLy57ZJH12fLHutcpYfbYeb3plW7oeJlS5Y43218MKkm5ZuNYsM17HUTExMmovYyvuU4fpKkW+jhqkTJii276AzDUE3RYdAhOfY+aTeCAtNCgble3FXTLx2jP18CiAmhjsMpb9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516119; c=relaxed/simple;
	bh=H4Zz7btA0ifGQ9ra42hl+F8evJJdL9ebClQBIpnOkAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLD7c7FK6VsL7G0BuNzMf3O5aPJtMQwOtY8s8MUSofUpspdvmteeywyA37Vjke5OxVAKj4Ng5LpPfJPtlRyuTOV26jMK5Xe9OE2+0Pk+fLCWhyxKSevmblUpUojR1rBwXOUExwMd5JHZDgC4VqXR6RmobQiBGRfann/5KLYo4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l0cWAGhd; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763516115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8dIlCkeLmHRvfs6fUIYZ7yvGZoAG1TWr2WBwtR6cnw=;
	b=l0cWAGhdWRSC8NfGk4eXSNApKMWN/6jjT/zXj8aYwETERhPKAqw9nf91LKUUVCqiLM+fkK
	mo4lHL3jkthGa0LDFfBd+OXsWrDEQ5bR89bznO6SIPCzUQ0onQosC6w5/0FCn1sjQRk8+Q
	WrAPWxSBABrvy+tLp1sJdnXMjrEnfmM=
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
Subject: [RFC PATCH 3/3] samples/bpf: add example memcg eBPF program
Date: Wed, 19 Nov 2025 09:34:08 +0800
Message-ID: <b470e1e2e3c1baa97a7bc6637863b3f52336ebb1.1763457705.git.zhuhui@kylinos.cn>
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

Add a sample eBPF program demonstrating the new memory
controller eBPF support. This example serves as both a reference
implementation and a validation tool for the memcg eBPF
functionality.

The sample includes:

- memcg_printk.bpf.c: An eBPF program that attaches to the
  try_charge_memcg hook and prints detailed information about
  memory charging events, including:
  * Memory cgroup name
  * GFP flags and page count
  * Reclamation options
  * Affected memory cgroup (when applicable)

- memcg_printk.c: A userspace loader program that:
  * Loads the eBPF object file
  * Finds and attaches the memcg_ops struct ops
  * Keeps the program attached until interrupted
  * Provides proper error handling and cleanup

Usage:
  $ ./samples/bpf/memcg_printk

This will attach the eBPF program to the memcg charging path.
Output can be viewed via kernel trace events (e.g.,
trace_printk logs).

The program demonstrates:
- Accessing memory cgroup context fields
- Using bpf_printk for debugging and monitoring
- Proper struct ops registration via libbpf
- Integration with the kernel's BPF infrastructure

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                    |  2 +
 samples/bpf/Makefile           |  2 +
 samples/bpf/memcg_printk.bpf.c | 30 +++++++++++++
 samples/bpf/memcg_printk.c     | 82 ++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 samples/bpf/memcg_printk.bpf.c
 create mode 100644 samples/bpf/memcg_printk.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dc3aa53d2346..c8f32f7dad3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6356,6 +6356,8 @@ F:	mm/memcontrol_bpf.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
+F:	samples/memcg_printk.bpf.c
+F:	samples/memcg_printk.c
 F:	tools/testing/selftests/bpf/*/memcg_ops.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 95a4fa1f1e44..d50e958fc8d5 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -37,6 +37,7 @@ tprogs-y += xdp_fwd
 tprogs-y += task_fd_query
 tprogs-y += ibumad
 tprogs-y += hbm
+tprogs-y += memcg_printk
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -122,6 +123,7 @@ always-y += task_fd_query_kern.o
 always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
+always-y += memcg_printk.bpf.o
 
 COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)
 TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
diff --git a/samples/bpf/memcg_printk.bpf.c b/samples/bpf/memcg_printk.bpf.c
new file mode 100644
index 000000000000..66c87bf4cbcb
--- /dev/null
+++ b/samples/bpf/memcg_printk.bpf.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("struct_ops/try_charge_memcg")
+int BPF_PROG(handle_try_charge_memcg, struct try_charge_memcg *tcm)
+{
+	bpf_printk(
+		"memcg %s gfp_mask 0x%x nr_pages %lu reclaim_options 0x%lx\n",
+		tcm->memcg->css.cgroup->kn->name,
+		tcm->gfp_mask,
+		tcm->nr_pages,
+		tcm->reclaim_options);
+	if (!tcm->charge_done)
+		bpf_printk("memcg %s mem_over_limit %s\n",
+			   tcm->memcg->css.cgroup->kn->name,
+			   tcm->mem_over_limit->css.cgroup->kn->name);
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct memcg_ops mcg_ops = {
+	.try_charge_memcg = (void *)handle_try_charge_memcg,
+};
+
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/memcg_printk.c b/samples/bpf/memcg_printk.c
new file mode 100644
index 000000000000..a2c5be2415ea
--- /dev/null
+++ b/samples/bpf/memcg_printk.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <signal.h>
+#include <bpf/libbpf.h>
+
+static bool exiting;
+
+static void sig_handler(int sig)
+{
+	exiting = true;
+}
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	return vfprintf(stderr, format, args);
+}
+
+int main(int argc, char **argv)
+{
+	struct bpf_object *obj = NULL;
+	struct bpf_link *link = NULL;
+	struct bpf_map *map;
+	char filename[256];
+	int err;
+
+	exiting = false;
+
+	signal(SIGINT, sig_handler);
+	signal(SIGTERM, sig_handler);
+
+	libbpf_set_print(libbpf_print_fn);
+
+	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
+	obj = bpf_object__open_file(filename, NULL);
+	err = libbpf_get_error(obj);
+	if (err) {
+		fprintf(stderr, "Failed to open BPF object file: %d\n",
+			err);
+		obj = NULL;
+		goto cleanup;
+	}
+
+	err = bpf_object__load(obj);
+	if (err) {
+		fprintf(stderr, "Failed to loading BPF object file: %d\n",
+			err);
+		goto cleanup;
+	}
+
+	map = bpf_object__find_map_by_name(obj, "mcg_ops");
+	if (!map) {
+		fprintf(stderr, "Failed to find struct_ops map 'mcg_ops'\n");
+		err = -ENOENT;
+		goto cleanup;
+	}
+
+	link = bpf_map__attach_struct_ops(map);
+	err = libbpf_get_error(link);
+	if (err) {
+		fprintf(stderr, "Failed to attach struct ops: %d\n",
+			err);
+		link = NULL;
+		goto cleanup;
+	}
+
+	printf("Press Ctrl+C to exit...\n");
+
+	while (!exiting)
+		sleep(1);
+
+	printf("Bye!\n");
+
+cleanup:
+	if (link)
+		bpf_link__destroy(link);
+	if (obj)
+		bpf_object__close(obj);
+
+	return err;
+}
-- 
2.43.0


