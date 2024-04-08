Return-Path: <linux-kselftest+bounces-7382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8892A89B9E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A001F21F40
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC347F6A;
	Mon,  8 Apr 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aly/g6MA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727550261;
	Mon,  8 Apr 2024 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563814; cv=none; b=BkH3oZyv5kE793ikygLvdYCBB39oQ/uPi245+Hxj9S6Bh9oVMRhzxgDF3vfqafo61/m2iagPeDtWG16fO1L1WXC6qgBAdl5B+P0F17dZOIW3MRi5W6Kfyofh75nSTO10mF7/EIrLonvDf3LiJE4gLTTzDrz+sPrI8sfSpRv+txk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563814; c=relaxed/simple;
	bh=VK5TMS1RBt4n3wTN5emOMrl/EafXnUKW81ujAeZ/zaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKUNF/gM7iua3JR3zZadGJ2E0Iqs15tKvComVVnQYiMzECnrhG0Z21jWCd8GasKndFk7YGF80q/3S/OGFgQYaJhHwzoMmsy0dZ9gUgJGbQZx4AQcTjaJFqeGDRwf+oFwh7GR0B2IMLPTLsJZS9NrjFWWRNMy+TZOyrhiCj5C6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aly/g6MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2F1C433C7;
	Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563814;
	bh=VK5TMS1RBt4n3wTN5emOMrl/EafXnUKW81ujAeZ/zaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aly/g6MAD0Joz022TK5sZ9ySr8NS3Gg2ZjmhgV9eUlJJq2Th/WS1AvTi0gHlnqWAD
	 M7z1TjSgkjqnnf8o80InKUs1yDnwvKB0ZtgMxDdSbL59po7T4zGGw7xsKd5zErHN+M
	 AwzoDToAUCDwxJwkxwhS/Tz2lOEc2Dz/IDfN3FQoyuXHTeXM8DxFZzyORFxcDsU+JZ
	 +PMKfmVf9TPJJP7THWRxp2Adt4qHJBJQzriHT+Tf9mbsgTJ+GmRw5dDP1s35yLYAJg
	 zzXpQmwlSSrvMEDoF8rpyBRt0MVRNqXmbrDybjuNAKafjNFinJZj8OZzpYhkefd4ls
	 lmuNsrdOsIrEQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 08 Apr 2024 10:09:31 +0200
Subject: [PATCH RFC bpf-next v6 6/6] selftests/bpf: add sleepable timer
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-hid-bpf-sleepable-v6-6-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
In-Reply-To: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712563787; l=10863;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=VK5TMS1RBt4n3wTN5emOMrl/EafXnUKW81ujAeZ/zaQ=;
 b=DkDztKSSM7lLUnbAHdGqP2rfKfHFrniK23AmOurdhWu2n1ngDjhSbKcRfGY08H+huRvSX8YNF
 DafjdkIw+xHDY0WMCUKiwZoi0dO0lrq27KPkm5BiTlAhm39gffESED5
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
including vmlinux.h, which is not compatible with including time.h
or bpf_tcp_helpers.h.

So keep sleepable tests in a separate bpf source file.

The first correct test is run twice for convenience:
- first through RUN_TESTS
- then we ensure that the timer was actually executed, in a manual
  load/attach/run

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

changes in v6:
- use of new _init API with BPF_F_TIMER_SLEEPABLE

changes in v5b:
- do not use SEC(syscall) as they are run in a sleepable context
  already
- duplicate test_call_sleepable() so we can test if the callback gets
  called

changes in v5:
- keep sleepable test separate

new in v4
---
 tools/testing/selftests/bpf/bpf_experimental.h     |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |   5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |   1 +
 tools/testing/selftests/bpf/prog_tests/timer.c     |  34 ++++
 .../testing/selftests/bpf/progs/timer_sleepable.c  | 213 +++++++++++++++++++++
 5 files changed, 258 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a5b9df38c162..06ed98b3bc51 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -459,4 +459,9 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
 extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css *it) __weak __ksym;
 extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
 
+extern int bpf_timer_set_sleepable_cb_impl(struct bpf_timer *timer,
+		int (callback_fn)(void *map, int *key, struct bpf_timer *timer),
+		void *aux__ign) __ksym;
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
index d66687f1ee6a..c6c7c623b31c 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include "timer.skel.h"
 #include "timer_failure.skel.h"
+#include "timer_sleepable.skel.h"
 
 #define NUM_THR 8
 
@@ -95,3 +96,36 @@ void serial_test_timer(void)
 
 	RUN_TESTS(timer_failure);
 }
