Return-Path: <linux-kselftest+bounces-18941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC898E78E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 02:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3956286C52
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0527629;
	Thu,  3 Oct 2024 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="f7by0eVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VULIBh7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87BEC2;
	Thu,  3 Oct 2024 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914320; cv=none; b=nNBtCcy0gL5BSXQmocGSRTc8xh9rc/OfdV42o4qtr3x75RSsTYqMBW9UuQilxUc75+8StrB1IcsqoLxS372oAY5scYdDYXfNHySeciG8O25hkX/52qLGIfjHENYsyruQDeFhVvPzEnbOV1A+bLNCnGAqMuCrgppLxSp7qdJ2GTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914320; c=relaxed/simple;
	bh=hlzXgp2HHzP8g+9r3wZXJx5VEgZEITsAVZEcwz7ESx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMCr5EF9B6IM8JMyvuu52Xd3d2WE7V+J8U/YtxVuKvITWnqmmhkKxZCbAzNB0Yag5TWsiIEahDWelwEj+R1q46uvUPK9/nxkT2GoL7SmRLIefFTIfEro0McncAEm9rGllwbxRdPJ7x5KPrwKCGIm40JW1a3VFH4x5/QaVR2Aj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=f7by0eVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VULIBh7Y; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17E1A1140223;
	Wed,  2 Oct 2024 20:11:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Oct 2024 20:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727914317; x=
	1728000717; bh=L5S22WBLb4rMLeyhozr/WQ/wfFLT7w9WnVidooaKxMU=; b=f
	7by0eVaStICJrAc3rGX+HQ8Gf3uSWmnQNlelwJler20pkFuwz/LAUZxDDPQx6KBx
	J00e7RsRcEjgckaeUkEZPHIZgtYDJczHYXPj81H5iJUd1sormHRuwII9jdLPmVFi
	wgHfTdlTRbyy2EWO4QLwB/f+sbhRLWWg1pWCrA9Ttce1TbVoITx8zz7IDa71eDdO
	luH4zje9BX+BEw/V4ZNPrzjhuD1ua/WoFH863pQpgkrwag4PByc6mStmEYMgt/yB
	4S9XxCY347c6lx8FO3LX0Zlm0AtcijERQdgUiO7DWJ5eQC5osUFYk8Hrlc0Xt9Ew
	9p1sFD1HJZtbI+cm5BQyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727914317; x=
	1728000717; bh=L5S22WBLb4rMLeyhozr/WQ/wfFLT7w9WnVidooaKxMU=; b=V
	ULIBh7Y8A7dxGX8zDEo73obV29+3Y2lEYBZr3GznqfOwGoAWekcVEZ1t3ftA0Y5q
	J/7RN8IOi2GL04WunToWQ7VXZEMjQrAqxNSz872W3Ir/WFfHqywCN6GqEG26Xz4E
	XxlmeLt2ZIz86kQIrjbQJZzk55XdY4a067hSrKXnHP7n/JjXNel+XYKdVhIYmtvh
	RnJ5It+zsRqDYkTmd9AXxgMure8EV0wsd+fNOa4MzwxYdNvkGfdCwdoumxfSPV7b
	B6iINw/jmP521kUTA0v6VlwL8kXSq89KzWpdL20z40j5UwchTXDeS/EPSRL0Egrs
	hiKWZJfdJj0rrEhZwwO+Q==
X-ME-Sender: <xms:S-H9ZmluZxtcLuLMvPy09C6cwbmNK3j7jrN_kKBiisb4SGMar1nLgQ>
    <xme:S-H9Zt10_rYU6Q3w4ntu-1Rf-3gRFUDSY_jBjyePDPqPexAxzNOqTtcspKAZ0hNPL
    a3sHNMZERg2pKU8MQ>
X-ME-Received: <xmr:S-H9ZkqocuCghgc9lnaaD5MtcPwztCn9lTzdj0bAE4h0_TmLARqgOVM63O2KT3FOljOyfEbcQgppbuovDrTcYk6DhWZXguAvIHwgscdwMPbTgU5mCFKR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiike
    ejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohig
    rdhnvghtpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:S-H9ZqmPHylBwBNU4hLrEe9kjWQfMEuuOGzF3WOQ2KQ2w3UXHOW8fQ>
    <xmx:TOH9Zk3FkRd_1xb0-r5LWOzvIbDKRGUtM6bzmedcizisDiw4xLgGXA>
    <xmx:TOH9ZhvMNircXFe_9JbzKDAwHUq8G2HKUD4HQBBG5UBwxu0ArAoJpw>
    <xmx:TOH9ZgW7Njq4mPIYeJ3SPrB9qWVsPzZ9-DoxzskQwaI35sp8VMeslw>
    <xmx:TeH9ZrvWEH50m7XFrLf2l2143gH1iqs90YOgC9J5O4LCgm970t0HxeTG>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 20:11:54 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	shuah@kernel.org,
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
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/2] bpf: verifier: Support eliding map lookup nullness
Date: Wed,  2 Oct 2024 18:11:39 -0600
Message-ID: <4ed563d21d1e34508a347a5b91a8089cbbae47c2.1727914243.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727914243.git.dxu@dxuuu.xyz>
References: <cover.1727914243.git.dxu@dxuuu.xyz>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         | 73 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 5 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d9b38ffd220..9ee2cd6c0508 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -284,6 +284,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	long const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -10416,6 +10417,60 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
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
+/* Returns constant key value if possible, else -1 */
+static long get_constant_map_key(struct bpf_verifier_env *env,
+				 struct bpf_reg_state *key)
+{
+	struct bpf_func_state *state = func(env, key);
+	struct bpf_reg_state *reg;
+	int stack_off;
+	int slot;
+	int spi;
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
+	if (slot < 0)
+		/* Stack grew upwards. This is properly checked
+		 * as part of helper argument processing, but since
+		 * this runs before those checks, we need to preemptively
+		 * do this here.
+		 */
+		return -1;
+	else if (slot >= state->allocated_stack)
+		/* Stack uninitialized */
+		return -1;
+
+	spi = slot / BPF_REG_SIZE;
+	reg = &state->stack[spi].spilled_ptr;
+	if (!tnum_is_const(reg->var_off))
+		/* Stack value not statically known */
+		return -1;
+
+	return reg->var_off.value;
+}
+
 static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			    const struct bpf_func_proto **ptr)
 {
@@ -10513,6 +10568,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 			env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
 	}
 
+	/* Logically we are trying to check on key register state before
+	 * the helper is called, so process here. Otherwise argument processing
+	 * may clobber the spilled key values.
+	 */
+	regs = cur_regs(env);
+	if (func_id == BPF_FUNC_map_lookup_elem)
+		meta.const_map_key = get_constant_map_key(env, &regs[BPF_REG_2]);
+
+
 	meta.func_id = func_id;
 	/* check args */
 	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
@@ -10773,10 +10837,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
+		if (!type_may_be_null(regs[BPF_REG_0].type) &&
 		    btf_record_has_field(meta.map_ptr->record, BPF_SPIN_LOCK)) {
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..24e6cd946396 100644
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
index 450bb373b179..c4a81d1c1354 100644
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


