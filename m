Return-Path: <linux-kselftest+bounces-6352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9254087CEEB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A451C227DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0044C76;
	Fri, 15 Mar 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kso+9RAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB341740;
	Fri, 15 Mar 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513002; cv=none; b=TL9UvH6cUGgK2C2DNtjI9V386cOJSuLVgyWqfWtLdMmWKzhcFsCt79NOlTV6CMHiFLLnFaBzodTEQszWTcggtvEUeEspvVuOHOAFxcBDrvV/5u1+61Dl2K5q40As+ayARFDlf7j2eTOPXrP8I4o8PkorOUbcNepE6EORDwcilJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513002; c=relaxed/simple;
	bh=26Me8+u5TzyDpIxITOUYsHiBNwg5FLbt6q/Tou7u72Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tog7/pFepVxv4j0gimfgsliN3zjkNZv92MJNmTvnAG46uBdi+cbAmUk2Ep3Mya41OwdFBVOMNxZsM7hHUwPcYX1eFFsJE36+7gzoKT578QrzRlmwRE0gWL9qofwqsbdVm2tfGVgmmdipa/0KcJR8wAcTIAuB3ksRGnaMPRIgNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kso+9RAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA4BC43330;
	Fri, 15 Mar 2024 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513002;
	bh=26Me8+u5TzyDpIxITOUYsHiBNwg5FLbt6q/Tou7u72Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kso+9RAZ5X5Z1AWvsIi4i99IuUUYJDenBgyzwBD5iR9xFu30mLzd0PYT62JprkepT
	 pGvPe1OJ3IoGtedVvfX76VYaex3dhEgvngIyoAsJoVBW1rysVUDFtWnKL/WFHyuPo1
	 aa9w8n97ViPGyLqTGRhTz4m8f8ThY2hjZPHjJ1Jifv81tr1cuqOS1VK1IsdOkckWpC
	 bMg4CpbrmIqUvYmJNofqaziOcK92/r/hGhDTlXdfDKbSSFe5pKqSKhrNU7ZUpUmgDB
	 QXAhouM5wFJtivBToQ27kfQojGhLrgTEO/pwgWIhMOWjDR/6uml72nyjm0t40Ddyoo
	 m7MJu6t4SmyBg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:29:30 +0100
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: add sleepable timer tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-hid-bpf-sleepable-v4-6-5658f2540564@kernel.org>
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
In-Reply-To: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710512973; l=9214;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=26Me8+u5TzyDpIxITOUYsHiBNwg5FLbt6q/Tou7u72Q=;
 b=E0/FlxTG5Yp8VKPH3kmITNMcIJl2imJb8feolcUlHhOM8Zvz4zXcdD5RWxS0q40lnRzCHZugH
 +WAZiBORCcYCynnR2MAlyTk/tHxKhfkngZp6HYlbhN2/lTC/gURqET4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
including vmlinux.h, which is not compatible with including time.h
or bpf_tcp_helpers.h.

So prevent vmlinux.h to be included, and override the few missing
types.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v4
---
 tools/testing/selftests/bpf/bpf_experimental.h     |   4 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |   1 +
 tools/testing/selftests/bpf/progs/timer.c          |  40 +++++++-
 tools/testing/selftests/bpf/progs/timer_failure.c  | 114 ++++++++++++++++++++-
 6 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a5b9df38c162..79da06ca4136 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -459,4 +459,8 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+extern int bpf_timer_set_sleepable_cb_impl(struct bpf_timer *timer,
+		int (callback_fn)(void *map, int *key, struct bpf_timer *timer), void *aux__ign) __ksym;
+#define bpf_timer_set_sleepable_cb(timer, cb) \
+	bpf_timer_set_sleepable_cb_impl(timer, cb, NULL)
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
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index d66687f1ee6a..48973c2e28c7 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -61,6 +61,7 @@ static int timer(struct timer *timer_skel)
 
 	/* check that code paths completed */
 	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+	ASSERT_EQ(timer_skel->bss->ok_sleepable, 1, "ok_sleepable");
 
 	prog_fd = bpf_program__fd(timer_skel->progs.race);
 	for (i = 0; i < NUM_THR; i++) {
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
index f615da97df26..6b19254c5b75 100644
--- a/tools/testing/selftests/bpf/progs/timer.c
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -6,6 +6,14 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
 
+#define __VMLINUX_H__
+#define u32 __u32
+#define u64 __u64
+#include "bpf_experimental.h"
+struct prog_test_member1;
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#undef __VMLINUX_H__
+
 char _license[] SEC("license") = "GPL";
 struct hmap_elem {
 	int counter;
@@ -34,7 +42,7 @@ struct elem {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 2);
+	__uint(max_entries, 3);
 	__type(key, int);
 	__type(value, struct elem);
 } array SEC(".maps");
@@ -62,6 +70,7 @@ __u64 callback_check = 52;
 __u64 callback2_check = 52;
 __u64 pinned_callback_check;
 __s32 pinned_cpu;
+__u32 ok_sleepable;
 
 #define ARRAY 1
 #define HTAB 2
@@ -422,3 +431,32 @@ int race(void *ctx)
 
 	return 0;
 }
