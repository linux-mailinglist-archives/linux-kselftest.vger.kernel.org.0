Return-Path: <linux-kselftest+bounces-23286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36B9F000E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 00:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D048A16AF20
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6F1DF752;
	Thu, 12 Dec 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qYh5HKj2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiYkS+vu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07041DF277;
	Thu, 12 Dec 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045813; cv=none; b=sGKG6wopGiDuzdxQ02DF1ABPZhUXa5XPMSKhoXa74/HY1mkxBvSKRzmXmn+MgD+GvFMuvqiDvlgm1cJ+9WtfTEs95gsQIKJMlOdTyYDyC09+hi5pbMhtbpcYi+pzE+czOzPeJdefJz+Aqa374Rif0ltSmigXaCJXLH0XJUTDWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045813; c=relaxed/simple;
	bh=2EEoIUgzhTtNmXLiiopRuh2JtyjBA635ryv0EvFkAck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGkcKJHcXCWsP9DoDmdluwqVRMn3UJ5cS2suR5tv1BrVyA05sI+LsZykbMPaLSL2DBboHqIaMk1XJsHyyF5C8WalkJdKg+i4RbhQJAwh94TFDqRBBIPhbRfYQKa4JPLORukoXaWAJh+k9BA8XESxU7CYmaaZzDbZZMebgTw696E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=qYh5HKj2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiYkS+vu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EAE111383E56;
	Thu, 12 Dec 2024 18:23:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Dec 2024 18:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734045809; x=
	1734132209; bh=kmPq0SYh9+HGIikHTCoxuSIFZ1X/VgluoAEyy8L/SQk=; b=q
	Yh5HKj2rNSf/pSQ+c3u1x88XZsd9AFljG7XYG2Bd/tt0sVOtj89d10PtXdlCU3iy
	cWzfoQgKhYYuS1VtV3ZZnTWx4g3A4opCZF1Zi+6ktjZsgxFLbQYd9HlRQj9+AcCg
	/i44ZRm1l1vJun7cUnIOAIAvP/6tEdl4swNvF7h9uquJvGDG3qg/7K1Ry4o7Hn4m
	ernMP94+ttoySVy3uiwuWv1o4WANuYjonc7aexlpRo9RYSEB5gW+ZzqX9mSC0PHK
	zAXArqHJTgSDlURkOukgIPOqMTZz/HpMcJGQ48K/ppNJjwDvqcALDBtijxAOk2Og
	HqGfTrKQPOELsd9uo4KCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734045809; x=1734132209; bh=k
	mPq0SYh9+HGIikHTCoxuSIFZ1X/VgluoAEyy8L/SQk=; b=TiYkS+vuJLKvBAJgB
	KjZN+N2NasiGcsADBjjw8qbmxArMqULUzSCLRRoXinpLdwtq+f1mq/5fIMz+Naxk
	vydIl22ByqWmKpeezNXHcTjHR+UcHJpRE0wnS9/t1Dg3xGuNZJP7paLW/38bdyRO
	wsIbC1Op+EAWJPscyRkQH5FtouvNu9HQzfSsTLc61vfahFFEfn1eIxx0rVbdk8nI
	2Vc+dIl3uON6ixhK2mbU9gpENFFUJfIP/D1Oa3NP9T1uNOx3A+is50h+KksK6XiD
	INFwiPjo4r94O8CAEjU10pApBQgP52z9Xilgo0dDxGQBca+HaRaBUoLZZ2h0cpR4
	04zjQ==
X-ME-Sender: <xms:cXBbZ22EdhquTotWjdM7i4Uzyk1Z6btdlni71P7o2kKMicWps-4bXA>
    <xme:cXBbZ5Fs4qHYwD2ZylbLt7Qcj5iD4amMg2tR_0-jtlgV3ws9QMIR7iZxu-xI67K_8
    WcByLHWHM0zJ7AuPw>
