Return-Path: <linux-kselftest+bounces-23475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892AF9F5D66
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 04:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D631880964
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4B14883C;
	Wed, 18 Dec 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFn6f+Xb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C114F121;
	Wed, 18 Dec 2024 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492258; cv=none; b=gK9zHqAFlak0uAoMRpVSwIfjcAh2gfnbbta8I4ZvYdADES7b/9isM9tU3o9kh7TdXC9mTcwmLONLb+ST5zQ/J115KDeaOD1fscgVMArzrot1Xss3yF3gUs+eXWinIqAP/WDTr6BPDh8djQGG1PV+kRb95q4pQi1Jr/KVa1kGW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492258; c=relaxed/simple;
	bh=KEl/adkdvZTh7TOy5Rn6Le9BzN+NF26WIwnO1JpgAVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUhZlWEl6dbA5JEK5MjgTkTdZkK3SCLLUHZ+rMvB58/UwS175E/BpxcCpqbeew2JOVUB4euNbYfb75/nCGa7I3uTct90Z1HllqpV4ZYNgoFAppzWTGlXDZ5/ktGfomOJcDjjfbqeAZsWsUi2eUWhLnoOOniBfiDIlmyISkXs1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFn6f+Xb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6fc3e9e4aso437489285a.2;
        Tue, 17 Dec 2024 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734492255; x=1735097055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vft8Kk6+6YsjztBMHAcvJpFCEVWTT76YX7ZTUW5iwEk=;
        b=aFn6f+Xbj8+M7j/duQ/YsRctBH+vedp7unWx4MWpDE5xOJ7fUhCHtqvjMVGK5iTL93
         tl2wScptrh1ikQg5pBRLlAUm0/IrVfkcxwGwEsM+2eAqimJywXIWS2iK86Cr1f6lue/P
         aA8CvLsG3wzoxRMezSeTxDsMsikygN/bT4nXp92cfofMbGV7D5fai3b4mGUsk34N9bs1
         n+gcTPYJuuSAOzH7OVW//njp9NCQwGjLMK+JKmWdLOT2TQhSN91MFFeA8IVQomL/zr2j
         f3YWJVxrdi5jR6S6N2O8h1uJxf12pVSfbY/StdaTs0EuF3QJHJc9JJiakAHE7pPeIXN0
         nZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492255; x=1735097055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vft8Kk6+6YsjztBMHAcvJpFCEVWTT76YX7ZTUW5iwEk=;
        b=FQqOLO8bkZcKPEXPudvMa/CwJc9idMS7ZcSmx02z64FWLQ4AdqPzELihfxDY4EWUqb
         npmF1coo0FCYtOobeW3F1t+dJzoHUMex81bSOdqIW/jmnUNKPtqXmO1Um8WHcizMmCnM
         z5QLGLruPfBKcao+XQ5Y/zMOhgL/Wa145Yw88xuQKBArWgO2S2Te94I9g/doLlokEhiz
         txCWcNvSK31je3mPYe091zGxGgWFYAzCZ1XYSn68xOybjuiYzt9ePrwOG9rEwGwvFMNj
         cviz+4LvlT+xIH6vjcOQAnvaGoQExyHk/ijlbee+DR6aTcXi235uxuwQXxdqF+eTnq4H
         3nWg==
X-Forwarded-Encrypted: i=1; AJvYcCUXI7i6BNMVcJfKBWXQSXU4ulvTep4hiIpCeQs92HVXlmrfBxRWFbsdaoRO7BC1GFGE6tytmsgjRda7Y4Vk@vger.kernel.org, AJvYcCVXTxKQnp2IY3fHmP8pkEwCxkO2V6r1jvdY1ZoIVJ4YhrZuSXjFoGOY/URSLugpnqZxhS4=@vger.kernel.org, AJvYcCVp1132jgwUGHAjXrbq7K8k3+znNQLtm/avZ5Y4kamTjeMOLWjm5adI+3Bu0vyzNgHWpehF4wVD3N/nmyn/oPrk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5h4kaIrV8r93Qg0YkearbpKVGlKKu/vNvTDIMH5u92+MwcQIe
	3H7xN0xgaFChJ2aVV26RoPa6rt7/j85Vwo0/thRqNu8pP/TATxBX
