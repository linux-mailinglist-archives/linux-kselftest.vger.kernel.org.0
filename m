Return-Path: <linux-kselftest+bounces-8145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6B8A6DA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A351F21E60
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337C133420;
	Tue, 16 Apr 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uumN6pLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6665A12EBFA;
	Tue, 16 Apr 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276648; cv=none; b=bhZ5v9pY4XMH+VuiyPEKjg9TrUeZ20oi19oE/Pmqt4E2uy3Nlhu/UhnWzpB8Rh6G4rPrzLcrT3Harojq+B4LokCBqjfa2uQp/ba5LjuEfKRI2VqgpXBY0HHhNL6k5r1HW9JwUzMO9htM6T61b+2bUipVahW/RKL3H+JmpYjtPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276648; c=relaxed/simple;
	bh=JjBJJq1sNWGaFqkELXJ+0AXMMVvsTz+E0m4FBFgIIH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApLq7WXllE2kP2cECPpx6ZF8NFLo2eUGQK502jhSzp5QcnI5PLgmgqgTYi4uYYkGFpZdRYD6BGo9naRSenpWf2R8MSNewoSOqfMxG5px3TPO+JU+o46LvDU40StGEndcJYFMF0eDpYw8FhuXHlwszM2To/FuyDfdajI3Lk0FK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uumN6pLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C769C2BD11;
	Tue, 16 Apr 2024 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276647;
	bh=JjBJJq1sNWGaFqkELXJ+0AXMMVvsTz+E0m4FBFgIIH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uumN6pLifqygT+JXv9qiCgenWMa00T38oCf1DsF5Ubqy4vPAACJGo6NaanYnnjDa0
	 4rpYYg0HKZu4hQJzi0z682qay2duOtDADQWFHY1wgrmKHWqabMR9nffi1blrVMZ4Y0
	 g0YcDeBEYwZmewYHNPY0TOwEkkPAUfEBj7IHdNGI3GtoJWFKTis3UL5q1GMIcudz7W
	 ukQL+UlFGDCngSmZuMoIM3gazKqQJc2NdCo9lX06d7Bi4rfnAV3LhfcOKDyQmdTquI
	 1/aBF/cSbiCuMxVjn5rr4rSo9Bxp7D3ITej75KdEgq3IW1kkd0TVhZ3OMDH8pu4jO8
	 RiSGupd6+MbLg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:26 +0200
Subject: [PATCH bpf-next 13/18] selftests/bpf: wq: add bpf_wq_init() checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-13-c9e66092f842@kernel.org>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=4860;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JjBJJq1sNWGaFqkELXJ+0AXMMVvsTz+E0m4FBFgIIH0=;
 b=WYoaxHeD3s7z9EobT9ZTV15qk6OxIM/4ku1EQbAUq4le7O/c5IAocLyIPEDwNkdukraKdOAIN
 5ln/q4dtvSRDwZhrDdnyxuxy9HpsoRZjxWkQKffom9ULmBDOOBSoyZb
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to test if allocation/free works

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h  |  1 +
 tools/testing/selftests/bpf/prog_tests/wq.c     |  8 +++
 tools/testing/selftests/bpf/progs/wq.c          | 10 +++
 tools/testing/selftests/bpf/progs/wq_failures.c | 82 +++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 3329ea080865..6af6f2a43e6d 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -470,4 +470,5 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+extern int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags) __weak __ksym;
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
index 000000000000..a08b6c93a195
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -0,0 +1,82 @@
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
+/* check that code path marks r1 as precise */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_wq_init#") /* anchor message */
+__msg("workqueue pointer in R1 map_uid=0 doesn't match map pointer in R2 map_uid=0")
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
+/* check that code path marks r1 as precise */
+__msg("mark_precise: frame0: regs=r1 stack= before")
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


