Return-Path: <linux-kselftest+bounces-17560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC5F97266B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 02:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25021F24E42
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 00:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650A59167;
	Tue, 10 Sep 2024 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BPIPk2sg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idH1ovM8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304823AB;
	Tue, 10 Sep 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929710; cv=none; b=dTyjb7DAnm50jR65l074eaabZ3SNiNDqtdiI+u5us1iF2eQ/grrYBpyc7i9saSMG/KxYqcj1p20fkUYZVw+BzI8QBRlr1hrNmDcWWInU7krlUyN6x/PZduF3IFcwV/EM7ymZADByMIH+p7thInbXGDr17lcpRWG2UrDoc8/z4cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929710; c=relaxed/simple;
	bh=7TAk0PYd+/kgFJ65jdPi3CyfGRtcJdBhAoMcPCN9Nbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZQluf3MzvA5XM2g+h/Yvesov+2PYJVWNlAyxvi++D4/gH7rZzk1pbfmz338XyZjlQ4K61Eyz6sRNIxAmUBSz2ovMoqSpYpc78ADIDU8yD2kEm5JqTEQZ0wShG+NflDjIwxlggatsUSLtJU0qbpGHoZe/QbewGnThzA32ZwEtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BPIPk2sg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idH1ovM8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DA2461380299;
	Mon,  9 Sep 2024 20:55:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 09 Sep 2024 20:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1725929706; x=1726016106; bh=Wg5xZP0V6We1FuxhlwgQo
	yCPN1ooTx+DvSYkmNc5izo=; b=BPIPk2sg8gCwXp+awGOBaJZlKFa6HBdKP0IOc
	F7WuA5LQLGuu2snXonOqL7M8SZ/UkxIPszXdk/mrkxHs64DiNR4h+S5vv/NSsfCP
	JWKeknWzb8815HOniOQniiaegIEnRmAFSDuNHjoTCJfeDor/ERR/LGbbFv9vBkhE
	/N539rCcqSGKZHak7m2KfTDTz+G2T7rBJb1yIxmvCCNbXbBe1o70AjzLFVVWATxa
	crzdHmk2Eq/0XqXCC0fv5x3ax4C4MgANUsy4HTm4q5vFBD8hKZaoxNax7lIK63JB
	R1G3qLqOwoy+lSI96sCReZ1dDDuhdFz3YbdRDftPqNUKPy4qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725929706; x=1726016106; bh=Wg5xZP0V6We1FuxhlwgQoyCPN1oo
	Tx+DvSYkmNc5izo=; b=idH1ovM8yob87nUah3Dg6reRoa7yOWDBBlg3pcZa+b7S
	JC23H4acBr6aF8gqN2L5z+PIDQgj0XSqrA7mrI5/++YI+S8q4X71HqByGBN5dDwe
	hmfV8AjOIQNUJcz53/wBKNEyLJrLEvF3uFVs+yDycNZOqPTZAmK9INLlVWaSfFbs
	zYDTzIpuhHe9ZA+eIEOo02vl6YT5PliKRbEuEk2qJeTvxnJmTW5S2o63W/gilcCG
	hX9PFUiuOapeFJTPNDuKv65tNmLh4xehIuyljToANgKr8sPlmU1dBbieuWBmzrS4
	/oSSPwD2Lc00uD7WTFfViGEofCvCK5JSy1yYc0uO/A==
X-ME-Sender: <xms:6pjfZsSQws83NLU758ztaSEOYWs7x8hL4JVHgVzoTJs016zaqVJhhw>
    <xme:6pjfZpzXjfg2iBBBdMrvAYnHANhX02-PzQM6StOc2kS6srrZPLdfLW6jrrEdIbzbj
    DTqwL8PxRfg9gEDUw>
X-ME-Received: <xmr:6pjfZp1NS0cGvVfkzr5utGkXp7jht16OtT8lCa5LD2gfoYVLPgqkddYCaGHIacF3pfh6Nqv9Vyldwr2o6HioV4HCE1wmLcaWEa77jWx-7jPgfogQcXOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepff
    eiteeuffetffefieefgeejheejgfevudffhffgleejtefghfevvddvkeejhfdunecuffho
    mhgrihhnpehrihhnghgsuhhfrdhmrghpnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthht
    ohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvugguhiiikeejsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrsh
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprh
    gtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopehs
    ohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngh
    eslhhinhhugidruggvvh
X-ME-Proxy: <xmx:6pjfZgCGavqUtgMquzh7Ngi6U4a79hwvKqf4xvwhjl4r2LTvFKyw3A>
    <xmx:6pjfZljSAhjlsuSelaGXWsIgGmfAp1UscmXT2C83fpIywimD-57VzQ>
    <xmx:6pjfZso7NXxxj0LsM2uzKzwK09MoG2_CIbaOvd54SGvuAASXGATcmA>
    <xmx:6pjfZoiCN3MPID3SQ1Z732EdQuB6faVPZEn7BJo9SD4rV4S23QRj0g>
    <xmx:6pjfZuYKuP_i-Yafyy58pZKz_BnvCof9S-xept3OZEalBERROn5neJi3>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 20:55:03 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: eddyz87@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	shuah@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: ringbuf: Support consuming BPF_MAP_TYPE_RINGBUF from prog
