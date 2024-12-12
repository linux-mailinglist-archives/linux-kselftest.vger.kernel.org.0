Return-Path: <linux-kselftest+bounces-23288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD579F001C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 00:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F169188E2D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDE1DFDAD;
	Thu, 12 Dec 2024 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OC9RfcZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sxOBm9rA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B7E1DF998;
	Thu, 12 Dec 2024 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045818; cv=none; b=BvtwMsY9sID9XMqzYDFaI0eDtXF/zBV9k4VBTG3YcoC636Dwqv1yDOEIAV0s4Bn5JnI70vXchZwjtuRDv/Nbh4P35fg6eWtTW1oSkbiDM7AVyCjR/0Y8oNIAYTIzgyjlY5EnbVeDPnVcqOR45VpcgCwH6nyVIVsl8UcecObrgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045818; c=relaxed/simple;
	bh=H7U0g6KHV+RedCnoOSo9H3KlNJVlCcjjye+Ii+NIuAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs4qg8zxzKHveRs0vWfg4/ZhlE0EAvZwZ0lWpUm7q8b3vUMBOER5ioUcvxJOza9dygMXShLYLmHkJZhnUzb/4j0SiNtUyRK1kBiz8p5wfh3emo7WIXe2SOti7gsFzt5Cm8W3PNx7Sp/tA8fw3S8rhlNwoeKiORBttumDq1eJhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=OC9RfcZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sxOBm9rA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45C2C114005F;
	Thu, 12 Dec 2024 18:23:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 18:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734045815; x=
	1734132215; bh=S+pWH49WNPIT+0GZMwPFONhzXnv7Z1bfBiMRxp/h00w=; b=O
	C9RfcZEzVYbJWmK3g26dVW33mtjdGSOX0wQr9QaE9kPmsPNiw2RCAe5tM4oR5ZxD
	6pJIx/62aikrNTygvVzYQpw6aD7RYmXr8LSRxFF26B/qnMMwCXw8Z4ELfkLj+yeb
	QQwYdlyaAeo4P2dHeukTvJ2sfY64TgGxZMTPrjR6MLPa8MRnAX/3oTRZ2VAqDN36
	XgWGAozv1DxMTPUQDL7P9H1gPeclLvov4XE2GC4n4vvQ7BrCqgaEaqNdjGKP1AOS
	9naalP3ciuSwzfvBqG5kc17JVJSdNCJB0/nDXtd7sZddqo7YShGucq+L0H6RygP8
	3zo3OuWhzbumGypPiMPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734045815; x=1734132215; bh=S
	+pWH49WNPIT+0GZMwPFONhzXnv7Z1bfBiMRxp/h00w=; b=sxOBm9rAUZnhuEWBR
	MuV3TsPxyef69EMkTsNaPtQ4zW1Y1Fnn4+kkRilhgM3Bz5mEA7yUSyhm3sewHC9u
	Cv2dUOGgmLmKnbRg3O0F9pHxYZuK6hX7yzUMcI0Ojlqk59PIL+Y9Roxmb0GhyE8X
	FtgybLYixgg8YpklvjUCINmrEr9dIrz37vuuAqwsBzg6ioehoc+6efyry93Z1BS0
	wWgjvY66Sb1oXtXKrrjP4srFXFNXhuZgbTdd64TL2AAXZDxsGedUP3ewGLG6kbhb
	54RdGew/zdQ0L8uqp1NBL7pWerFpz21nE5WXWQD0gcLdYj60uFQ/ZXq5RxL8sEh3
	Q1O+g==
X-ME-Sender: <xms:d3BbZ1z_x77rLk2N-j4v9PHLUxOhhMfpx7oprKzxJRJg6eUrs9KI4w>
    <xme:d3BbZ1R-WmOl4FK5jlhhiLnR-a0okEnkeUvsCUYJf315s-xqRvG2TIiu230xHIRaG
    eC4GxZb8zuAaz8aIg>
