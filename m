Return-Path: <linux-kselftest+bounces-24516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36412A111F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7B9188ACB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5620C030;
	Tue, 14 Jan 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H/b78WsQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJyZtbWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB320F096;
	Tue, 14 Jan 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886558; cv=none; b=heND6ujdfBDe00vQY+DA5fY2PNnMv+xDxwiiR0QPWkOaObE7QAxedLu6IlplvI3g2mokNh42/NZuVtzg4qFqN3UdM83tw6Yi4OutMzmOxs5hjcR+DvbpoShfddtqBJUUyL66Zf2OY+2SYwEhDzqQC2px8pc4r33JN57NmIzBWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886558; c=relaxed/simple;
	bh=MhtQTfNzlQ3tsKqwl5lM43sNtekGx4WB6JQmq98WyGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCEU1cfkwBXkaplnCSNUZbp9fWmFPdl8kGyKzYu6z7SsRTegAF5aT1irDzY934yTzuYgYkQvuA7zQUHgLAYHHr9ltd/x2IS2gsDSBY/tktmMzmGtd6+QLL8shzefRorxqt0t3gOH6ymQtgNI5RUBm++VXx9+izQ2IenmpmGASvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=H/b78WsQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJyZtbWq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2279111400D8;
	Tue, 14 Jan 2025 15:29:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jan 2025 15:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736886552; x=
	1736972952; bh=tPLVDZkancaTDemgUaoWTMsE0V6WQ6n9aGnjEoOUFOg=; b=H
	/b78WsQUA6s/mc7XNOOeGEdlgfka8Jz09b7B4suRcJAvE/qMPJgGdA0x2Vjw5nx9
	IRptk5WZoe2q5a92zZ7UkXdqh0ALxI0RQsI/mIKmfFqQPAwuGvu60MsYCovtBSVd
	BAIYpCekLVl1Pbq4hjCN2ICbnWlnS8NEKsRMut+6WTLrOmNOY6pnIoR5aIF2BwlN
	I/Yb+oyNJWmhZgixHXeH+KCfnkzdhJvPs/qMa1GqsAbwP+JfY7PGHqiG50O6XjgW
	ng+PjcoWSWH30xBcL7xRM2pwznTmFr5pST302bXAznGSI2llXNPnwN51J27xuC+v
	D4/BtMPr4noqBYYIYrKBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736886552; x=1736972952; bh=t
	PLVDZkancaTDemgUaoWTMsE0V6WQ6n9aGnjEoOUFOg=; b=gJyZtbWqOjgsNTGFl
	X4gWJjCBrQyYKy7uxi/GpaEr9BqhXrJgFuUr+VReeUWH3VtwSx+YWomCmthkmysv
	gjv0mSY9MY8Wv3ZydrMlPAPHjaNPK9ItsMqLomOeZdSe1i+AOcQXy+JYxjAB03kd
	Jzp4S0MOCK4qezyQmFxh8MJJsYc/xoeA8EK1gBsh0r5C5f/AyAwQgRJ/A8KM8X/Z
	sXPcDEnuKC9uZs4yUjCYNGJVeaJVoJo9m8rh6Zg/VvHXXEynvLRMhysstSwuqrDf
	2uvxJmSmVLZJcPf+0UO5z3FXNCbpWWE8qyZ8PZu1BB4eHI1WxpLMJCdvuCcAqG9G
	lntIw==
X-ME-Sender: <xms:GMmGZ4ZZC2swDdx_on5PaJqrp36XjzIg9Cfb37LjM2-DPJ6VtnkLUw>
    <xme:GMmGZzaewclf3zZKHhPigX-jinl5LYgSYhhqE7Zb_q73SE-f0dMcDAcFaXjlwQFZQ
    51gLJshnDzy_6xf2g>
