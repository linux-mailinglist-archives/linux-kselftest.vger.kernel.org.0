Return-Path: <linux-kselftest+bounces-23645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D79F8AEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C916B8DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141271A2C0B;
	Fri, 20 Dec 2024 04:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qy11YAuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qU9XQjx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F41A070E;
	Fri, 20 Dec 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667819; cv=none; b=LaTdMKx0hq8RVS0X5/JpKz0bZDRxZDze6qla03upOIdB8zWmX+HYz6bnYDtilkWTYQzxw+I5fR49+XSk007ECEWh6okJ3GfJ5pWi5jF5m3Ab4JBmPwDs3RMrJuRbdDCQY/ZNaWxsq50h39nx0szGijKoA+QvIjFxTfY7uDO2t3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667819; c=relaxed/simple;
	bh=j91i2eIbGrN7oqs26R8xlArrNNQeSfxO+yJR7BD6KnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRU1Ud+3qpAAPDSQq7dP7eijc5RnUjMSHTcEpFheUweToAxztGRTuwvk0nej/Wi+x+ex0hiRJPFpHfbG1tPTkWfjTZcVFwczB9w2LcBASus4kLTfVZFUWvMh1Nk0BRd9Z4gdbCkRue3CU5tAkKno/Xvr+dByMreqPNz9mOam+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=qy11YAuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qU9XQjx0; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF25F254015D;
	Thu, 19 Dec 2024 23:10:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 19 Dec 2024 23:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734667815; x=
	1734754215; bh=Pzg44vrqahkueipYoIDkB3Hlnk59Y/K6dgB+mc1P3lU=; b=q
	y11YAuY+151u7eQ3TTq834B/a0x16dgOE47OK9I7X5uxrsGFyKKVPbTA4saLAgqi
	ISkRgjT/gvcLCBFpdaMDBtrcWRES8llixwflkQZnI4Nm28mWaJ46j4BEZtgWgXFC
	Z5Hxulm/LRe25G09gB7VUFEFjYQkDj0biXPDwsfRjB8Ru1BOdNgKElc7WatBifDb
	d7CsWnipgCujyx0rrN1nb5JgMO9HdzmsxdUZ4Zi0K8/n5bhS54NuBml50N/k0eVg
	SFtcDHf4LInHgHKstVQPSQyqgE4NuSyY0Rl1bV8T3YJ2SwecCS0XghWkhDknBzzk
	KeyqMZ9hWKC2KUszOYGug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734667815; x=1734754215; bh=P
	zg44vrqahkueipYoIDkB3Hlnk59Y/K6dgB+mc1P3lU=; b=qU9XQjx0/RhwOJggu
	qHP/HzYIilkug7Z10epCyzN/XB3Au/FiL9VqmYNNvofzEVrzp4eYuApo7Smprz/f
	uvS5pB5NTgTF0ynIVbnLr1pnIKnGiCYBvVG48LE/cR52QaLgyyiooP+fMHIbr7Xp
	pTMIEvBeljJCvGSij2ewjIL+KNiAFYQKMcgRnyzojXXleBdExcxpLTRE5xZjkwvh
	7ztkAO/VsVIgl07tWZCFOHOln7K31Q+7CUS++8nKGciBM2l9QAJGu2mkFPhypE9d
	z03OHIWXp0QNNVUPfpu2HrcVd3EdTx/syAUjLFkb/UHurKaVhD9VHNZDO25kT4zQ
	0jFjA==
X-ME-Sender: <xms:J-5kZ28U5zaLZfwH1E9JCWuHJfq1qJ3rH2S-vTe9Xq5SpUva4F6KFg>
    <xme:J-5kZ2uJCV1YJpKsd_lHuqv30hsXoDpbY1D_-g0vHjh7ifftS_nhd387BQtvgNoQ1
    4aCdgZWl-39XfyJaw>
X-ME-Received: <xmr:J-5kZ8D8iZ5popLMb0otWkjCVswOro4e7pkCtZZOSMJYyNowf7DeZq79UpgPob2aCmu6dTNrgMsQxSJStaFW2ih3UEHHbRvXFpDVCZlJAbE59kGTc_zc>
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
    hnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopehmrghrthhinhdrlhgr
    uheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:J-5kZ-eJuD-gdWKtQh8Kg1avJpGfIKHQS_W_54nuga1QLr_ecf8D3w>
    <xmx:J-5kZ7MFsJzzyrqc8f-TrhJXPmLLQ7yYmwo4IAMyOfLR4JQloDTKCA>
    <xmx:J-5kZ4nb-9fs6-X5j0jWFKpV1mLPl8GSib5hzYBltu5E0FLxCS6LJQ>
    <xmx:J-5kZ9sgY-Bw0oecck7YAiG5MxJPY5ZtXkh0OCOeHrVi4OjDcImS0Q>
    <xmx:J-5kZ0xxojEvAgZ5Eh7VcohUJRJj0s4lkKQTFEpPR-A78SGjnKv8F_Gp>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 23:10:13 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: eddyz87@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 5/5] bpf: selftests: verifier: Add nullness elision tests
