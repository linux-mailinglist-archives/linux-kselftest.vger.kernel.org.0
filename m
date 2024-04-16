Return-Path: <linux-kselftest+bounces-8148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 058278A6DAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6B0B2528D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AD13698A;
	Tue, 16 Apr 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhqJ333w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E302136679;
	Tue, 16 Apr 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276659; cv=none; b=O0cZHtp4a5KEQrAD7M87eyLrlPHsETqSr3Z7eZfXaXKPOGl17eM48ICr0Tb/lymRv5LKhDvVBD+3HejClYc9lK5QnJMPYSfu441otzgTNFezoZ0kIpjSxCy8J860rV2HVxgJJPXBm3FWKtsm4oToyFQ6p7+XV6PgeESiIgu9XIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276659; c=relaxed/simple;
	bh=lm2FY30vt1roT/QaHJVcBSUumMbZDrssuz719s9NomA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNlBFVIeJwpKs8TALBDRaE1k8hqTq1fCldb3kBogBl1gvBRuWieLKERGYobfcJejOoeIXWw03ax94Ny+BHbxllKVepCpV70rtkW793l66ocLze/EZE7oE3ECW9ti4EAOl80y2XFySIpP5/hWtXAakbCDK/zxTONzVhroxJ7Bj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhqJ333w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE162C4AF12;
	Tue, 16 Apr 2024 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713276659;
	bh=lm2FY30vt1roT/QaHJVcBSUumMbZDrssuz719s9NomA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YhqJ333wGn6nuZFHU/tBSelQsDeTtLfq3RQC1eyOeo3BMOR0QGAC3Yx3RuTfUF7MG
	 EMeIO5M1+NVfUmSsgJxkntwgv4HyYXRZDCNipM484DuYubMTjuHr0qtG6HBJt+3o4T
	 zKDo+7WeoZe0pb386rRvmfotzB1GskiiFHWYitVxn/Tv3ShmXRtJxHCxpdwMuNOrUg
	 raGglP+EF0kolAO/lFpfpjE3hZCYh4gIrZkYxWXWfj6a0zo0m+DcGoWEqLGiK22Z7+
	 dj0hYaaV4idWzlWUXqutU9GWyQutbJNW8t9KT9pzkG/nfOPP37JoxTlhGshiSw6zJo
	 gmpJbtApgWkhw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 16 Apr 2024 16:08:29 +0200
Subject: [PATCH bpf-next 16/18] selftests/bpf: add checks for
 bpf_wq_set_callback()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bpf_wq-v1-16-c9e66092f842@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713276593; l=9344;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lm2FY30vt1roT/QaHJVcBSUumMbZDrssuz719s9NomA=;
 b=/XoRuGyVUIfvPUGrvgIEt3q9x4Yth7kpYX8XtHKjbLPbv3uYuPrLvbiMLfBQYTsnyO56dmjDo
 eqdo3l7tOW8AFjqXyx7B7SPcz5H9M97IEkbrmWcDXXay0SQWqo3kyU4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We assign the callback and set everything up.
The actual tests of these callbacks will be done when bpf_wq_start() is
available.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/bpf/bpf_experimental.h     |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/progs/wq.c             |  47 +++++++--
 tools/testing/selftests/bpf/progs/wq_failures.c    | 115 +++++++++++++++++++++
 5 files changed, 165 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 6af6f2a43e6d..272604f9c4a5 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -471,4 +471,9 @@ extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
 extern int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags) __weak __ksym;
+extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		unsigned int flags__k, void *aux__ign) __ksym;
+#define bpf_wq_set_callback(timer, cb, flags) \
+	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 39ad96a18123..eb2b78552ca2 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -494,6 +494,10 @@ __bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused
 	return arg;
 }
 
