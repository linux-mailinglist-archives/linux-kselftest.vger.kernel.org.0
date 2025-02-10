Return-Path: <linux-kselftest+bounces-26140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD5A2E27E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 04:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640053A36B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86643AA1;
	Mon, 10 Feb 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLCRmayV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291546B8;
	Mon, 10 Feb 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739156792; cv=none; b=keGFAVp9ESkmVIBUuIQ/bWHSgMGWnmK37fctwECbZV+Cb+fceSVZrjYqNi/GhT2+Q2csaPnYiTicpU5izSRgufysGR/h/vGsu3/MhWjaL6QaegfUM05dp8jNiGN7FD9IiYBDEog2QzDLsw3cSnpqRrWSaqK2GqYjq+uo0Dn37DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739156792; c=relaxed/simple;
	bh=Zrl+ewQRzlE0bIXMhCzW13QGfSy1WaBSyLu4KacV83I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOdhjCV6rJlWrTDGiIF0dzQkwB4m5//Q4Ii2AWKA7e7lrzonOoaY/gRxn8CC3j44wWI56eiYeYitw0Hg6C3Sm7XXj3vXWb0vbsZCMbMEo4CU9+XNoFiwjxLA2xlZDdB9p/Ci0xbJGYcpNyG/DSTDFkSdgY1Kv+lHYO6WTrzGG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLCRmayV; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso629118766b.1;
        Sun, 09 Feb 2025 19:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739156788; x=1739761588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NqHMtdn72ThqB0UnDBCaSYvJr3yrRS+ckdGN1HVYh8U=;
        b=JLCRmayVEHC++iwhOiTzUaSv0FP+OufBghdXz0XOuDs8ojba1fB+E4MIAavyewbvGf
         HikCMKIdB0h5VEldisiYxWcqLIlHtFmBEwW8mzJQ4wucQsYj9oA4ljUSIcThyHAcadGN
         bDPIYjyOfmRGvhUs7slgEGDOh1KtrBssNg7AtTp3UreoqDqo0v+uzCQdudJQIBZBc1Hn
         QoigWdk4FMmU5YYGKjtntb+TgPvXbBZsOgcL2lgS3GizNNT+d2GwECWY2QOxsjZvjaJT
         02uJ3ua/G/XtVRDKtHteCQoFRjuaQ0ZG2dmDCJ+svcke5ct9Ks89+sb4MvIJp7Hw+ROQ
         UqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739156788; x=1739761588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqHMtdn72ThqB0UnDBCaSYvJr3yrRS+ckdGN1HVYh8U=;
        b=Dn30IzLzMiA2zU8+jVbia0DEBUI+bCyU0/JyCE9Js6Si/gFS21PDeqlRGWHgNScq1X
         NpEGLZyXDLn4IbUE7gPFweBwM+1gZoFOlBb01DmbEC1AoP1nkFA0rzwfAJEwv2wpXv/Y
         fnYLrx+5cztDcT7OGyG3pCtNE5tbWTET2pn96oDH2KyCNuRv1bsdyPXYD2qxgbSAvmUX
         yqM4eNYuT/o8dsokzEl9A5L/D/+v6TrCSx9vMfk+7r/CQNLsK0RdG5byUNf8EsB6BNHZ
         lv2zCK05CBp7P1RgqjIHx6nKUlilHxQYYFMZBs+PJHHlhUA6BIN4oY/vMvo2akuDsSb1
         IGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIdB5PihaOvoLlel2YbhstAdWMJwST7dstV8brjLBACxpea9ND1rAJjoTzZ/BptfdJnacdI1wW434aGQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZUdgGrsGkJOR9TFGNUZiDeCgDKCqVZUTL+6z4qWkl6JNnt4r
	Q4p9JMyKMy3MqaAe6zg3fTF+XBcLW9u7d7Isxry6IQCM5VydP4dz
