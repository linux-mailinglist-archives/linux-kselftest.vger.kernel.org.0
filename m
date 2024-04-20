Return-Path: <linux-kselftest+bounces-8543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD598ABA8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435BA1C20869
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688F47A4C;
	Sat, 20 Apr 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7+VxAqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6EA47772;
	Sat, 20 Apr 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604201; cv=none; b=lhwfkycdIxe1oGZ0Gwe/aH2MtRrDtVAbeEx76puhF9wBnPfezO4XjbPLq9ZnnapCNvdh8P5u6BlHzZmuop9k8HTf18nc9f61kRdTbXBTF690Tja4JUApJOwa2d+0rxaTgGKIocf0fgsXOW6cvxgtZTzpIt4GYa2ILjTZhx7LqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604201; c=relaxed/simple;
	bh=NzXysX/bu2vROgUwAl/lCnfrCjNgBaeqTOkNE3BI0c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dktFahMfSvlB23oRDOxFN+59lWjmgW8OVxVfp8fAK6g58GprD7u8DkPveUtJN8B1/p2YjCuhpYWYLdFKhRElELTQ6N2fxQ7IUf1/I7mU33eiiumCjYBqlQhE10rHTbmAPRBiRT8v7YL/M3EnJH0Ko5TpHVpg9o647OqZOux+zCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7+VxAqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D903CC32781;
	Sat, 20 Apr 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604201;
	bh=NzXysX/bu2vROgUwAl/lCnfrCjNgBaeqTOkNE3BI0c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M7+VxAqZ5MUo0yyOwrxSVHtFKJADcSfGJ8z6TpN71yjsOr1RiI0V698Pn8QwLBHyb
	 4W2vgsmLTYG62kdMlH52Ng+29PIAyRA3+OamlpgNpqGt3XSuWuYOgiaiRLSi5T/qv8
	 THTM/Pz9QM85Qn7CqFKmXzmdxm9iFPHNRCQlZUle9vdTiTRBOZUF1At/tNoF/sWe86
	 vX6sEuX+G0OLk3cAgSN/LsUBJQRuP8FReaj/VTvPoKIWVveji79/vmZNTLz91rW1EE
	 iWZ5HZve61X3LjE8jITqe8KSlLpaTuCjdh61Roa4NH61Jt1M2lBlrQ3iIi0QAOSD/1
	 6c6wWJI94fMcQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:10 +0200
Subject: [PATCH bpf-next v2 10/16] selftests/bpf: add bpf_wq tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-10-6c986a5a741f@kernel.org>
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=3799;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=NzXysX/bu2vROgUwAl/lCnfrCjNgBaeqTOkNE3BI0c0=;
 b=kvTzAaHV8FjqtE8xYDQky1utSZVvL5KxEkcahX8VgReGFMCKmk6vWx6lURfmD5urFoRh5b8aj
 Zyw+21eC95oCoer9ATWU9i6dnbq6hTnCnbYhuRZM0pYRiU8scsMyfcy
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We simply try in all supported map types if we can store/load a bpf_wq.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/bpf/prog_tests/wq.c |  11 +++
 tools/testing/selftests/bpf/progs/wq.c      | 135 ++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
new file mode 100644
index 000000000000..9a07b8bc2c52
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Benjamin Tissoires */
+#include <test_progs.h>
+#include "wq.skel.h"
+
+void serial_test_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	RUN_TESTS(wq);
+}
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
new file mode 100644
index 000000000000..8c668ad04059
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Benjamin Tissoires
+ */
+
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct hmap_elem {
+	int counter;
+	struct bpf_timer timer; /* unused */
+	struct bpf_spin_lock lock; /* unused */
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap_malloc SEC(".maps");
+
+struct elem {
+	struct bpf_wq w;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct elem);
+} lru SEC(".maps");
+
+static int test_elem_callback(void *map, int *key)
+{
+	struct elem init = {}, *val;
+
+	if (map == &lru &&
+	    bpf_map_update_elem(map, key, &init, 0))
+		return -1;
+
+	val = bpf_map_lookup_elem(map, key);
+	if (!val)
+		return -2;
+
+	return 0;
+}
+
+static int test_hmap_elem_callback(void *map, int *key)
+{
+	struct hmap_elem init = {}, *val;
+
+	if (bpf_map_update_elem(map, key, &init, 0))
+		return -1;
+
+	val = bpf_map_lookup_elem(map, key);
+	if (!val)
+		return -2;
+
+	return 0;
+}
+
+SEC("tc")
+/* test that workqueues can be used from an array
+ */
+__retval(0)
+long test_call_array_sleepable(void *ctx)
+{
+	int key = 0;
+
+	return test_elem_callback(&array, &key);
+}
+
+SEC("syscall")
+/* Same test than above but from a sleepable context.
+ */
+__retval(0)
+long test_syscall_array_sleepable(void *ctx)
+{
+	int key = 1;
+
+	return test_elem_callback(&array, &key);
+}
+
+SEC("tc")
+/* test that workqueues can be used from a hashmap
+ */
+__retval(0)
+long test_call_hash_sleepable(void *ctx)
+{
+	int key = 2;
+
+	return test_hmap_elem_callback(&hmap, &key);
+}
+
+SEC("tc")
+/* test that workqueues can be used from a hashmap
+ * with NO_PREALLOC.
+ */
+__retval(0)
+long test_call_hash_malloc_sleepable(void *ctx)
+{
+	int key = 3;
+
+	return test_hmap_elem_callback(&hmap_malloc, &key);
+}
+
+SEC("tc")
+/* test that workqueues can be used from a LRU map
+ */
+__retval(0)
+long test_call_lru_sleepable(void *ctx)
+{
+	int key = 4;
+
+	return test_elem_callback(&lru, &key);
+}

-- 
2.44.0


