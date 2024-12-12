Return-Path: <linux-kselftest+bounces-23287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FF9F0015
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B416B88C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E11DF98C;
	Thu, 12 Dec 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DMFEsYbE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OyxJl4aG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF81DF96C;
	Thu, 12 Dec 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045815; cv=none; b=UNJRLoFxWM8pZv8BEpp8HjpGdnaex+4Ozewv9HJByZcT5Vc0UTUaD87Bk9qEEZLUqbFs4u8NGOohokXI+t9aXTQbJZLMFJW6eZWGfncavssicwpz5TPjDxUV5CxbI07dX+t1NsVxfcajhmZPft6k3UkeMpsJgT9KzJR0Nj/vDVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045815; c=relaxed/simple;
	bh=IG1Rmo/lMa15KO1oy3dsgvkpgvswmwsrtbBNN6ieX4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oj9Sk+oayBZ/b0Pdio9eOSRWNm664PT6S8EpTtSBWyBH2qroIBIHF4RTvm7226vwCiQoKWgVjBOgKFy6FMorCi+yU/r8Hmh3Iz3K7Gdk2eUpRof63V/vZMsYkmwGzOKQfptS7lj3aPHLU7sB8njLTFsQaUc3FP4jdiAm1sOF1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=DMFEsYbE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OyxJl4aG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BFAB81383CD1;
	Thu, 12 Dec 2024 18:23:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 12 Dec 2024 18:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734045812; x=
	1734132212; bh=MgKmuqzDtb8luWhZSqbCMvSN95W29W4MuIzlFSSEMWc=; b=D
	MFEsYbEkr5WM47Xxuwfg6D1asuCUb0KSToPnGIV0BIZTlRly72AboR74UmOJY/W1
	8/mSBAxxkwVv3TK3ewUQVLH/AR5x8wS2j+ue/av1Yi6ziuyfkEfu+4y1COBdOWx2
	8W9kkPmETRzB3IYaFIQxI3S4l8hkxdpWSITU8A6g9JGvoTPNDlBuisDCEYF8yBwV
	34Ez+7mfjzyduv8dTkYX46Ul6mMx0IKbLQDZHs+BZSMrTDMIjl4ED/j1nSWnVsG1
	u3sa9sBYsio+/zqmLbrxfIN08sEHY6mqGp+WRY0/VuxTYP9oVl+kRLazcTwGER9c
	HgtQSurTjBJ6TVYGn9p/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734045812; x=1734132212; bh=M
	gKmuqzDtb8luWhZSqbCMvSN95W29W4MuIzlFSSEMWc=; b=OyxJl4aG4Xm8z83z4
	ScA6VMZou/45xgKJ5AkeStI2/eSlLWW5m17OC6ruTVrsMP6SyvayHNzPyQALNrnz
	qH/W+Ana6LIXK9uehUmE9pHhMoTemsbbIbKTk3QxrrnNTXsWe9ztG3dHUfpDXz38
	ZcPBqJoWRfgnNFEkFCUdxBEXY+V3sGjd2VlBHC1RKScF/pt9x0XYp0whFetmERqO
	sejcfC8Ryb/tZZVaTk9J707d0ah3wMNCLfu4g3xyIWvWxTdYZoqTSB0UbOZAl6Uj
	iMtSeIF/mto0F5pSf2Wbg7X6drRahfjwMpekZB3qO+sJZs3T4Eo3KfE7Mtv9wTQQ
	U4OjQ==
X-ME-Sender: <xms:dHBbZ9ybqF3hCjJiGVhwxQHQz48a_mcR7GA7Ck3GUbodFLzGZspLXw>
    <xme:dHBbZ9QgmBteNwSjp_7VHxkR62t3qKfeS1wCX8buHNYObAZMmTzztKTknCS-r3knO
    Z-N-uTR8hZAYGGnkg>
