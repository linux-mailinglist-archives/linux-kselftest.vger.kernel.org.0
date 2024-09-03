Return-Path: <linux-kselftest+bounces-17020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ED969569
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52E3B224FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E61D6C7F;
	Tue,  3 Sep 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RWWYqfra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168381D54F2;
	Tue,  3 Sep 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348560; cv=none; b=pUYINm2dup/wRR6T4gbERDh90fwR4C4CaV9SKeq0GxCpZGS8I2m/h4K4Kph/+10pvnoiwpGPoyI75QIFXoT0Iu8ymepsgw0I98fAkLGFqwvJgHa65/SxJhbWWZqVYVnAk7r4VOXn9KqMGUX+mliAjYyjo0m96Gqu6eEodAkXVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348560; c=relaxed/simple;
	bh=ht9X6hMbbQFDtystccUaqRuUj/Q+XQredwL13eat6v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAl7CvsjEKK8yRrLJnmPeJR1M/NH2nMieQLxDS3cwSkrqaprR0x+UJjnC1hIP7ge9htDdEhrLPPBIetJmguXqqTtE9WsBCRtlB9I1AZsEtDl7VtIBZ80rs4pvYKPrkwSTcpw0ehrcd6NKMhRxAI2//pHzF2c0whaeWtMI7Q5miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RWWYqfra; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ncpbi
	4bDSuRFtz4GhQxasSaf6qj1oJ5TgIjN7n9LAbo=; b=RWWYqfraaNCvWiAdppS+X
	kqbJN1VGK8iMCzEeDoxe1yJZX89tcw/ruS6lbwUlsshLZB/O4ld9q0qD5gcAyy6Z
	FKuhPt28OKOt07hNpvAmy1/6JPYZKVEWOPDXWnj0jyW/yvZ1TGWqpVINEx8PHMLS
	gCaFEmUikLJ3HsBs8KPJjE=
Received: from localhost.localdomain (unknown [111.48.69.246])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3Xy0HutZmr9mTBQ--.40251S2;
	Tue, 03 Sep 2024 15:26:01 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: bpf: Replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE
Date: Tue,  3 Sep 2024 15:25:59 +0800
Message-Id: <20240903072559.292607-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Xy0HutZmr9mTBQ--.40251S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGr13GryfJry3uF1DtF1UKFg_yoWDXFW5pa
	4kA34jkF1fJF1aqw1UGrsF9F4rWF4DXFWYkr48try5Zr47Xr97XF4xKFWaqF93WrZYvrn3
	Za4IqrZxZw48ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5YFAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQpPeGXAoLOxggAAsd

From: Feng Yang <yangfeng@kylinos.cn>

The ARRAY_SIZE macro is more compact and more formal in linux source.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/fexit_stress.c        | 3 ++-
 tools/testing/selftests/bpf/prog_tests/log_buf.c             | 5 +++--
 .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 3 ++-
 .../bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c      | 3 ++-
 .../selftests/bpf/prog_tests/raw_tp_writable_test_run.c      | 5 +++--
 tools/testing/selftests/bpf/prog_tests/tc_opts.c             | 2 +-
 tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c | 3 ++-
 tools/testing/selftests/bpf/progs/syscall.c                  | 3 ++-
 tools/testing/selftests/bpf/progs/test_rdonly_maps.c         | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_bits_iter.c       | 2 +-
 10 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 49b1ffc9af1f..14c91b6f1e83 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 Facebook */
 #include <test_progs.h>
+#include "bpf_util.h"
 
 void serial_test_fexit_stress(void)
 {
@@ -36,7 +37,7 @@ void serial_test_fexit_stress(void)
 	for (i = 0; i < bpf_max_tramp_links; i++) {
 		fexit_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
 					    trace_program,
-					    sizeof(trace_program) / sizeof(struct bpf_insn),
+					    ARRAY_SIZE(trace_program),
 					    &trace_opts);
 		if (!ASSERT_GE(fexit_fd[i], 0, "fexit load"))
 			goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index 0f7ea4d7d9f6..46611040dec3 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -5,6 +5,7 @@
 #include <bpf/btf.h>
 
 #include "test_log_buf.skel.h"
+#include "bpf_util.h"
 
 static size_t libbpf_log_pos;
 static char libbpf_log_buf[1024 * 1024];
@@ -143,11 +144,11 @@ static void bpf_prog_load_log_buf(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	const size_t good_prog_insn_cnt = sizeof(good_prog_insns) / sizeof(struct bpf_insn);
+	const size_t good_prog_insn_cnt = ARRAY_SIZE(good_prog_insns);
 	const struct bpf_insn bad_prog_insns[] = {
 		BPF_EXIT_INSN(),
 	};
-	size_t bad_prog_insn_cnt = sizeof(bad_prog_insns) / sizeof(struct bpf_insn);
+	size_t bad_prog_insn_cnt = ARRAY_SIZE(bad_prog_insns);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	const size_t log_buf_sz = 1024 * 1024;
 	char *log_buf;
diff --git a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
index aa9f67eb1c95..bea05f78de5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
+++ b/tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c
@@ -4,6 +4,7 @@
 #include <bpf/btf.h>
 #include "bpf/libbpf_internal.h"
 #include "cgroup_helpers.h"
+#include "bpf_util.h"
 
 static const char *module_name = "bpf_testmod";
 static const char *symbol_name = "bpf_fentry_shadow_test";
@@ -100,7 +101,7 @@ void test_module_fentry_shadow(void)
 		load_opts.attach_btf_obj_fd = btf_fd[i];
 		prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
 					   trace_program,
-					   sizeof(trace_program) / sizeof(struct bpf_insn),
+					   ARRAY_SIZE(trace_program),
 					   &load_opts);
 		if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
 			goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
index e2f1445b0e10..216b0dfac0fe 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include <linux/nbd.h>
+#include "bpf_util.h"
 
 void test_raw_tp_writable_reject_nbd_invalid(void)
 {
@@ -25,7 +26,7 @@ void test_raw_tp_writable_reject_nbd_invalid(void)
 	);
 
 	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
-			       program, sizeof(program) / sizeof(struct bpf_insn),
+			       program, ARRAY_SIZE(program),
 			       &opts);
 	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable load",
 		  "failed: %d errno %d\n", bpf_fd, errno))
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
index f4aa7dab4766..e3668058b7bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_test_run.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include <linux/nbd.h>
+#include "bpf_util.h"
 
 /* NOTE: conflict with other tests. */
 void serial_test_raw_tp_writable_test_run(void)
