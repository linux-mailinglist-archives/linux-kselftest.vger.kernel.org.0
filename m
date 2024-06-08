Return-Path: <linux-kselftest+bounces-11498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF190138E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E101F21B40
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA284AEC8;
	Sat,  8 Jun 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MA8InosA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YT3wcUra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A621487BC;
	Sat,  8 Jun 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881403; cv=none; b=ewVkrSrZ51TSq7+hIVRNx/o+2HJDGRO4rohf2rH5SGkt+/chZanJ6kSxBMFH7SSKZVbNmEiyRp9U171xeJfZSKT/pbMt0GVT17SmCrFiGTGtwiIg+ac9Xnet3F8WeiFB40i8gPTOUoSOHqV+7zx2e9QH/AhZPU22ZOr0/XwPy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881403; c=relaxed/simple;
	bh=ijnUl0Hs27kSZo5nKTCwOlVMiTcVZASzt7fhb1OM00o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ8kcp2n+jJHLKmmakPvj3mIieGUhgy38Y/WssT2y+347J1+NJmU2zKXswTn6NNvfdltRvJ1ZAkhQg0ImNMD463YsGHKzsmQosPsr3KBOagR5F6ITyTlXPYwkJU6GaCtCG0LoKXRsKtpAOYwBloFL6noMTtI15hz0RA6EqW0Zl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=MA8InosA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YT3wcUra; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 7DEC32CC00F7;
	Sat,  8 Jun 2024 17:16:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 08 Jun 2024 17:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881399; x=
	1717888599; bh=P8U/vSNSp1TElUyC4OwmdinUUv2kbxRZJWBSbm83Cm8=; b=M
	A8InosAirC+uQq+1V/SjcpCYNW2Q5QgoI+gdHVzV6+Pf/sZqHnVYdHIBZJIQMHNf
	ph3nwtDM6UObzd/Ly55JpKOrtUzW8aqlWnN1u/AXvbH5FIrAlv/4h0wDa2io1dpF
	1gPNDfS0Wa6IaZQ4dDqvBrvhMUm6M+msKTuVUnyTbxv0RBFbFQVM/6JT3YlQL0eq
	XzJc1cYQVboT2IKEHxOrgYKcIeqqwlaWoiXmZvtyr9M9xl3jc9rnVkxMtSZo9OX0
	pLGBuzj4jflacPLKupbA9yoXweMrn83Ee+rR6WSVxDmmy08oHJowCkBffOFz+m4u
	vLWQBDdVl4+RognTfekAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881399; x=
	1717888599; bh=P8U/vSNSp1TElUyC4OwmdinUUv2kbxRZJWBSbm83Cm8=; b=Y
	T3wcUraR3ApdjVU7w14phOMIBw/pvQNN5FJiKM9RqB/gq6BKq24qHDrtylY24Wyc
	Ahzw6dPr+zEBFhkfY0AbFD0I/f9ZxNEM/yDDuhHwG9ny7dMCTQdODFlcmpH9ZqND
	vAsMtAPFXBzdwYFR0fX3ghjlGBddLq32bz49/rQpjnhCXyqR7Su5+f3l41ff3Yrn
	eyKEGnrxaoC6zknUfOqWQVD6MPNgp8vRU1AT4Uxfn60bpnJieEGROwZQJHRvhJch
	5yafa9+zeEz/fkV1rLWus3PfnYXKNpDScioFu631NNov6ZXJEN05z/e5eaaw2eh/
	VLyEuAnzLAKmLQO04lzHw==
X-ME-Sender: <xms:NspkZlqQYhq9py0T9oNI3SonrpdD1mI7DhiyagjAt1NurB00r0yVHg>
    <xme:NspkZnpuljASwsYfQj5vv5oNeR8cXccONhFAvQ5ZrGp1L6je6v1DU5nZWEInRCQ52
    hWlSfkBJf0vxoGq-w>
X-ME-Received: <xmr:NspkZiP-JnO9GxYC0BIFnOavy5n9IX64VJWH0qXq-uYSNOahc--oOqHypsdjnOOHoII38DvUoYrIGpFHnTKah4xHA9IM3eCtBM3cDrkm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:NspkZg4TFfdl9Jyx98jyCQyzk3JLaLxPHwRYM2qLLm-RFreMNSryRg>
    <xmx:NspkZk51QxS2EbAIuHZ5nh1S3lenZwh_0kpMkxV9DYWC3HHUhq-cLQ>
    <xmx:NspkZoii64SWkoE6uoDFCIp7YBjkbm99idHtnK56es_7fPz5aPxUCg>
    <xmx:NspkZm71V4Q2BFZ65ECR8SyP5EwbXIylelTiYCbJMyOMpiR1iSQdcg>
    <xmx:N8pkZqvZIutpkSvDwFMb1grYeVQkoFGBj-HtOq7tde_iYe3NW9-O5fw6>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:37 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 05/12] bpf: selftests: Fix bpf_map_sum_elem_count() kfunc prototype
Date: Sat,  8 Jun 2024 15:16:01 -0600
Message-ID: <1ade365ced7051f2e18803d182ebe14c61b18309.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prototype in progs/map_percpu_stats.c is not in line with how the
actual kfuncs are defined in kernel/bpf/map_iter.c. This causes
compilation errors when kfunc prototypes are generated from BTF.

Fix by aligning with actual kfunc definitions.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/map_percpu_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/map_percpu_stats.c b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
index 10b2325c1720..63245785eb69 100644
--- a/tools/testing/selftests/bpf/progs/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/progs/map_percpu_stats.c
@@ -7,7 +7,7 @@
 
 __u32 target_id;
 
-__s64 bpf_map_sum_elem_count(struct bpf_map *map) __ksym;
+__s64 bpf_map_sum_elem_count(const struct bpf_map *map) __ksym;
 
 SEC("iter/bpf_map")
 int dump_bpf_map(struct bpf_iter__bpf_map *ctx)
-- 
2.44.0


