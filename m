Return-Path: <linux-kselftest+bounces-23386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB099F2086
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 20:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E775F168000
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Dec 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05D1ADFEB;
	Sat, 14 Dec 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCpVDT4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6621AD3F6;
	Sat, 14 Dec 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734203070; cv=none; b=GTwEhDSnJo9s4MebQYYyk55/aTCQomzBcJjAQH8mfHOdslXrdbs7VaMrOAp5HQZKU4dVOBDwuQh2/uxTTHgcccD8zLNGv0Ast28Ba20Rwv2gmQSupD1atc44gP8KCs4sDosUFKR3oZf2uGTiTF5T59HBWlHbK0Qw6/6pdgftbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734203070; c=relaxed/simple;
	bh=AEIvYsBLlgSKhQGG8Q1h6+wTCJp9pWv0666FHmtYY7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot3kbJAk3QCzKKB0Vidwr9xCYsYadjUmAUM3O5Ymt73Ko1/+goeZxfEyVSR5WdXqXEll+mE96NO4cnPrm/iNf3H8wdk74du8sKP6NW0Cr+5CAF6VhMuQgoE2FCIMhdA3wFPka0bC11HSg88K0RM6l0YkZosAcS+jMcWjhrpSEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCpVDT4J; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8f544d227so16127166d6.1;
        Sat, 14 Dec 2024 11:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734203066; x=1734807866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWt2lwZGlpUrEiocBhzn54dtb/xUzdNeid1SDPj0B2U=;
        b=FCpVDT4JngBre+ln6iuLbWILMdoQ9C41VediJmjmp8fjNkfruuUgZFIceuvvo4obuB
         DSRcL6+mr82N60qcdDrwVMoDeenBFowWvEH1zGf19Pr56a5Y7yMheoqOmvjsYBtVQoxZ
         X5jOJdk+H+1PgtUuqzkjkpJJseT0nQiHJTQfM+r99b/tpREr3aaryFJvcnUBELvkHk4g
         ij/mRYB5OYyNzRwW9twh6XF9lTn98/DgSUDo+Gwzv9lnoxM7CP1WdxBgKDulsqqx8UPQ
         kVK60e868HkjLpuVmBQhZzWFG3nAudAGTPlkLaRxW4vqnvfP7t9w8P4ylFEgfdEVWW+I
         zSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734203066; x=1734807866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWt2lwZGlpUrEiocBhzn54dtb/xUzdNeid1SDPj0B2U=;
        b=Wx6hAQkdhfS86LKjYuqbAfjbM8IG7nHEb+k3pI2hAYMJjy3Hgl9nLkd/azHCcc02zX
         aX0nRC7N8ZtcgeshtaBQ7It5DpL0n0NlhGthKhGMSUUhqWJ422lqhygcUgVYVFV8roXp
         8fqvAMZ+GQCR881FQfjP0aWp1lIP10DRDf9TVJYmnXSbRvV/4AJvaXsHeFKQHaRnnhYH
         LizivLBEdYf2pCt05PephSQoN/qGolRI9wAWBIPkVNWhjlMICq5cwZekbRxsVrX2le+X
         ev3B0d5gQ+uQKTVtBMGhGwnlMjyBydLibCJ+ZSuxjZO90Ryb7/Zk0ugAMAnu+m7MJqHO
         yCEg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wewxa76FXyqIrkUxss0DKNolKy8EnibHEze0fcfcFIN+/JmMzYFhjmEzJn49mlbrZcYVwm0F/nmoFP0VQPT4@vger.kernel.org, AJvYcCVu4Zv/RRJ9sGrgLJSlf/mUqaefQ/NPhpJtvtmxAYEvSBBdND2VpqcYhYaBG5zY+/JQFQk=@vger.kernel.org, AJvYcCXnLCpXLRn38w7iCbXI11lwChd+9hLmKRIXn9fPez7yf5ioxFvgzWwZY2Cf+XdOEqSpYrv483X3NF6FMSr3@vger.kernel.org