Date: Thu, 19 Dec 2024 21:09:47 -0700
Message-ID: <478d188ecd9ac004ffae6fba969b71364adbab1a.1734667691.git.dxu@dxuuu.xyz>
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

Test that nullness elision works for common use cases. For example, we
want to check that both constant scalar spills and STACK_ZERO functions.
As well as when there's both const and non-const values of R2 leading up
to a lookup. And obviously some bound checks.

Particularly tricky are spills both smaller or larger than key size. For
smaller, we need to ensure verifier doesn't let through a potential read
into unchecked bytes. For larger, endianness comes into play, as the
native endian value tracked in the verifier may not be the bytes the
kernel would have read out of the key pointer. So check that we disallow
both.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/progs/verifier_array_access.c         | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 4195aa824ba5..ecc51eb80fc1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -28,6 +28,20 @@ struct {
 	__uint(map_flags, BPF_F_WRONLY_PROG);
 } map_array_wo SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, struct test_val);
+} map_array_pcpu SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__type(value, struct test_val);
+} map_array SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
@@ -525,4 +539,158 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("valid map access into an array using constant without nullness")
+__success __retval(4)
+unsigned int an_array_with_a_constant_no_nullness(void)
+{
+	/* Need 8-byte alignment for spill tracking */
+	__u32 __attribute__((aligned(8))) key = 1;
+	struct test_val *val;
+
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("valid multiple map access into an array using constant without nullness")
+__success __retval(8)
+unsigned int multiple_array_with_a_constant_no_nullness(void)
+{
+	__u32 __attribute__((aligned(8))) key = 1;
+	__u32 __attribute__((aligned(8))) key2 = 0;
+	struct test_val *val, *val2;
+
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	val2 = bpf_map_lookup_elem(&map_array, &key2);
+	val2->index = offsetof(struct test_val, foo);
+
+	return val->index + val2->index;
+}
+
+SEC("socket")
+__description("valid map access into an array using natural aligned 32-bit constant 0 without nullness")
+__success __retval(4)
+unsigned int an_array_with_a_32bit_constant_0_no_nullness(void)
+{
+	/* Unlike the above tests, 32-bit zeroing is precisely tracked even
+	 * if writes are not aligned to BPF_REG_SIZE. This tests that our
+	 * STACK_ZERO handling functions.
+	 */
+	struct test_val *val;
+	__u32 key = 0;
+
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("valid map access into a pcpu array using constant without nullness")
+__success __retval(4)
+unsigned int a_pcpu_array_with_a_constant_no_nullness(void)
+{
+	__u32 __attribute__((aligned(8))) key = 1;
+	struct test_val *val;
+
+	val = bpf_map_lookup_elem(&map_array_pcpu, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("invalid map access into an array using constant without nullness")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int an_array_with_a_constant_no_nullness_out_of_bounds(void)
+{
+	/* Out of bounds */
+	__u32 __attribute__((aligned(8))) key = 3;
+	struct test_val *val;
+
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("invalid map access into an array using constant smaller than key_size")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int an_array_with_a_constant_too_small(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+
+	/* Mark entire key as STACK_MISC */
+	bpf_probe_read_user(&key, sizeof(key), NULL);
+
+	/* Spilling only the bottom byte results in a tnum const of 1.
+	 * We want to check that the verifier rejects it, as the spill is < 4B.
+	 */
+	*(__u8 *)&key = 1;
+	val = bpf_map_lookup_elem(&map_array, &key);
+
+	/* Should fail, as verifier cannot prove in-bound lookup */
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("invalid map access into an array using constant larger than key_size")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int an_array_with_a_constant_too_big(void)
+{
+	struct test_val *val;
+	__u64 key = 1;
+
+	/* Even if the constant value is < max_entries, if the spill size is
+	 * larger than the key size, the set bits may not be where we expect them
+	 * to be on different endian architectures.
+	 */
+	val = bpf_map_lookup_elem(&map_array, &key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
+SEC("socket")
+__description("invalid elided lookup using const and non-const key")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int mixed_const_and_non_const_key_lookup(void)
+{
+	__u32 __attribute__((aligned(8))) key;
+	struct test_val *val;
+	__u32 rand;
+
+	rand = bpf_get_prandom_u32();
+	key = rand > 42 ? 1 : rand;
+	val = bpf_map_lookup_elem(&map_array, &key);
+
+	return val->index;
+}
+
+SEC("socket")
+__failure __msg("invalid read from stack R2 off=4096 size=4")
+__naked void key_lookup_at_invalid_fp(void)
+{
+	asm volatile ("					\
+	r1 = %[map_array] ll;				\
+	r2 = r10;					\
+	r2 += 4096;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