X-ME-Received: <xmr:GMmGZy85vYB0TZTLRrQdkNx4U_QG_VsvbUrDu-gxdCmfOk0W6WJCZ4B-V6UoglghSIAs1LFJV59HmTn5bGUCHAYvSgpQJLfLviRMj5JOuuxdILPyWp60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguug
    ihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtth
    hopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghuse
    hlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:GMmGZyr_KJA80kKUfeJmKrjSPeuuW4Ozkks2doG7iPGDeC1y3bTBzQ>
    <xmx:GMmGZzolsBnX-r3JGa-eDnuKElrRiKbyg-0-50wlN2ZMgFZ1MfN_7A>
    <xmx:GMmGZwSS0E857OtHtHkl4tu_ocT1DAIRoi91G3hpV_zcIvc2N7G41Q>
    <xmx:GMmGZzpVS-UWvAAfhgr_KgdEDFQ55tc1sSoAP1Pl5BIzxqUlW-XbtQ>
    <xmx:GMmGZ68apXB1DkfgkFQ1ccQzdRDnbDwIWTGkR2kOZAuIentP-Br3XxGd>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:10 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 3/5] bpf: verifier: Refactor helper access type tracking
Date: Tue, 14 Jan 2025 13:28:44 -0700
Message-ID: <ff885c0e5859e0cd12077c3148ff0754cad4f7ed.1736886479.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736886479.git.dxu@dxuuu.xyz>
References: <cover.1736886479.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the verifier was treating all PTR_TO_STACK registers passed
to a helper call as potentially written to by the helper. However, all
calls to check_stack_range_initialized() already have precise access type
information available.

Rather than treat ACCESS_HELPER as a proxy for BPF_WRITE, pass
enum bpf_access_type to check_stack_range_initialized() to more
precisely track helper arguments.

One benefit from this precision is that registers tracked as valid
spills and passed as a read-only helper argument remain tracked after
the call.  Rather than being marked STACK_MISC afterwards.

An additional benefit is the verifier logs are also more precise. For
this particular error, users will enjoy a slightly clearer message. See
included selftest updates for examples.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         | 45 +++++++------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +--
 .../selftests/bpf/progs/test_global_func10.c  |  2 +-
 .../selftests/bpf/progs/uninit_stack.c        |  5 ++-
 .../bpf/progs/verifier_basic_stack.c          |  2 +-
 .../selftests/bpf/progs/verifier_const_or.c   |  4 +-
 .../progs/verifier_helper_access_var_len.c    | 12 ++---
 .../selftests/bpf/progs/verifier_int_ptr.c    |  2 +-
 .../selftests/bpf/progs/verifier_mtu.c        |  2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  8 ++--
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 13 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8879977eb9eb..b71858390e65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5303,7 +5303,7 @@ enum bpf_access_src {
 static int check_stack_range_initialized(struct bpf_verifier_env *env,
 					 int regno, int off, int access_size,
 					 bool zero_size_allowed,
-					 enum bpf_access_src type,
+					 enum bpf_access_type type,
 					 struct bpf_call_arg_meta *meta);
 
 static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
@@ -5336,7 +5336,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
 	err = check_stack_range_initialized(env, ptr_regno, off, size,
-					    false, ACCESS_DIRECT, NULL);
+					    false, BPF_READ, NULL);
 	if (err)
 		return err;
 
@@ -7190,7 +7190,7 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
 static int check_stack_access_within_bounds(
 		struct bpf_verifier_env *env,
 		int regno, int off, int access_size,
-		enum bpf_access_src src, enum bpf_access_type type)
+		enum bpf_access_type type)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
@@ -7199,10 +7199,7 @@ static int check_stack_access_within_bounds(
 	int err;
 	char *err_extra;
 
-	if (src == ACCESS_HELPER)
-		/* We don't know if helpers are reading or writing (or both). */
-		err_extra = " indirect access to";
-	else if (type == BPF_READ)
+	if (type == BPF_READ)
 		err_extra = " read from";
 	else
 		err_extra = " write to";
@@ -7420,7 +7417,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 	} else if (reg->type == PTR_TO_STACK) {
 		/* Basic bounds checks. */
-		err = check_stack_access_within_bounds(env, regno, off, size, ACCESS_DIRECT, t);
+		err = check_stack_access_within_bounds(env, regno, off, size, t);
 		if (err)
 			return err;
 
@@ -7640,13 +7637,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 static int check_stack_range_initialized(
 		struct bpf_verifier_env *env, int regno, int off,
 		int access_size, bool zero_size_allowed,
-		enum bpf_access_src type, struct bpf_call_arg_meta *meta)
+		enum bpf_access_type type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno);
 	struct bpf_func_state *state = func(env, reg);
 	int err, min_off, max_off, i, j, slot, spi;