X-Gm-Message-State: AOJu0YxgX5/EzCOAA88z2sgUenUsi2gDzvNMWAz+gTo7iEs4HdRpPfMW
	LXmi6UEtOYTm9bXNQEEnXEQoWrvQiJw7YBPtRh55KN9sUifIXaGo
X-Gm-Gg: ASbGncuQHXJbXv1izGorHtciSfU+OK+biY/7NI2j8sbJBHirEKoAt+c44leW+RqwkIZ
	35aqrsWWuRRe9FFKOF1s2fE7iElcGCUlO21kPfCMLBAxiwp6KMuBlccs1ksURODSwoikNj3JQa1
	JHJywWk4Ruft5EehMN1/wxHjnCPVpgblaa5XYtG/hCiHVO//fzhYTaPCvIwwVV1Smov7HKNE++W
	inHBFiVG2qhKtauc8VfcTQV77uDB0SP8n9E1tEc+xq5E7JgOk5bOoAzhgYmB203uL3HqrfBb051
	giuOIasUV77afyjd0L/WQTaPcxoNSUw=
X-Google-Smtp-Source: AGHT+IHXauf8Jpe7242Fk3pvo3rwYWjynNJdEFZrbgGlbfh711g5p+3G5dxlxzxz8PIT2gbINPBQNw==
X-Received: by 2002:a05:6214:202c:b0:6d8:9124:8794 with SMTP id 6a1803df08f44-6dc8c1a1c28mr144250146d6.5.1734203065847;
        Sat, 14 Dec 2024 11:04:25 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6dccd26d086sm9884376d6.55.2024.12.14.11.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 11:04:24 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@gmail.com,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	m.shachnai@rutgers.edu,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf, verifier: Improve precision of BPF_MUL
Date: Sat, 14 Dec 2024 14:04:10 -0500
Message-Id: <20241214190413.25587-2-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241214190413.25587-1-m.shachnai@gmail.com>
References: <20241214190413.25587-1-m.shachnai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch improves (or maintains) the precision of register value tracking
in BPF_MUL across all possible inputs. It also simplifies
scalar32_min_max_mul() and scalar_min_max_mul().

As it stands, BPF_MUL is composed of three functions:

case BPF_MUL:
  tnum_mul();
  scalar32_min_max_mul();
  scalar_min_max_mul();

The current implementation of scalar_min_max_mul() restricts the u64 input
ranges of dst_reg and src_reg to be within [0, U32_MAX]:

    /* Both values are positive, so we can work with unsigned and
     * copy the result to signed (unless it exceeds S64_MAX).
     */
    if (umax_val > U32_MAX || dst_reg->umax_value > U32_MAX) {
        /* Potential overflow, we know nothing */
        __mark_reg64_unbounded(dst_reg);
        return;
    }

This restriction is done to avoid unsigned overflow, which could otherwise
wrap the result around 0, and leave an unsound output where umin > umax. We
also observe that limiting these u64 input ranges to [0, U32_MAX] leads to
a loss of precision. Consider the case where the u64 bounds of dst_reg are
[0, 2^34] and the u64 bounds of src_reg are [0, 2^2]. While the
multiplication of these two bounds doesn't overflow and is sound [0, 2^36],
the current scalar_min_max_mul() would set the entire register state to
unbounded.

Importantly, we update BPF_MUL to allow signed bound multiplication
(i.e. multiplying negative bounds) as well as allow u64 inputs to take on
values from [0, U64_MAX]. We perform signed multiplication on two bounds
[a,b] and [c,d] by multiplying every combination of the bounds
(i.e. a*c, a*d, b*c, and b*d) and checking for overflow of each product. If
there is an overflow, we mark the signed bounds unbounded [S64_MIN, S64_MAX].
In the case of no overflow, we take the minimum of these products to
be the resulting smin, and the maximum to be the resulting smax.

