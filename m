Return-Path: <linux-kselftest+bounces-23433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E39F3AD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468E616BB0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2B1D0E27;
	Mon, 16 Dec 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSfhaE3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB181B5EB5;
	Mon, 16 Dec 2024 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381118; cv=none; b=ouWInI+EoYDC57NjY1BpjHQzWuzfmawu/BByCRsBlysdWp+zm+pKdoWipYjVse3xdGASbkW+vEjHubC/UJe/2NA0rewyPfCEGbJKEBh9k3YnLhsfIh046jHf1YAjYMN9evE2GOBCDaTnhpzeZs+5T/UyKSpTDIlg1HnvHyTQ4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381118; c=relaxed/simple;
	bh=c33m8kcmA+c/RmYSgHXyNI3wLe/B2GDG5b9amZa4EOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5ejBZ13rAErWO8XaQD1yaFRYQFRyjhjiL1unAfKwHrHO5kka6jqXsn2uhwg1p3DFEDweVJDeIU1MILP08mFIDNes5Ke1WS8DWhcbh0qI4uLztRIwm++j9APzPr8QcMudUOiTk9FoqYgX/AuOB6M+tzkX/4wd7HB8KEwjoG4JFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSfhaE3Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43635796b48so16299505e9.0;
        Mon, 16 Dec 2024 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734381114; x=1734985914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Svu0q986IBg160F+a5ITE+MVbyLhrEyZrnOZ3Jfemc=;
        b=YSfhaE3YU8frpTONVVaXSoAO118rp7ABr1NvGIrIXGo6xWwOC1JSHMgcXSstRHu2Ja
         h7Jrb7B33SSk3uPz6Siqqu/YoMW93dDOjKm5mLKHWzuaVkov6tYDqZveiW0PY1Kq3fl9
         LQot4EYbSb91KybXrgVJp5MWbqvlznDqdx0G+d1OZy4Bp6Eu+3HaX9tp1UpVXyT4Zy3C
         KI2Iqfy9YKsdPPnb194BrkgdF6gRt6lMrXA8Tf3bQtln/ip3F4yDtTHhb4sn5czmBT5b
         LZ5Ait18K+Od/bBbb1zAe2GYFsHPzIN9jw1kjDxTXnN4/TsPWlVuMlGPolDuJVvTKfU/
         bmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381114; x=1734985914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Svu0q986IBg160F+a5ITE+MVbyLhrEyZrnOZ3Jfemc=;
        b=BwI87st7O4eXlv9O/Brrj1w1wk3eDTjrw0qMf75YGI8enfKmkSI/1Lb+pQMK/J2ebk
         IVaFQ9OJaokSZMWiXn5HyZdHgr31hmXMkfBleH5Lm7Q+3wceGSjPygNJ7WJI4ogouoqk
         Wd8V/vNpRGlHE0J383TXvQneY0y9ErzMWBknK7YvB0KDTYcotHSILPTG3LDEJut86O/G
         i0cCIGkK9oP3j0NDVeFmfVDlY1fO1U8bN3WMB/hDm3/6HZXTwEeQQfXKS1ObuhSpSrpj
         Q5y3esyPgRTRLnaR9ZT/EUSY366mHGHo/xu6NyQDT/ocXWM7wn6UCc3Gq1UPh7UuFCWC
         YZJw==
X-Forwarded-Encrypted: i=1; AJvYcCWdiBc346Yl2Goc6iv0TjKHxmXwWMUTSgdfUfosEo7AdfARcA8WH/SBOuh6OAfR3NkESNE2yNQqBwbvzpPx@vger.kernel.org, AJvYcCX1Oy94S+UzjzBl5eBVzQXuPbHBIMh0dgeuOEDIw4imRVPqoEGtNK6UW6c4y0FwkVHoklMuxkVpr6XgWhQxbzoM@vger.kernel.org, AJvYcCXKclX8eWiathXzgiTLuQPWbNKWnAxmyFTfzVkoC6s5OrnhzePaGRrEEz8x/ztsVt7NAgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY737lGLoR795cZdgAFV6GXLdIXhxXVWvHd4XGZkuxp57QWp8l
	Y6mUswr6uQmc5/ZdnJDDGsI8b1yKrrxBSr/ZE6hi5uiYlx9dkFk69JVjO9S51gDSzZ/ZnOglFBk
	yTcRm0glWBj0jEaC4mwF1M/qnOpM=