@@ -24,7 +25,7 @@ void serial_test_raw_tp_writable_test_run(void)
 	);
 
 	int bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
-				   trace_program, sizeof(trace_program) / sizeof(struct bpf_insn),
+				   trace_program, ARRAY_SIZE(trace_program),
 				   &trace_opts);
 	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable loaded",
 		  "failed: %d errno %d\n", bpf_fd, errno))
@@ -41,7 +42,7 @@ void serial_test_raw_tp_writable_test_run(void)
 	);
 
 	int filter_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL v2",
-				      skb_program, sizeof(skb_program) / sizeof(struct bpf_insn),
+				      skb_program, ARRAY_SIZE(skb_program),
 				      &skb_opts);
 	if (CHECK(filter_fd < 0, "test_program_loaded", "failed: %d errno %d\n",
 		  filter_fd, errno))
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
index 196abf223465..f77f604389aa 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
@@ -2384,7 +2384,7 @@ static int generate_dummy_prog(void)
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
+	const size_t prog_insn_cnt = ARRAY_SIZE(prog_insns);
 	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	const size_t log_buf_sz = 256;
 	char log_buf[log_buf_sz];
diff --git a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
index 0adf8d9475cb..472f4f9fa95f 100644
--- a/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
+++ b/tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
@@ -7,6 +7,7 @@
 #include "test_unpriv_bpf_disabled.skel.h"
 
 #include "cap_helpers.h"
+#include "bpf_util.h"
 
 /* Using CAP_LAST_CAP is risky here, since it can get pulled in from
  * an old /usr/include/linux/capability.h and be < CAP_BPF; as a result
@@ -146,7 +147,7 @@ static void test_unpriv_bpf_disabled_negative(struct test_unpriv_bpf_disabled *s
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	const size_t prog_insn_cnt = sizeof(prog_insns) / sizeof(struct bpf_insn);
+	const size_t prog_insn_cnt = ARRAY_SIZE(prog_insns);
 	LIBBPF_OPTS(bpf_prog_load_opts, load_opts);
 	struct bpf_map_info map_info = {};
 	__u32 map_info_len = sizeof(map_info);
diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 3d3cafdebe72..0f4dfb770c32 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -8,6 +8,7 @@
 #include <linux/btf.h>
 #include <string.h>
 #include <errno.h>
+#include "bpf_misc.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -119,7 +120,7 @@ int load_prog(struct args *ctx)
 	static __u64 value = 34;
 	static union bpf_attr prog_load_attr = {
 		.prog_type = BPF_PROG_TYPE_XDP,
-		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+		.insn_cnt = ARRAY_SIZE(insns),
 	};
 	int ret;
 
diff --git a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
index fc8e8a34a3db..7035fb4d4165 100644
--- a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
+++ b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
@@ -4,6 +4,7 @@
 #include <linux/ptrace.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 const struct {
 	unsigned a[4];
@@ -64,7 +65,7 @@ int full_loop(struct pt_regs *ctx)
 {
 	/* prevent compiler to optimize everything out */
 	unsigned * volatile p = (void *)&rdonly_values.a;
-	int i = sizeof(rdonly_values.a) / sizeof(rdonly_values.a[0]);
+	int i = ARRAY_SIZE(rdonly_values.a);
 	unsigned iters = 0, sum = 0;
 
 	/* validate verifier can allow full loop as well */
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
index 716113c2bce2..f4da4d508ddb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -87,7 +87,7 @@ int bits_memalloc(void)
 	int *bit;
 
 	__builtin_memset(&data, 0xf0, sizeof(data)); /* 4 * 16 */
-	bpf_for_each(bits, bit, &data[0], sizeof(data) / sizeof(u64))
+	bpf_for_each(bits, bit, &data[0], ARRAY_SIZE(data))
 		nr++;
 	return nr;
 }
-- 
2.27.0