The key idea here is that if there’s no possibility of overflow, either
when multiplying signed bounds or unsigned bounds, we can safely multiply the
respective bounds; otherwise, we set the bounds that exhibit overflow
(during multiplication) to unbounded.

if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
       (check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin))) {
        /* Overflow possible, we know nothing */
        dst_reg->umin_value = 0;
        dst_reg->umax_value = U64_MAX;
    }
  ...

Below, we provide an example BPF program (below) that exhibits the
imprecision in the current BPF_MUL, where the outputs are all unbounded. In
contrast, the updated BPF_MUL produces a bounded register state:

BPF_LD_IMM64(BPF_REG_1, 11),
BPF_LD_IMM64(BPF_REG_2, 4503599627370624),
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
BPF_LD_IMM64(BPF_REG_3, 809591906117232263),
BPF_ALU64_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
BPF_MOV64_IMM(BPF_REG_0, 1),
BPF_EXIT_INSN(),

Verifier log using the old BPF_MUL:

func#0 @0
0: R1=ctx() R10=fp0
0: (18) r1 = 0xb                      ; R1_w=11
2: (18) r2 = 0x10000000000080         ; R2_w=0x10000000000080
4: (87) r2 = -r2                      ; R2_w=scalar()
5: (87) r2 = -r2                      ; R2_w=scalar()
6: (5f) r1 &= r2                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R2_w=scalar()
7: (18) r3 = 0xb3c3f8c99262687        ; R3_w=0xb3c3f8c99262687
9: (2f) r3 *= r1                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R3_w=scalar()
...

Verifier using the new updated BPF_MUL (more precise bounds at label 9)

func#0 @0
0: R1=ctx() R10=fp0
0: (18) r1 = 0xb                      ; R1_w=11
2: (18) r2 = 0x10000000000080         ; R2_w=0x10000000000080
4: (87) r2 = -r2                      ; R2_w=scalar()
5: (87) r2 = -r2                      ; R2_w=scalar()
6: (5f) r1 &= r2                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R2_w=scalar()
7: (18) r3 = 0xb3c3f8c99262687        ; R3_w=0xb3c3f8c99262687
9: (2f) r3 *= r1                      ; R1_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R3_w=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))
...

Finally, we proved the soundness of the new scalar_min_max_mul() and
scalar32_min_max_mul() functions. Typically, multiplication operations are
expensive to check with bitvector-based solvers. We were able to prove the
soundness of these functions using Non-Linear Integer Arithmetic (NIA)
theory. Additionally, using Agni [2,3], we obtained the encodings for
scalar32_min_max_mul() and scalar_min_max_mul() in bitvector theory, and
were able to prove their soundness using 8-bit bitvectors (instead of
64-bit bitvectors that the functions actually use).

In conclusion, with this patch,

1. We were able to show that we can improve the overall precision of
   BPF_MUL. We proved (using an SMT solver) that this new version of
   BPF_MUL is at least as precise as the current version for all inputs
   and more precise for some inputs.

2. We are able to prove the soundness of the new scalar_min_max_mul() and
   scalar32_min_max_mul(). By leveraging the existing proof of tnum_mul
   [1], we can say that the composition of these three functions within
   BPF_MUL is sound.

