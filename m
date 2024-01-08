Return-Path: <linux-kselftest+bounces-2738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5638279AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441A31C22BC3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D8A56463;
	Mon,  8 Jan 2024 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nky5uTea"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2855E51;
	Mon,  8 Jan 2024 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-555144cd330so2767010a12.2;
        Mon, 08 Jan 2024 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704747222; x=1705352022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9DLq0TfwWAUMCpLHR20MyJFlzT+sTpZ6i+Jf0NPu6s=;
        b=Nky5uTeapyrVhcyd9lMbwTt32+PcLyKBrRfZFfMKmxh9qFjF57rgbFVz9XbSRw1q/2
         oip1fk+7WW3XTirSJeSEiLrEnV0h/cZSJgmdtLgVJMz7Lwcz/K5CsJuI0E51Xi6uJs5Y
         K7t0vzGqu6WrbDbpk+2M8EOjp4M3fjYXwodOgOKkXfl4CX3tpKMEiCxU8ars1xZQw0BY
         al9mpBa9rlnhpjtCVf0vD/BjCC/OhR3b8joRtrzHkXQBxC1IezUGZgm4Sp4XYaB5Am/R
         pGXmaiITuUSwRHyY4SDPxN9dnvxojOrQuPtGAxp+hJVJHBLxYatyBKOPXsOGYZyL3NB+
         qXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704747222; x=1705352022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9DLq0TfwWAUMCpLHR20MyJFlzT+sTpZ6i+Jf0NPu6s=;
        b=PUDGmdM/5WfdPP2XDPEGMVXa+wVd0AUJ1g6k5dX2x+pXsffDv663BaYanDeaXshDrR
         RTIsJ0IGFpt1kOrhj2UmsvId7iW0iLpIlJpfEevNYyk7HsxRSKSk3+iqdBThN5HTZREJ
         uAbzOUmILZG2O/7BefAWntp4fdG2HKgd/SAhrL9rtk6EwSPjmTMyi0xAXuCe95eOkI7V
         89uF4MwrA0Bp0d9aGuXTQVfu49uVxY9WZchgqF2DvuCuaxJ4NJzQStGGN08eWBnolYnj
         uSqHqLSE6AgH9biIeqg7aBM1hjpo2uLbZ/IY2kti/N2W7DEzdIMTCx3q38c64QggDVyf
         lPSw==
X-Gm-Message-State: AOJu0Yy/fj5+EzXlhzMw45ua6jUCp89hfrXIZhi0Sy2b7WcBAlczD4x7
	WBM2SSXThfSC0Atlf813/hU=
X-Google-Smtp-Source: AGHT+IHQ6/x0HVJ35HtD6Bjguw9MNx1mMJnNOgHd39sQ8neRKxkGKl8TzgyNleGUq342qGc3ggzm1g==
X-Received: by 2002:aa7:d6da:0:b0:556:a28e:7cc1 with SMTP id x26-20020aa7d6da000000b00556a28e7cc1mr2212161edr.81.1704747221648;
        Mon, 08 Jan 2024 12:53:41 -0800 (PST)
Received: from localhost ([185.220.101.80])
        by smtp.gmail.com with ESMTPSA id fi23-20020a056402551700b005579dbd7c4csm203899edb.35.2024.01.08.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 12:53:41 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 15/15] selftests/bpf: states pruning checks for scalar vs STACK_{MISC,ZERO}
Date: Mon,  8 Jan 2024 22:52:09 +0200
Message-ID: <20240108205209.838365-16-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108205209.838365-1-maxtram95@gmail.com>
References: <20240108205209.838365-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

Check that stacksafe() considers the following old vs cur stack spill
state combinations equivalent:
- spill of unbound scalar vs combination of STACK_{MISC,ZERO,INVALID}
- STACK_MISC vs spill of unbound scalar
- spill of scalar 0 vs STACK_ZERO
- STACK_ZERO vs spill of scalar 0

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 192 ++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 3764111d190d..3cd3fe30357f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1044,4 +1044,196 @@ l0_%=:	r1 >>= 32;					\
 	: __clobber_all);
 }
 