X-ME-Received: <xmr:dHBbZ3XKFID2gb_2EHRzH19zqj99heMh7NqEZ90RLBl63tgbf95ysSuhEbC7GeAL1gCn27ZNRjcr8akAyv5wxLfuL4gLB_md_9TLSlDA8b0mJtO46F8t>
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
X-ME-Proxy: <xmx:dHBbZ_i9fpUPpOR5txza_uexW06AFgl9-8tCgEdzoP8doGPDLKAjSg>
    <xmx:dHBbZ_B2h_JsgWgsKY8z03HhsqdFMcNriTx8SGc_LcCRsOy5XX1dZQ>
    <xmx:dHBbZ4Lgrz56rd1nlDuy_LWlEDpOxlLe3JNZCfD6nZdxJ2oNYhpCuQ>
    <xmx:dHBbZ-D0DNvT169JPdu4wSWHGAGAPkrI269yTAGEQAOOc8u-vA_yRw>
    <xmx:dHBbZ37ACnqyia2HSCBlxPWgyUqeJDrBmwyO9gEG0BL2R16lOfBHpOOR>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:30 -0500 (EST)
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
Subject: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map lookup nullness
Date: Thu, 12 Dec 2024 16:22:08 -0700
Message-ID: <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
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

This commit allows progs to elide a null check on statically known map
lookup keys. In other words, if the verifier can statically prove that
the lookup will be in-bounds, allow the prog to drop the null check.

This is useful for two reasons:

1. Large numbers of nullness checks (especially when they cannot fail)
   unnecessarily pushes prog towards BPF_COMPLEXITY_LIMIT_JMP_SEQ.
2. It forms a tighter contract between programmer and verifier.

For (1), bpftrace is starting to make heavier use of percpu scratch
maps. As a result, for user scripts with large number of unrolled loops,
we are starting to hit jump complexity verification errors.  These
percpu lookups cannot fail anyways, as we only use static key values.
Eliding nullness probably results in less work for verifier as well.

For (2), percpu scratch maps are often used as a larger stack, as the
currrent stack is limited to 512 bytes. In these situations, it is
desirable for the programmer to express: "this lookup should never fail,
and if it does, it means I messed up the code". By omitting the null
check, the programmer can "ask" the verifier to double check the logic.

Tests also have to be updated in sync with these changes, as the
verifier is more efficient with this change. Notable, iters.c tests had
to be changed to use a map type that still requires null checks, as it's
exercising verifier tracking logic w.r.t iterators.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         | 80 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 5 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58b36cc96bd5..4947ef884a18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	s64 const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -9163,6 +9164,53 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Returns constant key value if possible, else -1 */
+static s64 get_constant_map_key(struct bpf_verifier_env *env,
+				struct bpf_reg_state *key,
+				u32 key_size)
+{
+	struct bpf_func_state *state = func(env, key);
+	struct bpf_reg_state *reg;
+	int zero_size = 0;
+	int stack_off;
+	u8 *stype;
+	int slot;
+	int spi;
+	int i;
+
+	if (!env->bpf_capable)
+		return -1;
+	if (key->type != PTR_TO_STACK)
+		return -1;
+	if (!tnum_is_const(key->var_off))
+		return -1;
+
+	stack_off = key->off + key->var_off.value;
+	slot = -stack_off - 1;
+	spi = slot / BPF_REG_SIZE;
+
+	/* First handle precisely tracked STACK_ZERO, up to BPF_REG_SIZE */
+	stype = state->stack[spi].slot_type;
+	for (i = 0; i < BPF_REG_SIZE && stype[i] == STACK_ZERO; i++)
+		zero_size++;
+	if (zero_size == key_size)
+		return 0;
+
+	if (!is_spilled_reg(&state->stack[spi]))
+		/* Not pointer to stack */
+		return -1;
+
+	reg = &state->stack[spi].spilled_ptr;
+	if (reg->type != SCALAR_VALUE)
+		/* Only scalars are valid array map keys */
+		return -1;
+	else if (!tnum_is_const(reg->var_off))
+		/* Stack value not statically known */
+		return -1;
+
+	return reg->var_off.value;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -9173,6 +9221,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
+	u32 key_size;
 	int err = 0;
 	bool mask;
 
@@ -9307,8 +9356,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "invalid map_ptr to access map->key\n");
 			return -EACCES;
 		}
-		err = check_helper_mem_access(env, regno, meta->map_ptr->key_size,
-					      BPF_READ, false, NULL);
+		key_size = meta->map_ptr->key_size;
+		err = check_helper_mem_access(env, regno, key_size, BPF_READ, false, NULL);
+		if (err)
+			return err;
+		meta->const_map_key = get_constant_map_key(env, reg, key_size);
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -10833,6 +10885,21 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 				 state->callback_subprogno == subprogno);
 }
 