+__bpf_kfunc void bpf_kfunc_call_test_sleepable(void)
+{
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -520,6 +524,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_sleepable, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
index 7c664dd61059..ce5cd763561c 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h
@@ -96,6 +96,7 @@ void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
 void bpf_kfunc_call_test_mem_len_fail2(__u64 *mem, int len) __ksym;
 
 void bpf_kfunc_call_test_destructive(void) __ksym;
+void bpf_kfunc_call_test_sleepable(void) __ksym;
 
 void bpf_kfunc_call_test_offset(struct prog_test_ref_kfunc *p);
 struct prog_test_member *bpf_kfunc_call_memb_acquire(void);
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index f92466eb8fb1..c0a094c84834 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -49,7 +49,9 @@ struct {
 	__type(value, struct elem);
 } lru SEC(".maps");
 
-static int test_elem_callback(void *map, int *key)
+static int test_elem_callback(void *map, int *key,
+		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		u64 callback_flags)
 {
 	struct elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -63,13 +65,18 @@ static int test_elem_callback(void *map, int *key)
 		return -2;
 
 	wq = &val->w;
-	if (bpf_wq_init(wq, map, 0) != 0)
+	if (bpf_wq_init(wq, map, callback_flags) != 0)
 		return -3;
 
+	if (bpf_wq_set_callback(wq, callback_fn, callback_flags))
+		return -4;
+
 	return 0;
 }
 
-static int test_hmap_elem_callback(void *map, int *key)
+static int test_hmap_elem_callback(void *map, int *key,
+		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		u64 callback_flags)
 {
 	struct hmap_elem init = {}, *val;
 	struct bpf_wq *wq;
@@ -85,6 +92,28 @@ static int test_hmap_elem_callback(void *map, int *key)
 	if (bpf_wq_init(wq, map, 0) != 0)
 		return -3;
 
+	if (bpf_wq_set_callback(wq, callback_fn, callback_flags))
+		return -4;
+
+	return 0;
+}
+
+__u32 ok;
+__u32 ok_sleepable;
+
+/* callback for non sleepable workqueue */
+static int wq_callback(void *map, int *key, struct bpf_wq *work)
+{
+	bpf_kfunc_common_test();
+	ok |= (1 << *key);
+	return 0;
+}
+
+/* callback for sleepable workqueue */
+static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+{
+	bpf_kfunc_call_test_sleepable();
+	ok_sleepable |= (1 << *key);
 	return 0;
 }
 
@@ -96,7 +125,8 @@ long test_call_array_sleepable(void *ctx)
 {
 	int key = 0;
 
-	return test_elem_callback(&array, &key);
+	return test_elem_callback(&array, &key, wq_cb_sleepable,
+				  BPF_F_WQ_SLEEPABLE);
 }
 
 SEC("syscall")
@@ -107,7 +137,8 @@ long test_syscall_array_sleepable(void *ctx)
 {
 	int key = 1;
 
-	return test_elem_callback(&array, &key);
+	return test_elem_callback(&array, &key, wq_cb_sleepable,
+				  BPF_F_WQ_SLEEPABLE);
 }
 
 SEC("tc")
@@ -118,7 +149,7 @@ long test_call_hash_sleepable(void *ctx)
 {
 	int key = 2;
 
-	return test_hmap_elem_callback(&hmap, &key);
+	return test_hmap_elem_callback(&hmap, &key, wq_callback, 0);
 }
 
 SEC("tc")
@@ -130,7 +161,7 @@ long test_call_hash_malloc_sleepable(void *ctx)
 {
 	int key = 3;
 
-	return test_hmap_elem_callback(&hmap_malloc, &key);
+	return test_hmap_elem_callback(&hmap_malloc, &key, wq_callback, 0);
 }
 
 SEC("tc")
@@ -141,5 +172,5 @@ long test_call_lru_sleepable(void *ctx)
 {
 	int key = 4;
 
-	return test_elem_callback(&lru, &key);
+	return test_elem_callback(&lru, &key, wq_callback, 0);
 }
diff --git a/tools/testing/selftests/bpf/progs/wq_failures.c b/tools/testing/selftests/bpf/progs/wq_failures.c
index a08b6c93a195..efde14516358 100644
--- a/tools/testing/selftests/bpf/progs/wq_failures.c
+++ b/tools/testing/selftests/bpf/progs/wq_failures.c
@@ -27,6 +27,20 @@ struct {
 	__type(value, struct elem);
 } lru SEC(".maps");
 
+/* callback for non sleepable workqueue */
+static int wq_callback(void *map, int *key, struct bpf_wq *work)
+{
+	bpf_kfunc_common_test();
+	return 0;
+}
+
+/* callback for sleepable workqueue */
+static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+{
+	bpf_kfunc_call_test_sleepable();
+	return 0;
+}
+
 SEC("tc")
 /* test that bpf_wq_init takes a map as a second argument
  */
@@ -80,3 +94,104 @@ long test_wq_init_wrong_map(void *ctx)
 
 	return 0;
 }