+
+/* callback for sleepable timer */
+static int timer_cb_sleepable(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_kfunc_call_test_sleepable();
+	ok_sleepable |= 1;
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test6")
+int BPF_PROG2(test6, int, a)
+{
+	int key = 2;
+	struct bpf_timer *timer;
+
+	bpf_printk("test6");
+
+	timer = bpf_map_lookup_elem(&array, &key);
+	if (timer) {
+		if (bpf_timer_init(timer, &array, CLOCK_MONOTONIC) != 0)
+			err |= 32768;
+		bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable);
+		bpf_timer_start(timer, 0, BPF_F_TIMER_SLEEPABLE);
+	} else {
+		err |= 65536;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_failure.c b/tools/testing/selftests/bpf/progs/timer_failure.c
index 0996c2486f05..72942a90189b 100644
--- a/tools/testing/selftests/bpf/progs/timer_failure.c
+++ b/tools/testing/selftests/bpf/progs/timer_failure.c
@@ -8,6 +8,14 @@
 #include "bpf_misc.h"
 #include "bpf_tcp_helpers.h"
 
+#define __VMLINUX_H__
+#define u32 __u32
+#define u64 __u64
+#include "bpf_experimental.h"
+struct prog_test_member1;
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+#undef __VMLINUX_H__
+
 char _license[] SEC("license") = "GPL";
 
 struct elem {
@@ -16,7 +24,7 @@ struct elem {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, int);
 	__type(value, struct elem);
 } timer_map SEC(".maps");
@@ -66,3 +74,107 @@ long BPF_PROG2(test_bad_ret, int, a)
 
 	return 0;
 }
+
+/* callback for sleepable timer */
+static int timer_cb_sleepable(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_kfunc_call_test_sleepable();
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__log_level(2)
+__failure
+/* check that bpf_timer_set_callback() can not be called with a
+ * sleepable callback
+ */
+__msg("mark_precise: frame0: regs=r0 stack= before")
+__msg(": (85) call bpf_kfunc_call_test_sleepable#") /* anchor message */
+__msg("program must be sleepable to call sleepable kfunc bpf_kfunc_call_test_sleepable")
+int BPF_PROG2(test_non_sleepable_sleepable_callback, int, a)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC);
+		bpf_timer_set_callback(timer, timer_cb_sleepable);
+		bpf_timer_start(timer, 0, BPF_F_TIMER_SLEEPABLE);
+	}
+
+	return 0;
+}
+
+SEC("tc")
+/* check that calling bpf_timer_start() without BPF_F_TIMER_SLEEPABLE on a sleepable
+ * callback is returning -EINVAL
+ */
+__retval(-22)
+long test_call_sleepable_missing_flag(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 1;
+
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable))
+		return 3;
+
+	return bpf_timer_start(timer, 0, 0);
+}
+
+SEC("tc")
+/* check that calling bpf_timer_start() without BPF_F_TIMER_SLEEPABLE on a sleepable
+ * callback is returning -EINVAL
+ */
+__retval(-22)
+long test_call_sleepable_delay(void *ctx)
+{
+	int key = 1;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 1;
+
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable))
+		return 3;
+
+	return bpf_timer_start(timer, 1, BPF_F_TIMER_SLEEPABLE);
+}
+
+SEC("tc")
+__log_level(2)
+__failure
+/* check that the first argument of bpf_timer_set_callback()
+ * is a correct bpf_timer pointer.
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_timer_set_sleepable_cb_impl#") /* anchor message */
+__msg("arg#0 doesn't point to a map value")
+long test_wrong_pointer(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 1;
+
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb((void *)&timer, timer_cb_sleepable))
+		return 3;
+
+	return -22;
+}

-- 
2.44.0


