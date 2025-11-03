Return-Path: <linux-kselftest+bounces-44633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC47C2A31F
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 07:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9E188DC14
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 06:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCC0296BC3;
	Mon,  3 Nov 2025 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BFOkXztw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110CE296BB9
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151557; cv=none; b=kqZN+BHD0OsIxhrVhkTK5yyx5NOW1VbWrc5M4LbTUa1TELUaKpOFiPMHqBXB0qyVSAtLDqI/ic642+yv5IKWbuKzdzkgBrbT9ql3C9y/92y73hDBb5Q91dOG/l7PXxCjrsw61ZMjxjxARGhkwGQ8998RxCuS41gljB/K4eqTJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151557; c=relaxed/simple;
	bh=kbe8hMT2OvfiqAmCP4GWUa8XfLFY+MoXA/QxrTvkDww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljxSVUXFa2R3G41HO0r5WUI9OVFuLlrTrDD/QGUpGe3FUJKShBxdQmUVEm6XfPZ4lvjW9u1VH7KISOgJ7xvtLDNRy2kDV7iR37RWxR6uf0OwufdhSio2BWRSxkNTOXmRkIEwDx8QKHyJPMvzIs7oNJWB+dNZEYsLhsD4UtN68Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFOkXztw; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762151553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Co4HTS5uOZjTPA1XBfD/RtU0DY8DXK6Y5uls97p0Vw=;
	b=BFOkXztwNIL5K8mOH+vAFRaD0ZZkLd1UA9FuPUUuW5dS0hRu5IsyrUUg3PqdK/0YoXhElP
	cLXB95uuCrazQ9v7FRnqwBUjKZn9g75ncFFabEM/tm/9czjc/T0aXhGdEuf5FFS8OLw7we
	QpsPF7CfUSYZPdMFHwEmLkUDuKJF8Ec=
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add test for conditional jumps on same scalar register
Date: Mon,  3 Nov 2025 14:31:08 +0800
Message-ID: <20251103063108.1111764-3-kafai.wan@linux.dev>
In-Reply-To: <20251103063108.1111764-1-kafai.wan@linux.dev>
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
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