+/* stacksafe(): check if spill of unbound scalar in old state is
+ * considered equivalent to any state of the spill in the current state.
+ *
+ * On the first verification path an unbound scalar is written for
+ * fp-8 and later marked precise.
+ * On the second verification path a mix of STACK_MISC/ZERO/INVALID is
+ * written to fp-8. These should be considered equivalent.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("10: (79) r0 = *(u64 *)(r10 -8)")
+__msg("10: safe")
+__msg("processed 16 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_unbound_scalar_vs_cur_anything(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* get a random value for storing at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"if r7 == 0 goto 1f;"
+	/* unbound scalar written to fp-8 */
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* mark fp-8 as mix of STACK_MISC/ZERO/INVALID */
+	"r1 = 0;"
+	"*(u8*)(r10 - 8) = r0;"
+	"*(u8*)(r10 - 7) = r1;"
+	/* fp-2..fp-6 remain STACK_INVALID */
+	"*(u8*)(r10 - 1) = r0;"
+"2:"
+	/* read fp-8 and force it precise, should be considered safe
+	 * on second visit
+	 */
+	"r0 = *(u64*)(r10 - 8);"
+	"r0 &= 0xff;"
+	"r1 = r10;"
+	"r1 += r0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check if STACK_MISC in old state is considered
+ * equivalent to stack spill of unbound scalar in cur state.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("8: (79) r0 = *(u64 *)(r10 -8)         ; R0_w=scalar(id=1) R10=fp0 fp-8=scalar(id=1)")
+__msg("8: safe")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_unbound_scalar_vs_cur_stack_misc(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure unbound scalar at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"*(u32*)(r10 - 4) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r0 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check if stack spill of unbound scalar in old state is
+ * considered equivalent to STACK_MISC in cur state.
+ */
+SEC("socket")
+__success  __log_level(2)
+__msg("8: (79) r0 = *(u64 *)(r10 -8)         ; R0_w=scalar() R10=fp0 fp-8=mmmmmmmm")
+__msg("8: safe")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_stack_misc_vs_cur_unbound_scalar(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"*(u32*)(r10 - 4) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure unbound scalar at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r0 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): check if spill of register with value 0 in old state
+ * is considered equivalent to STACK_ZERO.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("9: (79) r0 = *(u64 *)(r10 -8)")
+__msg("9: safe")
+__msg("processed 15 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_spill_zero_vs_stack_zero(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"r7 = r0;"
+	/* get a random value for storing at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"if r7 == 0 goto 1f;"
+	/* conjure spilled register with value 0 at fp-8 */
+	"*(u64*)(r10 - 8) = r0;"
+	"if r0 != 0 goto 3f;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_ZERO at fp-8 */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+"2:"
+	/* read fp-8 and force it precise, should be considered safe
+	 * on second visit
+	 */
+	"r0 = *(u64*)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += r0;"
+"3:"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* stacksafe(): similar to old_spill_zero_vs_stack_zero() but the
+ * other way around: check if STACK_ZERO is considered equivalent to
+ * spill of register with value 0.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("8: (79) r0 = *(u64 *)(r10 -8)")
+__msg("8: safe")
+__msg("processed 14 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_stack_zero_vs_spill_zero(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure STACK_ZERO at fp-8 */
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"goto 2f;"
+"1:"
+	/* conjure spilled register with value 0 at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u64*)(r10 - 8) = r0;"
+	"if r0 != 0 goto 3f;"
+"2:"
+	/* read fp-8 and force it precise, should be considered safe
+	 * on second visit
+	 */
+	"r0 = *(u64*)(r10 - 8);"
+	"r1 = r10;"
+	"r1 += r0;"
+"3:"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


