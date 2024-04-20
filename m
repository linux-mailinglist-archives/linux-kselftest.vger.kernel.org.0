Return-Path: <linux-kselftest+bounces-8545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901138ABA92
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E09281576
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DBF4C60C;
	Sat, 20 Apr 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anRgPcMi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E704AEF6;
	Sat, 20 Apr 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713604209; cv=none; b=dcgF6EAxmrxI7CvjUCYRQgpr+qdu5yeDdon8xSkkuyURc8HzXEP/JOW8yHtSFJ5TsZpqOlGGhRDYBieotWsZUAF8RcNOxaInn1+KMU9ZRVry/hJOiEZRXI2Tj891O4a3kToRgPA7XMUk5+Oc1bVRc2pEtXJgAuS1yp+8T91xclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713604209; c=relaxed/simple;
	bh=dgl1Ep3U0dFJ7nrTFAsQUO+nU+CafbtbJcO/cfdK8UM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjo5dWLQmdJk1qsM3SdNNpzEWnnqnPLeryMpYYXUovZaoUC9qm0lqI5P5HuM3JyQPDhYtVlCCJG+pCkUEsDp6JaRE5qIKfadWutT2pNUCncBAC1XJWI8m2Ygra+mkxwXqaYSaZ+0lpE/rlmG5Zx94JvxFFmIjrWkXo3CsYipmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anRgPcMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751D8C32781;
	Sat, 20 Apr 2024 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713604208;
	bh=dgl1Ep3U0dFJ7nrTFAsQUO+nU+CafbtbJcO/cfdK8UM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anRgPcMivSeAKJK+Ael0fYxCQrX5N4WJE9heInbgEQ+ce6gSDyuyCSHqIGyE4Bmlf
	 HS1HQGAQO9aR+CqbvoIO64tv3ZCieXjf4BhZ4poACvQCEHIJfHCTAsswJ80IgAQ+7z
	 4Y3wMkOzUBCMdOqGPaEOXBj068c/anjNCiyllDdcAjeew0oi/21CNRtQVcFC9MY3Li
	 1IrPag5RxyoNFkgNzh2dxfp3i4cTGV/3qRS749NAPAGXdT7jKCx0la9UfPNeXm4kuN
	 bJ83kQcjmIFCuhs2HFeRHW9SykgAO+mWijglsuSD/zCJgrV0SmIFhUolSHO1AXuvC9
	 NW11IR7t/3VDw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 20 Apr 2024 11:09:12 +0200
Subject: [PATCH bpf-next v2 12/16] selftests/bpf: wq: add bpf_wq_init()
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-bpf_wq-v2-12-6c986a5a741f@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713604159; l=4667;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=dgl1Ep3U0dFJ7nrTFAsQUO+nU+CafbtbJcO/cfdK8UM=;
 b=JBJF0zs0pMsZXDgS6At1THNlx6u5LvuLPJqnWvwIEx/8DtAXz38sgWbpGBhLgqdOaaKKSkoJ+
 w2ldAv7l5n3AW/6D2I+So7fUFGRAK39c2Gobl5GAlvIvTIMSZ1n8kHg
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to test if allocation/free works

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v2:
- dropped mark_precise checks
---
 tools/testing/selftests/bpf/bpf_experimental.h  |  1 +
 tools/testing/selftests/bpf/prog_tests/wq.c     |  8 +++
 tools/testing/selftests/bpf/progs/wq.c          | 10 ++++
 tools/testing/selftests/bpf/progs/wq_failures.c | 78 +++++++++++++++++++++++++
 4 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 3329ea080865..785b91b629be 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -470,4 +470,5 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index 9a07b8bc2c52..26ab69796103 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2024 Benjamin Tissoires */
 #include <test_progs.h>
 #include "wq.skel.h"
+#include "wq_failures.skel.h"
 
 void serial_test_wq(void)
 {
@@ -9,3 +10,10 @@ void serial_test_wq(void)
 
 	RUN_TESTS(wq);
 }
+
+void serial_test_failures_wq(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	RUN_TESTS(wq_failures);
+}
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 8c668ad04059..f92466eb8fb1 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -52,6 +52,7 @@ struct {
 static int test_elem_callback(void *map, int *key)
 {
 	struct elem init = {}, *val;
+	struct bpf_wq *wq;
 
 	if (map == &lru &&
 	    bpf_map_update_elem(map, key, &init, 0))
@@ -61,12 +62,17 @@ static int test_elem_callback(void *map, int *key)
 	if (!val)
 		return -2;
 
+	wq = &val->w;
+	if (bpf_wq_init(wq, map, 0) != 0)
+		return -3;
+
 	return 0;
 }
 
 static int test_hmap_elem_callback(void *map, int *key)
 {
 	struct hmap_elem init = {}, *val;
+	struct bpf_wq *wq;
 
 	if (bpf_map_update_elem(map, key, &init, 0))
 		return -1;
@@ -75,6 +81,10 @@ static int test_hmap_elem_callback(void *map, int *key)
 	if (!val)
 		return -2;
 
+	wq = &val->work;
+	if (bpf_wq_init(wq, map, 0) != 0)
+		return -3;
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
new file mode 100644
index 000000000000..db7015c7d541
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -0,0 +1,78 @@
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
+SEC("tc")
+/* test that bpf_wq_init takes a map as a second argument
+ */
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure
+__msg(": (85) call bpf_wq_init#") /* anchor message */
+__msg("pointer in R2 isn't map pointer")
+long test_wq_init_nomap(void *ctx)
+{
+	struct bpf_wq *wq;
+	struct elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&array, &key);
+	if (!val)
+		return -1;
+
+	wq = &val->w;
+	if (bpf_wq_init(wq, &key, 0) != 0)
+		return -3;
+
+	return 0;
+}
+
+SEC("tc")
+/* test that the workqueue is part of the map in bpf_wq_init
+ */
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__failure
+__msg(": (85) call bpf_wq_init#") /* anchor message */
+__msg("workqueue pointer in R1 map_uid=0 doesn't match map pointer in R2 map_uid=0")
+long test_wq_init_wrong_map(void *ctx)
+{
+	struct bpf_wq *wq;
+	struct elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&array, &key);
+	if (!val)
+		return -1;
+
+	wq = &val->w;
+	if (bpf_wq_init(wq, &lru, 0) != 0)
+		return -3;
+
+	return 0;
+}

-- 
2.44.0