X-Gm-Gg: ASbGncuIvDa7rNJ/Hb6TubMB7FwTzsn6++55YBvhKPO/k/qv9gmatbMXUB3JBkNBSsd
	mjYcNM7AqbV9CvAh4xx2lxkDXTZ4w8Y09am3SPxBYUsQCTv0ZeE5rEedOgKJcs5HPcwG/slRrYq
	O2n64S94/Kq1/evlxLWzsIlRn/N0Bz5Yn9gN8+WjFHvhUQW3Njlwx9oOK3x4WEMcFBreXoW6Bwv
	DPzTRJ1ty8RVUrUR0RH0SvVkQuRJmnwIMcv0F3rONcPAj/YLSMB/GmbFqNJhCh186CGCFVBTU92
	ky6mE1a9Sruze/m0CULDwR+moZ/bzEjI5ewAfIiDk2eMaO10jyOSyGU=
X-Google-Smtp-Source: AGHT+IG8DjDqpa2ekQtlgquaz27MyCl256DVxrFXA3aFpqdI9qgGWpdCk7jPkV646eSDWlDMSKUZEQ==
X-Received: by 2002:a17:907:7e89:b0:ab3:ed0:8d7 with SMTP id a640c23a62f3a-ab789ac0f4cmr949284566b.23.1739156787721;
        Sun, 09 Feb 2025 19:06:27 -0800 (PST)
Received: from nyx.arnhem.chello.nl (g171115.upc-g.chello.nl. [80.57.171.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bae59ae6sm185367866b.169.2025.02.09.19.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 19:06:26 -0800 (PST)
Sender: Armin M <arminmahdilou@gmail.com>
From: Armin <armin.mahdilou@gmail.com>
X-Google-Original-From: Armin <Armin.Mahdilou@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Armin <Armin.Mahdilou@gmail.com>
Subject: [PATCH] selftests: proofreading bpf module
Date: Mon, 10 Feb 2025 04:04:55 +0100
Message-ID: <20250210030455.284568-1-Armin.Mahdilou@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple spelling issues in the kselftests bpf modules.

Signed-off-by: Armin <Armin.Mahdilou@gmail.com>
---
 tools/testing/selftests/bpf/Makefile                        | 2 +-
 tools/testing/selftests/bpf/bench.c                         | 2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/fd_array.c           | 2 +-
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c  | 2 +-
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c         | 4 ++--
 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c            | 2 +-
 tools/testing/selftests/bpf/progs/bpf_dctcp.c               | 2 +-
 .../testing/selftests/bpf/progs/freplace_unreliable_prog.c  | 2 +-
 tools/testing/selftests/bpf/progs/iters_state_safety.c      | 2 +-
 .../testing/selftests/bpf/progs/test_cls_redirect_dynptr.c  | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_dtime.c           | 2 +-
 tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c   | 6 +++---
 tools/testing/selftests/bpf/progs/uretprobe_stack.c         | 2 +-
 tools/testing/selftests/bpf/progs/verifier_loops1.c         | 2 +-
 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c     | 2 +-
 tools/testing/selftests/bpf/test_lru_map.c                  | 4 ++--
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh            | 2 +-
 tools/testing/selftests/bpf/test_sockmap.c                  | 2 +-
 tools/testing/selftests/bpf/verifier/calls.c                | 6 +++---
 tools/testing/selftests/bpf/xdping.c                        | 2 +-
 tools/testing/selftests/bpf/xsk.h                           | 2 +-
 22 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 87551628e112..a66d9173609d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -392,7 +392,7 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 		    DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
 endif
 
-# vmlinux.h is first dumped to a temprorary file and then compared to
+# vmlinux.h is first dumped to a temporary file and then compared to
 # the previous version. This helps to avoid unnecessary re-builds of
 # $(TRUNNER_BPF_OBJS)
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 1bd403a5ef7b..b25db4142126 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -497,7 +497,7 @@ extern const struct bench bench_rename_rawtp;
 extern const struct bench bench_rename_fentry;
 extern const struct bench bench_rename_fexit;
 
-/* pure counting benchmarks to establish theoretical lmits */
+/* pure counting benchmarks to establish theoretical limits */
 extern const struct bench bench_trig_usermode_count;
 extern const struct bench bench_trig_syscall_count;
 extern const struct bench bench_trig_kernel_count;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index b293b8501fd6..2b434038d5af 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -63,7 +63,7 @@ static int test_btf_dump_case(int n, struct btf_dump_test_case *t)
 
 	/* tests with t->known_ptr_sz have no "long" or "unsigned long" type,
 	 * so it's impossible to determine correct pointer size; but if they
-	 * do, it should be 8 regardless of host architecture, becaues BPF
+	 * do, it should be 8 regardless of host architecture, because BPF
 	 * target is always 64-bit
 	 */
 	if (!t->known_ptr_sz) {
diff --git a/tools/testing/selftests/bpf/prog_tests/fd_array.c b/tools/testing/selftests/bpf/prog_tests/fd_array.c
index a1d52e73fb16..ab0fe7add9dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/fd_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/fd_array.c
@@ -293,7 +293,7 @@ static int get_btf_id_by_fd(int btf_fd, __u32 *id)
  *  1) Create a new btf, it's referenced only by a file descriptor, so refcnt=1
  *  2) Load a BPF prog with fd_array[0] = btf_fd; now btf's refcnt=2
  *  3) Close the btf_fd, now refcnt=1