[1] https://ieeexplore.ieee.org/abstract/document/9741267
[2] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
[3] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf

Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
---
 kernel/bpf/verifier.c | 72 +++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c855e7905c35..5b0f83cc7f4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14118,64 +14118,56 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
 static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
 				 struct bpf_reg_state *src_reg)
 {
-	s32 smin_val = src_reg->s32_min_value;
-	u32 umin_val = src_reg->u32_min_value;
-	u32 umax_val = src_reg->u32_max_value;
+	s32 *dst_smin = &dst_reg->s32_min_value;
+	s32 *dst_smax = &dst_reg->s32_max_value;
+	u32 *dst_umin = &dst_reg->u32_min_value;
+	u32 *dst_umax = &dst_reg->u32_max_value;
+	s32 tmp_prod[4];
 
-	if (smin_val < 0 || dst_reg->s32_min_value < 0) {
-		/* Ain't nobody got time to multiply that sign */
-		__mark_reg32_unbounded(dst_reg);
-		return;
-	}
-	/* Both values are positive, so we can work with unsigned and
-	 * copy the result to signed (unless it exceeds S32_MAX).
-	 */
-	if (umax_val > U16_MAX || dst_reg->u32_max_value > U16_MAX) {
-		/* Potential overflow, we know nothing */
-		__mark_reg32_unbounded(dst_reg);
-		return;
+	if (check_mul_overflow(*dst_umax, src_reg->u32_max_value, dst_umax) ||
+	    check_mul_overflow(*dst_umin, src_reg->u32_min_value, dst_umin)) {
+		/* Overflow possible, we know nothing */
+		dst_reg->u32_min_value = 0;
+		dst_reg->u32_max_value = U32_MAX;
 	}
-	dst_reg->u32_min_value *= umin_val;
-	dst_reg->u32_max_value *= umax_val;
-	if (dst_reg->u32_max_value > S32_MAX) {
+	if (check_mul_overflow(*dst_smin, src_reg->s32_min_value, &tmp_prod[0]) ||
+	    check_mul_overflow(*dst_smin, src_reg->s32_max_value, &tmp_prod[1]) ||
+	    check_mul_overflow(*dst_smax, src_reg->s32_min_value, &tmp_prod[2]) ||
+	    check_mul_overflow(*dst_smax, src_reg->s32_max_value, &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
 		dst_reg->s32_min_value = S32_MIN;
 		dst_reg->s32_max_value = S32_MAX;
 	} else {
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
+		dst_reg->s32_min_value = min_array(tmp_prod, 4);
+		dst_reg->s32_max_value = max_array(tmp_prod, 4);
 	}
 }
 
 static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 			       struct bpf_reg_state *src_reg)
 {
-	s64 smin_val = src_reg->smin_value;
-	u64 umin_val = src_reg->umin_value;
-	u64 umax_val = src_reg->umax_value;
+	s64 *dst_smin = &dst_reg->smin_value;
+	s64 *dst_smax = &dst_reg->smax_value;
+	u64 *dst_umin = &dst_reg->umin_value;
+	u64 *dst_umax = &dst_reg->umax_value;
+	s64 tmp_prod[4];
 
-	if (smin_val < 0 || dst_reg->smin_value < 0) {
-		/* Ain't nobody got time to multiply that sign */
-		__mark_reg64_unbounded(dst_reg);
-		return;
-	}
-	/* Both values are positive, so we can work with unsigned and
-	 * copy the result to signed (unless it exceeds S64_MAX).
-	 */
-	if (umax_val > U32_MAX || dst_reg->umax_value > U32_MAX) {
-		/* Potential overflow, we know nothing */
-		__mark_reg64_unbounded(dst_reg);
-		return;
+	if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
+	    check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin)) {
+		/* Overflow possible, we know nothing */
+		dst_reg->umin_value = 0;
+		dst_reg->umax_value = U64_MAX;
 	}
-	dst_reg->umin_value *= umin_val;
-	dst_reg->umax_value *= umax_val;
-	if (dst_reg->umax_value > S64_MAX) {
+	if (check_mul_overflow(*dst_smin, src_reg->smin_value, &tmp_prod[0]) ||
+	    check_mul_overflow(*dst_smin, src_reg->smax_value, &tmp_prod[1]) ||
+	    check_mul_overflow(*dst_smax, src_reg->smin_value, &tmp_prod[2]) ||
+	    check_mul_overflow(*dst_smax, src_reg->smax_value, &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
 		dst_reg->smin_value = S64_MIN;
 		dst_reg->smax_value = S64_MAX;
 	} else {
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
+		dst_reg->smin_value = min_array(tmp_prod, 4);
+		dst_reg->smax_value = max_array(tmp_prod, 4);
 	}
 }
 
-- 
2.25.1


