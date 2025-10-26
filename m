Return-Path: <linux-kselftest+bounces-44072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A93C0ADD6
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D51A24E939A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EFC2EC563;
	Sun, 26 Oct 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXjuy59a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C32D2E8E00
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Oct 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496739; cv=none; b=hNNMuXVIhoNh2FZWMG8pn4QyW26ocXKhP+pHWVdSlRIHfD6x689jpjZxr1FJGRnBc8neVZN3YY4uFZQzZCJB8a2908KNmqP25oRiO5VsU54NaNU/cJLKsJUWUUwft+kqT7ZJ4uGAdGLyXg+RzZUdRz98eRmaAPeOz0jSIX1a/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496739; c=relaxed/simple;
	bh=HYd2qH7FWSYKEo+EVxagg1RUtl38TekujFQnRYEMBtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQsSOe3FtuynKvXBrJN7IrN7F7qS3AqKUWbPzxz4AmWV8DDgmY9Oehpa7EaTIlRQsJOMaHGrDlkqQEOiYrYtX29eK4zTmiKsLc+kqyS1Whq6H+RPsWjyM1akfbChfAgJMUhYPJ2hfe45CZ9mqBc7jHtUHVPKoQoV59Fa1HOOmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXjuy59a; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761496735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBxBqu3N+DlOX27bsFsVYIxqbBpbd6ybHXvJvZNNT5E=;
	b=SXjuy59ahh3w+VrMyR309CrXCHXNiM3FjCgKOoHtccqeUsyUNSVP/uT5On83uo6AiMA5++
	Chuvw2x21hwyatCb+D/eupYeDviCex0uhCsr++UJ0485Fh4cQ/QeXgkVkCB/V5yV+kBqFJ
	ioFECGwK6xo7KQnFQR5qdvkq3YV7vYE=
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
	memxor@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	shung-hsi.yu@suse.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Range analysis test case for JEQ
Date: Mon, 27 Oct 2025 00:38:06 +0800
Message-ID: <20251026163806.3300636-3-kafai.wan@linux.dev>
In-Reply-To: <20251026163806.3300636-1-kafai.wan@linux.dev>
References: <20251026163806.3300636-1-kafai.wan@linux.dev>
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


