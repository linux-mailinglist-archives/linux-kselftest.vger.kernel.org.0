Return-Path: <linux-kselftest+bounces-23644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F59F8AE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9188D188EABE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5119F116;
	Fri, 20 Dec 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YuFCnHB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QISgoJ3n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BC19C56D;
	Fri, 20 Dec 2024 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667816; cv=none; b=QZU+fDyzQSC9I/6seMVWnB4nhzNXQE+Jn0ztbHHTG0wZd/qyocCqtLcQoOjTbVVAUasQxsBVUqQj5wovfuc5BnyMdz+x5VlThvUmmvtM2F4dzI8VUjI3vryo3M7ys7dxt2e/kU3aKNGglerhpmmCoIBXDrcdAXl1y2hOuWF8Y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667816; c=relaxed/simple;
	bh=+IsUGrQnoQir3FMFyWBC5dyofCUXPQdGw+aXyO8uUp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAHBDAarazJ9XZpruUDhzZexKyUgyg8401sgIqkTYOXF/pNiV3S0W1P5AH5Oig2jDLr91GTTQABZ5sq6ZztxfB3Joa+nM95D8KGYbY0neoRRxeuNOTLaZ/hn474ydUQAUk+XfglUwp/YlGCAMuamFuReXafFaQ00wPJIVSo7oRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YuFCnHB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QISgoJ3n; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13F07254014E;
	Thu, 19 Dec 2024 23:10:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Dec 2024 23:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734667812; x=
	1734754212; bh=z7c7QEeIB2eU5kipShp4c+vA8U9SOmBe1N3LPhQK8OQ=; b=Y
	uFCnHB3wr6EQ30VA916HGyxKtlD8I/ENGpGS5psg/gkDqQae9kiXvIvOolAeQN2o
	NpXWx8nlCMOnxmD/NNQjam21fJ6iLe3xztRlSy103C/azd85Aci83Gkj168cESyU
	DqWnpjtf16V2wpXOuVM+jukNwkHmQ6UZ++mndWfE4TkPZ7lHnDWT7NIOPDujJNfL
	8/zhdeDpV0omj6fPG6A+NDcGw348Ae8U/VfWcoJOeD0hKhb1QCdbdgU1W0nZ3ft4
	mIeCnfq1AAc7e23awnmu7EU48WZd7J4nsTKcJ4EUXkYEceNuss6sDpCK6Lk8L6Df
	3iZeiVd+NKTgQCn8Q3wnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734667812; x=1734754212; bh=z
	7c7QEeIB2eU5kipShp4c+vA8U9SOmBe1N3LPhQK8OQ=; b=QISgoJ3nA8G7xR814
	no373GMH0mhMB/W/RX2l03cGC4ZanLTcN449ezb+l9bOFVdaDoEKID9bZPf9vNN1
	Eup77faWst9d7zwp2x5WBQLzht8i12Jb5ZfuWekD+ErkboGvrL87h1A0u3ePl0et
	g2akpSqRBFaNKyuaZAVch0OsvwJjM88UybXoIQTORHoATE2Gr4iwki/xdAm0s8F9
	x+yV+E0XLWgtjOgIcw8276DDOirtboozvHXOeQw5IezB4QzVMMr3bB0ScR2fW6Qs
	lfJjejkXjIFzxluS/A05MVOKEMJ52s+jKZS7xipP+vWzAEGfQ+tNSAaJXB0ZdHCZ
	A+iQw==
X-ME-Sender: <xms:JO5kZ7nQkAGQBNjFmOj_06SWyju1oBsEqEACFRoUf4jQZ9SsmVwr8Q>
    <xme:JO5kZ-0wseaiVvpM8wwdM1691dHlQ_MFWhb3-kHbXTPjniTxyk4VlplSWlA7pN5mh
    J_G_b56afs6FpbmpQ>