+
+/* isolate sleepable tests from main timer tests
+ * because if test_timer fails, it spews the console
+ * with 10000 * 5 "spin_lock_thread:PASS:test_run_opts retval 0 nsec"
+ */
+void serial_test_sleepable_timer(void)
+{
+	struct timer_sleepable *timer_sleepable_skel = NULL;
+	int err, prog_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	RUN_TESTS(timer_sleepable);
+
+	/* re-run the success test to check if the timer was actually executed */
+
+	timer_sleepable_skel = timer_sleepable__open_and_load();
+	if (!ASSERT_OK_PTR(timer_sleepable_skel, "timer_sleepable_skel_load"))
+		return;
+
+	err = timer_sleepable__attach(timer_sleepable_skel);
+	if (!ASSERT_OK(err, "timer_sleepable_attach"))
+		return;
+
+	prog_fd = bpf_program__fd(timer_sleepable_skel->progs.test_syscall_sleepable);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	usleep(50); /* 10 usecs should be enough, but give it extra */
+
+	ASSERT_EQ(timer_sleepable_skel->bss->ok_sleepable, 1, "ok_sleepable");
+}
diff --git a/tools/testing/selftests/bpf/progs/timer_sleepable.c b/tools/testing/selftests/bpf/progs/timer_sleepable.c
new file mode 100644
index 000000000000..fc7829d8b6c4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer_sleepable.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook
+ * Copyright (c) 2024 Benjamin Tissoires
+ */
+
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define CLOCK_MONOTONIC 1
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 3);
+	__type(key, int);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+__u32 ok_sleepable;
+
+/* callback for sleepable timer */
+static int timer_cb_sleepable(void *map, int *key, struct bpf_timer *timer)
+{
+	bpf_kfunc_call_test_sleepable();
+	ok_sleepable |= (1 << *key);
+	return 0;
+}
+
+SEC("tc")
+/* check that calling bpf_timer_start() with BPF_F_TIMER_SLEEPABLE on a sleepable
+ * callback works
+ */
+__retval(0)
+long test_call_sleepable(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	if (ok_sleepable & 1)
+		return -1;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE) != 0)
+			return -2;
+		bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable);
+		if (bpf_timer_start(timer, 0, 0))
+			return -3;
+	} else {
+		return -4;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+/* check that calling bpf_timer_start() with BPF_F_TIMER_SLEEPABLE on a sleepable
+ * callback works.
+ */
+__retval(0)
+long test_syscall_sleepable(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	if (ok_sleepable & 1)
+		return -1;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE) != 0)
+			return -2;
+		bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable);
+		if (bpf_timer_start(timer, 0, 0))
+			return -3;
+	} else {
+		return -4;
+	}
+
+	return 0;
+}
+
+SEC("?tc")
+__log_level(2)
+__failure
+/* check that bpf_timer_set_callback() can not be called with a
+ * sleepable callback
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_kfunc_call_test_sleepable#") /* anchor message */
+__msg("program must be sleepable to call sleepable kfunc bpf_kfunc_call_test_sleepable")
+long test_non_sleepable_sleepable_callback(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (timer) {
+		bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE);
+		bpf_timer_set_callback(timer, timer_cb_sleepable);
+		bpf_timer_start(timer, 0, 0);
+	}
+
+	return 0;
+}
+
+SEC("tc")
+/* check that calling bpf_timer_set_sleepable_cb() without a sleepable timer
+ * initialized with BPF_F_TIMER_SLEEPABLE on a sleepable
+ * callback is returning -EINVAL
+ */
+__retval(3)
+long test_call_sleepable_missing_flag(void *ctx)
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
+	return bpf_timer_start(timer, 0, 0);
+}
+
+SEC("tc")
+/* check that calling bpf_timer_start() with a delay on a sleepable
+ * callback is returning -EINVAL
+ */
+__retval(-22)
+long test_call_sleepable_delay(void *ctx)
+{
+	int key = 2;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 1;
+
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable))
+		return 3;
+
+	return bpf_timer_start(timer, 1, 0);
+}
+
+SEC("?tc")
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
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb((void *)&timer, timer_cb_sleepable))
+		return 3;
+
+	return -22;
+}
+
+SEC("?tc")
+__log_level(2)
+__failure
+/* check that the first argument of bpf_timer_set_callback()
+ * is a correct bpf_timer pointer.
+ */
+__msg("mark_precise: frame0: regs=r1 stack= before")
+__msg(": (85) call bpf_timer_set_sleepable_cb_impl#") /* anchor message */
+__msg("off 1 doesn't point to 'struct bpf_timer' that is at 0")
+long test_wrong_pointer_offset(void *ctx)
+{
+	int key = 0;
+	struct bpf_timer *timer;
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 1;
+
+	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE))
+		return 2;
+
+	if (bpf_timer_set_sleepable_cb((void *)timer + 1, timer_cb_sleepable))
+		return 3;
+
+	return -22;
+}

-- 
2.44.0