-	char *err_extra = type == ACCESS_HELPER ? " indirect" : "";
-	enum bpf_access_type bounds_check_type;
 	/* Some accesses can write anything into the stack, others are
 	 * read-only.
 	 */
@@ -7657,18 +7652,10 @@ static int check_stack_range_initialized(
 		return -EACCES;
 	}
 
-	if (type == ACCESS_HELPER) {
-		/* The bounds checks for writes are more permissive than for
-		 * reads. However, if raw_mode is not set, we'll do extra
-		 * checks below.
-		 */
-		bounds_check_type = BPF_WRITE;
+	if (type == BPF_WRITE)
 		clobber = true;
-	} else {
-		bounds_check_type = BPF_READ;
-	}
-	err = check_stack_access_within_bounds(env, regno, off, access_size,
-					       type, bounds_check_type);
+
+	err = check_stack_access_within_bounds(env, regno, off, access_size, type);
 	if (err)
 		return err;
 
@@ -7685,8 +7672,8 @@ static int check_stack_range_initialized(
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d%s variable offset stack access prohibited for !root, var_off=%s\n",
-				regno, err_extra, tn_buf);
+			verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
+				regno, tn_buf);
 			return -EACCES;
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
@@ -7767,14 +7754,14 @@ static int check_stack_range_initialized(
 		}
 
 		if (tnum_is_const(reg->var_off)) {
-			verbose(env, "invalid%s read from stack R%d off %d+%d size %d\n",
-				err_extra, regno, min_off, i - min_off, access_size);
+			verbose(env, "invalid read from stack R%d off %d+%d size %d\n",
+				regno, min_off, i - min_off, access_size);
 		} else {
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "invalid%s read from stack R%d var_off %s+%d size %d\n",
-				err_extra, regno, tn_buf, i - min_off, access_size);
+			verbose(env, "invalid read from stack R%d var_off %s+%d size %d\n",
+				regno, tn_buf, i - min_off, access_size);
 		}
 		return -EACCES;
 mark:
@@ -7849,7 +7836,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_stack_range_initialized(
 				env,
 				regno, reg->off, access_size,
-				zero_size_allowed, ACCESS_HELPER, meta);
+				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
 		return check_ptr_to_btf_access(env, regs, regno, reg->off,
 					       access_size, BPF_READ, -1);
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index dfd817d0348c..bd8f15229f5c 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -192,7 +192,7 @@ int ringbuf_invalid_api(void *ctx)
 
 /* Can't add a dynptr to a map */
 SEC("?raw_tp")
-__failure __msg("invalid indirect read from stack")
+__failure __msg("invalid read from stack")
 int add_dynptr_to_map1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -210,7 +210,7 @@ int add_dynptr_to_map1(void *ctx)
 
 /* Can't add a struct with an embedded dynptr to a map */
 SEC("?raw_tp")
