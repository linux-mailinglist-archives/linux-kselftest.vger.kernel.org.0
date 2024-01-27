Return-Path: <linux-kselftest+bounces-3666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D6E83EF3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366231C2167E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78272D05E;
	Sat, 27 Jan 2024 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyScnCXP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080532D600;
	Sat, 27 Jan 2024 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706377985; cv=none; b=JdmgiqD+nDSUCPURHcrTkzQYV3I7zvKrV1+HLtUVTDOL1uvdpV0T7zuCzYMJ1UuJqhyUwUUAGlZmffFRfsySg4yTJ55MLMyI3BcjLt2zwh/ITDVrcmnrMdVhuuPx677QhPoXbXr5cU3jyX7/1qP59QhcU9BTCajnuSyuRNY0hYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706377985; c=relaxed/simple;
	bh=tCrlPxhS+T295vFqO3J48QdUkPVcQ+VfKAzqeN3uN0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2eG6emKyt0VMNIzC/HsUyZWx6kOPgB2gLBny5HRwwGwlxOqWalRx4f5yFQ1ywFRHnZF08XQbbKaLZVMFP56kCj3MHbmtoyWcjzoq+vNEt4UGf6FMYPKlMDWkMZFzKJoB/HRSoBdaOlUiTU/NxK+VfQJYFqfMWcBNDX2yG3okQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyScnCXP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so971224a12.2;
        Sat, 27 Jan 2024 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706377982; x=1706982782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjKlkVBdyalMJl+fAj4IHpaZGfCfC+zDeIDRIDfHkAM=;
        b=EyScnCXPOYvgwoHuiCPKp+11uUJUIAMtC910rs+BeaZmi0PVXSk+EUe/Z0n0Fl403p
         ethgNMh5Lg4aPwsEDV6AzMVji2lYD4Z17LMjc4QIW41tmucdh5dCghQuxoQMoTwrKjy9
         bBdLa/Y4Y/4NynP6sHmKp77brzbp457YHz3Wvia/Y3ZpJMSonYbXRogbMQ+V2J17Qhav
         T2z7dwY6yIYt7VFlqeJGz5Jz5EVBMlcCV1blyaZBSt67vlcMgn0Nke/KThF7GAotgrW0
         SUR0b9TPkbaaSg7IfYbiU8BcW/xyaGMd8Yn4UBd7AWG/9E+hfGZZKB0GWKsp94VoJRPV
         cc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706377982; x=1706982782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjKlkVBdyalMJl+fAj4IHpaZGfCfC+zDeIDRIDfHkAM=;
        b=ZFeVDXM+bn3K/FIOjbLy4T3q760lb5MQwwL12dVY+h2gUjaOob7cRTvqlm/EHhKnpW
         zJPawMvCypIw3cIzl9EnO7CzU0ia7dz3uTjXjIKzmNZyfpI4tzcY5zgn/9h9EXecpzd2
         Snw7GxDJaGT3Ag2i2lFPzzf7V55ukBnQivRICJCIKduwc1rzaBNyv4j/I9cWA+1vFgpu
         itCm4LJaVHopl31ituCCBIe4JsvTkhW0YO/dj/E9oEZ7o1f2DvukYa465wiVY72ShNnh
         j2Vhgf2P12Nzbj7OPtGYOCCtIxfIQOvjfB46Y6Fwbi3MC+SNoU3td8pBKchh5byDyBOf
         V3uw==
X-Gm-Message-State: AOJu0Yy5/s7Dd81Ix6ShdO56+RQB/TePpv8BFBNWfkjtgTC2L8W+TN4H
	h5L1+TB9yfdmf9+1r5VESFOUKOC3ILtcfQwdB1FgQ20hMi7ATxpi
X-Google-Smtp-Source: AGHT+IGaxqP7sp/rWBwKiujJl8zWECq4wDfkan4iJ1aJVv0+iMoH6HIMjU2DFggA86BuvNzLipV7KQ==
X-Received: by 2002:a05:6402:b2a:b0:55d:151:ebf2 with SMTP id bo10-20020a0564020b2a00b0055d0151ebf2mr979224edb.20.1706377982068;
        Sat, 27 Jan 2024 09:53:02 -0800 (PST)
Received: from localhost ([185.220.101.170])
        by smtp.gmail.com with ESMTPSA id e10-20020a50ec8a000000b0055c643f4f8asm1852147edr.32.2024.01.27.09.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 09:53:01 -0800 (PST)
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
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH bpf-next v3 3/6] bpf: Preserve boundaries and track scalars on narrowing fill
Date: Sat, 27 Jan 2024 19:52:34 +0200
Message-ID: <20240127175237.526726-4-maxtram95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127175237.526726-1-maxtram95@gmail.com>
References: <20240127175237.526726-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

