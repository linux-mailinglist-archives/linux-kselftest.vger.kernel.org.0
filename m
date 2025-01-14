Return-Path: <linux-kselftest+bounces-24517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18757A111F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83A13A685F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153C20F999;
	Tue, 14 Jan 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dW2RfUGk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGwWBTXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C620F983;
	Tue, 14 Jan 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886558; cv=none; b=jmbYwURC0Nu48NfqYYoaswaGTEGfOwU2KnuYig/wdWCYLDDLFpBMQ36aajWsAnFylLN5QiYFiCyl8byPhC/0SvLPlJYdp0GqfoHPfH6NMxUdjj2Rwl91tlUnHaBqhaYHoljrfEHNi3w9P+fHSYxzWDWHeIEZMePoG6vgclX8a/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886558; c=relaxed/simple;
	bh=gK1/cSRGs/Y9BqxmQSW9haDJWTtrx8uVa2wdtMltsOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIvwdxzbMv2WNbiC67l8MtCM4xVobEIEcHSHyo7+bY3PFx48aLWoE8iJ+vGzyOL+WVRGJws9s33rC37AK/rkisxS8l3mX8mlwAisfqkqeqG+sM+CrqDbFCRUwOz1PHFI/wA0mF48PCfdwwox4yBA8Bdu/zo++of9FRVnJcuZ9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dW2RfUGk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGwWBTXP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id ACA0F114011A;
	Tue, 14 Jan 2025 15:29:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jan 2025 15:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736886555; x=
	1736972955; bh=0tVFe/5fh6fMgpuPO/mkrH2T5WxZhgl8HlJOyHen5ss=; b=d
	W2RfUGkN1APqTkYRLnkl2MoARJHfolb3cXMD3IfMwPQZyW+J4pdidG2Z3Xa0/W72
	ZlDsZ1Hz46VEMpzraOhpqO36SxdxhF7Wj238lAL98Qmd57tNEtPK8XH1Act2ikxm
	FU0wXXsJBfhEeT2njENs02oP2GajOKSsUzFA4KEXrVC9XNZ72GcxVHT7AGAh93EB
	gLyxGNjw7Z/L/eXaVMRm4fPxU7naD8QKANdlsTNCvQ/t90leB45D5JXDm76NNTrW
	ARTx1qAZ2CEMzpgZoYDlPxJ204WGHdFF7HkFZ1gi9jBaaUvHBXAUBgFAnWYBjlVQ
	yt7gAJsguF9aHAqdR7xQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736886555; x=1736972955; bh=0
	tVFe/5fh6fMgpuPO/mkrH2T5WxZhgl8HlJOyHen5ss=; b=HGwWBTXPDbGU20zaN
	SVLHChiicY9OHsP6xmZl5ks5axKOmxbtCABKbwwipM225VIMqGUsHjpmNtyvO70d
	T3enoDaeajAH3pbxA7jYECRQ7uNLhKyOzI7D6uyH47+1xi4edITH7TGx9IzJDbDm
	/1GMYWCMRAm1ae56rcuFXycfVlY7hOWrfE+r1JfPfEhY6O9SdN2S7AYMaExHPegE
	L+TFrRRgguhN95/b9nd2jsYsSZHBcW0GFmkpIyqOk8kKHVvm3HM5FTofjwevd484
	WWWaVSDKszocxbdavQMBU5OuCi7sGAdC8L7UDHVVRhc8H3Ac2+Dog6KZOCArry2e
	5vxRg==
X-ME-Sender: <xms:G8mGZzM_BMwEP8MljRyB8xxGuECa6SFLYXQAAq_uHZnWyJpVrG7HoQ>
    <xme:G8mGZ9_WkHPgURvwtPEk_l4dz2VLJGOdfkJMpMlfuIn95zV5bmKhrwsLeWbnAkXk4
    XKjMr79TRpTPPlVcA>
X-ME-Received: <xmr:G8mGZyQvrMSOpUQh40soLruO36CDK5Uar5HdTWQqpoQUg4xk31-KjVghE8HcgLZZ4nelzn_njlL97w_ACtOP2cC43t7ordPW2sYRUC9e4JmKFDwvrOqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    ejtddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhep
    ffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrh
    hnpefgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihuse
    gugihuuhhurdighiiipdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguug
    ihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtth
    hopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghuse
    hlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:G8mGZ3vWvWG_JkU1Y2cAORqpaau5BZhvRcf1uufi3Fvpx_rUWR5yOg>
    <xmx:G8mGZ7eYLszxvxvKbnMg95uvZCVhiMawmCFD7XRQiHQ_LkEdnWyTAw>
    <xmx:G8mGZz0Mpsh8Xdh7TtivMSmcXO4UAhcVc_uDhQOIT5FkF7-saEPRhA>
    <xmx:G8mGZ3-Viz6A-MMo1LfgbIzAj5NofTG6KiB5EHFKe2Y5lU4GEYm5rw>
    <xmx:G8mGZ2Apnk_XxOFrLbbJnEfPvG4IAbRr-qArNgnkbLN-lNJBM7_Rf9bl>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:13 -0500 (EST)
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
Subject: [PATCH bpf-next v7 4/5] bpf: verifier: Support eliding map lookup nullness
Date: Tue, 14 Jan 2025 13:28:45 -0700
Message-ID: <68f3ea96ff3809a87e502a11a4bd30177fc5823e.1736886479.git.dxu@dxuuu.xyz>
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
index b71858390e65..245f1f3f1aec 100644
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
+	bt_set_frame_slot(&env->bt, key->frameno, spi);
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