X-Gm-Gg: ASbGnctP3r2MRU7yXhzuUPw7ck9blW8vfuctnrCGWFjO7H9VMwFqLVA5FDtRyM5HijY
	vH2b3WQRCnNe21aOne68+DTHDXtPUVMEm+YkbT5jK
X-Google-Smtp-Source: AGHT+IEiqazAy1W93vTzYtfZyq1W8zzLNMBEZ+2nhayxbJMMCokfxs35DnH/CeM/1PexrRhusnkq8m6C1fcU9OhHUlk=
X-Received: by 2002:a05:600c:5854:b0:436:2155:be54 with SMTP id
 5b1f17b1804b1-4364812a126mr6249825e9.1.1734381114175; Mon, 16 Dec 2024
 12:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214190413.25587-1-m.shachnai@gmail.com> <20241214190413.25587-2-m.shachnai@gmail.com>
In-Reply-To: <20241214190413.25587-2-m.shachnai@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Dec 2024 12:31:43 -0800
Message-ID: <CAADnVQ+wdbbFUN03_YPYLDtr4KyQAowk5_V8SzwyM6wjE9JvLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, verifier: Improve precision of BPF_MUL
To: Matan Shachnai <m.shachnai@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 11:04=E2=80=AFAM Matan Shachnai <m.shachnai@gmail.c=
om> wrote:
>
> This patch improves (or maintains) the precision of register value tracki=
ng
> in BPF_MUL across all possible inputs. It also simplifies
> scalar32_min_max_mul() and scalar_min_max_mul().
>
> As it stands, BPF_MUL is composed of three functions:
>
> case BPF_MUL:
>   tnum_mul();
>   scalar32_min_max_mul();
>   scalar_min_max_mul();
>
> The current implementation of scalar_min_max_mul() restricts the u64 inpu=
t
> ranges of dst_reg and src_reg to be within [0, U32_MAX]:
>
>     /* Both values are positive, so we can work with unsigned and
>      * copy the result to signed (unless it exceeds S64_MAX).
>      */
>     if (umax_val > U32_MAX || dst_reg->umax_value > U32_MAX) {
>         /* Potential overflow, we know nothing */
>         __mark_reg64_unbounded(dst_reg);
>         return;
>     }
>
> This restriction is done to avoid unsigned overflow, which could otherwis=
e
> wrap the result around 0, and leave an unsound output where umin > umax. =
We
> also observe that limiting these u64 input ranges to [0, U32_MAX] leads t=
o
> a loss of precision. Consider the case where the u64 bounds of dst_reg ar=
e
> [0, 2^34] and the u64 bounds of src_reg are [0, 2^2]. While the
> multiplication of these two bounds doesn't overflow and is sound [0, 2^36=
],
> the current scalar_min_max_mul() would set the entire register state to
> unbounded.
>
> Importantly, we update BPF_MUL to allow signed bound multiplication
> (i.e. multiplying negative bounds) as well as allow u64 inputs to take on
> values from [0, U64_MAX]. We perform signed multiplication on two bounds
> [a,b] and [c,d] by multiplying every combination of the bounds
> (i.e. a*c, a*d, b*c, and b*d) and checking for overflow of each product. =
If
> there is an overflow, we mark the signed bounds unbounded [S64_MIN, S64_M=
AX].
> In the case of no overflow, we take the minimum of these products to
> be the resulting smin, and the maximum to be the resulting smax.
>
> The key idea here is that if there=E2=80=99s no possibility of overflow, =
either
> when multiplying signed bounds or unsigned bounds, we can safely multiply=
 the
