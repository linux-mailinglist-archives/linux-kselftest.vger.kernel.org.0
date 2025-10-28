Return-Path: <linux-kselftest+bounces-44189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E1C1566C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA6E1885A27
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466A533FE26;
	Tue, 28 Oct 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVlRfk5d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F2633FE10;
	Tue, 28 Oct 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664832; cv=none; b=vFE+1MiW3gA7X7hkEg0qsLZ7eHgX3Ie0GR4N1bH6KWG6Mwc5Cv85x5YioDLEYDFXxk/VC+GUs6n3DRecmETL4N35IUcxrL//qWMcAxtpe76MZKCZuyfxiIkraX5Y8AZXhO6m+XMpz0flIni0tJV10XAJtMu+GBSyA1Oc93C8/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664832; c=relaxed/simple;
	bh=HYd2qH7FWSYKEo+EVxagg1RUtl38TekujFQnRYEMBtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS6M6HfgWajnhYo9/6l7Scv9D2+TXciaUsw/0ok2o96XUEWY8jKv1m+9BpQag4gPElyrGeJ/BuNxrlG2fdg+766/MKy+LDuyKHXqYIsvQ5ZUd5pD2VMuLCFnJe8+22MRXkn13yuCMAVI5tZx24In61PbUwRRCIGRlK6U1NwnaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVlRfk5d; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761664829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBxBqu3N+DlOX27bsFsVYIxqbBpbd6ybHXvJvZNNT5E=;
	b=ZVlRfk5d74WPMBIH8ldQdIY8hxKmUlxbUA639saRb9HsLjkj5W/H2wzvsovLXZCn2jeoqc
	2zFv0ACVKfYwSjpC2wv/xLwWOjqMhs9Yb+JaoKBuVsO9prkrAKL1KaUzgOeV04DmdE1z4t
	ZXcDrxnAeNJOCUSTmGWi/q7BAZnlG8s=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	kafai.wan@linux.dev,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Range analysis test case for JEQ
Date: Tue, 28 Oct 2025 23:19:38 +0800
Message-ID: <20251028151938.3872003-3-kafai.wan@linux.dev>
In-Reply-To: <20251028151938.3872003-1-kafai.wan@linux.dev>
References: <20251028151938.3872003-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds coverage for the warning detected by syzkaller and fixed
in the previous patch. Without the previous patch, this test fails with:

  verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds
  violation u64=[0xffffffffffffff01, 0xffffffffffffff00]
  s64=[0xffffffffffffff01, 0xffffffffffffff00]
  u32=[0xffffff01, 0xffffff00] s32=[0xffffff00, 0xffffff00]
  var_off=(0xffffffffffffff00, 0x0)
  verifier bug: REG INVARIANTS VIOLATION (true_reg2): range bounds
  violation u64=[0xffffffffffffff01, 0xffffffffffffff00]
  s64=[0xffffffffffffff01, 0xffffffffffffff00]
  u32=[0xffffff01, 0xffffff00] s32=[0xffffff01, 0xffffff00]
  var_off=(0xffffffffffffff00, 0x0)

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..304ab5a07a3b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1550,6 +1550,29 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("dead branch on jeq, does not result in invariants violation error")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jeq_range_analysis(void)
+{
+	asm volatile ("			\
+	call %[bpf_get_prandom_u32];	\
+	r6 = r0;			\
+	r6 &= 0xFFFFFFFFFFFFFFF0;	\
+	r7 = r0;			\
+	r7 &= 0x07;			\
+	r7 -= 0xFF;			\
+	if r6 == r7 goto l1_%=;		\
+l0_%=:  r0 = 0;				\
+	exit;				\
+l1_%=:  r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
  * overlap on the negative side. At instruction 7, the ranges look as follows:
  *
-- 
2.43.0