Date: Mon,  9 Sep 2024 18:54:52 -0600
Message-ID: <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now there exists prog produce / userspace consume and userspace
produce / prog consume support. But it is also useful to have prog
produce / prog consume.

For example, we want to track the latency overhead of cpumap in
production. Since we need to store enqueue timestamps somewhere and
cpumap is MPSC, we need an MPSC data structure to shadow cpumap. BPF
ringbuf is such a data structure. Rather than reimplement (possibly
poorly) a custom ringbuffer in BPF, extend the existing interface to
allow the final quadrant of ringbuf usecases to be filled. Note we
ignore userspace to userspace use case - there is no need to involve
kernel for that.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         |  6 +-
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 50 +++++++++++++++
 .../bpf/progs/test_ringbuf_bpf_to_bpf.c       | 64 +++++++++++++++++++
 4 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53d0556fbbf3..56bfe559f228 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9142,7 +9142,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_ringbuf_query &&
 		    func_id != BPF_FUNC_ringbuf_reserve_dynptr &&
 		    func_id != BPF_FUNC_ringbuf_submit_dynptr &&
-		    func_id != BPF_FUNC_ringbuf_discard_dynptr)
+		    func_id != BPF_FUNC_ringbuf_discard_dynptr &&
+		    func_id != BPF_FUNC_user_ringbuf_drain)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_USER_RINGBUF:
@@ -9276,7 +9277,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_user_ringbuf_drain:
-		if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
+		if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF &&
+		    map->map_type != BPF_MAP_TYPE_RINGBUF)
 			goto error;
 		break;
 	case BPF_FUNC_get_stackid:
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 9905e3739dd0..233109843d4d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -503,7 +503,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
+	test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
+	test_ringbuf_bpf_to_bpf.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index da430df45aa4..3e7955573ac5 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -17,6 +17,7 @@
 #include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 #include "test_ringbuf_write.lskel.h"
+#include "test_ringbuf_bpf_to_bpf.lskel.h"
 
 #define EDONE 7777
 
@@ -497,6 +498,53 @@ static void ringbuf_map_key_subtest(void)
 	test_ringbuf_map_key_lskel__destroy(skel_map_key);
 }
 
+static void ringbuf_bpf_to_bpf_subtest(void)
+{
+	struct test_ringbuf_bpf_to_bpf_lskel *skel;
+	int err, i;
+
+	skel = test_ringbuf_bpf_to_bpf_lskel__open();
+	if (!ASSERT_OK_PTR(skel, "test_ringbuf_bpf_to_bpf_lskel__open"))
+		return;
+
+	skel->maps.ringbuf.max_entries = getpagesize();
+	skel->bss->pid = getpid();
+
+	err = test_ringbuf_bpf_to_bpf_lskel__load(skel);
+	if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__load"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel->maps.ringbuf.map_fd, NULL, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	err = test_ringbuf_bpf_to_bpf_lskel__attach(skel);
+	if (!ASSERT_OK(err, "test_ringbuf_bpf_to_bpf_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	/* Produce N_SAMPLES samples in the ring buffer by calling getpid() */
+	skel->bss->value = SAMPLE_VALUE;
+	for (i = 0; i < N_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	/* Trigger bpf-side consumption */
+	syscall(__NR_prctl);
+
+	/* Check correct number samples were consumed */
+	if (!ASSERT_EQ(skel->bss->round_tripped, N_SAMPLES, "round_tripped"))
+		goto cleanup_ringbuf;
+
+	/* Check all samples were consumed */
+	err = ring_buffer__consume(ringbuf);
+	if (!ASSERT_EQ(err, 0, "rb_consume"))
+		goto cleanup_ringbuf;
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_bpf_to_bpf_lskel__destroy(skel);
+}
+
 void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
@@ -507,4 +555,6 @@ void test_ringbuf(void)
 		ringbuf_map_key_subtest();
 	if (test__start_subtest("ringbuf_write"))
 		ringbuf_write_subtest();
+	if (test__start_subtest("ringbuf_bpf_to_bpf"))
+		ringbuf_bpf_to_bpf_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c b/tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c
new file mode 100644
index 000000000000..378154922024
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_bpf_to_bpf.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <unistd.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct sample {
+	long value;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int pid = 0;
+long value = 0;
+int round_tripped = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_bpf_to_bpf_produce(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+	sample->value = value;
+
+	bpf_ringbuf_submit(sample, 0);
+	return 0;
+}
+
+static long consume_cb(struct bpf_dynptr *dynptr, void *context)
+{
+	struct sample *sample = NULL;
+
+	sample = bpf_dynptr_data(dynptr, 0, sizeof(*sample));
+	if (!sample)
+		return 0;
+
+	if (sample->value == value)
+		round_tripped++;
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_prctl")
+int test_ringbuf_bpf_to_bpf_consume(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != pid)
+		return 0;
+
+	bpf_user_ringbuf_drain(&ringbuf, consume_cb, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.46.0


