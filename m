Return-Path: <linux-kselftest+bounces-18292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183369843D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58BF286857
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920619F120;
	Tue, 24 Sep 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TqiF7xRb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cyt2VHFS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1419EEB7;
	Tue, 24 Sep 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174431; cv=none; b=cs5+c93A5LbbM3a8UWJLr0ZyuIRb8hdpevvhPh8tTSQVLc29RsY9OdKRrJPvfP/a1YqbhWD1Qk/7MFTNsdeG4kBBgp+sUjb4cS2M0xZvW5QJdZuJhIr1gmO+4Fr3gAnv8ozAdAwFgqKvbjILmqgS6mWJSNhYAFxYmogsCKcsqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174431; c=relaxed/simple;
	bh=ryGGQ01u25GfzFcnfpQ+eQMm7gzGWJ8S+REeHBF0Bok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZbCRbk9P36+zpegVPlqwc6A6EEiGhd6CjYvWEi6ZT5lgtUfELXbS8vmHHgqXkBkn1j8wR10cjVIT/yGJ2RQSfA8+OxJTvfuc5Gix5FPzPKOjKIx66txNj4QNwaB2A3jEH9RtLNrHCM0NbZTqySaL3W8mmwNYljm6fMNl1lKLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=TqiF7xRb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cyt2VHFS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADBEE114030F;
	Tue, 24 Sep 2024 06:40:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727174428; x=
	1727260828; bh=tm27dyNaV+N171Lor7VvQJK/9qI5IQauKtiSXWUnARg=; b=T
	qiF7xRbnIC6UybUVNYP+K1WAvCVUNMbLJhC0hY68kBOreT1QtmUl9fFy9tjQLd5d
	6qpKeogbumXnMLE2FXtCkufHVVFSze9x1kgJ/NJa2CksZGaWgUtllWfFUDCQmdJJ
	7TdMSkTI9WCRrn7ijxfQxtkef2xNl8iARqPskbV6pMJdURhP97WA+5Y7fBu3/0g+
	iGvr6zxTpHzDOjAwLotTJiwqvVHCEDRDo0Su617pp8MGdHi5NZU3C71yhckAoaw8
	gZiujxvYbcFt3HQPaXdEYOuv+3O+zbM5EaqbVg3CpntJl0QYz7ZmV5s6sVnKjeMg
	2BPDuc1W6FkFJi2ODc3GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727174428; x=
	1727260828; bh=tm27dyNaV+N171Lor7VvQJK/9qI5IQauKtiSXWUnARg=; b=C
	yt2VHFS6SyvggsSMaTSewvrmHr3n5YZBmfwZofn+EXykTrkG6iNPPCqrFFhhPUfz
	lGn+KoUpQtVLCs3RtpcJhbBywKBNWAwIxFWy8Ia7QT6BZFkiKUMqPfSrZxtq2BvJ
	/yVABdeI6xNLk2nKLG3oAMSKWs/D2iJw2fi3XSwBxb0Xs4kUHSWHjQhHfQsN3xWm
	klYGRFxpgRIOc8K7u9k5iwNs+4ACtppCMKmWBaK/ijudgp5Ur7XM1BpW2zzy5nJg
	5k02S188pK5gvTBjPMbLAKOYDiVIl2FyKeX3VMCw6sBEJMPxN5d5aPoShEbV6Hvf
	ZYsGdVyB0lkqpSW/tjCbw==
X-ME-Sender: <xms:HJfyZiWM1jsvHLgA9LK5gSw8fupCrTCNKi5x1u9A6sY6FGwM0ZMrGw>
    <xme:HJfyZukFVczhiI8azp2Gt73cmQdrwcy7ASMatx1P3jhFP8kiS1-YpXtaQj5q57aSY
    mSxPQStsrx0dhqNMw>
X-ME-Received: <xmr:HJfyZmYyr9u0_Qn2NvGShvdDPtYZKwYGcu7pUS0MwSX14OoYYPKlEXoKVsW5p7u8-3R4ql7t4u9X32Jp0aZm7X7LgM9wphcean70aMT8-3NdJuti-Zen>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgfedtucetufdoteggodetrfdotf
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
    eprghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhihkohhlrghlsehf
    sgdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprh
    gtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhho
    nhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:HJfyZpWFyx9r9iZOhPEyuORSdoR1m7v0XIwehuavly7dMSSYNxFDLw>
    <xmx:HJfyZsmCS_vK8ychJmPq0LYgtBrsxyz5JHh8nRrxTf4KfP-Z3wvGcg>
    <xmx:HJfyZufh2TZNq27tGnPdu6xNj-Ap7kDfiORaf5T7uV0xioqByN0cMQ>
    <xmx:HJfyZuFKTCE7NcVMvJekMWPgwTg5YrSs1PYvLsOvnZFEpjPwTLTnEg>
    <xmx:HJfyZrd-DA2RobS6_p72nyvCKPyCXXgQMq3wZB-wOWNyTMHRwnycWTAE>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:40:26 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	eddyz87@gmail.com,
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
Subject: [PATCH bpf-next v3 2/2] bpf: selftests: verifier: Add nullness elision tests
Date: Tue, 24 Sep 2024 04:40:09 -0600
Message-ID: <0fe2a76efed263378c9739795d88d77a5ee81ff5.1727174358.git.dxu@dxuuu.xyz>
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

Test that nullness elision works for common use cases. For example, we
want to check that both full and subreg stack slots are recognized. As
well as when there's both const and non-const values of R2 leading up to
a lookup. And obviously some bound checks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
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