X-ME-Received: <xmr:cXBbZ-7X_iWu_vlIFmS4KCLq2Ws5aFP07u3twUXS4bXLkOy9P8vNZlIY0Zsi4rKtEU0b13B8eW9QrOEPYx_EPga_3tYi9M3k4pN0DdKxciaBmO8ZQNRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgr
    sggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlih
    hnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:cXBbZ30wzdt-HP-MV_O80TQ6vBNALuxaOWFIBvS0BGnwrrOUtjJvCg>
    <xmx:cXBbZ5G3bUXCTmhFgOo3LoOFIiAVCwTEvYHh9W2InsAHfIhOMbV4UA>
    <xmx:cXBbZw8LNpuwjuNNdTKfoqy2sKfFUbqQKGc8113EEAZkueMDr_8cog>
    <xmx:cXBbZ-nAY0rHSI6_Ma8Gi6kbXNBr2URhXl2O_ThlJEaIq3PyKLNpbw>
    <xmx:cXBbZ3-GEgoLQSpVkiabywn_34fHQ1HEfnHtnzlbMzWRRDmHlvmxZjFt>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:27 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	daniel@iogearbox.net
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
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 3/5] bpf: verifier: Refactor helper access type tracking
Date: Thu, 12 Dec 2024 16:22:07 -0700
Message-ID: <4727abf12fbc53723359d4edcdf5b6dd7d33f9cb.1734045451.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1734045451.git.dxu@dxuuu.xyz>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
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

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         | 45 +++++++------------
 .../testing/selftests/bpf/progs/dynptr_fail.c |  6 +--
 .../selftests/bpf/progs/test_global_func10.c  |  2 +-
 .../selftests/bpf/progs/uninit_stack.c        | 29 ------------
 .../bpf/progs/verifier_basic_stack.c          |  2 +-
 .../selftests/bpf/progs/verifier_const_or.c   |  4 +-
 .../progs/verifier_helper_access_var_len.c    | 12 ++---
 .../selftests/bpf/progs/verifier_int_ptr.c    |  2 +-
 .../selftests/bpf/progs/verifier_mtu.c        |  2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  4 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |  2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  8 ++--
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 13 files changed, 39 insertions(+), 81 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 630150013479..58b36cc96bd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5302,7 +5302,7 @@ enum bpf_access_src {
 static int check_stack_range_initialized(struct bpf_verifier_env *env,
 					 int regno, int off, int access_size,
 					 bool zero_size_allowed,
-					 enum bpf_access_src type,
+					 enum bpf_access_type type,
 					 struct bpf_call_arg_meta *meta);
 
 static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
@@ -5335,7 +5335,7 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
 	/* Note that we pass a NULL meta, so raw access will not be permitted.
 	 */
 	err = check_stack_range_initialized(env, ptr_regno, off, size,
-					    false, ACCESS_DIRECT, NULL);
+					    false, BPF_READ, NULL);
 	if (err)
 		return err;
 
@@ -7205,7 +7205,7 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
 static int check_stack_access_within_bounds(
 		struct bpf_verifier_env *env,
 		int regno, int off, int access_size,
-		enum bpf_access_src src, enum bpf_access_type type)
+		enum bpf_access_type type)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
@@ -7214,10 +7214,7 @@ static int check_stack_access_within_bounds(
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
@@ -7435,7 +7432,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 	} else if (reg->type == PTR_TO_STACK) {
 		/* Basic bounds checks. */
-		err = check_stack_access_within_bounds(env, regno, off, size, ACCESS_DIRECT, t);
+		err = check_stack_access_within_bounds(env, regno, off, size, t);
 		if (err)
 			return err;
 
@@ -7655,13 +7652,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
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
@@ -7672,18 +7667,10 @@ static int check_stack_range_initialized(
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
 
@@ -7700,8 +7687,8 @@ static int check_stack_range_initialized(
 			char tn_buf[48];
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "R%d%s variable offset stack access prohibited for !root, var_off=%s\n",
-				regno, err_extra, tn_buf);
+			verbose(env, "R%d variable offset stack access prohibited for !root, var_off=%s\n",
+				regno, tn_buf);
 			return -EACCES;
 		}
 		/* Only initialized buffer on stack is allowed to be accessed
@@ -7782,14 +7769,14 @@ static int check_stack_range_initialized(
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
@@ -7864,7 +7851,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
index 8a403470e557..87a2f8f7e92a 100644
--- a/tools/testing/selftests/bpf/progs/uninit_stack.c
+++ b/tools/testing/selftests/bpf/progs/uninit_stack.c
@@ -55,33 +55,4 @@ exit_%=:	r0 = 0;					\
 		      : __clobber_all);
 }
 
-static __noinline void dummy(void) {}
-
-/* Pass a pointer to uninitialized stack memory to a helper.
- * Passed memory block should be marked as STACK_MISC after helper call.
- */
-SEC("socket")
-__log_level(7) __msg("fp-104=mmmmmmmm")
-__naked int helper_uninit_to_misc(void *ctx)
-{
-	asm volatile ("					\
-		/* force stack depth to be 128 */	\
-		*(u64*)(r10 - 128) = r1;		\
-		r1 = r10;				\
-		r1 += -128;				\
-		r2 = 32;				\
-		call %[bpf_trace_printk];		\
-		/* Call to dummy() forces print_verifier_state(..., true),	\
-		 * thus showing the stack state, matched by __msg().		\
-		 */					\
-		call %[dummy];				\
-		r0 = 0;					\
-		exit;					\
-"
-		      :
-		      : __imm(bpf_trace_printk),
-			__imm(dummy)
-		      : __clobber_all);
-}
-
 char _license[] SEC("license") = "GPL";
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
2.46.0