> respective bounds; otherwise, we set the bounds that exhibit overflow
> (during multiplication) to unbounded.
>
> if (check_mul_overflow(*dst_umax, src_reg->umax_value, dst_umax) ||
>        (check_mul_overflow(*dst_umin, src_reg->umin_value, dst_umin))) {
>         /* Overflow possible, we know nothing */
>         dst_reg->umin_value =3D 0;
>         dst_reg->umax_value =3D U64_MAX;
>     }
>   ...
>
> Below, we provide an example BPF program (below) that exhibits the
> imprecision in the current BPF_MUL, where the outputs are all unbounded. =
In
> contrast, the updated BPF_MUL produces a bounded register state:
>
> BPF_LD_IMM64(BPF_REG_1, 11),
> BPF_LD_IMM64(BPF_REG_2, 4503599627370624),
> BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
> BPF_ALU64_IMM(BPF_NEG, BPF_REG_2, 0),
> BPF_ALU64_REG(BPF_AND, BPF_REG_1, BPF_REG_2),
> BPF_LD_IMM64(BPF_REG_3, 809591906117232263),
> BPF_ALU64_REG(BPF_MUL, BPF_REG_3, BPF_REG_1),
> BPF_MOV64_IMM(BPF_REG_0, 1),
> BPF_EXIT_INSN(),
>
> Verifier log using the old BPF_MUL:
>
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r1 =3D 0xb                      ; R1_w=3D11
> 2: (18) r2 =3D 0x10000000000080         ; R2_w=3D0x10000000000080
> 4: (87) r2 =3D -r2                      ; R2_w=3Dscalar()
> 5: (87) r2 =3D -r2                      ; R2_w=3Dscalar()
> 6: (5f) r1 &=3D r2                      ; R1_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xb)) R2_w=3Dscalar()
> 7: (18) r3 =3D 0xb3c3f8c99262687        ; R3_w=3D0xb3c3f8c99262687
> 9: (2f) r3 *=3D r1                      ; R1_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xb)) R3_w=3Dscalar()
> ...
>
> Verifier using the new updated BPF_MUL (more precise bounds at label 9)
>
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r1 =3D 0xb                      ; R1_w=3D11
> 2: (18) r2 =3D 0x10000000000080         ; R2_w=3D0x10000000000080
> 4: (87) r2 =3D -r2                      ; R2_w=3Dscalar()
> 5: (87) r2 =3D -r2                      ; R2_w=3Dscalar()
> 6: (5f) r1 &=3D r2                      ; R1_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xb)) R2_w=3Dscalar()
> 7: (18) r3 =3D 0xb3c3f8c99262687        ; R3_w=3D0xb3c3f8c99262687
> 9: (2f) r3 *=3D r1                      ; R1_w=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xb)) R3_w=3Dscalar(smi=
n=3D0,smax=3Dumax=3D0x7b96bb0a94a3a7cd,var_off=3D(0x0; 0x7fffffffffffffff))
> ...
>
> Finally, we proved the soundness of the new scalar_min_max_mul() and
> scalar32_min_max_mul() functions. Typically, multiplication operations ar=
e
> expensive to check with bitvector-based solvers. We were able to prove th=
e
> soundness of these functions using Non-Linear Integer Arithmetic (NIA)
> theory. Additionally, using Agni [2,3], we obtained the encodings for
> scalar32_min_max_mul() and scalar_min_max_mul() in bitvector theory, and
> were able to prove their soundness using 8-bit bitvectors (instead of
> 64-bit bitvectors that the functions actually use).
>
> In conclusion, with this patch,
>
> 1. We were able to show that we can improve the overall precision of
>    BPF_MUL. We proved (using an SMT solver) that this new version of
>    BPF_MUL is at least as precise as the current version for all inputs
>    and more precise for some inputs.
>
> 2. We are able to prove the soundness of the new scalar_min_max_mul() and
>    scalar32_min_max_mul(). By leveraging the existing proof of tnum_mul
>    [1], we can say that the composition of these three functions within
>    BPF_MUL is sound.
>
> [1] https://ieeexplore.ieee.org/abstract/document/9741267
> [2] https://link.springer.com/chapter/10.1007/978-3-031-37709-9_12
> [3] https://people.cs.rutgers.edu/~sn349/papers/sas24-preprint.pdf
>
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
> ---
>  kernel/bpf/verifier.c | 72 +++++++++++++++++++------------------------
>  1 file changed, 32 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c855e7905c35..5b0f83cc7f4d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14118,64 +14118,56 @@ static void scalar_min_max_sub(struct bpf_reg_s=
tate *dst_reg,
>  static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
>                                  struct bpf_reg_state *src_reg)
>  {
> -       s32 smin_val =3D src_reg->s32_min_value;
> -       u32 umin_val =3D src_reg->u32_min_value;
> -       u32 umax_val =3D src_reg->u32_max_value;
> +       s32 *dst_smin =3D &dst_reg->s32_min_value;
> +       s32 *dst_smax =3D &dst_reg->s32_max_value;
> +       u32 *dst_umin =3D &dst_reg->u32_min_value;
> +       u32 *dst_umax =3D &dst_reg->u32_max_value;
> +       s32 tmp_prod[4];
>
> -       if (smin_val < 0 || dst_reg->s32_min_value < 0) {
> -               /* Ain't nobody got time to multiply that sign */
> -               __mark_reg32_unbounded(dst_reg);
> -               return;
> -       }
> -       /* Both values are positive, so we can work with unsigned and
> -        * copy the result to signed (unless it exceeds S32_MAX).
> -        */
> -       if (umax_val > U16_MAX || dst_reg->u32_max_value > U16_MAX) {
> -               /* Potential overflow, we know nothing */
> -               __mark_reg32_unbounded(dst_reg);
> -               return;
> +       if (check_mul_overflow(*dst_umax, src_reg->u32_max_value, dst_uma=
x) ||
> +           check_mul_overflow(*dst_umin, src_reg->u32_min_value, dst_umi=
n)) {
> +               /* Overflow possible, we know nothing */
> +               dst_reg->u32_min_value =3D 0;
> +               dst_reg->u32_max_value =3D U32_MAX;

It would be cleaner to use:
*dst_umin =3D 0;
*dst_umax =3D U32_MAX;

to make it obvious that though check_mul_overflow()-s wrote something
into dst_umax and dst_umin,
we clean them up with these two assignments.

Just like scalar32_min_max_add() does already.

>         }
> -       dst_reg->u32_min_value *=3D umin_val;
> -       dst_reg->u32_max_value *=3D umax_val;
> -       if (dst_reg->u32_max_value > S32_MAX) {
> +       if (check_mul_overflow(*dst_smin, src_reg->s32_min_value, &tmp_pr=
od[0]) ||
> +           check_mul_overflow(*dst_smin, src_reg->s32_max_value, &tmp_pr=
od[1]) ||
> +           check_mul_overflow(*dst_smax, src_reg->s32_min_value, &tmp_pr=
od[2]) ||
> +           check_mul_overflow(*dst_smax, src_reg->s32_max_value, &tmp_pr=
od[3])) {
>                 /* Overflow possible, we know nothing */
>                 dst_reg->s32_min_value =3D S32_MIN;
>                 dst_reg->s32_max_value =3D S32_MAX;
>         } else {
> -               dst_reg->s32_min_value =3D dst_reg->u32_min_value;
> -               dst_reg->s32_max_value =3D dst_reg->u32_max_value;
> +               dst_reg->s32_min_value =3D min_array(tmp_prod, 4);
> +               dst_reg->s32_max_value =3D max_array(tmp_prod, 4);

dst_smin/smax here too.

