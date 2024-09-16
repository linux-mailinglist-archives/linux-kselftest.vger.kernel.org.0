Return-Path: <linux-kselftest+bounces-18013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CF0979A25
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 05:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71F91F22A83
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B542D032;
	Mon, 16 Sep 2024 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="AoQqC1oq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNx8ORoS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA1210E9;
	Mon, 16 Sep 2024 03:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458341; cv=none; b=Pmgv4VtRHl2+5ZywugKmeW+YM/XtF9mkYS+/smHkCAihKva1feKiLJT1vrpPbAQF37wsX/0JCIAMMCNexHmVTpr8pFOZXnl7xYu1Yv/i8qk801YIT1Ljk4Y0nmhQlqLERQwzvSTEkk1dC2pd4d7KQsE3/AOoRzxh/jR0urZ/iuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458341; c=relaxed/simple;
	bh=vXDJQCJessgWs7j3OPnNSJrwOAmsKCw/ugcv6ZQnd0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwJFH2Wrc09p33P5GZYEzXtB1j3bMrcM+82YDPS/BeYeqACuL18gmHs4+D6zctdPFPZ3Ny5c7Aw1azctxjJiYvfK0Up/67bZwP64cSRqBOg/KRoLZcak4/gTMoWtpRiv9cC/zNOCK8TyAeKLZFCuE2WCjdukchGnTdz/mZJcoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=AoQqC1oq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNx8ORoS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DE671380278;
	Sun, 15 Sep 2024 23:45:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 15 Sep 2024 23:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726458338; x=
	1726544738; bh=/yzZ56O5FRFhQ5SJTT8R9rL6t8SgRbGwbbj/xdpptdo=; b=A
	oQqC1oqIVcFAJoho5kwzwRPkiOuDMo5ZMPLxPIK80ndstLb1Llz6OjR5Svn26FdK
	lNymAkRlAx3dl2UnLDUyrmjHdwDC4Mc3Xb2thxc5SFMBua6qJg2sVBfX5ZYxOXco
	48cTlZ54uhI+vv7+5fq5d4qcD2W22wGJ5AyqcFQcY0jggZGZdAfiOc3pfeEOZYOl
	ij36MvLB1NJh983WxykFhG46YNmp3Rl21MeuU6shFNCMOV5UHQbh3R7mnufIOPpF
	ywI7WnUlKJgGSCsCOXahRe2233ljsp5bCzTeItI9QMZ+n1IIMpP4eyeOJMXNA/CZ
	lgce0OjoJhE4X6BannGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726458338; x=
	1726544738; bh=/yzZ56O5FRFhQ5SJTT8R9rL6t8SgRbGwbbj/xdpptdo=; b=q
	Nx8ORoSH+u4JNcYmK2gNqhxfM+apqKSwdWPk+q2uc8P5wJtojx8MHQiiXX+igXT5
	D3UiaUT4BXoyE94tS/tbxDwIMwmzdWt0JYHqi1Ogc1oz6VRMQQtFnfjs2atNFAzo
	HRtA4utufQNtBYubZwdUFziannL24N5pDFssWzLSIw+XQGNzWoCn9/NgtsWplI8b
	mlJRP8CczJTqMjITkUSvfoBozFAaCZ/nw/nE8rquC8jc7MLK3/1Tbbp7DunWEOmX
	InuwJUeFQzEg6gh3/adqWLCvHGcpKVILaBaVIZbZ3Esi2dSszJphyLXqMq46kRkE
	KD0IBsRgMB25EcyckVzDQ==
X-ME-Sender: <xms:4annZnoP9BsAI02uIOlvbmm_XJd_a6vu6YQvG6QZHFsIyC2mFE-6mQ>
    <xme:4annZhpPQIXU2H7MhW2rFQ5pULyKqay7RWOPgYHWqULiIb8Md3yTpqirId35GOiZ0
    MSGw7c4hZrCBGtcRQ>
X-ME-Received: <xmr:4annZkNiy_K8ydqHZvaZ6454wkjVu_y9EJLUQL4SloNFJmUWWjA1glUyZzVKG8mL7d23JuNjEC63wRX4ZQd5NpBncMYkKVgeEeXhMOFNFMLl8528x5Wu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhope
    gvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrthhinhdrlhgr
    uheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphht
    thhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4annZq50iA_nAADFiVGuCXElNYkrS_XJR62c6UO-CKyK_qSok4aGbQ>
    <xmx:4annZm7GmeaNuYqrDVSCQiQof5HNOu54Eh6koR9DAZmguyoHFs4taw>
    <xmx:4annZijtDiqxUHwWcEscyIl8cGT0tzo3TJqvjBGWRPLO-oO8kl97ww>
    <xmx:4annZo576hRc5QfUgHT4QGNh7pqTxWvChK7TO5QDIDUCcHojGjwp7w>
    <xmx:4qnnZjwNd_5eEIRChqiP0DqGhjkl_fHfcsh8nAGpJ1cPUQlWSDq2-Lmt>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Sep 2024 23:45:35 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org
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
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] bpf: selftests: verifier: Add nullness elision tests
Date: Sun, 15 Sep 2024 21:45:20 -0600
Message-ID: <1d8e11853a04ad6a6fdb2ba726090666d5bc6473.1726458273.git.dxu@dxuuu.xyz>
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

Test that nullness elision works for common use cases. For example, we
want to check that both full and subreg stack slots are recognized. As
well as when there's both const and non-const values of R2 leading up to
a lookup. And obviously some bound checks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/progs/verifier_array_access.c         | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963..2e74504ddbb5 100644
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
@@ -526,4 +540,156 @@ l0_%=:	exit;						\
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
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