- * Wait and check that BTF stil exists.
+ * Wait and check that BTF still exists.
  */
 static void check_fd_array_cnt__referenced_btfs(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e19ef509ebf8..f377bea0b82d 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -463,7 +463,7 @@ static bool skip_entry(char *name)
 	return false;
 }
 
-/* Do comparision by ignoring '.llvm.<hash>' suffixes. */
+/* Do comparison by ignoring '.llvm.<hash>' suffixes. */
 static int compare_name(const char *name1, const char *name2)
 {
 	const char *res1, *res2;
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 39d42271cc46..de302ecd5f58 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -609,7 +609,7 @@ static void range_cond(enum num_t t, struct range x, struct range y,
 			*newx = range(t, x.a, x.b);
 			*newy = range(t, y.a + 1, y.b);
 		} else if (x.a == x.b && x.b == y.b) {
-			/* X is a constant matching rigth side of Y */
+			/* X is a constant matching right side of Y */
 			*newx = range(t, x.a, x.b);
 			*newy = range(t, y.a, y.b - 1);
 		} else if (y.a == y.b && x.a == y.a) {
@@ -617,7 +617,7 @@ static void range_cond(enum num_t t, struct range x, struct range y,
 			*newx = range(t, x.a + 1, x.b);
 			*newy = range(t, y.a, y.b);
 		} else if (y.a == y.b && x.b == y.b) {
-			/* Y is a constant matching rigth side of X */
+			/* Y is a constant matching right side of X */
 			*newx = range(t, x.a, x.b - 1);
 			*newy = range(t, y.a, y.b);
 		} else {
diff --git a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
index 1654a530aa3d..4e51785e7606 100644
--- a/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
+++ b/tools/testing/selftests/bpf/progs/bpf_cc_cubic.c
@@ -101,7 +101,7 @@ static void tcp_cwnd_reduction(struct sock *sk, int newly_acked_sacked,
 	tp->snd_cwnd = pkts_in_flight + sndcnt;
 }
 
-/* Decide wheather to run the increase function of congestion control. */
+/* Decide whether to run the increase function of congestion control. */
 static bool tcp_may_raise_cwnd(const struct sock *sk, const int flag)
 {
 	if (tcp_sk(sk)->reordering > TCP_REORDERING)
diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 7cd73e75f52a..32c511bcd60b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 
-/* WARNING: This implemenation is not necessarily the same
+/* WARNING: This implementation is not necessarily the same
  * as the tcp_dctcp.c.  The purpose is mainly for testing
  * the kernel BPF logic.
  */
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
index 624078abf3de..d7e30ee576c9 100644
--- a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -7,7 +7,7 @@
 
 SEC("freplace/btf_unreliable_kprobe")
 /* context type is what BPF verifier expects for kprobe context, but target
- * program has `stuct whatever *ctx` argument, so freplace operation will be
+ * program has `struct whatever *ctx` argument, so freplace operation will be
  * rejected with the following message:
  *
  * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match btf_unreliable_kprobe(struct whatever *)
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index f41257eadbb2..b381ac0c736c 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -345,7 +345,7 @@ int __naked read_from_iter_slot_fail(void)
 		"r3 = 1000;"
 		"call %[bpf_iter_num_new];"
 
-		/* attemp to leak bpf_iter_num state */
+		/* attempt to leak bpf_iter_num state */
 		"r7 = *(u64 *)(r6 + 0);"
 		"r8 = *(u64 *)(r6 + 8);"
 
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
index d0f7670351e5..dfd4a2710391 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
@@ -494,7 +494,7 @@ static ret_t get_next_hop(struct bpf_dynptr *dynptr, __u64 *offset, encap_header
 
 	*offset += sizeof(*next_hop);
 
-	/* Skip the remainig next hops (may be zero). */
+	/* Skip the remaining next hops (may be zero). */
 	return skip_next_hops(offset, encap->unigue.hop_count - encap->unigue.next_hop - 1);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
index ca8e8734d901..f0c58519cab1 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -21,7 +21,7 @@
  *  ns_src   |              ns_fwd             |   ns_dst
  *
  * ns_src and ns_dst: ENDHOST namespace
- *            ns_fwd: Fowarding namespace
+ *            ns_fwd: Forwarding namespace
  */
 
 #define ctx_ptr(field)		(void *)(long)(field)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
index fe49f2cb5360..d15f49ed93f1 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_verifier.c
@@ -10,14 +10,14 @@ char _license[] SEC("license") = "GPL";
 
 SEC("uprobe.session")
 __success
-int uprobe_sesison_return_0(struct pt_regs *ctx)
+int uprobe_session_return_0(struct pt_regs *ctx)
 {
 	return 0;
 }
 
 SEC("uprobe.session")
 __success
-int uprobe_sesison_return_1(struct pt_regs *ctx)
+int uprobe_session_return_1(struct pt_regs *ctx)
 {
 	return 1;
 }
@@ -25,7 +25,7 @@ int uprobe_sesison_return_1(struct pt_regs *ctx)
 SEC("uprobe.session")
 __failure
 __msg("At program exit the register R0 has smin=2 smax=2 should have been in [0, 1]")
-int uprobe_sesison_return_2(struct pt_regs *ctx)
+int uprobe_session_return_2(struct pt_regs *ctx)
 {
 	return 2;
 }
diff --git a/tools/testing/selftests/bpf/progs/uretprobe_stack.c b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
index 9fdcf396b8f4..cbc428a80744 100644
--- a/tools/testing/selftests/bpf/progs/uretprobe_stack.c
+++ b/tools/testing/selftests/bpf/progs/uretprobe_stack.c
@@ -27,7 +27,7 @@ SEC("uprobe//proc/self/exe:target_1")
 int BPF_UPROBE(uprobe_1)
 {
 	/* target_1 is recursive wit depth of 2, so we capture two separate
-	 * stack traces, depending on which occurence it is
+	 * stack traces, depending on which occurrence it is
 	 */
 	static bool recur = false;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index e07b43b78fd2..cd4ee4d38cf6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -261,7 +261,7 @@ l0_%=:	r2 += r1;					\
 
 SEC("xdp")
 __success
-__naked void not_an_inifinite_loop(void)
+__naked void not_an_infinite_loop(void)
 {
 	asm volatile ("					\
 	call %[bpf_get_prandom_u32];			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 7c5e5e6d10eb..dba3ca728f6e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -349,7 +349,7 @@ __naked void precision_two_ids(void)
 SEC("socket")
 __success __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-/* check thar r0 and r6 have different IDs after 'if',
+/* check that r0 and r6 have different IDs after 'if',
  * collect_linked_regs() can't tie more than 6 registers for a single insn.
  */
 __msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index fda7589c5023..b80b3bc17575 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -306,7 +306,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
  * Update 1 to tgt_free/2
  *   => The original 1 to tgt_free/2 will be removed due to
  *      the LRU shrink process
- * Re-insert 1 to tgt_free/2 again and do a lookup immeidately
+ * Re-insert 1 to tgt_free/2 again and do a lookup immediately
  * Insert 1+tgt_free to tgt_free*3/2
  * Insert 1+tgt_free*3/2 to tgt_free*5/2
  *   => Key 1+tgt_free to tgt_free*3/2
@@ -371,7 +371,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	}
 
 	/* Re-insert 1 to tgt_free/2 again and do a lookup
-	 * immeidately.
+	 * immediately.
 	 */
 	end_key = 1 + batch_size;
 	value[0] = 4321;
diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
index 1e565f47aca9..37c31e53cc6e 100755
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
@@ -164,7 +164,7 @@ setup()
 		ip -netns ${NS2} link set veth7 vrf red
 	fi
 
-	# configure addesses: the top route (1-2-3-4)
+	# configure addresses: the top route (1-2-3-4)
 	ip -netns ${NS1}    addr add ${IPv4_1}/24  dev veth1
 	ip -netns ${NS2}    addr add ${IPv4_2}/24  dev veth2
 	ip -netns ${NS2}    addr add ${IPv4_3}/24  dev veth3
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index fd2da2234cc9..76568db7a664 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1372,7 +1372,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	} else
 		fprintf(stderr, "unknown test\n");
 out:
-	/* Detatch and zero all the maps */
+	/* Detach and zero all the maps */
 	bpf_prog_detach2(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS);
 
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 18596ae0b0c1..e0ce0a7ed774 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1375,7 +1375,7 @@
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
-	/* fetch secound map_value_ptr from the stack */
+	/* fetch second map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -16),
 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
 	/* write into map value */
@@ -1439,7 +1439,7 @@
 	/* second time with fp-16 */
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 1, 2),
-	/* fetch secound map_value_ptr from the stack */
+	/* fetch second map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
@@ -1493,7 +1493,7 @@
 	/* second time with fp-16 */
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	/* fetch secound map_value_ptr from the stack */
+	/* fetch second map_value_ptr from the stack */
 	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, 0),
 	/* write into map value */
 	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index 1503a1d2faa0..9ed8c796645d 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -155,7 +155,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!server) {
-		/* Only supports IPv4; see hints initiailization above. */
+		/* Only supports IPv4; see hints initialization above. */
 		if (getaddrinfo(argv[optind], NULL, &hints, &a) || !a) {
 			fprintf(stderr, "Could not resolve %s\n", argv[optind]);
 			return 1;
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index 93c2cc413cfc..73d01518bf84 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -94,7 +94,7 @@ static inline __u32 xsk_prod_nb_free(struct xsk_ring_prod *r, __u32 nb)
 	 * cached_cons is r->size bigger than the real consumer pointer so
 	 * that this addition can be avoided in the more frequently
 	 * executed code that computs free_entries in the beginning of
-	 * this function. Without this optimization it whould have been
+	 * this function. Without this optimization it would have been
 	 * free_entries = r->cached_prod - r->cached_cons + r->size.
 	 */
 	r->cached_cons = __atomic_load_n(r->consumer, __ATOMIC_ACQUIRE);
-- 
2.47.2


