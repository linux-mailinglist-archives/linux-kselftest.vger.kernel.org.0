Return-Path: <linux-kselftest+bounces-23643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D03C9F8AE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836651691AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282C19D070;
	Fri, 20 Dec 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JhlSZ0+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nxPGVXMi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0991198823;
	Fri, 20 Dec 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667814; cv=none; b=nK013Cst5mJyEb+CpPJwzBMbCC2IHs9N8m+GRlgUojcfAZH7CB3gKgzpYb9GGHsYxBHbvR7JUFbZeeDglhafBBgwX3MFZZxvIDEGlzk09+5kyBoVDGQjb8/vB12BDaNNgtUcpaREbytfsm6I6lZrQJvvyntZbG+5A91C8HnfOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667814; c=relaxed/simple;
	bh=g0qoKBe1dSSZ1DOCbAhSnR2bAPW6XPQ4lleq7lPmG0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBNUUdbkGMZ6VfP6YFwhjG4lVudiLn2pxCzXu0wJUBB4xz1gYavUzQ0HZ7u2R4yGBe4ynJPzX9pIdqP+GouwQwfutluC2uSpxZOftWrJwtdHJusvbV9+uKUhYB8lS0jOXX7/tq4oXzoaX+YzQWqANzMeKgaswipOw1mn9bDNaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JhlSZ0+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nxPGVXMi; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55BC6254015B;
	Thu, 19 Dec 2024 23:10:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Dec 2024 23:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734667810; x=
	1734754210; bh=6aUvsV0+i7Nfh351E07EGjpHsyGTBgOewnNELvqQJRc=; b=J
	hlSZ0+M9nTP9L8mtoZ9qTPj7zCyo8DoDYOkMhrSTy4GzhE543tmBvbNW7WNyXpRr
	5McuN5eOfyKJfL1j0lwNwMufK4pEc2zRt3NiU7eZa2Xo+OFy8//4WkeXa6uZhkgI
	awnMn6+tCdyAIu+KEFULC3nm8H4tcKuEgGy+YYDHwCQmzfzvyJYlZjBHy0ocvIst
	FQhYW4Jk2HDgzUKLMIKh8jD80M0TqCSBQvik5ZdMverwrUXlIz0tf0/Pn36LDm0K
	w2TXHpSSQMhdw8/03CC0Liuidjx1SVJnJESrLIFhs286UCjTZRu7zBdfIXleesqv
	IvCp/baEbHTONxeL9RfPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734667810; x=1734754210; bh=6
	aUvsV0+i7Nfh351E07EGjpHsyGTBgOewnNELvqQJRc=; b=nxPGVXMiJCS9nms/Q
	XmNGW5I5y+IkyBtbOw/cVUkv0Satt1ly6IaInyr4mN3JauQkoCs3FuLEp2MJcXwb
	Be0gRfQ56L0Ff/FlIxYIdUNsdlRtsqnSU8fxXPSlhqeYGvyjRLG3GNCaQaXjNXJP
	+THInnmr+YfzmsRH4jdL01fKymuE/EwVW9BI0bKFQicUWTjcMP/ahyt3exs+DXMQ
	QSQgh/IKchzHP2qeIUzSOjYAOKg0qyOAJAUU6c+mJ5K719mgpQwtRvOjpRZIFZEx
	rzZiRQXEjrk2Ets0N0mpYIZzC0Khy0ZtC3fjHDHsibZu/m3xGNcvSXu4WrxbZ8UY
	T47FA==
X-ME-Sender: <xms:Ie5kZx1rDy_KoePvHAuV7eQsVZXw1ig57gNw77zmeU3Wg6Io5Irfrw>
    <xme:Ie5kZ4HFfhAT2Syhx90jnKIHWegiHi1pd_HexhVIac4Nm0EhOppktJF7z4dq2rKEz
    MxHlNoc4rRLLe4q9w>
X-ME-Received: <xmr:Ie5kZx5WuNMlQ5EAg2haf543ZQjHg_eMhlQN2ciZUnsVFNSquMtM_7GwDeBdWnQjBmQgxRrABlYt1YTqrcisXfZnsMxGaTKgf69me0UnhoClZsjP2oVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:Ie5kZ-0KZ287q9oT-9VyuNOqSRSrzK-lhTnVk3tV36qmyB3LaFl89g>
    <xmx:Iu5kZ0FZcNcQg9hhuOF6MAjMWJOkDCpSEWdvDvsFxWeQuiiyzADvrg>
    <xmx:Iu5kZ_8C2dH2prsxTm3HjNB5BdzRIskWjGY5-MEf83s75y42TfD0bA>
    <xmx:Iu5kZxnyyKkbCID1NE1RLb0ALB8WWFN08py-lKuRZ2J7DGbSCwhWdw>
    <xmx:Iu5kZ5JKaM1RVjNJPB_j6oRvU_edsfr8yRSAOH163rlPS3xvH4x8RojN>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:10:08 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: eddyz87@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 3/5] bpf: verifier: Refactor helper access type tracking
Date: Thu, 19 Dec 2024 21:09:45 -0700
Message-ID: <1a8de4259f6cf399cf072d78fa15686b9dad21b7.1734667691.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734667691.git.dxu@dxuuu.xyz>
References: <cover.1734667691.git.dxu@dxuuu.xyz>
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
index 4383653764e8..5b5fa8f5e25c 100644
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