+
+SEC("?tc")
+__log_level(2)
+__failure
+/* check that bpf_wq_set_callback() can not be called with a
+ * sleepable callback without BPF_F_WQ_SLEEPABLE
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_kfunc_call_test_sleepable#") /* anchor message */
+__msg("program must be sleepable to call sleepable kfunc bpf_kfunc_call_test_sleepable")
+long test_call_sleepable_callback_missing_flag(void *ctx)
+{
+	int key = 0;
+	struct bpf_wq *wq;
+
+	wq = bpf_map_lookup_elem(&array, &key);
+	if (wq) {
+		bpf_wq_init(wq, &array, 0);
+		bpf_wq_set_callback(wq, wq_cb_sleepable, 0);
+	}
+
+	return 0;
+}
+
+SEC("tc")
+/* check that calling a non sleepable callback with
+ * bpf_wq_set_callback() while providing BPF_F_WQ_SLEEPABLE
+ * fails.
+ */
+__retval(3)
+long test_call_non_sleepable_callback_wrong_flag(void *ctx)
+{
+	int key = 1;
+	struct bpf_wq *wq;
+
+	wq = bpf_map_lookup_elem(&array, &key);
+	if (!wq)
+		return 1;
+
+	if (bpf_wq_init(wq, &array, 0))
+		return 2;
+
+	if (bpf_wq_set_callback(wq, wq_callback, BPF_F_WQ_SLEEPABLE))
+		return 3;
+
+	return -22;
+}
+
+SEC("?tc")
+__log_level(2)
+__failure
+/* check that the first argument of bpf_wq_set_callback()
+ * is a correct bpf_wq pointer.
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
+__msg("arg#0 doesn't point to a map value")
+long test_wrong_wq_pointer(void *ctx)
+{
+	int key = 0;
+	struct bpf_wq *wq;
+
+	wq = bpf_map_lookup_elem(&array, &key);
+	if (!wq)
+		return 1;
+
+	if (bpf_wq_init(wq, &array, 0))
+		return 2;
+
+	if (bpf_wq_set_callback((void *)&wq, wq_callback, 0))
+		return 3;
+
+	return -22;
+}
+
+SEC("?tc")
+__log_level(2)
+__failure
+/* check that the first argument of bpf_wq_set_callback()
+ * is a correct bpf_wq pointer.
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
+__msg("off 1 doesn't point to 'struct bpf_wq' that is at 0")
+long test_wrong_wq_pointer_offset(void *ctx)
+{
+	int key = 0;
+	struct bpf_wq *wq;
+
+	wq = bpf_map_lookup_elem(&array, &key);
+	if (!wq)
+		return 1;
+
+	if (bpf_wq_init(wq, &array, 0))
+		return 2;
+
+	if (bpf_wq_set_callback((void *)wq + 1, wq_cb_sleepable, 0))
+		return 3;
+
+	return -22;
+}

-- 
2.44.0


