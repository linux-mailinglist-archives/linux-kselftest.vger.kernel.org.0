Return-Path: <linux-kselftest+bounces-18002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C350A97945A
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 04:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7A91F212BD
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 02:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89DC15E96;
	Sun, 15 Sep 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Y1F8qNed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXl8SMYr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EE10A0C;
	Sun, 15 Sep 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366294; cv=none; b=dZDXayB3nyYio/STAOlR9a2K2pz3ITP/EXQ4bgm0fuwhTDHi1LqjdYqBDkq8cxiDNLpHzIhtTIX7yUDnB+Ocj+QxCJ3g9JkuCzkRKc4w05LPxsoLGIuyFWVSSEQtsFBgDon0LGPWaJ8/sOtp547UGR8VnHKOYN8QNdt9a+eqIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366294; c=relaxed/simple;
	bh=g7juDejI7eJN79EEGNSXhjN9Y+JkFquiwa2q2bWnyKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoMzNo25aF1NaS1P9yV7NnWt0LpzAuCX4ahrDS7/loZzZ+bvR1oH8pV0SaeYGOWJ7NMJjSekhO86FztEgWBB69UdgiuvXK79vPS8PceE2+ldToZPUtm0cLZI1MX7AaAGqmBx1veAivlcLgTd/Q8dnqC/L0Cqa7tu5eoVY0HB9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Y1F8qNed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXl8SMYr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1122E114008B;
	Sat, 14 Sep 2024 22:11:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sat, 14 Sep 2024 22:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1726366292; x=
	1726452692; bh=x9ZpRYM8kHS0muDHL06dw8EZ3cVcPCsBaorwNhHXrgo=; b=Y
	1F8qNedlpVN08nzHcuDs3jG6q+tBuVupSXBPCbIDbMT/sUQBdaYVGFsD+hrxPvVb
	JVOTDumh3hjFSdpn5OcqlACjZVmZK4q03Jskd1qsqIU56/3GYy1aRBVwmpPbLZhl
	7Ztvd9wXaSLwo3Mxy/D9iqrWyX6Z9AOVzMzP8jycjXO02u3v/NVjmcW0o/BTH3sc
	hl9dfpuV214cnqVu6f2bFmHUMrkYAR2npio03f1YgP1Se4UE00i6nJFgo2PjIV2W
	tEMzc/fE9ymjxNnaT/YtZaERlmDxFNyqQmVQaDSUR3wuFvPW4dcQ/nGNucZVSHR+
	3itt7HFjJ2bYJfU6/6thw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726366292; x=
	1726452692; bh=x9ZpRYM8kHS0muDHL06dw8EZ3cVcPCsBaorwNhHXrgo=; b=i
	Xl8SMYryWT4WoauTDCvC2Rft4KffX4DW/oj2ncBXKMIN91KUSTmOU8i0p7Z88Bah
	q6Mm7oNN0rTJMYXYYUfkpglwmMQAt+pqAXIrKYuwhk4qFI2eKqXDDPChhnXJOJoh
	deFD28Og60wTF2/tGHhbIAj2ZLiaPvgvrmBMQPvrLBQ+ka3yA99ZwwCYkcqyGi55
	v7mfElMBy6mDqIt2Z7gQlJt9CXoS/DONb8XgAfQotSgIBt7xSy/Ao0DOk8XMnqQZ
	R/H4/2JW0mZi0qe1ibsY8aK/uTkkcIFHrfpgJn3hzFBm0hVEYrNoIFwOxtUypSTq
	DD1nUzzBDQExADKL9Ixzw==
X-ME-Sender: <xms:U0LmZjyGdZdzm5KpR6rH5L8Cufxo2GCMMkB_IlAE7VyfEII9gPP2kA>
    <xme:U0LmZrQr6iI-njgI4Fdoe0Uj2ApWcL6Us8geYTfHAA89mcvEwMYHnpowCQ1Cmd4Uv
    JfY-kn9bwl6hoKTTw>
X-ME-Received: <xmr:U0LmZtWrSJrAXqdAH_fjj69tI7hThT2jCwHousl161e27nBAtgjwlBMltEPSCYhCnfQuNUJ8fkvTToOCjquB3WKCxDj-F3gJyOx9_s7K2hV7W8klVfeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeff
    rghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnh
    epgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesug
    iguhhuuhdrgiihiidpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurh
    hiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoh
    epvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehf
    sgdrtghomhdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprh
    gtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhho
    nhhgrdhsohhngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:U0LmZtjzkV7f-xzvOiufTdzVBnoXPaNgPkLFtQW4ZDZRqHiCB_rPzA>
    <xmx:U0LmZlCnnLwPz_Ov3lQY9hKohxPskGhCATvO6FBH5MV4E3rVaFr_OA>
    <xmx:U0LmZmK5qyuyevCEARgipSMFiM2tJqIEK_f99uaL-hiDknX1dKHxKQ>
    <xmx:U0LmZkCMoTXVZR96s4kSu8C146H2o4ahCgbAsJW-K5Zuq0zuUzXOjw>
    <xmx:VELmZt50oWC4Ka5-l2nVXfMR8MuR77HgWemDwd91RLApNaQdJa7f0p83>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Sep 2024 22:11:28 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
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
Subject: [PATCH bpf-next 2/2] bpf: selftests: verifier: Add nullness elision tests
Date: Sat, 14 Sep 2024 20:11:12 -0600
Message-ID: <55d878b5b9ee0daef9e19f7c5e13cd78d96a59cd.1726366145.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726366145.git.dxu@dxuuu.xyz>
References: <cover.1726366145.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that nullness elision works for common use cases. For example, we
want to check that both full and subreg stack slots recognized. As well
as multiple lookups. And obviously some bound checks.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../bpf/progs/verifier_array_access.c         | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963..85bf50750a8e 100644
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
@@ -526,4 +540,133 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("valid map access into an array using constant without nullness")
+__success
+__retval(4)
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
+__success
+__retval(8)
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
+__success
+__retval(4)
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
+__success
+__retval(4)
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
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