X-ME-Received: <xmr:d3BbZ_WZ19-TlAWezGQ_-dDVltNfiT23lShnuFgIIyDwzCLVAmQnWU_iDDmpggqR2AUix289xNf6ghSyr0uHRxXTtc-DeLyvdoWQ9kXixzUtTXx_ILwe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtd
    dmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgr
    nhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpe
    fgfefggeejhfduieekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugi
    huuhhurdighiiipdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepmhihkhholhgrlhesfhgs
    rdgtohhmpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtg
    hpthhtohepshhonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhn
    ghdrshhonhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:d3BbZ3gX3qtXSlpS2D589DVLF_1DTW0wiIYQXwnL9dkddgw2aBOhuw>
    <xmx:d3BbZ3CSiaVo8E0XE4XxM0lDJQl_sd9QmB8c3dx8eWxkRjJfdIlIfA>
    <xmx:d3BbZwKWSrUG68oUDop-LLxrK6Q6wnV45woB0gOXEHDoBu14jWvfGw>
    <xmx:d3BbZ2A8_at8ehZ5dGOt12dYb_SW2GUpfaMOKChjZbauT9j7DW44sQ>
    <xmx:d3BbZ_6rfjbZMr0pv2YGXOW_9gbvr6aBkRRgzTQOFqgFjjn45E1eiIqr>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 18:23:32 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	daniel@iogearbox.net
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 5/5] bpf: selftests: verifier: Add nullness elision tests
Date: Thu, 12 Dec 2024 16:22:09 -0700
Message-ID: <c97b9ffd2042790ae6eb55ba01eae94282014006.1734045451.git.dxu@dxuuu.xyz>
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

Test that nullness elision works for common use cases. For example, we
want to check that both full and subreg stack slots are recognized. As
well as when there's both const and non-const values of R2 leading up to
a lookup. And obviously some bound checks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/progs/verifier_array_access.c         | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 4195aa824ba5..8ed8865fc6f6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -28,6 +28,20 @@ struct {
 	__uint(map_flags, BPF_F_WRONLY_PROG);
 } map_array_wo SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array_pcpu SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct test_val);
+} map_array SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
@@ -525,4 +539,204 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("valid map access into an array using constant without nullness")
+__success __retval(4)
+__naked void an_array_with_a_constant_no_nullness(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid multiple map access into an array using constant without nullness")
+__success __retval(8)
+__naked void multiple_array_with_a_constant_no_nullness(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r6 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r6;				\
+	r7 = *(u64*)(r0 + 0);				\
+	r1 = 0;						\
+	*(u64*)(r10 - 16) = r1;				\
+	r2 = r10;					\
+	r2 += -16;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	*(u64*)(r0 + 0) = r6;				\
+	r1 = *(u64*)(r0 + 0);				\
+	r7 += r1;					\
+	r0 = r7;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into an array using 32-bit constant without nullness")
+__success __retval(4)
+__naked void an_array_with_a_32bit_constant_no_nullness(void)
+{
+	/* 32-bit write must be to stack address aligned to BPF_REG_SIZE
+	 * so that the spill is tracked. Unaligned subreg writes are less
+	 * precisely tracked.
+	 */
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u32*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into an array using 32-bit constant 0 without nullness")
+__success __retval(4)
+__naked void an_array_with_a_32bit_constant_0_no_nullness(void)
+{
+	/* Unlike the above test, 32-bit zeroing is precisely tracked even
+	 * if writes are not aligned to BPF_REG_SIZE. This tests that our
+	 * STACK_ZERO handling functions.
+	 */
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32*)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("valid map access into a pcpu array using constant without nullness")
+__success __retval(4)
+__naked void a_pcpu_array_with_a_constant_no_nullness(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array_pcpu] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array_pcpu),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid map access into an array using constant without nullness")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void an_array_with_a_constant_no_nullness_out_of_bounds(void)
+{
+	asm volatile ("					\
+	r1 = 3;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = %[test_val_foo];				\
+	*(u64*)(r0 + 0) = r1;				\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array),
+	  __imm_const(test_val_foo, offsetof(struct test_val, foo))
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("invalid elided lookup using const and non-const key")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void mixed_const_and_non_const_key_lookup(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 > 42 goto l1_%=;				\
+	*(u64*)(r10 - 8) = r0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	goto l0_%=;					\
+l1_%=:	r1 = 1;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+l0_%=:	r1 = %[map_array] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r0 = *(u64*)(r0 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_array)
+	: __clobber_all);
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
2.46.0


