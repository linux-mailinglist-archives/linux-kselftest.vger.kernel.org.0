Return-Path: <linux-kselftest+bounces-24518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827CEA111FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9873A58B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F3212B3C;
	Tue, 14 Jan 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="dKaXkNSv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZkNBxBW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E720C46E;
	Tue, 14 Jan 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886562; cv=none; b=EBGvy+35WyqMkCLleHAoOPwcRA9jk7XbqXpom8rOBV+cwBguyTSEJeCq72HshWHSqp4/wrg8uFDkRSzDY4SYzRw9EKmfhCz6dMg3wR2Ld0Gt2z5MAPtQVv2dB4oYAiizwTureXqmX9v3VDtSCnTIDhevNEiqUsk6FLczdvUP048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886562; c=relaxed/simple;
	bh=czZ4Mpnmkrow1hHAmMCKjnkd+QwGSZhyq8WqbZoRWuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfOahjmJFw6orgRiUj987PtKKMerVSL5EnfEdsf/yw1o2g5kVVOkBRcVtlAEH5EKoAUnu1DsVs3NlceGmuHLeX8c4pmQWrCghEx03ZYaPTjgemurwC/p51ofhVFyyqsSDlcOXONZ+OeFtfHVHJbgDfhplK6RmcdTYEwUDLALCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=dKaXkNSv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZkNBxBW; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F4302540192;
	Tue, 14 Jan 2025 15:29:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 15:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736886558; x=
	1736972958; bh=hiAH15ASAJl1qeq8RbV4azHqOQtb6ImILSyAe1zcbpg=; b=d
	KaXkNSv2ogGxozNlOb5hP2cHrOiG9PgZ/v5QFciwzcPScb1FCBPUgYNOdcD7v3ua
	F5TIafiZv1UrgL5uBT1+mhYea2MmDq6lmOp84uXii6/cCXdI/CarctJ0UK58Dcqp
	GheJT8RgGmpIPYDDgpNw2fpTy3RLDvdw7/zVNLvmCAoBIBhxUMaLsXt6oBHxYu/M
	LLo/PmwadIlSnlBpu4GYYirQ8oYkZzX7ER/li+PNX1dVRp0MId8MDsA5l5HXiPlH
	OTrQlsXBBGu4TJJEVS98NJF9Jl9qM8MX80vOo//xv/pUBCS2tzlBpQEwHabZh0qw
	VIFRw0Ucma/3lC9BuG44w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736886558; x=1736972958; bh=h
	iAH15ASAJl1qeq8RbV4azHqOQtb6ImILSyAe1zcbpg=; b=BZkNBxBWmR7Usvrsb
	jDH9N4t2LA3u78YtSaJ4180YBS3JSz8W6de0NhsLq1zCuJE+26HB5QHi5Cq09De5
	zRcicN08vJVnsMpdAXZBk7l9a7xZCrpPTj1z9ZLcJHeZQQW50fVLmuUAKhD0GSYM
	Efkd+ucrLJlWssQzoqjnpvSogcKn+mCv9T0aYM6NQK3gDVrwA8tPwTx1eG3kvG1I
	vazlVTVzjdzVGZDWC95euGn/jSczlUFmGQEXLjuT9sHLq7Y85y3yK8pBesabi+Dl
	6sd7EQm2ry428tHR4B87GT/q/zF9B6XGJ9tQKoGYgaQHd7+eCczjUghtswuo4v95
	AScFQ==
X-ME-Sender: <xms:HsmGZ9tazW8GEsju6e0koweX-RoLr2LzSAxCbKFVYv0cMXSXN3YBIw>
    <xme:HsmGZ2eN6g14EgrISF04FhuJziaC3LtItFUWWcmnmmJD4EskoA8aDsaJDnjyuOyWR
    sG36q0n6fHsqNv0Vg>
X-ME-Received: <xmr:HsmGZwwXPUw5IReXzNvOrpZBo95V6TFvfORHtoeJpzpppV5tGbjDgWlGNq5xxjWaKpQVNogkH5dAgoqTMZYqlUFiH68PTBPfLzFxt79KgCVc490CczxG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefjecutefuodetggdotefrod
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
    hopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhl
    rghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhgsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlihhnuhigrdguvghvpdhrtghp
    thhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HsmGZ0MEq0QB94Y8l3l-GKgJfvrZ6Nwnu4eNElFIdFJ80yByGoklMA>
    <xmx:HsmGZ9_GrCYPutrNPvOWrkDRy8GhXXsbv43ljPqXv05dt9sGqfhszA>
    <xmx:HsmGZ0Wjt-oAyMxNleTvSwml_aZBJ1MFU24VLP8KMvyMDsE5MQI5kQ>
    <xmx:HsmGZ-cTGrkwvREWJSbcYRlud3kItFoFXyVkbn831gtOhC8izkjnOg>
    <xmx:HsmGZyiK7faUJcnwt0gseTep_aNFM9MDJxu3JOGb4MnRmdFAU8VPjqVJ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:29:16 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
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
Subject: [PATCH bpf-next v7 5/5] bpf: selftests: verifier: Add nullness elision tests
Date: Tue, 14 Jan 2025 13:28:46 -0700
Message-ID: <f1dacaa777d4516a5476162e0ea549f7c3354d73.1736886479.git.dxu@dxuuu.xyz>
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
 .../bpf/progs/verifier_array_access.c         | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 4195aa824ba5..29eb9568633f 100644
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
@@ -525,4 +539,178 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("valid map access into an array using constant without nullness")
+__success __retval(4) __log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
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
+__success __retval(8) __log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -16) = {{(0|r[0-9])}}")
+__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
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
+__success __retval(4) __log_level(2)
+__msg("mark_precise: frame0: regs= stack=-8 before {{[0-9]}}: ({{[a-f0-9]+}}) *(u32 *)(r10 -8) = {{(1|r[0-9])}}")
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
+volatile __u32 __attribute__((aligned(8))) global_key;
+
+SEC("socket")
+__description("invalid elided lookup using non-stack key")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+unsigned int non_stack_key_lookup(void)
+{
+	struct test_val *val;
+
+	global_key = 1;
+	val = bpf_map_lookup_elem(&map_array, (void *)&global_key);
+	val->index = offsetof(struct test_val, foo);
+
+	return val->index;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.1


