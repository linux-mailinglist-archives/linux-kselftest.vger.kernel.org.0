Return-Path: <linux-kselftest+bounces-30396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05983A81B8F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94347B623E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40871DE3A8;
	Wed,  9 Apr 2025 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hjbq9Vmy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uO5KWbPm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBA1DDA1B;
	Wed,  9 Apr 2025 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169694; cv=none; b=TaRWuWUVupZDNIDS3XlAvRjhLYV/uRwxEo2e5uOBoQEgBmVxrx9LDLlUe4TsGnYvrsO+RGGB3o6inWe1T45zur78b04biBVZ/0C5C+gOp8mlBzpZxwJ0VkHU6Hj5J1Mo3LNiGtpuxzMYXYxITqOpZaldo/NmGhc5MsBoYsHiuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169694; c=relaxed/simple;
	bh=0QQJ3jdXg0Dk0Z/fgQp/zkhhtH8UYn+dBEX6hE0vJFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEXtK32jS0wYwNHLnM0DHjQQIR9AKtTi28aQRaisVo2Gyv/ignsNzWh1bznMOBfx0v3ID9FwLWsf1DuL5HIPIpoMK2ZfJ/15+vznht6mmjqMubWLAgUAY/HyDgCOuAeXCzqDIsGOJRTfFvKr3PP82eYLWlWTeKkTDQIuqccAiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hjbq9Vmy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uO5KWbPm; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 132581140252;
	Tue,  8 Apr 2025 23:34:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 23:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1744169692; x=
	1744256092; bh=47R6IUBo2KJ2pOAYSTre05QTjaX02+1h8+rPzsl3QyQ=; b=h
	jbq9VmyKBPbB7P1UcvIddgNuCrEAl0yk+FYXMRvKGOzPgKbQBKiegrWaiFoWLTRe
	xOmTxXvlkJUUxgFo9z/EdAGV3ROna0xYtjy61BgflqhxI1qMFz/nPTR+JYRbeMqv
	lW8RcWi5PIEwxhDRMmMj/NE3Swm089akm/iOKuoPTKq/MRbnP8cfmrvcVKIhVFvF
	Nhx2msSVFXJa4CiGaU+OH6uLUMC81jjjq9j0kpCL2QAfpSOhkq78/4drfeNYu5fs
	6mwMJxwVZJmIQwDZbr4dAVVKhs6NN5jmt8BeGns0+EDwmCpKrVfeKqg00QdaXU+Q
	FR7UjfGovzyCWwhMez4sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744169692; x=1744256092; bh=4
	7R6IUBo2KJ2pOAYSTre05QTjaX02+1h8+rPzsl3QyQ=; b=uO5KWbPm+dbDlzLXe
	0N/ezbfGnej+xcG9aefx0Nq5SldK+zZlNGSq1FiL7MrcU5Nl8oLzdWuWGFx/a5lF
	6ghzCL9MLsmKQDKTs5q8Ni6hQ+JvBfz/qEQQj8WRC8UHDtXC+f0P58zbYFLNF4QQ
	peS+y6gt9SEySSj4Odh4ICRyn/s+HQ/471gfGZQXJR4sKgjjrQG3A0b0qs2k8pY7
	segKzEFXLaRLaEcApu8EBg9K7HWqp8P5wBkgdXuqLFXJdHKRNnj0hEclSTOKH/Os
	umDtqar5Tp3iRXf0BMw/qxhirnqxazI3AN+jJlSCI/d36lXaDttP59SbXzPzA0Z+
	XWTgA==
X-ME-Sender: <xms:2-r1Z1YK1qktgqXVZUvA0dYmQJ6eFuRzfPKwToWIZLA-5bquddJxig>
    <xme:2-r1Z8bGqQBEIy7-okWlNRiZ4VI1kW2YRogrXCbhv1bPDg5kciMnxXMXCpLCGi9L-
    AF7a-g05jQsPeeh4Q>
X-ME-Received: <xmr:2-r1Z3_ex7p405OYVqdW2_tcCTFptAhxp0OZn0ziGlg6UTntVs9YcEr2ZD5IBrQu5Hw-55KW6P7YKHzhzCSrlgRFoyO5ragF1JqESQFArsgjGjXYo9_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dljedtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhm
    peffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvg
    hrnhepgfefgfegjefhudeikedvueetffelieefuedvhfehjeeljeejkefgffeghfdttdet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
    esugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggr
    rhgsohigrdhnvghtpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdr
    lhgruheslhhinhhugidruggvvhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgt
    phhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2-r1ZzpC95ytBwsnbCngtdSIqzM-cUiLkFMvceay5Kz6u3lNC0s9jg>
    <xmx:2-r1ZwoTg5AkEA2XBgyfw49293TE__TM5IY-wfD5gsnqeAZHCYrvbg>
    <xmx:2-r1Z5SzCAXhvZtzXGQnJYiH8ljOX6G89jDwpJc-pODYYkDm3FJcZQ>
    <xmx:2-r1Z4r_GE0WNB3-u-IrlIrqktYjKfDkbHR-_ocEtphO4UiX33r82A>
    <xmx:3Or1ZyzTLjJEiKwvm9SIBPWdEXgJJylEQfySyFSuku9lKHG7zAqS42cZ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 23:34:50 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	eddyz87@gmail.com
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
Subject: [RFC bpf-next 08/13] selftests: bpf: Avoid attaching to bpf_check()
Date: Tue,  8 Apr 2025 21:34:03 -0600
Message-ID: <25a4bb8f1168b955b949c703e8cb671eea2eb92e.1744169424.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1744169424.git.dxu@dxuuu.xyz>
References: <cover.1744169424.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_check(), as it currently exists, will soon be going away to make way
for loadable BPF verifier support. Fixup selftests so they fentry attach
to a more reliable location.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/exceptions_assert.c | 2 +-
 tools/testing/selftests/bpf/progs/exceptions_fail.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/tools/testing/selftests/bpf/progs/exceptions_assert.c
index 5e0a1ca96d4e..50bc52cbb2e7 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
@@ -124,7 +124,7 @@ int check_assert_generic(struct __sk_buff *ctx)
 	return data[128];
 }
 
-SEC("?fentry/bpf_check")
+SEC("?fentry/bpf_fentry_test1")
 __failure __msg("At program exit the register R1 has smin=64 smax=64")
 int check_assert_with_return(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 8a0fdff89927..b44cb0a6c9d9 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -299,7 +299,7 @@ __noinline int exception_cb_bad_ret(u64 c)
 	return c;
 }
 
-SEC("?fentry/bpf_check")
+SEC("?fentry/bpf_fentry_test1")
 __exception_cb(exception_cb_bad_ret)
 __failure __msg("At program exit the register R0 has unknown scalar value should")
 int reject_set_exception_cb_bad_ret1(void *ctx)
@@ -307,7 +307,7 @@ int reject_set_exception_cb_bad_ret1(void *ctx)
 	return 0;
 }
 
-SEC("?fentry/bpf_check")
+SEC("?fentry/bpf_fentry_test1")
 __failure __msg("At program exit the register R1 has smin=64 smax=64 should")
 int reject_set_exception_cb_bad_ret2(void *ctx)
 {
-- 
2.47.1


