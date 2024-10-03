Return-Path: <linux-kselftest+bounces-18943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7C98E794
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 02:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14621C214B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 00:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41A184E;
	Thu,  3 Oct 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fuut2lPN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyVDdwza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B1BA4A;
	Thu,  3 Oct 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727914327; cv=none; b=S2HsROuqbqGOedx2J+RKTudTXuxJIpWqoUcgxml57r4nWYl0Zue1c9oybHFpFLCsNd4wkqc2qD9vosSAPANTp1MFKY4xdmseEfEdDjRoCuH7ZEz2RrLkzrvnnzDv1cjKg8oMbMXWa7TqsuJ9Hah2nQhNQjoqEKK28WUnUr+o7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727914327; c=relaxed/simple;
	bh=gRHHISraAUHj5VJZsunSPqdXpZcVmMrap88nIPChNF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvniyFbxYMLmShJdoNpqvtmliEjqJ1QNUp0NBdUdbCeSVEUH9Z417uEdkzqkaF7tt9Fx7OlBl/4n0FF0RIilx0YmatAY9lHLKemVv3Z8lgqvud7Q3/alG0/BVEhE3Wb8BHQoO/UHUV1BQf+7TX6QiJ0rZ05NnrLHvnvbjWsIv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=fuut2lPN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyVDdwza; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C0C1114009E;
	Wed,  2 Oct 2024 20:11:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 20:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727914319; x=
	1728000719; bh=UACAjwh73MnY7DNlfZUB/AZis/CIaXIzU94UCeEeXtQ=; b=f
	uut2lPNZtMAbz2RVhkM6MZUdIBfu6sjFfhIxl5oueEzt6SQ4R+o48EQHd1HgcRsl
	Tdl8wNBATZN1OPRMVC2sA9fHipRuxM7vG2XC9dWbXZTmVZ5PRKup0r55GaVbsB55
	zR7NYCfFe3jp0g6rqNvsrGIcq9FO/Yu6cLjhm3qLfwoTib7dnfCaJTX9DkvoL653
	OZmo2QAGi3jj0Xbw5PcnkehIl72fWj77u0QGrxH4J2WxCslh9ht2TceLPNrkgoQX
	g8A+7v5ua3pOkdVVXlKmHnUjbheAun4YzWenYyJYLACJWQR/fYa2HNhj3uAUCmR9
	rOPSICgKvDffGCeJ0nFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727914319; x=
	1728000719; bh=UACAjwh73MnY7DNlfZUB/AZis/CIaXIzU94UCeEeXtQ=; b=f
	yVDdwzaFJf6zqjf0/praOl3nsaOaetugZUCzNHi4aOoyY/WD49DZBFGIR1zvGAN2
	J1aH+N40yqJmapu0czLDoIJRK44QOdNax+GvENXXVAxusr20dcFP9/QihZGKcsnh
	pT751jm5cZUIG9152FO/JGqskmPhTOI4uwIFCTci6oHJ7E28aL/XQuz6S5/R61hd
	yxet1BvKDOj4SRWTpSM+B6Fo5rxHcabstv/zd5O7J6OH6wJu09wKDGSunuxaA5b0
	Td5b7gp+LQZ25ASy3uLTHeoAW8vxOfH6Gl/vD4LSxL1xwWTd/x3MtCAyMgyplYtR
	NA7aBYfKGqFN/gbqEPwSg==
X-ME-Sender: <xms:T-H9Zojmak8GCSKUEIqIQsTvKMYgkIdGxscmyNtGPM8e1uYDnKrMFw>
    <xme:T-H9ZhB0-JhUvBDWhm9cs7mAbU85jdHMxmeN_RykURHp5Px6RHoFBLiHJRFCm8OsY
    epC2shjbgtYvvzzww>
X-ME-Received: <xmr:T-H9ZgEjMDBcso2mXJPEeNbC8Li8a39Wn5Hn8ZY8scdsBch_7JSbo91eXvaOgyEN-j0XggReOaMsTczI_K7OBqpn0-diBEbfUn8c6bWJ_V-Ud9729Wom>
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
    eprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehf
    sgdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprh
    gtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhho
    nhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:T-H9ZpQ5wSsNdwo1k3WVghtxVR-h6RS6YDWyrcvpLGiipOWe-sWQTg>
    <xmx:T-H9ZlxAtOOGLt6HCFaBahyM_3f17AJLKvkKur4am6VPJ-FGLOxo6g>
    <xmx:T-H9Zn6rSIM7VxhoeezwW0RqMAtVTuCeW5xESdDG_PbYSy-3wB9ieQ>
    <xmx:T-H9ZizKyf7oPx7V16JgPkd4jbMCmUs5DBEyeCfCVD38wCoYXFSx4A>
    <xmx:T-H9Zmpejxwq8X4RyRsnMaqRsdSyI2Mccral6RD4r4a333o0HBR0AETQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 20:11:57 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	eddyz87@gmail.com,
	daniel@iogearbox.net,
	shuah@kernel.org,
	andrii@kernel.org
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/2] bpf: selftests: verifier: Add nullness elision tests
Date: Wed,  2 Oct 2024 18:11:40 -0600
Message-ID: <40ffed8348831397b79e6350dc80af3da27d6abb.1727914243.git.dxu@dxuuu.xyz>
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

Test that nullness elision works for common use cases. For example, we
want to check that both full and subreg stack slots are recognized. As
well as when there's both const and non-const values of R2 leading up to
a lookup. And obviously some bound checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/progs/verifier_array_access.c         | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963..872edded1623 100644
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
@@ -526,4 +540,173 @@ l0_%=:	exit;						\
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
+	asm volatile ("					\
+	r1 = 1;						\
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
+__failure __msg("invalid indirect access to stack R2 off=4096 size=4")
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


