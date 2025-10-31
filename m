Return-Path: <linux-kselftest+bounces-44527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1DDC25E2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D89A4E7738
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB22E62C0;
	Fri, 31 Oct 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cuMvyJcu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618F2E0400;
	Fri, 31 Oct 2025 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925462; cv=none; b=RjjTum04gbq9XOSFNhghZER3qysKglUYB2HSOCjqDSuWfRRpisK+kXGeMdDyXBs/UAHeH9E81FlCnNIaRLZccur/eEMgn0KkBGln5vmAynr0t30MQJLRAQf6EYsrgtO6NPikfhLxUnH7kCgFViKO5oSkaEmgv9CbisJVwo7PiiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925462; c=relaxed/simple;
	bh=kbe8hMT2OvfiqAmCP4GWUa8XfLFY+MoXA/QxrTvkDww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5RCmf8DNpp/A4fRDCbF4pk4iP3vv9e1XxcyBwvWs+I70Y0dvku2E5HQ2FDxcmW8+9bCnXxUhP5FIcmVUqe6KCdy+aijMJeI3W94+OkpQ+EKxKnjv89VpIMwM3oMxt7nf+Zs8mNtlK4g513ssJiLfd0sDYZYqtkkcbTVygLnPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cuMvyJcu; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761925457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Co4HTS5uOZjTPA1XBfD/RtU0DY8DXK6Y5uls97p0Vw=;
	b=cuMvyJcu4+I98YZ39u4pyAHTE3nLelMYnLssuGaiI+KdXbLwBI8dVPZV12yVJpmuty/vNP
	OPpWxh6Zi6SorujhiEQLw50ZUcsOnXVS0LGmg+crTLBsuZr+wuDTmSUts0oePm2lGmUd/+
	ErvPSV4Ks0t/nrxSbWS8gQXVNDT0Dp8=
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
	henriette.herzog@rub.de,
	kafai.wan@linux.dev,
	luis.gerhorst@fau.de,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add test for conditional jumps on same scalar register
Date: Fri, 31 Oct 2025 23:41:07 +0800
Message-ID: <20251031154107.403054-3-kafai.wan@linux.dev>
In-Reply-To: <20251031154107.403054-1-kafai.wan@linux.dev>
References: <20251031154107.403054-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test cases to verify the correctness of the BPF verifier's branch analysis
when conditional jumps are performed on the same scalar register. And make sure
that JGT does not trigger verifier BUG.

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..e975dc285db6 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1709,4 +1709,158 @@ __naked void jeq_disagreeing_tnums(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("conditional jump on same register, branch taken")
+__not_msg("20: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void condition_jump_on_same_register(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w8 = 0x80000000;		\
+	r0 &= r8;			\
+	if r0 == r0 goto +1;		\
+	goto l1_%=;			\
+	if r0 >= r0 goto +1;		\
+	goto l1_%=;			\
+	if r0 s>= r0 goto +1;		\
+	goto l1_%=;			\
+	if r0 <= r0 goto +1;		\
+	goto l1_%=;			\
+	if r0 s<= r0 goto +1;		\
+	goto l1_%=;			\
+	if r0 != r0 goto l1_%=;		\
+	if r0 >  r0 goto l1_%=;		\
+	if r0 s> r0 goto l1_%=;		\
+	if r0 <  r0 goto l1_%=;		\
+	if r0 s< r0 goto l1_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("jset on same register, constant value branch taken")
+__not_msg("7: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_on_same_register_1(void *ctx)
+{
+	asm volatile("			\
+	r0 = 0;				\
+	if r0 & r0 goto l1_%=;		\
+	r0 = 1;				\
+	if r0 & r0 goto +1;		\
+	goto l1_%=;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("jset on same register, scalar value branch taken")
+__not_msg("12: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_on_same_register_2(void *ctx)
+{
+	asm volatile("			\
+	/* range [1;2] */		\
+	call %[bpf_get_prandom_u32];	\
+	r0 &= 0x1;			\
+	r0 += 1;			\
+	if r0 & r0 goto +1;		\
+	goto l1_%=;			\
+	/* range [-2;-1] */		\
+	call %[bpf_get_prandom_u32];	\
+	r0 &= 0x1;			\
+	r0 -= 2;			\
+	if r0 & r0 goto +1;		\
+	goto l1_%=;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("jset on same register, scalar value unknown branch 1")
+__msg("3: (b7) r0 = 0 {{.*}} R0=0")
+__msg("5: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_on_same_register_3(void *ctx)
+{
+	asm volatile("			\
+	/* range [0;1] */		\
+	call %[bpf_get_prandom_u32];	\
+	r0 &= 0x1;			\
+	if r0 & r0 goto l1_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("jset on same register, scalar value unknown branch 2")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
+__msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_on_same_register_4(void *ctx)
+{
+	asm volatile("			\
+	/* range [-1;0] */		\
+	call %[bpf_get_prandom_u32];	\
+	r0 &= 0x1;			\
+	r0 -= 1;			\
+	if r0 & r0 goto l1_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("jset on same register, scalar value unknown branch 3")
+__msg("4: (b7) r0 = 0 {{.*}} R0=0")
+__msg("6: (b7) r0 = 1 {{.*}} R0=1")
+__success __log_level(2)
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void jset_on_same_register_5(void *ctx)
+{
+	asm volatile("			\
+	/* range [-1;-1] */		\
+	call %[bpf_get_prandom_u32];	\
+	r0 &= 0x2;			\
+	r0 -= 1;			\
+	if r0 & r0 goto l1_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+l1_%=:	r0 = 1;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