-__failure __msg("invalid indirect read from stack")
+__failure __msg("invalid read from stack")
 int add_dynptr_to_map2(void *ctx)
 {
 	struct test_info x;
@@ -398,7 +398,7 @@ int data_slice_missing_null_check2(void *ctx)
  * dynptr argument
  */
 SEC("?raw_tp")
-__failure __msg("invalid indirect read from stack")
+__failure __msg("invalid read from stack")
 int invalid_helper1(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index 5da001ca57a5..09d027bd3ea8 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -26,7 +26,7 @@ __noinline int foo(const struct Big *big)
 }
 
 SEC("cgroup_skb/ingress")
-__failure __msg("invalid indirect access to stack")
+__failure __msg("invalid read from stack")
 int global_func10(struct __sk_buff *skb)
 {
 	const struct Small small = {.x = skb->len };
diff --git a/tools/testing/selftests/bpf/progs/uninit_stack.c b/tools/testing/selftests/bpf/progs/uninit_stack.c
index 8a403470e557..046a204c8fc6 100644
--- a/tools/testing/selftests/bpf/progs/uninit_stack.c
+++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
@@ -70,7 +70,8 @@ __naked int helper_uninit_to_misc(void *ctx)
 		r1 = r10;				\
 		r1 += -128;				\
 		r2 = 32;				\
-		call %[bpf_trace_printk];		\
+		r3 = 0;					\
+		call %[bpf_probe_read_user];		\
 		/* Call to dummy() forces print_verifier_state(..., true),	\
 		 * thus showing the stack state, matched by __msg().		\
 		 */					\
@@ -79,7 +80,7 @@ __naked int helper_uninit_to_misc(void *ctx)
 		exit;					\
 "
 		      :
-		      : __imm(bpf_trace_printk),
+		      : __imm(bpf_probe_read_user),
 			__imm(dummy)
 		      : __clobber_all);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index 8d77cc5323d3..fb62e09f2114 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -28,7 +28,7 @@ __naked void stack_out_of_bounds(void)
 SEC("socket")
 __description("uninitialized stack1")
 __success __log_level(4) __msg("stack depth 8")
-__failure_unpriv __msg_unpriv("invalid indirect read from stack")
+__failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_const_or.c b/tools/testing/selftests/bpf/progs/verifier_const_or.c
index ba8922b2eebd..68c568c3c3a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_const_or.c
+++ b/tools/testing/selftests/bpf/progs/verifier_const_or.c
@@ -25,7 +25,7 @@ __naked void constant_should_keep_constant_type(void)
 
 SEC("tracepoint")
 __description("constant register |= constant should not bypass stack boundary checks")
-__failure __msg("invalid indirect access to stack R1 off=-48 size=58")
+__failure __msg("invalid write to stack R1 off=-48 size=58")
 __naked void not_bypass_stack_boundary_checks_1(void)
 {
 	asm volatile ("					\
@@ -62,7 +62,7 @@ __naked void register_should_keep_constant_type(void)
 
 SEC("tracepoint")
 __description("constant register |= constant register should not bypass stack boundary checks")
-__failure __msg("invalid indirect access to stack R1 off=-48 size=58")
+__failure __msg("invalid write to stack R1 off=-48 size=58")
 __naked void not_bypass_stack_boundary_checks_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index 50c6b22606f6..f2c54e4d89eb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -67,7 +67,7 @@ SEC("socket")
 __description("helper access to variable memory: stack, bitwise AND, zero included")
 /* in privileged mode reads from uninitialized stack locations are permitted */
 __success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R2 off -64+0 size 64")
+__msg_unpriv("invalid read from stack R2 off -64+0 size 64")
 __retval(0)
 __naked void stack_bitwise_and_zero_included(void)
 {
@@ -100,7 +100,7 @@ __naked void stack_bitwise_and_zero_included(void)
 
 SEC("tracepoint")
 __description("helper access to variable memory: stack, bitwise AND + JMP, wrong max")
-__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__failure __msg("invalid write to stack R1 off=-64 size=65")
 __naked void bitwise_and_jmp_wrong_max(void)
 {
 	asm volatile ("					\
@@ -187,7 +187,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tracepoint")
 __description("helper access to variable memory: stack, JMP, bounds + offset")
-__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__failure __msg("invalid write to stack R1 off=-64 size=65")
 __naked void memory_stack_jmp_bounds_offset(void)
 {
 	asm volatile ("					\
@@ -211,7 +211,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tracepoint")
 __description("helper access to variable memory: stack, JMP, wrong max")
-__failure __msg("invalid indirect access to stack R1 off=-64 size=65")
+__failure __msg("invalid write to stack R1 off=-64 size=65")
 __naked void memory_stack_jmp_wrong_max(void)
 {
 	asm volatile ("					\
@@ -260,7 +260,7 @@ SEC("socket")
 __description("helper access to variable memory: stack, JMP, no min check")
 /* in privileged mode reads from uninitialized stack locations are permitted */
 __success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R2 off -64+0 size 64")
+__msg_unpriv("invalid read from stack R2 off -64+0 size 64")
 __retval(0)
 __naked void stack_jmp_no_min_check(void)
 {
@@ -750,7 +750,7 @@ SEC("socket")
 __description("helper access to variable memory: 8 bytes leak")
 /* in privileged mode reads from uninitialized stack locations are permitted */
 __success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R2 off -64+32 size 64")
+__msg_unpriv("invalid read from stack R2 off -64+32 size 64")
 __retval(0)
 __naked void variable_memory_8_bytes_leak(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index 5f2efb895edb..59e34d558654 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -96,7 +96,7 @@ __naked void arg_ptr_to_long_misaligned(void)
 
 SEC("cgroup/sysctl")
 __description("arg pointer to long size < sizeof(long)")
-__failure __msg("invalid indirect access to stack R4 off=-4 size=8")
+__failure __msg("invalid write to stack R4 off=-4 size=8")
 __naked void to_long_size_sizeof_long(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_mtu.c b/tools/testing/selftests/bpf/progs/verifier_mtu.c
index 4ccf1ebc42d1..256956ea1ac5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_mtu.c
+++ b/tools/testing/selftests/bpf/progs/verifier_mtu.c
@@ -8,7 +8,7 @@ SEC("tc/ingress")
 __description("uninit/mtu: write rejected")
 __success
 __caps_unpriv(CAP_BPF|CAP_NET_ADMIN)
-__failure_unpriv __msg_unpriv("invalid indirect read from stack")
+__failure_unpriv __msg_unpriv("invalid read from stack")
 int tc_uninit_mtu(struct __sk_buff *ctx)
 {
 	__u32 mtu;
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index 7cc83acac727..c689665e07b9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -236,7 +236,7 @@ __naked void load_bytes_spilled_regs_data(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, invalid access 1")
-__failure __msg("invalid indirect access to stack R3 off=-513 size=8")
+__failure __msg("invalid write to stack R3 off=-513 size=8")
 __naked void load_bytes_invalid_access_1(void)
 {
 	asm volatile ("					\
@@ -255,7 +255,7 @@ __naked void load_bytes_invalid_access_1(void)
 
 SEC("tc")
 __description("raw_stack: skb_load_bytes, invalid access 2")
-__failure __msg("invalid indirect access to stack R3 off=-1 size=8")
+__failure __msg("invalid write to stack R3 off=-1 size=8")
 __naked void load_bytes_invalid_access_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 7ea535bfbacd..a4a5e2071604 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -199,7 +199,7 @@ __naked void pass_pointer_to_helper_function(void)
 SEC("socket")
 __description("unpriv: indirectly pass pointer on stack to helper function")
 __success __failure_unpriv
-__msg_unpriv("invalid indirect read from stack R2 off -8+0 size 8")
+__msg_unpriv("invalid read from stack R2 off -8+0 size 8")
 __retval(0)
 __naked void on_stack_to_helper_function(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index c810f4f6f479..1d36d01b746e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -203,7 +203,7 @@ __naked void stack_write_clobbers_spilled_regs(void)
 
 SEC("sockops")
 __description("indirect variable-offset stack access, unbounded")
-__failure __msg("invalid unbounded variable-offset indirect access to stack R4")
+__failure __msg("invalid unbounded variable-offset write to stack R4")
 __naked void variable_offset_stack_access_unbounded(void)
 {
 	asm volatile ("					\
@@ -236,7 +236,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("lwt_in")
 __description("indirect variable-offset stack access, max out of bound")
-__failure __msg("invalid variable-offset indirect access to stack R2")
+__failure __msg("invalid variable-offset read from stack R2")
 __naked void access_max_out_of_bound(void)
 {
 	asm volatile ("					\
@@ -269,7 +269,7 @@ __naked void access_max_out_of_bound(void)
  */
 SEC("socket")
 __description("indirect variable-offset stack access, zero-sized, max out of bound")
-__failure __msg("invalid variable-offset indirect access to stack R1")
+__failure __msg("invalid variable-offset write to stack R1")
 __naked void zero_sized_access_max_out_of_bound(void)
 {
 	asm volatile ("                      \
@@ -294,7 +294,7 @@ __naked void zero_sized_access_max_out_of_bound(void)
 
 SEC("lwt_in")
 __description("indirect variable-offset stack access, min out of bound")
-__failure __msg("invalid variable-offset indirect access to stack R2")
+__failure __msg("invalid variable-offset read from stack R2")
 __naked void access_min_out_of_bound(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 7afc2619ab14..18596ae0b0c1 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -2252,7 +2252,7 @@
 	BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_48b = { 7 },
-	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
+	.errstr_unpriv = "invalid read from stack R2 off -8+0 size 8",
 	.result_unpriv = REJECT,
 	/* in privileged mode reads from uninitialized stack locations are permitted */
 	.result = ACCEPT,
-- 
2.47.1


