Return-Path: <linux-kselftest+bounces-18012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C051E979A22
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 05:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6201C2234D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 03:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF920B28;
	Mon, 16 Sep 2024 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lZeUk8a4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpeiYKsC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99831CA85;
	Mon, 16 Sep 2024 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458338; cv=none; b=JiXugWwLiXcw7eJWj83P5+otbNyWgBiMiLuL28gcujY8LuZ8zNp0F+74QPqnoAmdwiaG1VbU0IX2IxqYcw6tRKnF80dNRDykI8OzYzPosAkSA8zPUM7GMZXVAKIQR3E5UfmP1nZMss2ILc1lUftMNhzMPlWefB2MyM/L1WWa2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458338; c=relaxed/simple;
	bh=sz1qCSdDv5YlmO/PXn+JqvkLz1UwT+ctLwLAUoLb9Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOFCaCN5KaE7qyckWsXqaA79Mwqetle5PgYqc9mF5Af1Jba6O+3CSAf1oE/8xT/bgWnWhzzQE2V3TjEk24cw/ZUucQwJSITpCMjalgvWeZDPLMjvz2MdRllPPI5GPR5we59qT1bU+uaJwUzy81Arh689eq7p0mdqLrUrzeupBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=lZeUk8a4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpeiYKsC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D2B1E11401F0;
	Sun, 15 Sep 2024 23:45:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 15 Sep 2024 23:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726458335; x=
	1726544735; bh=yU8nhOJGYzc0DOMMI0G8l5B/bSrnAhtVorqxp2H7Y/4=; b=l
	ZeUk8a41P0/IKeHBIK0c9oyik0OARATWUK5+cUz9x0e7SDMmFUoJJKXl3XiwtLb7
	ePyX2ehKLqi+KJVCPLSP1tFLuYCLSfmYctnbEQw0cPykoLIuaFCsM+Bq/L/6uAiq
	vDM3YgufZCcxZkutWojJgSsGjIIbri37B4CTs+bzlHj0v12o67SahFrLeUF3fK8W
	uRbb8CgzWy1OBI83JDZcilY1BPZq8BSN56bJYL+BlE/Up6vulzQdmaqLhHzary1W
	xZg/IIqFo5OD3B3pznM9lCbbo0At/DUuMKPTtP0bszelPMYZlzBKf6OSxm44/S+p
	RHX9vz5ix/TjiHkWaPp9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726458335; x=
	1726544735; bh=yU8nhOJGYzc0DOMMI0G8l5B/bSrnAhtVorqxp2H7Y/4=; b=m
	peiYKsCbY+LkHAeZ0PScLX9oawnWpDpMwD8hZG4D9jKyzFk2JhZq6/S2eLT+DZa/
	6mJKxHwq/LFPbf2RwfT/8DsTiGvF9mY1erGg6jGVmis+SctPH1muVVfh7cLeGdiw
	JO+yyrYMpT+LcvoAP6um3X2yrefydHYHVk5CNUhlG1mAAoAOC1DSmAoAbdP4WMci
	N+wlAQ1s3p+Cbn8PaoxrxMPnnQtj/+496gWqBj3Ibyib3gYto11Ri6ZNBYIvXw/b
	1JIn5wbiDbNH+uDiDM7CTaqK/RcMigkd+eZgUBvQDznXLE7yEaWtWiV1M8YwmUxF
	smPcTj/dPGHQrxuPJuxlA==
X-ME-Sender: <xms:3qnnZrlsnIQlz58eqOM1yw8VuweVnjTVZGpeAeABl38DDb6D1LPXhw>
    <xme:3qnnZu2cyvACR0FoqBovgUZxL9w5vAYfS_9dhjD1GrTQoLlzRtEDqTgIElrawFAXe
    KyPlVY5ojt4NMQIGA>
X-ME-Received: <xmr:3qnnZhoXHrfcK3Hg3oW7MxzdOqU2pUfoRg0ZZkvwbonAOWKyMAMRevK1IJPCSXPfKafgoriFU_Iw6Zgl02I5yMOYgAuu-df7nvz8BJGebEPhJfrJyOXC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    gvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:3qnnZjmebB1M1D17XdZU3b7wZIIoPKxSr1Lz5g7_SVJh7n_s28N7ZA>
    <xmx:3qnnZp1YNqTQWXBKBvnn6NFExjZ_UI6k5899CAchhFXHKUn0JdGRgg>
    <xmx:3qnnZitlYxY-u67XptGJ8emK9CF-Jb8kmUvzoGlFw8tTTBCfGPyKJA>
    <xmx:3qnnZtVGeNVjjmCn-6MHZuyhiMFIkRJ6u6RCxMCC3FXacqzeCDF5Nw>
    <xmx:36nnZgt4XLYTZ8osH7Rx68ON7TM-qtuRtreMJDN5tagsVJDn6YsEIb1s>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Sep 2024 23:45:32 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
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
Subject: [PATCH bpf-next v2 1/2] bpf: verifier: Support eliding map lookup nullness
Date: Sun, 15 Sep 2024 21:45:19 -0600
Message-ID: <3b54139f8d4877e0487daebdd799c3878ee27ed0.1726458273.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726458273.git.dxu@dxuuu.xyz>
References: <cover.1726458273.git.dxu@dxuuu.xyz>
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

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/verifier.c                         | 64 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 5 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7df5c29293a4..e0c9c53ce9c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -282,6 +282,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	long const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -10414,6 +10415,51 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
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
+	if (key->type != PTR_TO_STACK)
+		return -1;
+	if (!tnum_is_const(key->var_off))
+		return -1;
+
+	stack_off = key->off + key->var_off.value;
+	slot = -stack_off - 1;
+	if (slot >= state->allocated_stack)
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
@@ -10511,6 +10557,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10771,10 +10826,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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