X-Gm-Gg: ASbGnctmmEgfL8EMVzVeUv+rWaRGt2FjMOpwFuskH/J77+ePSuzuFYRMxLkhA43TOLe
	RQX8IhkAcVYMIWUXzPD0CgGEdIx8Qb0ZzCyGbdyS7ZtU4YxSryhgA/mBrI0C9amy1lUtIVVTTep
	fy0N59LthRqMV0SJNsEi9+JsTMLeumsctnZ9weabjRWea8H5OlZBEBXFR/CCwEAKD2d3Fcooigj
	W1IF4reqr1FPNTNF9fFToJcp8vflq8AsCwfzSWN/6acUKPjfIzGxojZG6sKEywZSAGaIDVpZaGx
	5CZvqQE084AW/xUy1lR3ThVPtPFVNwc=
X-Google-Smtp-Source: AGHT+IGVk35d2QGLkM63ev/BNzUuBqujmi3hIQMJ1OumJabbtWMlbS+axVspObMx7fV7qA0++zLkMg==
X-Received: by 2002:a05:620a:1a90:b0:7b6:d383:3cca with SMTP id af79cd13be357-7b86375e834mr222852285a.35.1734492255106;
        Tue, 17 Dec 2024 19:24:15 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7b7047aa6bbsm381977985a.3.2024.12.17.19.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:24:14 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/2] bpf, verifier: Improve precision of BPF_MUL
Date: Tue, 17 Dec 2024 22:23:34 -0500
Message-Id: <20241218032337.12214-2-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218032337.12214-1-m.shachnai@gmail.com>
References: <20241218032337.12214-1-m.shachnai@gmail.com>
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
        *dst_umin = 0;
        *dst_umax = U64_MAX;
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
 kernel/bpf/verifier.c | 80 +++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e5..419f75c2cabb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14084,64 +14084,56 @@ static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
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
+		*dst_umin = 0;
+		*dst_umax = U32_MAX;
 	}
-	dst_reg->u32_min_value *= umin_val;
-	dst_reg->u32_max_value *= umax_val;
-	if (dst_reg->u32_max_value > S32_MAX) {
+	if (check_mul_overflow(*dst_smin, src_reg->s32_min_value, &tmp_prod[0]) ||
+	    check_mul_overflow(*dst_smin, src_reg->s32_max_value, &tmp_prod[1]) ||
+	    check_mul_overflow(*dst_smax, src_reg->s32_min_value, &tmp_prod[2]) ||
+	    check_mul_overflow(*dst_smax, src_reg->s32_max_value, &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
-		dst_reg->s32_min_value = S32_MIN;
-		dst_reg->s32_max_value = S32_MAX;
+		*dst_smin = S32_MIN;
+		*dst_smax = S32_MAX;
 	} else {
-		dst_reg->s32_min_value = dst_reg->u32_min_value;
-		dst_reg->s32_max_value = dst_reg->u32_max_value;
+		*dst_smin = min_array(tmp_prod, 4);
+		*dst_smax = max_array(tmp_prod, 4);
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
+		*dst_umin = 0;
+		*dst_umax = U64_MAX;
 	}
-	dst_reg->umin_value *= umin_val;
-	dst_reg->umax_value *= umax_val;
-	if (dst_reg->umax_value > S64_MAX) {
+	if (check_mul_overflow(*dst_smin, src_reg->smin_value, &tmp_prod[0]) ||
+	    check_mul_overflow(*dst_smin, src_reg->smax_value, &tmp_prod[1]) ||
+	    check_mul_overflow(*dst_smax, src_reg->smin_value, &tmp_prod[2]) ||
+	    check_mul_overflow(*dst_smax, src_reg->smax_value, &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
-		dst_reg->smin_value = S64_MIN;
-		dst_reg->smax_value = S64_MAX;
+		*dst_smin = S64_MIN;
+		*dst_smax = S64_MAX;
 	} else {
-		dst_reg->smin_value = dst_reg->umin_value;
-		dst_reg->smax_value = dst_reg->umax_value;
+		*dst_smin = min_array(tmp_prod, 4);
+		*dst_smax = max_array(tmp_prod, 4);
 	}
 }
 
-- 
2.25.1