X-ME-Received: <xmr:JO5kZxobQwOcWV0_vKwkanDrtqZ_s-Fe1m0K4F7QQrLgjHl3kvfuNj_RwXFQVCZjqACbs7fSxhUXrOmtmaBAHH6ROksF-OKvvpEA7hGtTK7FlAJxLHjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnug
    hrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurg
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:JO5kZzlSx3pU4kjBjvyz8bUnZbc-tgWZXlRp2-7-1IeVP1BucVFw2g>
    <xmx:JO5kZ538jNFwZSnnyanOB2aeJhyQ_I1y80-6J6xjgDqq1GM7c7loYA>
    <xmx:JO5kZys5n2veUcsD8d5ozrUGO38cIJZBpxN5lqdzOk2ZHJ8TJs7Rpg>
    <xmx:JO5kZ9WKaVCwBImGef8aG7UbYkxwQ418HJ5oHeOH0n3M4u7BDrhUeQ>
    <xmx:JO5kZ156qIXFf914ecxLR9FIjHZOYn0a0GK0t_g7voECG7RlAnjQ6LkR>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:10:10 -0500 (EST)
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
Subject: [PATCH bpf-next v6 4/5] bpf: verifier: Support eliding map lookup nullness
Date: Thu, 19 Dec 2024 21:09:46 -0700
Message-ID: <86213ea40c6e6a30bf8ba967da9b9c4c6d77fd0b.1734667691.git.dxu@dxuuu.xyz>
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
 kernel/bpf/verifier.c                         | 92 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 +--
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 5 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b5fa8f5e25c..bf7191968cfe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -287,6 +287,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	s64 const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -9148,6 +9149,63 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* Returns constant key value if possible, else negative error */
+static s64 get_constant_map_key(struct bpf_verifier_env *env,
+				struct bpf_reg_state *key,
+				u32 key_size)
+{
+	struct bpf_func_state *state = func(env, key);
+	struct bpf_reg_state *reg;
+	int slot, spi, off;
+	int spill_size = 0;
+	int zero_size = 0;
+	int stack_off;
+	int i, err;
+	u8 *stype;
+
+	if (!env->bpf_capable)
+		return -EOPNOTSUPP;
+	if (key->type != PTR_TO_STACK)
+		return -EOPNOTSUPP;
+	if (!tnum_is_const(key->var_off))
+		return -EOPNOTSUPP;
+
+	stack_off = key->off + key->var_off.value;
+	slot = -stack_off - 1;
+	spi = slot / BPF_REG_SIZE;
+	off = slot % BPF_REG_SIZE;
+	stype = state->stack[spi].slot_type;
+
+	/* First handle precisely tracked STACK_ZERO */
+	for (i = off; i >= 0 && stype[i] == STACK_ZERO; i--)
+		zero_size++;
+	if (zero_size >= key_size)
+		return 0;
+
+	/* Check that stack contains a scalar spill of expected size */
+	if (!is_spilled_scalar_reg(&state->stack[spi]))
+		return -EOPNOTSUPP;
+	for (i = off; i >= 0 && stype[i] == STACK_SPILL; i--)
+		spill_size++;
+	if (spill_size != key_size)
+		return -EOPNOTSUPP;
+
+	reg = &state->stack[spi].spilled_ptr;
+	if (!tnum_is_const(reg->var_off))
+		/* Stack value not statically known */
+		return -EOPNOTSUPP;
+
+	/* We are relying on a constant value. So mark as precise
+	 * to prevent pruning on it.
+	 */
+	bt_set_frame_slot(&env->bt, env->cur_state->curframe, spi);
+	err = mark_chain_precision_batch(env);
+	if (err < 0)
+		return err;
+
+	return reg->var_off.value;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn,
@@ -9158,6 +9216,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
+	u32 key_size;
 	int err = 0;
 
 	if (arg_type == ARG_DONTCARE)
@@ -9291,8 +9350,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
+		if (meta->const_map_key < 0 && meta->const_map_key != -EOPNOTSUPP)
+			return meta->const_map_key;
 		break;
 	case ARG_PTR_TO_MAP_VALUE:
 		if (type_may_be_null(arg_type) && register_is_null(reg))
@@ -10816,6 +10880,21 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
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
@@ -11182,10 +11261,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
2.47.1


