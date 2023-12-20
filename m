Return-Path: <linux-kselftest+bounces-2292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AE81A888
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DE4B21C07
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 21:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0011B4E1B3;
	Wed, 20 Dec 2023 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjcFwrmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B74E1C9;
	Wed, 20 Dec 2023 21:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so151685a12.2;
        Wed, 20 Dec 2023 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703108458; x=1703713258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sM0p3ninJhZQiLF62VH9FTNW7PXmPuY4hvKlJNu1iqU=;
        b=KjcFwrmp86WX6o44vS0GQAx/GDDp9lrqEMTBqEKDU5GOaCOsmhfdeIanIvXM9GYCj1
         6UTLQ1311oz2L8a7roNcmZlKNvgqZx2tm2bj83DA1I7z6HU95hjW7juDa0Ma9D5688c3
         f/s5uRHgs+fl6l0X5bAx/U2RHJL/J7FG7aEmS3XZRH22cLEKOmf28wtXjUELgZ5DJ0Qd
         TcnqoJ1jvxcgZhqWBMFfukEORVVqbbboqIEtexho7MBxxFibmxt6QaY2K+YrTjO5KkCR
         LDV5J0KDPRxdIM/sE4oUnPPh7Hqu6SisPkjd5y2r9/QKCi/gnvWJfqFJ767Hme+X0/XX
         WqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703108458; x=1703713258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sM0p3ninJhZQiLF62VH9FTNW7PXmPuY4hvKlJNu1iqU=;
        b=Mr5MieawDdZarOZ/DxqCxgNf+zIfpDAZ+stH1aqSGAvCoa//HIwJ+bhntKCz/f9hwb
         J78EhECbB23OEELMexHHNLZFDMsqv9wwKYXecA6rNcRisKoDcbSU4w+ybAu7Zr9nCrF4
         Ww8twUNMAKWBwK5TtmzHadF4ljj1sb8xKWqgXKVwuM+YAKYq38Sj7WFuR3FxHcy4NwVZ
         ehFqYFgDqIJIJqj/kldic+hIVTeoJR8p2SsSeq7/Rql7jmXWR8DMfdCzHp5Lstu62M4N
         2Lewe5/hAg0lYMkUUQ9PuOzQmjc9BhZa7kdZAb6htuOeKBgrG5YNyTLHJcHpDZb8qNLS
         mcXQ==
X-Gm-Message-State: AOJu0YypHLGLKeIYKE66zJNJQ8Tvz/0Doq/j7QRq/nMNq27Se6yobAX4
	PFmidLPb3jTOxi537Thn3kM=
X-Google-Smtp-Source: AGHT+IFd32rNhmpTGzbU1vvGYZUPxN3dRbJ5LmyJ8+p+vL0K7Mz7xBWDJx/SRNoyliwvX/g8IxI9cw==
X-Received: by 2002:a50:aa9a:0:b0:553:6abe:203 with SMTP id q26-20020a50aa9a000000b005536abe0203mr1870457edc.14.1703108458413;
        Wed, 20 Dec 2023 13:40:58 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id p20-20020aa7cc94000000b00553b746e17esm291312edt.83.2023.12.20.13.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 13:40:58 -0800 (PST)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
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
Subject: [PATCH bpf-next 15/15] selftests/bpf: states pruning checks for scalar vs STACK_{MISC,ZERO}
Date: Wed, 20 Dec 2023 23:40:13 +0200
Message-ID: <20231220214013.3327288-16-maxtram95@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231220214013.3327288-1-maxtram95@gmail.com>
References: <20231220214013.3327288-1-maxtram95@gmail.com>
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
index df195cf5c77b..e2acc4fc3d10 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1046,4 +1046,196 @@ l0_%=:	r1 >>= 32;					\
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
2.42.1


