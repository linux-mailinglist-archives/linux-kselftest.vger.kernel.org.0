Return-Path: <linux-kselftest+bounces-18291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073D09843D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847CB1F23B79
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E019E97D;
	Tue, 24 Sep 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fXkeVXw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hys23LD/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73619E82A;
	Tue, 24 Sep 2024 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174429; cv=none; b=P2rUdk2Dh0Ffb+nfnoKRM1S1Kl/nKYx9ZQgnPvwm07dHD/cDE2qlgVwf9vZDG2S4xaS9Je3Kj/f0quIWPx4psNbBmCF3qlwjrt6BBfEjf8tXkM1wXcjkW+rgs6XSf3NWMj+Z3MM+qi7wkowTpmceDdAN+nMobrQKCAwLm7qtEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174429; c=relaxed/simple;
	bh=Ki4tFfMThiUnoNq0azYe4DvedllRfF7B9UwQ+4e2cyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RR4ZWhzuj+4S2f8hj/6OijnBZKuumj+s1WFVQe+Otmw7PDi9eAx8CBkTb0iky7hwLJvvKTw4dHaH+sIeUQHVYUl5QCcA2VIpTEkpH60/JNwfkrSTLuLULZTD3dmQp/ac8qM3IQpN+U5fNebtKTX6ldwHSchlIlkQb2Rii0AL/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fXkeVXw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hys23LD/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1878E1380486;
	Tue, 24 Sep 2024 06:40:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 06:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727174426; x=
	1727260826; bh=2kWV/ZNpe61ZapbpRrvIYyWcS6fNhUtvWTgRBjo5PPk=; b=f
	XkeVXw/ZL4VxbFEIcL1A0283amvjmAmMnBL+QTmjrTUOoh8fZsWMqEOdJAYI7HVK
	66bxwhEjsdsjbMp/7MB2KVOkMfSpq/CCo5+QAWx4QNh7Qn8OTUXBrwNZCl8kRKvB
	/bgD4Wp7AnalPMS8W1VysUSCgMcd6OxUbFiAIoQzp4xmMJtn/y2sBuVsDcsysh1R
	zRcJb+oBjZG/JKqEh1Nr3Gu8YRTDFiGp8PVMBZGrw5I7XzH+L01qm7tv1gSmyTZM
	qN71CJnJT9gm7cN7PFh/GmWGEFSAy9BqQVd0l8iIOINF37D4dS06gQS4v8SODB0J
	STaFi2FZ+B+WDoRuA4NqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727174426; x=
	1727260826; bh=2kWV/ZNpe61ZapbpRrvIYyWcS6fNhUtvWTgRBjo5PPk=; b=H
	ys23LD/bPyA31lU/uH9FP+ZiE3Ag7azHeUq6dG7HEYT89gGor7OckwPl0bR1jvSa
	YzBQx4ibB437pvjhFiRNTflmwwEFIPreiQLTi8Rs6vnOzDQc08jSxXksHldftGBd
	Iv2PjU2ozuqrmUM6hGt59KHQRTu0ePl2ZX21Rz8AetoVB4iO5eVSG8ehjeN6DK3v
	wn6+tZQEGKpX5Hcf93yOpO76RB1cth3F4Fg0CBryzmefhmqQ4q55V18pXTXgd68z
	9sqNT/t1iIf0EChjV0IVr9E6OAbp0xlVLNPa9Q4fDjq3P7gcnIVOYPo8qXHKWwdP
	ptKXwbuleUAZvLAk5lZaA==
X-ME-Sender: <xms:GZfyZrRd7zmQHMZ_mwm6iR15x1zXMSYMwdSU65IwHTmznGiUMa_RPw>
    <xme:GZfyZsy5AHuBA2ZaCy-F7CkLFjd485-nAp7i5_Rk1K0KQBdpTbsrme37oOYIcU1uL
    GYJutp474NkAflzqA>
X-ME-Received: <xmr:GZfyZg28rC26NFjDClEgmNercITnShPn7Lw6fI_Lv-kHDOkRo9hCi-mg_s6IAosCBR2wnujoVS9pnjLmBRPzW0dxRn6wAjIwLMsBvSittxegnZryTdIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnih
    gvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrshhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslh
    hinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:GZfyZrArX4rOVnYgIOJadUnudsdd2fkQG5NFqal6TdqDDBoPFEHalQ>
    <xmx:GZfyZkh-SY4nT2VbQr12KMtl8hSz4I27ukXJhfCa5GChOEepLgZo6A>
    <xmx:GZfyZvoQBvigBV3ss1bppFUdZBXUqk4K539tfGp2D8sDrYSq_FoyIw>
    <xmx:GZfyZvhn6_JcAajSbENV_0FcyhrPhDe9M-qVALHoeuYPjMlm3PXqwg>
    <xmx:GpfyZtagEODVcYYNqqb33Ta-VcwHNwyc8t5MhQar-kmU3gpdu30Bkfrs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:40:23 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	eddyz87@gmail.com,
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
Subject: [PATCH bpf-next v3 1/2] bpf: verifier: Support eliding map lookup nullness
Date: Tue, 24 Sep 2024 04:40:08 -0600
Message-ID: <815cefa75561c30bec8ca62b9261d4706fa25bb6.1727174358.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727174358.git.dxu@dxuuu.xyz>
References: <cover.1727174358.git.dxu@dxuuu.xyz>
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
 kernel/bpf/verifier.c                         | 67 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/iters.c     | 14 ++--
 .../selftests/bpf/progs/map_kptr_fail.c       |  2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |  2 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 5 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd86282ccaa4..cff745d484df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -284,6 +284,7 @@ struct bpf_call_arg_meta {
 	u32 ret_btf_id;
 	u32 subprogno;
 	struct btf_field *kptr_field;
+	long const_map_key;
 };
 
 struct bpf_kfunc_call_arg_meta {
@@ -10416,6 +10417,54 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
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
+	if (slot < 0)
+		/* Stack grew upwards */
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
@@ -10513,6 +10562,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -10773,10 +10831,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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