When the width of a fill is smaller than the width of the preceding
spill, the information about scalar boundaries can still be preserved,
as long as it's coerced to the right width (done by coerce_reg_to_size).
Even further, if the actual value fits into the fill width, the ID can
be preserved as well for further tracking of equal scalars.

Implement the above improvements, which makes narrowing fills behave the
same as narrowing spills and MOVs between registers.

Two tests are adjusted to accommodate for endianness differences and to
take into account that it's now allowed to do a narrowing fill from the
least significant bits.

reg_bounds_sync is added to coerce_reg_to_size to correctly adjust
umin/umax boundaries after the var_off truncation, for example, a 64-bit
value 0xXXXXXXXX00000000, when read as a 32-bit, gets umin = 0, umax =
0xFFFFFFFF, var_off = (0x0; 0xffffffff00000000), which needs to be
synced down to umax = 0, otherwise reg_bounds_sanity_check doesn't pass.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 include/linux/bpf_verifier.h                  |  9 +++++++
 kernel/bpf/verifier.c                         | 15 ++++++++---
 .../selftests/bpf/progs/verifier_spill_fill.c | 26 ++++++++++++++-----
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7f5816482a10..897be9dd6f12 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -918,6 +918,15 @@ static inline void mark_verifier_state_scratched(struct bpf_verifier_env *env)
 	env->scratched_stack_slots = ~0ULL;
 }
 
+static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_size)
+{
+#ifdef __BIG_ENDIAN
+	off -= spill_size - fill_size;
+#endif
+
+	return !(off % BPF_REG_SIZE);
+}
+
 const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type);
 const char *dynptr_type_str(enum bpf_dynptr_type type);
 const char *iter_type_str(const struct btf *btf, u32 btf_id);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f4b9fd0006d1..81b08a0e9e2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4778,7 +4778,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 			if (dst_regno < 0)
 				return 0;
 
-			if (!(off % BPF_REG_SIZE) && size == spill_size) {
+			if (size <= spill_size &&
+			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
 				/* The earlier check_reg_arg() has decided the
 				 * subreg_def for this insn.  Save it first.
 				 */
@@ -4786,6 +4787,12 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
+
+				/* Break the relation on a narrowing fill.
+				 * coerce_reg_to_size will adjust the boundaries.
+				 */
+				if (get_reg_width(reg) > size * BITS_PER_BYTE)
+					state->regs[dst_regno].id = 0;
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
 
@@ -6061,10 +6068,10 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
-	if (size < 4) {
+	if (size < 4)
 		__mark_reg32_unbounded(reg);
-		reg_bounds_sync(reg);
-	}
+
+	reg_bounds_sync(reg);
 }
 
 static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index f9803005e1c0..3e5d063ea7e8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -217,7 +217,7 @@ __naked void uninit_u32_from_the_stack(void)
 
 SEC("tc")
 __description("Spill a u32 const scalar.  Refill as u16.  Offset to skb->data")
-__failure __msg("invalid access to packet")
+__success __retval(0)
 __naked void u16_offset_to_skb_data(void)
 {
 	asm volatile ("					\
@@ -225,13 +225,19 @@ __naked void u16_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 8);				\
+	"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r4 = *(u16*)(r10 - 8);"
+#else
+	"r4 = *(u16*)(r10 - 6);"
+#endif
+	"						\
 	r0 = r2;					\
-	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */\
 	r0 += r4;					\
-	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */\
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	if r0 > r3 goto l0_%=;				\
-	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */\
+	/* r0 = *(u32 *)r2 R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */\
 	r0 = *(u32*)(r2 + 0);				\
 l0_%=:	r0 = 0;						\
 	exit;						\
@@ -268,7 +274,7 @@ l0_%=:	r0 = 0;						\
 }
 
 SEC("tc")
-__description("Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data")
+__description("Spill a u32 const scalar.  Refill as u16 from MSB.  Offset to skb->data")
 __failure __msg("invalid access to packet")
 __naked void _6_offset_to_skb_data(void)
 {
@@ -277,7 +283,13 @@ __naked void _6_offset_to_skb_data(void)
 	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
 	w4 = 20;					\
 	*(u32*)(r10 - 8) = r4;				\
-	r4 = *(u16*)(r10 - 6);				\
+	"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	"r4 = *(u16*)(r10 - 6);"
+#else
+	"r4 = *(u16*)(r10 - 8);"
+#endif
+	"						\
 	r0 = r2;					\
 	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */\
 	r0 += r4;					\
-- 
2.43.0