+/* Returns whether or not the given map type can potentially elide
+ * lookup return value nullness check. This is possible if the key
+ * is statically known.
+ */
+static bool can_elide_value_nullness(enum bpf_map_type type)
+{
+	switch (type) {
+	case BPF_MAP_TYPE_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			    const struct bpf_func_proto **ptr)
 {
@@ -11199,10 +11266,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				"kernel subsystem misconfigured verifier\n");
 			return -EINVAL;
 		}
+
+		if (func_id == BPF_FUNC_map_lookup_elem &&
+		    can_elide_value_nullness(meta.map_ptr->map_type) &&
+		    meta.const_map_key >= 0 &&
+		    meta.const_map_key < meta.map_ptr->max_entries)
+			ret_flag &= ~PTR_MAYBE_NULL;
+
 		regs[BPF_REG_0].map_ptr = meta.map_ptr;
 		regs[BPF_REG_0].map_uid = meta.map_uid;
 		regs[BPF_REG_0].type = PTR_TO_MAP_VALUE | ret_flag;
-		if (!type_may_be_null(ret_type) &&
+		if (!type_may_be_null(ret_flag) &&
 		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index 7c969c127573..190822b2f08b 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -524,11 +524,11 @@ int iter_subprog_iters(const void *ctx)
 }
 
 struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
 	__type(value, int);
 	__uint(max_entries, 1000);
-} arr_map SEC(".maps");
+} hash_map SEC(".maps");
 
 SEC("?raw_tp")
 __failure __msg("invalid mem access 'scalar'")
@@ -539,7 +539,7 @@ int iter_err_too_permissive1(const void *ctx)
 
 	MY_PID_GUARD();
 
-	map_val = bpf_map_lookup_elem(&arr_map, &key);
+	map_val = bpf_map_lookup_elem(&hash_map, &key);
 	if (!map_val)
 		return 0;
 
@@ -561,12 +561,12 @@ int iter_err_too_permissive2(const void *ctx)
 
 	MY_PID_GUARD();
 
-	map_val = bpf_map_lookup_elem(&arr_map, &key);
+	map_val = bpf_map_lookup_elem(&hash_map, &key);
 	if (!map_val)
 		return 0;
 
 	bpf_repeat(1000000) {
-		map_val = bpf_map_lookup_elem(&arr_map, &key);
+		map_val = bpf_map_lookup_elem(&hash_map, &key);
 	}
 
 	*map_val = 123;
@@ -585,7 +585,7 @@ int iter_err_too_permissive3(const void *ctx)
 	MY_PID_GUARD();
 
 	bpf_repeat(1000000) {
-		map_val = bpf_map_lookup_elem(&arr_map, &key);
+		map_val = bpf_map_lookup_elem(&hash_map, &key);
 		found = true;
 	}
 
@@ -606,7 +606,7 @@ int iter_tricky_but_fine(const void *ctx)
 	MY_PID_GUARD();
 
 	bpf_repeat(1000000) {
-		map_val = bpf_map_lookup_elem(&arr_map, &key);
+		map_val = bpf_map_lookup_elem(&hash_map, &key);
 		if (map_val) {
 			found = true;
 			break;
diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
index c2a6bd392e48..4c0ff01f1a96 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
@@ -345,7 +345,7 @@ int reject_indirect_global_func_access(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__failure __msg("Unreleased reference id=5 alloc_insn=")
+__failure __msg("Unreleased reference id=4 alloc_insn=")
 int kptr_xchg_ref_state(struct __sk_buff *ctx)
 {
 	struct prog_test_ref_kfunc *p;
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
index 4eaab1468eb7..7d088ba99ea5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_in_map.c
@@ -47,7 +47,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("xdp")
 __description("map in map state pruning")
-__success __msg("processed 26 insns")
+__success __msg("processed 15 insns")
 __log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
 __naked void map_in_map_state_pruning(void)
 {
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index f420c0312aa0..4b39f8472f9b 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -373,7 +373,7 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "Unreleased reference id=5 alloc_insn=20",
+	.errstr = "Unreleased reference id=4 alloc_insn=20",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 15 },
 	}
-- 
2.46.0


